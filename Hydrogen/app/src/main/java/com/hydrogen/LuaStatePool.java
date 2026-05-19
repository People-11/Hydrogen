package com.hydrogen;

import com.androlua.*;
import com.luajava.*;
import java.util.LinkedList;
import java.util.Queue;

/**
 * Pool of pre-initialized LuaState instances for reuse across MyLuaFileFragment.
 * Eliminates the per-fragment overhead of newLuaState(), openLibs(), pushContext(),
 * common function registrations (print, set, call), and pre-warms the LuaState
 * with cached bindClass results and pre-required core modules.
 */
public class LuaStatePool {
    private static volatile LuaStatePool sInstance;
    private final Queue<LuaState> mAvailable = new LinkedList<>();
    private String mDefaultLuaLpath;
    private String mDefaultLuaCpath;
    private boolean mDefaultsCaptured;

    // Commonly used Android classes — pre-caching them avoids JNI calls later
    private static final String[] COMMON_CLASSES = {
        "android.widget.TextView", "android.widget.LinearLayout",
        "android.widget.FrameLayout", "android.widget.ImageView",
        "android.widget.Button", "android.widget.ProgressBar",
        "android.widget.ScrollView", "android.widget.EditText",
        "android.widget.RelativeLayout", "android.widget.HorizontalScrollView",
        "androidx.recyclerview.widget.RecyclerView",
        "com.google.android.material.card.MaterialCardView",
        "com.google.android.material.appbar.AppBarLayout",
        "com.google.android.material.appbar.CollapsingToolbarLayout",
        "androidx.viewpager2.widget.ViewPager2",
        "androidx.swiperefreshlayout.widget.SwipeRefreshLayout",
        "com.google.android.material.textview.MaterialTextView",
        "com.google.android.material.button.MaterialButton",
        "com.google.android.material.tabs.TabLayout",
        "com.google.android.material.bottomnavigation.BottomNavigationView",
        "com.google.android.material.navigation.NavigationView",
        "androidx.coordinatorlayout.widget.CoordinatorLayout",
        "androidx.drawerlayout.widget.DrawerLayout",
        "androidx.cardview.widget.CardView",
        "androidx.viewpager.widget.ViewPager",
        "android.view.View", "android.view.ViewGroup",
        "android.text.Html", "android.graphics.Paint",
        "android.graphics.drawable.ColorDrawable",
        "android.graphics.Bitmap", "android.graphics.BitmapFactory",
        "android.graphics.Typeface", "android.graphics.Matrix",
        "com.bumptech.glide.Glide",
        "androidx.core.view.ViewCompat",
        "android.animation.ArgbEvaluator", "android.animation.ObjectAnimator",
        "android.view.animation.Animation", "android.view.animation.OvershootInterpolator",
        "com.google.android.material.transition.MaterialContainerTransform",
        "com.google.android.material.transition.MaterialSharedAxis",
        "com.google.android.material.transition.MaterialArcMotion",
        "androidx.core.view.WindowInsetsCompat",
        "android.webkit.CookieManager", "android.webkit.WebSettings",
    };

    private LuaStatePool() {
    }

    public static LuaStatePool getInstance(LuaActivity activity) {
        if (sInstance == null) {
            synchronized (LuaStatePool.class) {
                if (sInstance == null) {
                    LuaStatePool pool = new LuaStatePool();
                    pool.warmUp(activity);
                    sInstance = pool;
                }
            }
        }
        return sInstance;
    }

    private void warmUp(LuaActivity activity) {
        LuaState L = createBaseState(activity);
        mAvailable.add(L);
    }

    private LuaState createBaseState(LuaActivity activity) {
        LuaState L = LuaStateFactory.newLuaState();
        L.openLibs();
        L.pushContext(activity);
        L.pop(1); // pop the luajava object left on stack by pushContext

        if (!mDefaultsCaptured) {
            saveDefaultPaths(L);
            mDefaultsCaptured = true;
        }

        // Pre-warm: cache common bindClass results and pre-require core modules
        prewarm(L, activity);

        // Register shared functions — these are identical for all fragments
        JavaFunction print = new LuaPrint(activity, L);
        print.register("print");
        new LuaSetFunction(L).register("set");
        new LuaCallFunction(L).register("call");

        L.setTop(0); // ensure clean stack for the next user
        return L;
    }

