surface.CreateFont( "trebuchet35", {
    font = "DermaLarge", 
    size = ScreenScale(10),
    weight = 500,
    antialias = true,
})

usermessage.Hook("jobnpc_createmenu", function(um) 
    
    local panel = vgui.Create("DPanel")
    local SpawnPos = um:ReadVector()

    panel:SetSize(500, 250)
    panel:Center()
    panel:MakePopup()
    function panel:Paint( w, h )
        draw.RoundedBox(0, 0, 0, w, h, Color( 0, 0, 0, 255 ))

    end
    local close = vgui.Create("DButton", panel)
    close:SetPos(440, 0)
    close:SetSize(60, 30)
    close:SetText(" X ")
    close:SetFont( "DermaLarge" )
    function close:Paint( w, h )
        close:SetColor(Color( 0, 0, 0 ))
        draw.RoundedBox(0, 0, 0, w, h, Color( 240, 82, 40 ))
        if( close:IsDown() ) then
            close:SetColor(Color( 255, 255, 255 ))
            draw.RoundedBox(0, 0, 0, w, h, Color( 215, 90, 74 ))
        elseif ( close:IsHovered() ) then
            close:SetColor(Color( 255, 255, 255 ))
            draw.RoundedBox(0, 0, 0, w, h, Color( 215, 90, 74 ))
        else
            close:SetColor(Color( 0, 0, 0 ))
            draw.RoundedBox(0, 0, 0, w, h, Color( 240, 82, 40 ))
        end
    end
    
    function close:DoClick()
        panel:Remove()
        close:Remove()
    end
end)

usermessage.Hook("jobnpc_srcmenu", function()
	local menu = vgui.Create("jobnpc_scrmenu")
	menu:jobnpc_button(
		"citizen",				--将成为的职业ID
		{
								--看这是这一行最长的字符了,请注意.
			--就职--按钮npc对话词             
			text1 = "未命名：",
			text2 = "     你确定要这份工作了吗",
			text3 = "     不要嫌弃喔.",
			--聊聊天--按钮npc对话词
			buttontext1         = "聊聊天",
			text5 = "     文明游戏,愉快游玩",
			text6 = "     注意自己的游戏行为,和谐游玩",
			--其他--按钮npc对话词
			buttontext3         = "任务",
			text8 = "     你浪费了我npc的生命!",
			text9 = "     其他",
			--辞职--按钮npc对话词
			text14 = "    你辞掉的话会成为游客!",
			text15 = "    很多东西都会玩不成的.",
			--默认npc对话词
			text17 = "    一天又一天没厌倦吧?",
			text18 = "    食材不够就通知加哦.",

			text20 = "    你已经有别的职业了",
			text21 = "    先去辞职再过来干吧!",

		},
		items.citizenTable,		--职业专属工具的数据表
		"user",					--检查是否user用户/检查按钮是否user用户而显示
		"reuser",				--辞职方法
		0,						--就职费用
		0						--辞职费用
	)
	menu:jobnpc_base(citizenNPCConfig.NpcModel, "公民", ULib.ucl.groups["citizen"].team.wage, ULib.ucl.groups["citizen"].team.description)
	
    gui.EnableScreenClicker( true )
end)

--自定义面板
local PANEL = {}
	--主
