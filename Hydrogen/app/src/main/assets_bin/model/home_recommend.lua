local base={}



function base:new(id)--类的new方法
  local child=table.clone(self)
  child.id=id
  return child
end

--全局变量
recommend_data={}
homeapphead=table.clone(head)
homeapphead["x-close-recommend"]="0"

-- 预读历史记录缓存，避免在循环中重复读取 IO
local recommend_history
local function load_recommend_history()
  if recommend_history then return recommend_history end
  local cache_path = tostring(activity.getExternalCacheDir()).."/rc.json"
  if File(cache_path).exists() then
    local content = io.open(cache_path):read("*a")
    pcall(function() recommend_history = luajson.decode(content) end)
  end
  recommend_history = recommend_history or {}
  return recommend_history
end

local accessibilityManager = this.getSystemService(Context.ACCESSIBILITY_SERVICE);

function base.resolvedata(v,data)
  if v.type~="feed" then
    return
  end

  local isread='"t"'
  local readdata=v.brief
  local v=v.target or v
  local 标题=v.title
  local 点赞数=tostring(v.voteup_count or v.vote_count or v.reaction_count)
  local 评论数=tostring(v.comment_count)
  local 作者=v.author.name
  local 预览内容=作者.." : "..(v.excerpt or v.excerpt_title)
  
  if tointeger(activity.getSharedData("feed_cache"))>1 then
    recommend_history = load_recommend_history()
    if table.find(recommend_history,预览内容) then
      --开启无障碍后不提示找到重复内容
      if activity.getSharedData("feed_cache_tip") == "true" and not accessibilityManager.isTouchExplorationEnabled() then
        提示("找到重复内容")
      end
      local postdata=luajson.encode(readdata)
      postdata=urlEncode('[["r",'..postdata..']]')
      postdata="targets="..postdata
      zHttp.post("https://api.zhihu.com/lastread/touch/v2",postdata,apphead,function(code,content)
      end)
      return
     else
      if #recommend_history>tointeger(activity.getSharedData("feed_cache") or 100) then
        table.remove(recommend_history,1)
      end
      table.insert(recommend_history,预览内容)
      -- 异步或稍后保存会更好，但目前先保持同步写入以防丢失，至少减少了读取次数
      io.open(tostring(activity.getExternalCacheDir()).."/rc.json","w"):write(luajson.encode(recommend_history)):close()
    end
  end
  local id=v.id
  local 分割字符串

  local datatype
  local content_type=v.type
  switch content_type
   case "answer"
    datatype=0
    标题=v.question.title
    分割字符串="回答分割"
   case "pin"
    datatype=1
    标题=作者.."发表了想法"
    分割字符串="想法分割"
   case "article"
    datatype=2
    分割字符串="文章分割"
   case "zvideo"
    datatype=3
    分割字符串="视频分割"
   case "drama"
    datatype=4
    分割字符串="直播分割"
  end

  if not 预览内容 or 预览内容=="" or 预览内容=="无预览内容" then
    预览内容=nil
   else
    预览内容=Html.fromHtml(预览内容)
  end

  if 点赞数 then
    点赞数=tostring(点赞数)
   else
    点赞数="未知"
  end

  local id内容=分割字符串..id

  local mytype, myid
  if 分割字符串 == "文章分割" then
    mytype = "article"
    myid = id
  elseif 分割字符串 == "想法分割" then
    mytype = "pin"
    myid = id
  elseif 分割字符串 == "视频分割" then
    mytype = "zvideo"
    myid = id
  elseif 分割字符串 == "直播分割" then
    mytype = "drama"
    myid = id
  else
    mytype = "answer"
    myid = id
  end

  local add={}
  add.标题=标题
  add.预览内容=预览内容
  add.评论数=评论数
  add.点赞数=点赞数
  add.id内容=id内容
  add.mytype=mytype
  add.myid=myid

  local extradata= {
    isread=isread,
    readdata=readdata
  }
  table.insert(recommend_data,extradata)
  add.extradata=extradata

  table.insert(data,add)
end



function base.getAdapter(home_pagetool,pos)
  local data=home_pagetool:getItemData(pos)
  local downx, downy -- 局部化坐标变量

  -- 预定义事件处理函数，避免在 onBindViewHolder 中重复创建闭包
  local cardTouch = function(v,event)
    downx=event.getRawX()
    downy=event.getRawY()
  end

  local cardClick = function(v)
    local views = v.getTag()
    local position = views.card.getTag(R.id.tag_first) -- 使用 tag 获取位置
    local itemData = data[position+1]

    if getLogin() then
      itemData.extradata.isread='"r"'

      local postdata=luajson.encode(itemData.extradata.readdata)
      postdata=urlEncode('[["r",'..postdata..']]')
      postdata="targets="..postdata

      zHttp.post("https://api.zhihu.com/lastread/touch/v2",postdata,apphead,function(code,content)
        -- 记录成功即可
      end)
    end

    nTView=views.card
    点击事件判断(itemData.id内容,itemData.标题)
  end

  local cardLongClick = function(v)
    local views = v.getTag()
    local position = views.card.getTag(R.id.tag_first)
    local itemData = data[position+1]
    
    local mytype = itemData.mytype
    local myid = itemData.myid

    zHttp.get("https://api.zhihu.com/negative-feedback/panel?scene_code=RECOMMEND&content_type="..mytype.."&content_token="..myid,apphead,function(code,content)
      if code==200 then
        local menu={}
        local respData=luajson.decode(content).data.items
        for k,v in ipairs(respData) do
          local raw_button=v.raw_button
          local method=string.lower(raw_button.action.method)
          local panel_text=raw_button.text.panel_text
          table.insert(menu,{
            panel_text,
            function()
              if raw_button.action.backend_url then
                zHttp.request(raw_button.action.backend_url,method,"",apphead,function(code,content)
                  if code==200 then
                    提示(raw_button.text.toast_text)
                  end
                end)
               elseif raw_button.action.intent_url then
                newActivity("browser",{raw_button.action.intent_url.."&source=android&ab_signature=","举报"})
              end
            end
          })
        end
        local pop=showPopMenu(menu)
        pop.showAtLocation(v, Gravity.NO_GRAVITY, downx, downy);
      end
    end)
    return true
  end

  return LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount=function()
      return #data
    end,

    getItemViewType=function(position)
      return 0
    end,

    onCreateViewHolder=function(parent,viewType)
      local views={}
      local loaditemc=获取适配器项目布局("home/home_layout")
      local holder=LuaCustRecyclerHolder(loadlayout(loaditemc,views))
      holder.view.setTag(views)
      -- 将 views 绑定到 card 方便点击事件获取
      views.card.setTag(views)
      views.card.onTouch=cardTouch
      views.card.onClick=cardClick
      views.card.onLongClick=cardLongClick
      return holder
    end,

    onBindViewHolder=function(holder,position)
      local views=holder.view.getTag()
      local data=data[position+1]

      views.标题.text=data.标题
      views.预览内容.text=data.预览内容
      views.评论数.text=data.评论数
      views.点赞数.text=data.点赞数
      
      -- 更新位置 tag
      views.card.setTag(R.id.tag_first, position)
    end,
  }))

end

function base:initpage(view,sr)
  return MyPageTool2:new({
    view=view,
    sr=sr,
    head="homeapphead",
    adapters_func=self.getAdapter,
    func=self.resolvedata,
    allow_prev=true
  })
  :initPage()
  :createfunc()
  :setUrlItem("https://api.zhihu.com/topstory/recommend")
end

return base