local zemojip={}
taskUI(function()
  if not File(activity.getExternalCacheDir().getPath().."/zemoji/doge.png").exists() then
    pcall(function()LuaUtil.unZip(srcLuaDir.."/res/zemoji.zip",activity.getExternalCacheDir().getPath())end,function()提示("ZEMOJI解压失败")end)
  end
  zemoji = {
    握手 = [[https://pic2.zhimg.com/v2-f5aa165e86b5c9ed3b7bee821da59365.png]];
    打招呼 = [[https://picx.zhimg.com/v2-95c560d0c9c0491f6ef404cc010878fc.png]];
    哇 = [[https://picx.zhimg.com/v2-6a766571a6d6d3a4d8d16f433e5b284c.png]];
    感谢 = [[https://pic1.zhimg.com/v2-694cac2ec9f3c63f774e723f77d8c840.png]];
    知乎益蜂 = [[https://pica.zhimg.com/v2-11d9b8b6edaae71e992f95007c777446.png]];
    百分百赞 = [[https://picx.zhimg.com/v2-27521d5ba23dfc1ea58fd9ebb220e304.png]];
    为爱发乎 = [[https://pic1.zhimg.com/v2-609b1f168acfa22d59fa09d3cb0846ee.png]];
    脑爆 = [[https://pica.zhimg.com/v2-b6f53e9726998343e7713f564a422575.png]];
    暗中学习 = [[https://pica.zhimg.com/v2-5dc88b4f8cbc58d7597e2134a384e392.png]];
    匿了 = [[https://pic1.zhimg.com/v2-c1e799b8357888525ec45793e8270306.png]];
    谢邀 = [[https://pic2.zhimg.com/v2-6fe2283baa639ae1d7c024487f1d68c7.png]];
    赞同 = [[https://pic2.zhimg.com/v2-419a1a3ed02b7cfadc20af558aabc897.png]];
    蹲 = [[https://pic4.zhimg.com/v2-66e5de3da039ac969d3b9d4dc5ef3536.png]];
    爱 = [[https://pic1.zhimg.com/v2-0942128ebfe78f000e84339fbb745611.png]];
    害羞 = [[https://pic4.zhimg.com/v2-52f8c87376792e927b6cf0896b726f06.png]];
    好奇 = [[https://pic2.zhimg.com/v2-72b9696632f66e05faaca12f1f1e614b.png]];
    思考 = [[https://pic4.zhimg.com/v2-bffb2bf11422c5ef7d8949788114c2ab.png]];
    酷 = [[https://pic4.zhimg.com/v2-c96dd18b15beb196b2daba95d26d9b1c.png]];
    大笑 = [[https://pic1.zhimg.com/v2-3ac403672728e5e91f5b2d3c095e415a.png]];
    微笑 = [[https://pic1.zhimg.com/v2-3700cc07f14a49c6db94a82e989d4548.png]];
    捂脸 = [[https://pic1.zhimg.com/v2-b62e608e405aeb33cd52830218f561ea.png]];
    捂嘴 = [[https://pic4.zhimg.com/v2-0e26b4bbbd86a0b74543d7898fab9f6a.png]];
    飙泪笑 = [[https://pic4.zhimg.com/v2-3bb879be3497db9051c1953cdf98def6.png]];
    耶 = [[https://pic2.zhimg.com/v2-f3b3b8756af8b42bd3cb534cbfdbe741.png]];
    可怜 = [[https://pic1.zhimg.com/v2-aa15ce4a2bfe1ca54c8bb6cc3ea6627b.png]];
    惊喜 = [[https://pic2.zhimg.com/v2-3846906ea3ded1fabbf1a98c891527fb.png]];
    流泪 = [[https://pic4.zhimg.com/v2-dd613c7c81599bcc3085fc855c752950.png]];
    大哭 = [[https://pic1.zhimg.com/v2-41f74f3795489083630fa29fde6c1c4d.png]];
    生气 = [[https://pic4.zhimg.com/v2-6a976b21fd50b9535ab3e5b17c17adc7.png]];
    惊讶 = [[https://pic4.zhimg.com/v2-0d9811a7961c96d84ee6946692a37469.png]];
    调皮 = [[https://pic1.zhimg.com/v2-76c864a7fd5ddc110965657078812811.png]];
    衰 = [[https://pic1.zhimg.com/v2-d6d4d1689c2ce59e710aa40ab81c8f10.png]];
    发呆 = [[https://pic2.zhimg.com/v2-7f09d05d34f03eab99e820014c393070.png]];
    机智 = [[https://pic1.zhimg.com/v2-4e025a75f219cf79f6d1fda7726e297f.png]];
    嘘 = [[https://pic4.zhimg.com/v2-f80e1dc872d68d4f0b9ac76e8525d402.png]];
    尴尬 = [[https://pic3.zhimg.com/v2-b779f7eb3eac05cce39cc33e12774890.png]];
    小情绪 = [[https://pic3.zhimg.com/v2-b779f7eb3eac05cce39cc33e12774890.png]];
    为难 = [[https://pic1.zhimg.com/v2-132ab52908934f6c3cd9166e51b99f47.png]];
    吃瓜 = [[https://pic4.zhimg.com/v2-74ecc4b114fce67b6b42b7f602c3b1d6.png]];
    语塞 = [[https://pic2.zhimg.com/v2-58e3ec448b58054fde642914ebb850f9.png]];
    看看你 = [[https://pic3.zhimg.com/v2-4e4870fc6e57bb76e7e5924375cb20b6.png]];
    撇嘴 = [[https://pic2.zhimg.com/v2-1043b00a7b5776e2e6e1b0af2ab7445d.png]];
    魔性笑 = [[https://pic2.zhimg.com/v2-e6270881e74c90fc01994e8cd072bd3a.png]];
    潜水 = [[https://pic1.zhimg.com/v2-99bb6a605b136b95e442f5b69efa2ccc.png]];
    口罩 = [[https://pic4.zhimg.com/v2-6551348276afd1eaf836551b93a94636.png]];
    开心 = [[https://pic2.zhimg.com/v2-c99cdc3629ff004f83ff44a952e5b716.png]];
    滑稽 = [[https://pic4.zhimg.com/v2-8a8f1403a93ddd0a458bed730bebe19b.png]];
    笑哭 = [[https://pic4.zhimg.com/v2-ca0015e8ed8462cfce839fba518df585.png]];
    白眼 = [[https://pic2.zhimg.com/v2-d4f78d92922632516769d3f2ce055324.png]];
    红心 = [[https://pic2.zhimg.com/v2-9ab384e3947547851cb45765e6fc1ea8.png]];
    柠檬 = [[https://pic4.zhimg.com/v2-a8f46a21217d58d2b4cdabc4568fde15.png]];
    拜托 = [[https://pic2.zhimg.com/v2-3e36d546a9454c8964fbc218f0db1ff8.png]];
    赞 = [[https://pic1.zhimg.com/v2-c71427010ca7866f9b08c37ec20672e0.png]];
    发火 = [[https://pic1.zhimg.com/v2-d5c0ed511a09bf5ceb633387178e0d30.png]];
    不抬杠 = [[https://pic4.zhimg.com/v2-395d272d5635143119b1dbc0b51e05e4.png]];
    种草 = [[https://pic2.zhimg.com/v2-cb191a92f1296e33308b2aa16f61bfb9.png]];
    抱抱 = [[https://pic2.zhimg.com/v2-b2e3fa9e0b6f431bd18d4a9d5d3c6596.png]];
    doge = [[https://pic4.zhimg.com/v2-501ff2e1fb7cf3f9326ec5348dc8d84f.png]];
  }
  for i in pairs(zemoji) do
    local drawable = getImageDrawable(表情(i))
    zemoji[i] = drawable.setBounds(0, 0, sp2px(20), sp2px(20))
    table.insert(zemojip, {ii=i, i=表情(i)})
  end
end)

local base={}

function base:new(id,type)
  local child=table.clone(self)
  child.id=id
  child.type=type
  return child
end

-- 性能优化：缓存常用的正则表达式模式
local IMAGE_PATTERN = "%.(jpg|gif|bmp|png|webp|jpeg)$"

function base:getUrlByType(sortby)
  if self.type ~= "comments" then
    return string.format("https://api.zhihu.com/comment_v5/%s/%s/root_comment?order_by=%s", self.type, self.id, sortby or "score")
  end
  return string.format("https://api.zhihu.com/comment_v5/comment/%s/child_comment?order_by=%s", self.id, sortby or "ts")
end

local function MyClickableSpan(url)
  return ClickableSpan{
    onClick=function(v)
      v.Tag={isc=true}
      v.post(Runnable{run=function() v.Tag=nil end})
      if v.Text:find("图片") or v.Text:find("动图") or url:lower():match(IMAGE_PATTERN) or url:find("zhimg.com") then
        this.setSharedData("imagedata", luajson.encode({["0"]=url, ["1"]=1}))
        activity.newActivity("image")
        return true
      end
      检查链接(url)
    end,
    updateDrawState=function(v)
      v.setColor(v.linkColor)
      v.setUnderlineText(true)
    end
  }
end

function base.resolvedata(v, data)
  local author = v.author
  local content = v.content:gsub("</p>+$", ""):gsub("^<p>", "")
  local name = author.name
  
  if v.author_tag and v.author_tag[1] then
    name = name .. "「" .. v.author_tag[1].text .. "」"
  end
  if v.reply_to_author then
    name = name .. " -> " .. v.reply_to_author.name
    if v.reply_author_tag and v.reply_author_tag[1] then
      name = name .. "「" .. v.reply_author_tag[1].text .. "」"
    end
  end

  local myspan
  local has_url, has_img = false, nil
  if content:find("http") then
    local style = SpannableStringBuilder(Html.fromHtml(content))
    local spans = luajava.astable(style.getSpans(0, style.length(), URLSpan))
    has_url = true
    for _, span in ipairs(spans) do
      local url = span.getURL()
      style.setSpan(MyClickableSpan(url), style.getSpanStart(span), style.getSpanEnd(span), Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
      if url:lower():match(IMAGE_PATTERN) then has_img = url end
      style.removeSpan(span)
    end
    myspan = style
   else
    myspan = Html.fromHtml(content)
  end

  -- 性能优化：只有当内容包含表情符号格式时才进行匹配
  if content:find("%[.-%]") and zemoji then
    for i, d in pairs(zemoji) do
      Spannable_Image(myspan, "\\["..i.."\\]", d)
    end
  end

  local time = 时间戳(v.created_time)
  pcall(function()
    if v.comment_tag and v.comment_tag[1] and v.comment_tag[1].type == "ip_info" then
      time = v.comment_tag[1].text .. " · " .. time
    end
  end)

  table.insert(data, {
    评论 = (v.child_comment_count and v.child_comment_count > 0) and tostring(v.child_comment_count) or "false",
    id内容 = tostring(v.id),
    作者id = author.id,
    author = author,
    预览内容 = myspan,
    标题 = name,
    图像 = author.avatar_url,
    赞 = tostring(v.like_count),
    时间 = time,
    like_count = v.like_count,
    can_delete = v.can_delete,
    liked = v.liked,
    disliked = v.disliked,
    包含url = has_url,
    包含图片 = has_img
  })
end

local function 多选菜单(data, views)
  local id内容 = data.id内容
  local menu = {
    {"分享", function() 分享文本(data.预览内容.toString()) end},
    {"复制", function()
        activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(data.预览内容.toString())
        提示("复制文本成功")
    end},
    { data.disliked and "取消踩" or "踩评论", function()
        if not getLogin() then return 提示("请登录后使用本功能") end
        local method = data.disliked and zHttp.delete or zHttp.put
        method("https://api.zhihu.com/comment_v5/comment/"..id内容.."/reaction/dislike", '', postapphead, function(code)
          if code == 200 then
            提示(data.disliked and "取消踩成功" or "踩成功")
            data.disliked = not data.disliked
          end
        end)
    end},
    { data.liked and "取消赞" or "赞评论", function()
        if not getLogin() then return 提示("请登录后使用本功能") end
        local method = data.liked and zHttp.delete or zHttp.put
        method("https://api.zhihu.com/comment_v5/comment/"..id内容.."/reaction/like", '', postapphead, function(code)
          if code == 200 then
            提示(data.liked and "取消赞成功" or "赞成功")
            data.liked = not data.liked
          end
        end)
    end},
    {"举报", function()
        local url = "https://www.zhihu.com/report?id="..id内容.."&type=comment"
        newActivity("browser", {url.."&source=android&ab_signature=", "举报"})
    end},
    {"屏蔽", function()
        if not getLogin() then return 提示("请登录后使用本功能") end
        AlertDialog.Builder(this).setTitle("提示").setMessage("确定拉黑该用户吗？")
        .setPositiveButton("确定", {onClick=function()
            zHttp.post("https://api.zhihu.com/settings/blocked_users", "people_id="..data.作者id, apphead, function(code)
              if code == 200 or code == 201 then 提示("已拉黑") end
            end)
        end}).setNegativeButton("取消", nil).show()
    end},
    {"查看主页", function() newActivity("people", {data.作者id, data.author}) end}
  }

  if isstart then
    table.insert(menu, {"回复评论", function() 发送评论(id内容, "回复"..data.标题) end})
  end

  showPopMenu(menu).showAsDropDown(views, downx, 0)
  return true
end

local function animChip(primary, secondary)
  return function(v, e)
    if e.action == MotionEvent.ACTION_DOWN then
      primary.tag = "t"
      local s = AnimatorSet()
      s.setInterpolator(AnticipateOvershootInterpolator(0.1))
      s.setDuration(200)
      s.play(ObjectAnimator.ofFloat(primary, "ChipCornerRadius", {primary.ChipCornerRadius, dp2px(4)}))
      .with(ObjectAnimator.ofFloat(primary, "ChipStartPadding", {primary.ChipStartPadding, dp2px(16)}))
      .with(ObjectAnimator.ofFloat(primary, "ChipEndPadding", {primary.ChipEndPadding, dp2px(16)}))
      .with(ObjectAnimator.ofFloat(secondary, "ChipStartPadding", {secondary.ChipStartPadding, dp2px(6)}))
      .with(ObjectAnimator.ofFloat(secondary, "ChipEndPadding", {secondary.ChipEndPadding, dp2px(6)}))
      s.start()
    elseif primary.tag == "t" then
      primary.tag = "off"
      taskUI(200, function()
        local s = AnimatorSet()
        s.setInterpolator(AnticipateOvershootInterpolator(0.1))
        s.setDuration(200)
        s.play(ObjectAnimator.ofFloat(primary, "ChipCornerRadius", {primary.ChipCornerRadius, dp2px(16)}))
        .with(ObjectAnimator.ofFloat(primary, "ChipStartPadding", {primary.ChipStartPadding, dp2px(8)}))
        .with(ObjectAnimator.ofFloat(primary, "ChipEndPadding", {primary.ChipEndPadding, dp2px(8)}))
        .with(ObjectAnimator.ofFloat(secondary, "ChipStartPadding", {secondary.ChipStartPadding, dp2px(8)}))
        .with(ObjectAnimator.ofFloat(secondary, "ChipEndPadding", {secondary.ChipEndPadding, dp2px(8)}))
        s.start()
      end)
    end
    return false
  end
end

function base.getAdapter(comment_pagetool,pos)
  local data=comment_pagetool:getItemData(pos)
  local item_layout = comment_pagetool.adapters_func_config.item_layout -- 从配置中获取布局
  return LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount=function()
      return #data
    end,

    getItemViewType=function(position)
      return 0
    end,

    onCreateViewHolder=function(parent,viewType)
      local views={}
      local holder=LuaCustRecyclerHolder(loadlayout(item_layout,views))
      holder.view.setTag(views)
      return holder
    end,

    onBindViewHolder=function(holder,position)
      local views=holder.view.getTag()
      local data=data[position+1]
      local type=data.datatype
      local 标题=data.标题
      local 预览内容=data.预览内容
      local 预览图片=data.包含图片
      local id内容=data.id内容
      local 评论=data.评论
      local 作者id=data.作者id
      local 图像=data.图像
      local 时间=data.时间
      local 赞=data.赞
      local isme=data.isme

      views.标题.text=标题
      views.时间.text=时间
      views.赞.text=赞
      views.评论.text=评论
      views.预览内容.text=预览内容
      loadglide(views.图像,图像)
      --[[if 预览图片
        loadglide(views.预览图片,预览图片)
        views.预览图片.onClick=function()
          nTView=views.预览图片
          this.setSharedData("imagedata",luajson.encode(预览图片))
        activity.newActivity("image")
        end
      end]]

      views.评论.visibility = (评论~="false") and 0 or 8
      views.赞.ChipIcon = data.liked and liked_drawable or like_drawable
      import "android.view.MotionEvent"
      import "android.animation.ObjectAnimator"

      views.赞.onTouch = animChip(views.赞, views.评论)
      views.评论.onTouch = animChip(views.评论, views.赞)
      if comment_type=="comments"&&position==0
        local layoutParams = views.line.LayoutParams;
        layoutParams.height=dp2px(24)
        views.line.setLayoutParams(layoutParams);
        --感谢可爱的喵立方
        function draw_sin(canvas, x, y, length, height, periods, paint)
          local path = Path()
          local density = 40
          for i = 0, 1, 1 / periods / density do
            path.lineTo(i * length, math.sin(i * periods * math.pi * 2) * height)
          end
          path.offset(x, y)
          canvas.drawPath(path, paint)
        end

        local paint_qwq = Paint()
        paint_qwq.setColor(res.color.attr.colorSurfaceVariant)
        paint_qwq.setStrokeWidth(dp2px(1.5))
        paint_qwq.setStyle(Paint.Style.STROKE)
        paint_qwq.setStrokeCap(Paint.Cap.ROUND)

        views.line.setBackground(LuaDrawable(
        function(canvas, paint, drawable)
          canvas.drawColor(转0x(backgroundc))
          draw_sin(canvas, 0, views.line.height/2, views.line.width, views.line.height/4, 8, paint_qwq)
        end
        ))




        --[[已有加粗分割线，没必要 elseif comment_type=="comments"
        local layoutParams = views.card.LayoutParams;
        layoutParams.setMargins(dp2px(20), layoutParams.rightMargin, layoutParams.rightMargin,layoutParams.bottomMargin);
        views.card.setLayoutParams(layoutParams);]]
      end
      views.评论.onClick=function()
        发送评论(id内容,"回复"..data.标题.."发送的评论")
      end
      views.赞.onClick=function()
        if not(data.liked)
          zHttp.put("https://api.zhihu.com/comment_v5/comment/"..id内容.."/reaction/like",'',postapphead,function(code,content)
            if code==200 then
              提示("赞成功")
              data.liked=true
              data.like_count=data.like_count+1
              views.赞.ChipIcon=liked_drawable
              views.赞.text=data.like_count..""

            end
          end)
         else
          zHttp.delete("https://api.zhihu.com/comment_v5/comment/"..id内容.."/reaction/like",postapphead,function(code,content)
            if code==200 then
              提示("取消赞成功")
              data.liked=false
              data.like_count=data.like_count-1
              views.赞.ChipIcon=like_drawable
              views.赞.text=data.like_count..""
            end
          end)
        end
      end




      views.author_lay.onClick=function()
        nTView=views.图像
        newActivity("people",{data.作者id, data.author})
      end

      views.card.onTouch=function(v,event)
        downx=event.getX()
        downy=event.getY()
      end
      views.card.onClick=function()
        if 评论=="false" then
          return
         else
          if comment_type=="comments" then
            return 提示("当前已在该对话列表内")
          end
        end
        nTView=views.card
        newActivity("comment",{data.id内容,"comments",保存路径,comment_id})
      end
      views.预览内容.onClick=function(v)
        if v.Tag and v.Tag.isc then
          return
        end
        views.card.performClick()
      end
      views.card.onLongClick=function(view)
        多选菜单(data,view)
      end

      if data.包含url then
        views.预览内容.MovementMethod=LinkMovementMethod.getInstance()
      end

    end,
  }))

end

function base:initpage(view,sr,item_layout)
  self.view=view
  self.sr=sr
  orititle=_title.text

  return MyPageTool2:new({
    view=view,
    sr=sr,
    head="head",
    adapters_func=self.getAdapter,
    adapters_func_config={item_layout=item_layout}, -- 显式传递布局配置
    func=self.resolvedata,
    firstfunc=function(data,adpdata)
      --针对对话列表 添加父评论
      if self.type=="comments" then
        self.resolvedata(data.root,adpdata)
        评论类型=data.root.resource_type.."s"
        评论id=父回复id or comment_id
       else
        评论类型=comment_type
        评论id=comment_id
      end
      if data.counts then
        _title.text=orititle.." "..tostring(data.counts.total_counts).."条"
       else
        local tip="知识被荒原了"
        if data.comment_status and data.comment_status.text then
          tip=data.comment_status.text
        end
        AlertDialog.Builder(this)
        .setTitle("提示")
        .setCancelable(false)
        .setMessage(tip)
        .setPositiveButton("我知道了",{onClick=function()
            关闭页面()
        end})
        .show()
      end
    end
  })
  :initPage()
  :createfunc()
  :setUrlItem(self:getUrlByType())

end

function 发送评论(id,title)
  if not(getLogin()) then
    return 提示("请登录后使用本功能")
  end
  -- 性能优化：将 JNI 类绑定移到函数开始，避免在条件分支中重复绑定
  local WindowInsets = Build.VERSION.SDK_INT >= 30 and luajava.bindClass "android.view.WindowInsets" or nil
  
  local stitle = title or "输入评论"
  local mytext
  local postdata
  local 请求链接
  回复id=id
  local endicondrawable=BitmapDrawable(Bitmap.createScaledBitmap(loadbitmap(图标("face")), sp2px(48),sp2px(48), true))


  bottomSheetDialog = BottomSheetDialog(this)
  bottomSheetDialog.setContentView(
  loadlayout({
    LinearLayout;
    id="root",
    fitsSystemWindows=false;
    orientation="vertical";
    layout_height="fill";
    layout_width="fill";
    {
      LinearLayout;
      layout_width="fill";
      layout_height="fill";
      gravity="center";
      id="sendlay";
      Focusable=true;
      FocusableInTouchMode=true;
      --开启动画可能造成卡顿
      --LayoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING);
      --[[  {
        EditText;
        id="send_edit";
        layout_weight=1;
        layout_marginLeft="16dp";
        layout_margin="8dp";
        maxLines=10;
        hint="输入评论";
      };]]
      {
        TextInputLayout,
        layout_height="wrap",
        layout_weight=1;
        layout_marginLeft="16dp";
        layout_marginTop="12dp";
        layout_margin="8dp";
        boxStrokeColor=primaryc,
        boxCornerRadii = {dp2px(20),dp2px(20),dp2px(20),dp2px(20)},
        --paddingBottom="16dp",
        layout_width="match",
        hint=stitle,
        id="send_input",
        endIconDrawable=endicondrawable,
        endIconMode=1,
        hintTextColor=ColorStateList.valueOf(转0x(primaryc)),
        boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
        --startIconDrawable=R.drawable.material_ic_edit_black_24dp,
        --boxBackgroundColor=0xffffffff,
        {
          TextInputEditText,
          id="send_edit",
          HighlightColor =primaryc,
          textColor=textc,
          --style=R.style.Widget_MaterialComponents_TextInputEditText_OutlinedBox_Dense,
          layout_height="wrap",
          layout_width="match",
        },
      },
      {
        MaterialButton;
        layout_marginRight="10dp";
        id="send";
        textColor=backgroundc;
        text="发送";
      };
    };
    {RecyclerView;
      id="zemorc";
      layout_width="fill";
      layout_height=0;
    };

  }))

  isZemo=false
  heightmax=0
  --不好看（zemorc.setPadding(0,dp2px(24),0,dp2px(24))
  send_edit.requestFocus()
  send_edit.postDelayed(Runnable{
    run=function()
      local imm= this.getSystemService(Context.INPUT_METHOD_SERVICE);
      imm.showSoftInput(send_edit, InputMethodManager.SHOW_IMPLICIT);
    end
  }, 100);
  send_input.setEndIconOnClickListener(View.OnClickListener{
    onClick=function(v)
      local view=bottomSheetDialog.window.getDecorView()
      if heightmax<100
        heightmax=dp2px(260)
      end
      if isShowing then
        if Build.VERSION.SDK_INT >= 30 then
          view.windowInsetsController.hide(WindowInsets.Type.ime())
         else
          local imm = this.getSystemService(Context.INPUT_METHOD_SERVICE)
          imm.hideSoftInputFromWindow(view.getWindowToken(), 0)
        end
        isZemo=true
       else
        if Build.VERSION.SDK_INT >= 30 then
          view.windowInsetsController.show(WindowInsets.Type.ime())
         else
          local imm = this.getSystemService(Context.INPUT_METHOD_SERVICE)
          imm.showSoftInput(send_edit, InputMethodManager.SHOW_IMPLICIT)
        end
      end
    end,
  })
  local GridLayoutManager = luajava.bindClass "androidx.recyclerview.widget.GridLayoutManager"
  local LuaRecyclerAdapter = luajava.bindClass "com.androlua.LuaRecyclerAdapter"
  local adapter1=LuaRecyclerAdapter(activity,zemojip,{LinearLayout,id="mainlay",gravity="center",
    {ImageView,id="i",layout_width="32sp",layout_marginTop="8dp";layout_height="32sp";layout_marginLeft="4dp";layout_marginRight="4dp";layout_marginBottom="8dp";},
  })
  pcall(function() bottomSheetDialog.getWindow().setDecorFitsSystemWindows(false)
    bottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
  end)
  bottomSheetDialog.show()
  .setCancelable(true)
  .behavior.setMaxWidth(dp2px(600))

  local view=bottomSheetDialog.window.getDecorView()
  local OnApplyWindowInsetsListener = luajava.bindClass "androidx.core.view.OnApplyWindowInsetsListener"
  ViewCompat.setOnApplyWindowInsetsListener(view, OnApplyWindowInsetsListener{
    onApplyWindowInsets=function(v,i)
      local status = i.getInsets(WindowInsetsCompat.Type.statusBars())
      local nav = i.getInsets(WindowInsetsCompat.Type.navigationBars())
      local ime = i.getInsets(WindowInsetsCompat.Type.ime())
      local layoutParams = sendlay.LayoutParams;
      layoutParams.setMargins(layoutParams.leftMargin, layoutParams.rightMargin, layoutParams.rightMargin,nav.bottom);
      sendlay.setLayoutParams(layoutParams);
      if ime.bottom>heightmax
        heightmax=ime.bottom
      end
      if Build.VERSION.SDK_INT<31
        local layoutParams = zemorc.LayoutParams;
        layoutParams.height = (not isZemo) and ime.bottom or heightmax
        zemorc.setLayoutParams(layoutParams);
        local layoutParams = root.LayoutParams;
        layoutParams.height=-2
        root.setLayoutParams(layoutParams);
      end
      isShowing=i.isVisible(WindowInsetsCompat.Type.ime())
      return i
    end
  })
  if Build.VERSION.SDK_INT >30
    view.setWindowInsetsAnimationCallback(luajava.override(WindowInsetsAnimation.Callback,{
      onProgress=function(_,i,animations)
        local status = i.getInsets(WindowInsets.Type.statusBars())
        local nav = i.getInsets(WindowInsets.Type.navigationBars())
        local ime = i.getInsets(WindowInsets.Type.ime())
        local layoutParams = zemorc.LayoutParams;
        layoutParams.height = (not isZemo) and ime.bottom or heightmax
        zemorc.setLayoutParams(layoutParams);
        local layoutParams = root.LayoutParams;
        layoutParams.height=-2
        root.setLayoutParams(layoutParams);
        return i
      end,
    },1))
  end
  zemorc.adapter=adapter1
  zemorc.layoutManager=GridLayoutManager(activity,8)
  adapter1.setAdapterInterface(LuaRecyclerAdapter.AdapterInterface{
    onBindViewHolder=function(viewHolder,index)
      viewHolder.tag.i.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{primaryc})))
      --lua的adapter不支持直接调用非索引table，因此在这里脱裤子放屁（
      xpcall(function()
        viewHolder.tag.i.setTooltipText(tostring(adapter1.data[index+1].ii or "error"))
        viewHolder.tag.i.onClick=function()
          local s,e = send_edit.getSelectionStart(),send_edit.getSelectionEnd()
          send_edit.text=utf8.sub(send_edit.text,1,s).."["..adapter1.data[index+1].ii.."]"..utf8.sub(send_edit.text,s+1)
          --[[ 效果不佳    myspan=Html.fromHtml(send_edit.text)
          for i,d in pairs(zemoji) do
    Spannable_Image(myspan, "["..i.."]",d)
  end
send_edit.text=myspan]]
          send_edit.setSelection(utf8.len(adapter1.data[index+1].ii)+2+s)
        end
      end,function(a) print(index) end)
    end
  })



  send.onClick=function()
    --测试不通过unicode编码也可以 暂时这么解决
    --或许之后知乎会仅支持unicode 到时候下载知乎app分析一下

    --替换 防止发表评论提交多行知乎api报错
    local mytext=send_edit.text
    --回车
    :gsub("\r","\\u000D")
    --换行
    :gsub("\n","\\u000A")

    if tostring(send_edit.text)==""
      提示("你还没输入喵")
      return
    end
    --评论类型和评论id处理逻辑在comment_base
    local postdata='{"comment_id":"","content":"'..mytext..'","extra_params":"","has_img":false,"reply_comment_id":"'..回复id..'","score":0,"selected_settings":[],"sticker_type":null,"unfriendly_check":"strict"}'
    local 请求链接="https://www.zhihu.com/api/v4/comment_v5/"..评论类型.."/"..评论id.."/comment"

    local url,head=require "model.zse96_encrypt"(请求链接)
    zHttp.post(url,postdata,head,function(code,json)
      if code==200 then
        提示("发送成功 如若想看到自己发言请刷新数据")
        bottomSheetDialog.dismiss()
      end
    end)
  end

end

return base