function PANEL:Init()
	self:SetSize( 400, 500 )
	self:Center()
	self:SetVisible( true )
	self:MakePopup()
	local x, y = self:GetSize()
	--画按钮
	local button = vgui.Create( "DButton", self )
	button:SetText( "X" )
	button:SetFont( "DermaLarge" )
	button:SetSize( 400, 35 )
	button:SetPos( x - 400, y - 35 )
	
	--按钮改皮肤
	function button:Paint( w, h )
		--如果按钮被按下
		if( button:IsDown() ) then
			button:SetColor( Color( 255, 255, 255 ) )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
		--如果按钮有鼠标停留
		elseif( button:IsHovered() ) then
			button:SetColor( Color( 255, 255, 255 ) )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
		else
			button:SetColor( Color( 0, 0, 0 ) )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 240, 82, 40 ) )
		end

	end

	--按钮点击事件
	button.DoClick = function()
		self:Remove()
		self:SetVisible( false )
		gui.EnableScreenClicker( false )
	end

	--标签
	local Label = vgui.Create( "DLabel", self )
	Label:SetFont( "DermaLarge" )
	Label:SetPos( 3, 0 )
	Label:SetText( "对话框" )
	Label:SizeToContents()

	--底面
	local plymodelpanel = vgui.Create( "DPanel", self ) 
	plymodelpanel:SetSize( 100, 120 )
	plymodelpanel:SetPos( 5, 35 )
	


	self.npcmodel = vgui.Create( "DModelPanel", plymodelpanel  )
	self.npcmodel:SetSize( 100, 120 )

	--self.npcmodel:SetModel( citizenNPCConfig.NpcModel )
	
	self.npcmodel:Dock( FILL )
	function self.npcmodel:LayoutEntity( Entity ) return end
	local angl = 60
	self.npcmodel:SetCamPos(Vector(40,-15,angl))
	self.npcmodel:SetLookAt(Vector(0,0,(angl + 3)))
	self.npcmodel:SetFOV(20)		
	--------------------------------------------------------------------------------
	--招聘信息框
	--------------------------------------------------------------------------------
	local infofram = vgui.Create( "DPanel", self )
	infofram:SetSize( 395, 100 )
	infofram:SetPos( 0, y - 345 )
	infofram.Paint = function( self, w, h )
		draw.RoundedBox( 0, 4, 1, w, h, Color( 10, 10, 10, 200 ) )
	end

	local label1 = vgui.Create( "DLabel", infofram )
	label1:SetPos( 5, 0 )
	label1:SetText( "职业信息" )
	label1:SetFont( "Trebuchet18" )

	self.label2 = vgui.Create( "DLabel", infofram )
	self.label2:SetPos( 10, 20 )
	self.label2:SetSize( 160, 13 )
	--label2:SetText( "职业名：" .. citizenNPCConfig.jobname )

	self.label4 = vgui.Create( "DLabel", infofram )
	self.label4:SetPos( 10, 40 )
	self.label4:SetSize( 160, 13 )
	--label4:SetText( "发薪日：" .. citizenNPCConfig.jobpayday )

	self.label3 = vgui.Create( "DLabel", infofram )
	self.label3:SetPos( 10, 50 )
	self.label3:SetSize( 360, 60 )
	--label3:SetText( "职业说明：" .. "\n" .. ULib.ucl.groups[citizenNPCConfig.TeamID].team.description )
	self.label3:SetWrap( true )



	--绘画
	self.Paint = function(self, w, h) 

		--底面Color( 10, 10, 10, 250 )
        draw.RoundedBox( 0, 4, 3, w - 8, h - 8, citizenNPCConfig.Color_2 )
        --描边
        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawOutlinedRect( 4, 3, w - 8, h - 8 )
        --标题背景
		draw.RoundedBox( 0, 0, 0, w , h - 465, Color( 57, 57, 57 ))

		draw.RoundedBox( 0, 160, 50, 230, 75, Color(255,255,255) )

		local triangle = {			--				 /\	x160y50
			{ x = 105, y = 90 },	--				/  \
			{ x = 160, y = 50 },	--			   /    \
			{ x = 160, y = 125 }	--			  /      \
		}							--   x105y90 ---------- x160y125
		
		--原描边draw.RoundedBox(0,0,0,w,h, citizenNPCConfig.Color_1 )
		--原底面draw.RoundedBox(0,1,1,w -2,h -2, citizenNPCConfig.Color_2 )
		
		

	   draw.NoTexture()
       surface.SetDrawColor( 255, 255, 255, 255 )
	   surface.DrawPoly( triangle )
	   draw.NoTexture()

	end
end

