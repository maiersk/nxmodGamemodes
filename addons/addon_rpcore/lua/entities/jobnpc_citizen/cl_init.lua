--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.citizenTable = {}

function items.AddcitizenTable(data)
	data.value = data.value or 0
	items.citizenTable[data.name] = data
end

function items.RemovecitizenTable(name)
	items.citizenTable[name] = nil
end

for key, name in pairs(file.Find("entities/jobnpc_citizen/items/*.lua", "LUA")) do
	include("entities/jobnpc_citizen/items/"..name)
end
------------------------------------------------------------------------------------------
include('shared.lua')
surface.CreateFont( "trebuchet50", {
    font = "Trebuchet MS", 
    size = ScreenScale(30),
    weight = 500,
    antialias = true,
})
surface.CreateFont( "trebuchet35", {
    font = "DermaLarge", 
    size = ScreenScale(10),
    weight = 500,
    antialias = true,
})

surface.CreateFont( "trebuchet30", {
    font = "Trebuchet MS", 
    size = ScreenScale(7.5),
    weight = 500,
    antialias = true,
})

surface.CreateFont( "trebuchet20", {
    font = "Trebuchet MS", 
    size = ScreenScale(7.5),
    weight = 500,
    antialias = true,
})

surface.CreateFont( "my_npc", { 
	font = "Arial",
	extended = true,
	size = 200,
	weight = 1000
} )

--收到信息后启用function
net.Receive( "citizen_NPCPANEL", function()		--需每个npc不一样的网络信息名字
	--如果不存在，创建窗口设置不可见
	if( !NPCMianPANEL ) then
		NPCMianPANEL = vgui.Create( "citizen_menu_npc" )		--需每个npc不一样的界面名字
		NPCMianPANEL:SetVisible( false )
	end

	--如果窗口是可见的
	if ( NPCMianPANEL:IsVisible() ) then
		--设置不可见，设置不能鼠标触控
		NPCMianPANEL:Remove()
		gui.EnableScreenClicker( false )
	else
		--否则设置可见，设置能鼠标触控
		NPCMianPANEL = vgui.Create( "citizen_menu_npc" )		--需每个npc不一样的界面名字
		gui.EnableScreenClicker( true )
	end  
end )

