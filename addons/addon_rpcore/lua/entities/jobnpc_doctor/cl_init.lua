--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.doctorTable = {}

function items.AdddoctorTable(data)
	data.value = data.value or {}
	items.doctorTable[data.name] = data
end

function items.RemovedoctorTable(name)
	items.doctorTable[name] = nil
end

for k, name in pairs(file.Find("entities/jobnpc_doctor/items/*.lua", "LUA")) do
	include("entities/jobnpc_doctor/items/" .. name)
end
-------------------------------------------------------------------------------------------
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

PrintTable(items.doctorTable)
--收到信息后启用function
net.Receive( "doctor_NPCPANEL", function()		--需每个npc不一样网络信息的名字
	--如果不存在，创建窗口设置不可见
	local menu = vgui.Create("jobnpc_scrmenu")
	menu:jobnpc_button(
		"doctor",
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
		items.doctorTable,
		"citizen",
		"rejob",
		ULib.ucl.groups["doctor"].team.mcost,
		ULib.ucl.groups["doctor"].team.lcost
	)
	menu:jobnpc_base(doctorNPCConfig.NpcModel, "工程", ULib.ucl.groups["doctor"].team.wage, ULib.ucl.groups["doctor"].team.description)
	
	--[[
	if( !NPCMianPANEL ) then
		NPCMianPANEL = vgui.Create( "doctor_menu_npc" )		--需每个npc不一样的界面名字
		NPCMianPANEL:SetVisible( false )
	end

	--如果窗口是可见的
	if ( NPCMianPANEL:IsVisible() ) then
		--设置不可见，设置不能鼠标触控
		NPCMianPANEL:Remove()
		gui.EnableScreenClicker( false )
	else
		--否则设置可见，设置能鼠标触控
		NPCMianPANEL = vgui.Create( "doctor_menu_npc" )		--需每个npc不一样的界面名字
		gui.EnableScreenClicker( true )
	end 
	--]] 
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

        npcmodel:SetModel( doctorNPCConfig.NpcModel )
        
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
		label2:SetPos( 10, 25 )
		label2:SetSize( 160, 13 )
		label2:SetText( "职业名：" .. doctorNPCConfig.jobname )

		local label3 = vgui.Create( "DLabel", infofram )
		label3:SetPos( 10, 45 )
		label3:SetSize( 160, 13 )
		label3:SetText( "职能：" .. doctorNPCConfig.jobable )

		local label4 = vgui.Create( "DLabel", infofram )
		label4:SetPos( 10, 65 )
		label4:SetSize( 160, 13 )
		label4:SetText( "发薪日：" .. doctorNPCConfig.jobpayday )

		local label5 = vgui.Create( "DLabel", infofram )
		label5:AlignTop( 25 )
		label5:AlignLeft( 180 )
		label5:SetSize( 160, 13 )
		label5:SetText( "任务结算：" .. doctorNPCConfig.jobtaskpay )

		local label6 = vgui.Create( "DLabel", infofram )
		label6:AlignTop( 45 )
		label6:AlignLeft( 180 )
		label6:SetSize( 160, 13)
		label6:SetText( "职业权限：" .. doctorNPCConfig.jobperm )

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
			selectbutton:SetText( doctorNPCConfig.buttontext1 )
			selectbutton:SetFont( "trebuchet35" )

			function selectbutton:Paint( w, h )
				if( selectbutton:IsDown() ) then
					selectbutton:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
				elseif( selectbutton:IsHovered() ) then
					selectbutton:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
					--改变对话词
					text1:SetText( doctorNPCConfig.text4 )
					text2:SetText( doctorNPCConfig.text5 )
					text3:SetText( doctorNPCConfig.text6 )
				else
					selectbutton:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_1 )
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
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
				elseif( selectbutton1:IsHovered() ) then
					selectbutton1:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
					--改变对话词
					if(LocalPlayer():GetUserGroup() == "citizen") then
						text1:SetText( doctorNPCConfig.text1 )
						text2:SetText( doctorNPCConfig.text2 )
						text3:SetText( doctorNPCConfig.text3 )
					else
						text1:SetText( doctorNPCConfig.text19 )
						text2:SetText( doctorNPCConfig.text20 )
						text3:SetText( doctorNPCConfig.text21 )
					end
				else
					selectbutton1:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_1 )
				end
			end
			
			selectbutton1.DoClick = function ()

				if ( LocalPlayer():GetUserGroup() ~= "citizen" ) then
					notification.AddLegacy( "请先辞职掉你的" .. LocalPlayer():GetUserGroup() .. "职业再来", NOTIFY_GENERIC, 5 )
					surface.PlaySound( "buttons/button9.wav" )
				else 
					net.Start( "Buttonflow" )
						net.WriteString( "cagjob" )
						net.WriteString( doctorNPCConfig.TeamID )
						net.WriteFloat( ULib.ucl.groups[doctorNPCConfig.TeamID].team.mcost )

					net.SendToServer()
					--notification.AddLegacy( "你已成为" .. doctorNPCConfig.TeamID .. "职业", NOTIFY_GENERIC, 5 )
					--notification.AddLegacy( "并从你的账号扣除" .. doctorNPCConfig.cagjob .. "$入职费用", NOTIFY_GENERIC, 5 )
					--surface.PlaySound( "buttons/lever8.wav" )

					selectbutton:IsValid( false )
					selectbutton1:IsValid( false )
	
					lastbutton()		--按钮变动
				end

			end
			----------------------------------------------------------------------
		end
		--------------------------------------------------------------------------------
		--预变动按钮
		--------------------------------------------------------------------------------
		function lastbutton()

			--任务按钮
			local selectbutton3 = vgui.Create( "DButton", buttonfram )
			selectbutton3:SetPos( 0, 100 )
			selectbutton3:SetSize( 400, 50 )
			selectbutton3:SetText( doctorNPCConfig.buttontext2 )
			selectbutton3:SetFont( "trebuchet35" )

			function selectbutton3:Paint( w, h )
				if( selectbutton3:IsDown() ) then
					selectbutton3:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
				elseif( selectbutton3:IsHovered() ) then
					selectbutton3:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
					--改变对话词
					text1:SetText( doctorNPCConfig.text10 )
					text2:SetText( doctorNPCConfig.text11 )
					text3:SetText( doctorNPCConfig.text12 )
				else
					selectbutton3:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_1 )
				end
			end

			
			selectbutton3.DoClick = function ( len, pl )
				
				net.Start( "Buttonflow" )
				
				net.SendToServer()

			end
			----------------------------------------------------------------------
			--其他按钮
			local selectbutton4 = vgui.Create( "DButton", buttonfram )
			selectbutton4:SetPos( 0, 160 )
			selectbutton4:SetSize( 400, 50 )
			selectbutton4:SetText( doctorNPCConfig.buttontext3 )
			selectbutton4:SetFont( "trebuchet35" )

			function selectbutton4:Paint( w, h )
				if( selectbutton4:IsDown() ) then
					selectbutton4:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
				elseif( selectbutton4:IsHovered() ) then
					selectbutton4:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_2 )
					--改变对话词
					text1:SetText( doctorNPCConfig.text7 )
					text2:SetText( doctorNPCConfig.text8 )
					text3:SetText( doctorNPCConfig.text9 )
				else
					selectbutton4:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_1 )
				end
			end
			
			selectbutton4.DoClick = function ( len, pl )
				print( "2")
				net.Start( "Buttonflow" )
				
				net.SendToServer()

			end
			----------------------------------------------------------------------
			--辞职按钮
			local selectbutton2 = vgui.Create( "DButton", buttonfram )
			selectbutton2:SetPos( 0, 220 )
			selectbutton2:SetSize( 400, 50 )
			selectbutton2:SetText( "辞职" )
			selectbutton2:SetFont( "trebuchet35" )

			function selectbutton2:Paint( w, h )
				if( selectbutton2:IsDown() ) then
					selectbutton2:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_4 )
				elseif( selectbutton2:IsHovered() ) then
					selectbutton2:SetColor( Color( 255, 255, 255 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_4 )
					--改变对话词
					text1:SetText( doctorNPCConfig.text13 )
					text2:SetText( doctorNPCConfig.text14 )
					text3:SetText( doctorNPCConfig.text15 )
				else
					selectbutton2:SetColor( Color( 0, 0, 0 ) )
					draw.RoundedBox( 0, 0, 0, w, h, doctorNPCConfig.ButtonColor_3 )
				end
			end
			
			
			selectbutton2.DoClick = function ( len, pl )
				
				net.Start( "Buttonflow" )
					net.WriteString( "rejob" )
					net.WriteString("")
					net.WriteFloat( ULib.ucl.groups[doctorNPCConfig.TeamID].team.lcost )
				net.SendToServer()
				--notification.AddLegacy( "你辞去了" .. doctorNPCConfig.TeamID .. "工作", NOTIFY_GENERIC, 5 )
				--notification.AddLegacy( "返还" .. doctorNPCConfig.rejob .. "$就职费用", NOTIFY_GENERIC, 5 )
				--surface.PlaySound( "buttons/lever8.wav" )

				selectbutton2:Remove()
				selectbutton3:Remove()
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
			text1:SetText(doctorNPCConfig.text16)
			text1:SetTextColor(doctorNPCConfig.MenuTextColor)

			text2 = vgui.Create("DLabel" , self )
			text2:SetPos(158, 78)
			text2:SetSize(400, 20)
			text2:SetFont("trebuchet30")
			text2:SetText(doctorNPCConfig.text17)
			text2:SetTextColor(doctorNPCConfig.MenuTextColor)

			text3 = vgui.Create("DLabel" , self )
			text3:SetPos(158, 100)
			text3:SetSize(400, 20)
			text3:SetFont("trebuchet30")
			text3:SetText(doctorNPCConfig.text18)
			text3:SetTextColor(doctorNPCConfig.MenuTextColor)

		end

		npcchat()
		
		--判断按钮显示顺序
		if ( LocalPlayer():GetUserGroup() == doctorNPCConfig.TeamID ) then
			lastbutton()
		else
			firstbutton()
		end


	end,

	--绘画
    Paint = function( self, w, h )

        --底面Color( 10, 10, 10, 250 )
        draw.RoundedBox( 0, 4, 3, w - 8, h - 8, doctorNPCConfig.Color_2 )
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
		
		--原描边draw.RoundedBox(0,0,0,w,h, doctorNPCConfig.Color_1 )
		--原底面draw.RoundedBox(0,1,1,w -2,h -2, doctorNPCConfig.Color_2 )
		
		

	   draw.NoTexture()
       surface.SetDrawColor( 255, 255, 255, 255 )
	   surface.DrawPoly( triangle )
	   draw.NoTexture()

    end
} 

--注册一个面板供以后创建。
vgui.Register( "doctor_menu_npc", NPCPANEL )


function ENT:Draw()

    self:DrawModel()

    if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

        local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 90 )

        cam.IgnoreZ( false )
        cam.Start3D2D( self:GetPos() + Vector( 0, 0, 78 ), ang, .1 )
			if doctorNPCConfig.HeaderOutline == true then
				if ( #doctorNPCConfig.HeaderText > 6 )then --若有npc头部标签3个中文字扩大矩形
					draw.RoundedBox(5,-71 -10,-17,146 + 26,40,doctorNPCConfig.HeaderOutlineColour)
				else
					draw.RoundedBox(5,-71,-17,146,40,doctorNPCConfig.HeaderOutlineColour)
				end	
			end
            draw.SimpleTextOutlined( doctorNPCConfig.HeaderText, "trebuchet50", 5, 0, doctorNPCConfig.HeaderTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color( 0, 0, 0, 255 ) )
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