function PANEL:jobnpc_button(TeamID, textarr, toolTable, checkjob, reuser, mcost, lcost)
	
	local x, y = self:GetSize()

	local textdate = textarr
	--按钮框------------------------------------------------------------------------
	local buttonfram = vgui.Create( "DPanel", self )
	buttonfram:SetSize( 400, 310 )
	buttonfram:SetPos( 0, y - 345 )
	buttonfram.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 0 ) )
	end

	--------------------------------------------------------------------------------
	--初始按钮
	--------------------------------------------------------------------------------
	function firstbutton ()

		--聊聊天按钮
		local selectbutton = vgui.Create( "DButton", buttonfram )
		selectbutton:SetPos( 0, 160 )
		selectbutton:SetSize( 400, 50 )
		selectbutton:SetText( textdate["buttontext1"] )
		selectbutton:SetFont( "trebuchet35" )

		function selectbutton:Paint( w, h )
			if( selectbutton:IsDown() ) then
				selectbutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
			elseif( selectbutton:IsHovered() ) then
				selectbutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
				--改变对话词
				text1:SetText( textdate["text1"] )
				text2:SetText( textdate["text5"] )
				text3:SetText( textdate["text6"] )
			else
				selectbutton:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 67, 176, 92, 255 ) )-- 默认颜色
			end
		end

		
		selectbutton.DoClick = function ( len, pl )
			print( "1")
			net.Start( "Buttonflow" )

			net.SendToServer()

		end
		--选职业按钮-------------------------------------------------------------
		local selectbutton1 = vgui.Create( "DButton", buttonfram )
		selectbutton1:SetPos( 0, 100 )
		selectbutton1:SetSize( 400, 50 )
		selectbutton1:SetText( "就职" )
		selectbutton1:SetFont( "trebuchet35" )

		function selectbutton1:Paint( w, h )
			if( selectbutton1:IsDown() ) then
				selectbutton1:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
			elseif( selectbutton1:IsHovered() ) then
				selectbutton1:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
				--改变对话词
				if(LocalPlayer():GetUserGroup() == checkjob) then
					text1:SetText( textdate["text1"] )
					text2:SetText( textdate["text2"] )
					text3:SetText( textdate["text3"] )
				else
					text1:SetText( textdate["text1"] )
					text2:SetText( textdate["text20"] )
					text3:SetText( textdate["text21"] )
				end
			else
				selectbutton1:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 67, 176, 92, 255 ) )-- 默认颜色
			end
		end
		
		selectbutton1.DoClick = function ()

			if ( LocalPlayer():GetUserGroup() ~= checkjob ) then
				notification.AddLegacy( "请先辞职掉你的" .. LocalPlayer():GetUserGroup() .. "职业再来", NOTIFY_GENERIC, 5 )
				surface.PlaySound( "buttons/button9.wav" )
			else 
				net.Start( "Buttonflow" )
					net.WriteString( "cagjob" )
					net.WriteString( TeamID )
					net.WriteFloat( mcost )
				net.SendToServer()
				--notification.AddLegacy( "你已成为" .. citizenNPCConfig.TeamID .. "职业", NOTIFY_GENERIC, 5 )
				--surface.PlaySound( "buttons/lever8.wav" )

				selectbutton:Remove()
				selectbutton1:Remove()

				lastbutton()		--按钮变动
			end

		end
		----------------------------------------------------------------------
	end
	--------------------------------------------------------------------------------
	--预变动按钮
	--------------------------------------------------------------------------------
	function lastbutton()

		----------------------------------------------------------------------
		--任务按钮
		local selectbutton4 = vgui.Create( "DButton", buttonfram )
		selectbutton4:SetPos( 0, 190 )
		selectbutton4:SetSize( 400, 50 )
		selectbutton4:SetText( textdate["buttontext3"] )
		selectbutton4:SetFont( "trebuchet35" )
		
		function selectbutton4:Paint( w, h )
			if( selectbutton4:IsDown() ) then
				selectbutton4:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
			elseif( selectbutton4:IsHovered() ) then
				selectbutton4:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 35, 162, 77, 255 ) )-- 停留颜色
				--改变对话词
				text1:SetText( textdate["text1"] )
				text2:SetText( textdate["text8"] )
				text3:SetText( textdate["text9"] )
			else
				selectbutton4:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 67, 176, 92, 255 ) )-- 默认颜色
			end
		end
		
		selectbutton4.DoClick = function ( len, pl )
			print( "2")
			--net.Start( "Buttonflow" )
			--local newfrom = vgui.Create("citizen_arm")
			--newfrom:Center()
			--net.SendToServer()

		end

		--spawnmenu框------------------------------------------------------------------------
		local menufram = vgui.Create( "DPanel", self )
		menufram:SetSize( 400, 100 )
		menufram:SetPos( 0, y - 260 )
		menufram.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 0 ) )
		end
		--------------------------------------------------------------------------------
		--初始
		--------------------------------------------------------------------------------
		--筛选table
		function cTable()
			local tbl = {}
			for key, data in pairs(toolTable) do
				tbl[data.models[1]] = {
					name = data.name,
					level = data.level,
					textinfo = data.textinfo,
					type = key,
				}
			end	
			return tbl
		end
		--创建生成页
		local spawnmenu = vgui.Create("jobnpc:spawnmune", menufram)
		spawnmenu:cSpawn(cTable(), TeamID)

		----------------------------------------------------------------------
		--辞职按钮
		local selectbutton2 = vgui.Create( "DButton", buttonfram )
		selectbutton2:SetPos( 0, 250 )
		selectbutton2:SetSize( 400, 50 )
		selectbutton2:SetText( "辞职" )
		selectbutton2:SetFont( "trebuchet35" )

		function selectbutton2:Paint( w, h )
			if( selectbutton2:IsDown() ) then
				selectbutton2:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 154, 0, 255 ) )-- 停留颜色
			elseif( selectbutton2:IsHovered() ) then
				selectbutton2:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 154, 0, 255 ) )-- 停留颜色
				--改变对话词
				text1:SetText( textdate["text1"] )
				text2:SetText( textdate["text14"] )
				text3:SetText( textdate["text15"] )
			else
				selectbutton2:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 183, 79, 255 ) )-- 默认颜色
			end
		end
		selectbutton2.DoClick = function ( len, pl )
			
			net.Start( "Buttonflow" )
				net.WriteString( reuser )
				net.WriteString("")
				net.WriteFloat( lcost )
			net.SendToServer()
			--notification.AddLegacy( "你辞去了" .. citizenNPCConfig.TeamID .. "工作", NOTIFY_GENERIC, 5 )
			--surface.PlaySound( "buttons/lever8.wav" )
			menufram:Remove()
			spawnmenu:Remove()

			selectbutton2:Remove()
			selectbutton4:Remove()

			firstbutton()

		end
		----------------------------------------------------------------------
	end

	function npcchat( check )

		--第一段
		text1 = vgui.Create("DLabel" , self )
		text1:SetPos(158, 55)
		text1:SetSize(400, 20)
		text1:SetFont("trebuchet30")
		text1:SetText(citizenNPCConfig.text16)
		text1:SetTextColor(Color( 0, 0, 0, 255))	--菜单字体颜色

		text2 = vgui.Create("DLabel" , self )
		text2:SetPos(158, 78)
		text2:SetSize(400, 20)
		text2:SetFont("trebuchet30")
		text2:SetText(citizenNPCConfig.text17)
		text2:SetTextColor(Color( 0, 0, 0, 255))	--菜单字体颜色

		text3 = vgui.Create("DLabel" , self )
		text3:SetPos(158, 100)
		text3:SetSize(400, 20)
		text3:SetFont("trebuchet30")
		text3:SetText(citizenNPCConfig.text18)
		text3:SetTextColor(Color( 0, 0, 0, 255))	--菜单字体颜色

	end

	npcchat()

	--判断按钮显示顺序
	if ( LocalPlayer():GetUserGroup() == TeamID ) then
		lastbutton()
	else
		firstbutton()
	end