--自定义面板
local NPCPANEL = {
	--主
	Init = function( self )
		
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
		

		

		local npcmodel = vgui.Create( "DModelPanel", plymodelpanel  )
		npcmodel:SetSize( 100, 120 )

        npcmodel:SetModel( citizenNPCConfig.NpcModel )
        
		npcmodel:Dock( FILL )
		function npcmodel:LayoutEntity( Entity ) return end
		local angl = 60
		npcmodel:SetCamPos(Vector(40,-15,angl))
		npcmodel:SetLookAt(Vector(0,0,(angl + 3)))
		npcmodel:SetFOV(20)		
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
		label1:SetText( "招聘信息" )
		label1:SetFont( "Trebuchet18" )

		local label2 = vgui.Create( "DLabel", infofram )
		label2:SetPos( 10, 20 )
		label2:SetSize( 160, 13 )
		label2:SetText( "职业名：" .. citizenNPCConfig.jobname )

		local label4 = vgui.Create( "DLabel", infofram )
		label4:SetPos( 10, 40 )
		label4:SetSize( 160, 13 )
		label4:SetText( "发薪日：" .. citizenNPCConfig.jobpayday )

		local label3 = vgui.Create( "DLabel", infofram )
		label3:SetPos( 10, 50 )
		label3:SetSize( 360, 60 )
		label3:SetText( "职业说明：" .. "\n" .. ULib.ucl.groups[citizenNPCConfig.TeamID].team.description )
		label3:SetWrap( true )

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

			--其他按钮
			local selectbutton = vgui.Create( "DButton", buttonfram )
			selectbutton:SetPos( 0, 160 )
			selectbutton:SetSize( 400, 50 )
			selectbutton:SetText( citizenNPCConfig.buttontext1 )
			selectbutton:SetFont( "trebuchet35" )

			function selectbutton:Paint( w, h )
				if( selectbutton:IsDown() ) then
					selectbutton:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
				elseif( selectbutton:IsHovered() ) then
					selectbutton:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
					--改变对话词
					text1:SetText( citizenNPCConfig.text4 )
					text2:SetText( citizenNPCConfig.text5 )
					text3:SetText( citizenNPCConfig.text6 )
				else
					selectbutton:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_1 )
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
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
				elseif( selectbutton1:IsHovered() ) then
					selectbutton1:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
					--改变对话词
					if(LocalPlayer():GetUserGroup() == "user") then
						text1:SetText( citizenNPCConfig.text1 )
						text2:SetText( citizenNPCConfig.text2 )
						text3:SetText( citizenNPCConfig.text3 )
					else
						text1:SetText( citizenNPCConfig.text19 )
						text2:SetText( citizenNPCConfig.text20 )
						text3:SetText( citizenNPCConfig.text21 )
					end
				else
					selectbutton1:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_1 )
				end
			end
			
			selectbutton1.DoClick = function ()

				if ( LocalPlayer():GetUserGroup() ~= "user" ) then
					notification.AddLegacy( "请先辞职掉你的" .. LocalPlayer():GetUserGroup() .. "职业再来", NOTIFY_GENERIC, 5 )
					surface.PlaySound( "buttons/button9.wav" )
				else 
					net.Start( "Buttonflow" )
						net.WriteString( "cagjob" )
						net.WriteString( citizenNPCConfig.TeamID )
						net.WriteFloat( 0 )
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
			selectbutton4:SetText( citizenNPCConfig.buttontext3 )
			selectbutton4:SetFont( "trebuchet35" )
			
			function selectbutton4:Paint( w, h )
				if( selectbutton4:IsDown() ) then
					selectbutton4:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
				elseif( selectbutton4:IsHovered() ) then
					selectbutton4:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_2 )
					--改变对话词
					text1:SetText( citizenNPCConfig.text7 )
					text2:SetText( citizenNPCConfig.text8 )
					text3:SetText( citizenNPCConfig.text9 )
				else
					selectbutton4:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_1 )
				end
			end
			
			selectbutton4.DoClick = function ( len, pl )
				print( "2")
				--net.Start( "Buttonflow" )
				local newfrom = vgui.Create("citizen_arm")
				newfrom:Center()
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
				for key, data in pairs(items.citizenTable) do
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
			local spawnmenu = vgui.Create("citizen:spawnmune", menufram)
			spawnmenu:cSpawn(cTable())

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
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_4 )
				elseif( selectbutton2:IsHovered() ) then
					selectbutton2:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_4 )
					--改变对话词
					text1:SetText( citizenNPCConfig.text13 )
					text2:SetText( citizenNPCConfig.text14 )
					text3:SetText( citizenNPCConfig.text15 )
				else
					selectbutton2:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, citizenNPCConfig.ButtonColor_3 )
				end
			end
			selectbutton2.DoClick = function ( len, pl )
				
				net.Start( "Buttonflow" )
					net.WriteString( "reuser" )
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
			text1:SetTextColor(citizenNPCConfig.MenuTextColor)

			text2 = vgui.Create("DLabel" , self )
			text2:SetPos(158, 78)
			text2:SetSize(400, 20)
			text2:SetFont("trebuchet30")
			text2:SetText(citizenNPCConfig.text17)
			text2:SetTextColor(citizenNPCConfig.MenuTextColor)

			text3 = vgui.Create("DLabel" , self )
			text3:SetPos(158, 100)
			text3:SetSize(400, 20)
			text3:SetFont("trebuchet30")
			text3:SetText(citizenNPCConfig.text18)
			text3:SetTextColor(citizenNPCConfig.MenuTextColor)

		end

		npcchat()

		--判断按钮显示顺序
		if ( LocalPlayer():GetUserGroup() == citizenNPCConfig.TeamID ) then
			lastbutton()
		else
			firstbutton()
		end


	end,

	--绘画
    Paint = function( self, w, h )

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
} 

--注册一个面板供以后创建。
vgui.Register( "citizen_menu_npc", NPCPANEL )

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
function PANEL:cSpawn(table)
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
			RunConsoleCommand("citizen_tool", data.type)
		end

		self:AddItem(icon)	--添加到DPanelList
	end
end
vgui.Register("citizen:spawnmune", PANEL,"DPanelList")

local PANEL = {
	Init = function( self )
		self:SetSize(300, 150)
		
	end,

	Paint = function( self, w, h )
		draw.RoundedBox( 0, 4, 3, w - 8, h - 8, citizenNPCConfig.Color_2 )
	end
}


vgui.Register("citizen_arm", PANEL, "DPanel")

function ENT:Draw()

    self:DrawModel()

    if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

        local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 90 )

        cam.IgnoreZ( false )
        cam.Start3D2D( self:GetPos() + Vector( 0, 0, 78 ), ang, .1 )
			if citizenNPCConfig.HeaderOutline == true then
				if ( #citizenNPCConfig.HeaderText > 6 )then --若有npc头部标签3个中文字扩大矩形
					draw.RoundedBox(5,-71 -10,-17,146 + 26,40,citizenNPCConfig.HeaderOutlineColour)
				else
					draw.RoundedBox(5,-71,-17,146,40,citizenNPCConfig.HeaderOutlineColour)
				end	
			end
            draw.SimpleTextOutlined( citizenNPCConfig.HeaderText, "trebuchet50", 5, 0, citizenNPCConfig.HeaderTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color( 0, 0, 0, 255 ) )
        cam.End3D2D()

    end

end

hook.Add("PostDrawOpaqueRenderables", "NPCPANEL", function()
	for _, ent in pairs (ents.FindByClass("panel")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)

			cam.Start3D2D(ent:GetPos()+ent:GetUp()*76, Ang, 0.10)
				draw.SimpleTextOutlined( "NPC PANEL", "my_npc", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(255,255,255,255) )
			cam.End3D2D()
		end
	end
end)