    /**
     * Pre-warms the LuaState by pre-caching JNI bindClass results and
     * pre-requiring core modules so that the first page load on this
     * LuaState is significantly faster.
     */
    private void prewarm(LuaState L, LuaActivity activity) {
        // --- Pre-cache common bindClass results ---
        try {
            L.getGlobal("luajava");
            L.getField(-1, "bindClass");
            for (String className : COMMON_CLASSES) {
                L.pushValue(-1);       // duplicate bindClass function
                L.pushString(className);
                L.pcall(1, 0, 0);      // silently ignore missing classes
                L.setTop(2);           // keep luajava + bindClass, discard result/error
            }
            L.pop(2); // pop bindClass and luajava
            L.setTop(0);
        } catch (Exception e) {
            L.setTop(0);
        }

        // --- Pre-require core Lua modules ---
        try {
            // Temporarily set activity globals needed by the import system
            L.pushJavaObject(activity);
            L.setGlobal("activity");
            L.setGlobal("this");

            // Set up package.path so require() can find Lua files
            String luaDir = activity.getLuaDir();
            LuaApplication app = (LuaApplication) activity.getApplication();
            String luaLpath = app.getLuaLpath();
            String luaCpath = app.getLuaCpath();
            String prewarmPath = luaDir + "/?.lua;" + luaDir + "/lua/?.lua;"
                              + luaDir + "/?/init.lua;" + luaLpath;

            L.getGlobal("package");
            L.pushString(prewarmPath);
            L.setField(-2, "path");
            L.pushString(luaCpath);
            L.setField(-2, "cpath");
            L.pop(1);

            // Core modules used by virtually every page
            execLuaChunk(L, "require 'import'");
            execLuaChunk(L, "require 'loadlayout'");

            // mods.imports pre-loads 100+ common class bindings
            execLuaChunk(L, "require 'mods.imports'");

            L.setTop(0);
        } catch (Exception e) {
            L.setTop(0);
        }

        // Clean up temporary activity globals
        nilGlobal(L, "activity");
        nilGlobal(L, "this");

        // Restore default package.path / cpath (will be set per-fragment in initLua)
        restoreDefaultPaths(L);
    }

    private void execLuaChunk(LuaState L, String script) {
        L.setTop(0);
        int ok = L.LloadString(script);
        if (ok == 0) {
            L.pcall(0, 0, 0);
        }
        L.setTop(0);
    }

    private void saveDefaultPaths(LuaState L) {
        L.getGlobal("package");
        if (!L.isNil(-1)) {
            L.getField(-1, "path");
            if (L.isString(-1)) {
                mDefaultLuaLpath = L.toString(-1);
            }
            L.pop(1);
            L.getField(-1, "cpath");
            if (L.isString(-1)) {
                mDefaultLuaCpath = L.toString(-1);
            }
            L.pop(1);
        }
        L.pop(1);
    }

    private void restoreDefaultPaths(LuaState L) {
        L.getGlobal("package");
        if (!L.isNil(-1)) {
            L.pushString(mDefaultLuaLpath != null ? mDefaultLuaLpath : "");
            L.setField(-2, "path");
            L.pushString(mDefaultLuaCpath != null ? mDefaultLuaCpath : "");
            L.setField(-2, "cpath");
        }
        L.pop(1);
    }

    public synchronized LuaState acquire(LuaActivity activity) {
        if (!mAvailable.isEmpty()) {
            return mAvailable.poll();
        }
        return createBaseState(activity);
    }

    public synchronized void release(LuaState L, String[] globalKeys) {
        if (L == null) return;

        try {
            L.setTop(0);

            nilGlobal(L, "thisFragment");
            nilGlobal(L, "activity");
            nilGlobal(L, "this");
            nilGlobal(L, "currentFragment");

            if (globalKeys != null) {
                for (String key : globalKeys) {
                    nilGlobal(L, key);
                }
            }

            // Clear fragment-specific luajava fields
            L.getGlobal("luajava");
            if (!L.isNil(-1)) {
                L.pushString("");
                L.setField(-2, "luaextdir");
                L.pushString("");
                L.setField(-2, "luadir");
                L.pushString("");
                L.setField(-2, "luapath");
            }
            L.pop(1);

            // Restore default package.path / cpath
            restoreDefaultPaths(L);

            L.setTop(0);
        } catch (Exception e) {
            // best-effort cleanup; discard the state
            return;
        }

        if (mAvailable.size() < 3) {
            mAvailable.add(L);
        }
    }

    private static void nilGlobal(LuaState L, String key) {
        L.pushNil();
        L.setGlobal(key);
    }
}