end

function PANEL:jobnpc_base(jobmodel, jobname, jobpayday, description)

	self.npcmodel:SetModel( jobmodel )

	self.label2:SetText( "职业名：" .. jobname )

	self.label4:SetText( "发薪日：" .. jobpayday )

	self.label3:SetText( "职业说明：" .. "\n" .. description )

end

vgui.Register("jobnpc_scrmenu", PANEL)

--沿用的读table遍历spawn方法
--画生成按钮面板
local PANEL = {}

function PANEL:Init()
	
	self:SetSize( 400, 80 )
	self:SetPos( 20, 30 )
	self:EnableHorizontal(true)
	self:EnableVerticalScrollbar(true)
	
end
--可换table的按钮面板
function PANEL:cSpawn(table, jobname)
	self.tbl = {}
	self.tbl = table
	-- 添加按钮
	for models, data in pairs(self.tbl) do

		local icon = vgui.Create("SpawnIcon")
		icon:SetModel( models )
		icon:SetSize(60,60)
		icon:SetToolTip(data.name .. ":" .. "\n" .. data.textinfo )

		icon.IsDown = function()
			if !data.level then return end
			if (LocalPlayer():GetNWInt("level") < data.level) then
				return false
			else
				return true
			end
		end

		icon.Paint = function(self, w, h)	--默认按钮样式
			surface.SetDrawColor( Color( 10, 10, 10, 255 ) )
			surface.DrawOutlinedRect( 0, 0, w, h )
			draw.RoundedBox(0,0,0,w,h,Color( 10, 10, 10, 200))
		end

		function icon:OnCursorEntered()	--当鼠标进入按钮显示
			icon.Paint = function(self, w, h)
				surface.SetDrawColor( Color( 255, 255, 255, 1 ) )
				surface.DrawOutlinedRect( 0, 0, w, h )
				draw.RoundedBox(0,0,0,w,h,Color( 10, 10, 10, 255))
			end
		end
		function icon:OnCursorExited()	--当鼠标离开按钮恢复
			icon.Paint = function(self, w, h)
				surface.SetDrawColor( Color( 10, 10, 10, 255 ) )
				surface.DrawOutlinedRect( 0, 0, w, h )
				draw.RoundedBox(0,0,0,w,h,Color( 10, 10, 10, 200))
			end
		end

		function icon:PaintOver(w, h)
			--
			draw.SimpleText( data.level .. "级解锁", "DermaDefault", 5, 46, color_black, TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
			draw.SimpleText( data.level .. "级解锁", "DermaDefault", 4, 45, Color( 255, 250, 33, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
		end

		icon.DoClick = function()
			RunConsoleCommand(jobname .. "_tool", data.type)
		end

		self:AddItem(icon)	--添加到DPanelList
	end
end
vgui.Register("jobnpc:spawnmune", PANEL,"DPanelList")

local PANEL = {
	Init = function( self )
		self:SetSize(300, 150)
		
	end,

	Paint = function( self, w, h )
		draw.RoundedBox( 0, 4, 3, w - 8, h - 8, citizenNPCConfig.Color_2 )
	end
}


vgui.Register("citizen_arm", PANEL, "DPanel")