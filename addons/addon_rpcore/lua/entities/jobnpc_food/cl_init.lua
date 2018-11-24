--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.foodTable = {}

function items.AddFoodTable(data)
	data.value = data.value or 0
	items.foodTable[data.name] = data
end

function items.RemoveFoodTable(name)
	items.foodTable[name] = nil
end

for key, name in pairs(file.Find("entities/jobnpc_food/items/*.lua", "LUA")) do
	include("entities/jobnpc_food/items/"..name)
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
net.Receive( "food_NPCPANEL", function()		--需每个npc不一样的网络信息名字
	--如果不存在，创建窗口设置不可见
	if( !NPCMianPANEL ) then
		NPCMianPANEL = vgui.Create( "food_menu_npc" )		--需每个npc不一样的界面名字
		NPCMianPANEL:SetVisible( false )
	end

	--如果窗口是可见的
	if ( NPCMianPANEL:IsVisible() ) then
		--设置不可见，设置不能鼠标触控
		NPCMianPANEL:Remove()
		gui.EnableScreenClicker( false )
	else
		--否则设置可见，设置能鼠标触控
		NPCMianPANEL = vgui.Create( "food_menu_npc" )		--需每个npc不一样的界面名字
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
		
		--npc对话框照片
		local npcmodel = vgui.Create( "DModelPanel", plymodelpanel  )
		npcmodel:SetSize( 100, 120 )

        npcmodel:SetModel( foodNPCConfig.NpcModel )
        
		npcmodel:Dock( FILL )
		function npcmodel:LayoutEntity( Entity ) return end
		local angl = 60
		npcmodel:SetCamPos(Vector(40,-15,angl))
		npcmodel:SetLookAt(Vector(0,0,(angl + 3)))
		npcmodel:SetFOV(20)		

		function npcchat( check )

			--第一段
			text1 = vgui.Create("DLabel" , self )
			text1:SetPos(158, 55)
			text1:SetSize(400, 20)
			text1:SetFont("trebuchet30")
			text1:SetText(foodNPCConfig.text1)
			text1:SetTextColor(foodNPCConfig.MenuTextColor)

			text2 = vgui.Create("DLabel" , self )
			text2:SetPos(158, 78)
			text2:SetSize(400, 20)
			text2:SetFont("trebuchet30")
			text2:SetText(foodNPCConfig.text2)
			text2:SetTextColor(foodNPCConfig.MenuTextColor)

			text3 = vgui.Create("DLabel" , self )
			text3:SetPos(158, 100)
			text3:SetSize(400, 20)
			text3:SetFont("trebuchet30")
			text3:SetText(foodNPCConfig.text3)
			text3:SetTextColor(foodNPCConfig.MenuTextColor)

		end

		npcchat()
		--------------------------------------------------------------------------------
		--招聘信息框
		--------------------------------------------------------------------------------
		local infofram = vgui.Create( "DPanel", self )
		infofram:SetSize( 395, 83 )
		infofram:SetPos( 0, y - 345 )
		infofram.Paint = function( self, w, h )
			draw.RoundedBox( 0, 4, 1, w, h, Color( 10, 10, 10, 200 ) )
		end

		local label1 = vgui.Create( "DLabel", infofram )
		label1:SetPos( 5, 0 )
		label1:SetSize( 160, 20 )
		label1:SetText( "简单说明" )
		label1:SetFont( "Trebuchet18" )

		local label2 = vgui.Create( "DLabel", infofram )
		label2:SetPos( 10, 25 )
		label2:SetSize( 400, 13 )
		label2:SetText( "玩法: " .. foodNPCConfig.plyinfo )

		local label3 = vgui.Create( "DLabel", infofram )
		label3:SetPos( 10, 45 )
		label3:SetSize( 400, 13 )
		label3:SetText( "操作: " .. foodNPCConfig.limit )

		local label4 = vgui.Create( "DLabel", infofram )
		label4:SetPos( 10, 65 )
		label4:SetSize( 400, 13 )
		label4:SetText( "  " .. foodNPCConfig.faq )

		--按钮框------------------------------------------------------------------------
		local npcmenufram = vgui.Create( "DPanel", self )
		npcmenufram:SetSize( 400, 227 )
		npcmenufram:SetPos( 0, y - 262 )
		npcmenufram.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 0 ) )
		end
		--------------------------------------------------------------------------------
		--初始
		--------------------------------------------------------------------------------
		--筛选table
		function cTable(plane)
			local tbl = {}
			for key, data in pairs(items.food) do
				if plane == "food" then
					if !data.isbox then
						tbl[data.models[1]] = {
							name = data.name,
							cost = data.cost,
							price = data.price,
							textinfo = data.textinfo,
							type = key,
						}
					end
				elseif plane == "box" then
					if data.isbox then
						tbl[data.models[1]] = {
							name = data.name,
							price = data.price,
							textinfo = data.textinfo,
							type = key,
						}
					end
				end
			end	
			return tbl
		end

		--创建生成页
		local spawnmenu = vgui.Create("food:spawnmune", npcmenufram)
		spawnmenu:cSpawn(cTable("food"))

		--类别按钮
		local boxtypebutton = vgui.Create("DButton", npcmenufram)
		boxtypebutton:SetText( "食物类" )
		boxtypebutton:SetFont( "trebuchet30" )
		boxtypebutton:SetSize( 90, 30 )
		boxtypebutton:SetPos( 6, 0 )
		--按钮改皮肤
		function boxtypebutton:Paint( w, h )
			--如果按钮被按下
			if( boxtypebutton:IsDown() ) then
				boxtypebutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 230, 182, 23, 255 ) )
			--如果按钮有鼠标停留
			elseif( boxtypebutton:IsHovered() ) then
				boxtypebutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 230, 182, 23, 255 ) )
			else
				boxtypebutton:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 202, 25, 255 ) )
			end
		end
		boxtypebutton.DoClick = function()
			spawnmenu:Clear()
			spawnmenu:cSpawn(cTable("food"))
		end
		--类别按钮
		local boxtypebutton = vgui.Create("DButton", npcmenufram)
		boxtypebutton:SetText( "货架类" )
		boxtypebutton:SetFont( "trebuchet30" )
		boxtypebutton:SetSize( 90, 30 )
		boxtypebutton:SetPos( 100, 0 )
		--按钮改皮肤
		function boxtypebutton:Paint( w, h )
			--如果按钮被按下
			if( boxtypebutton:IsDown() ) then
				boxtypebutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 187, 246, 255 ) )
			--如果按钮有鼠标停留
			elseif( boxtypebutton:IsHovered() ) then
				boxtypebutton:SetColor( Color( 255, 255, 255 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 187, 246, 255 ) )
			else
				boxtypebutton:SetColor( Color( 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 98, 225, 251, 255 ) )
			end
		end
		boxtypebutton.DoClick = function()
			spawnmenu:Clear()
			spawnmenu:cSpawn(cTable("box"))
		end


	end,

	--绘画
    Paint = function( self, w, h )

        --底面Color( 10, 10, 10, 250 )
        draw.RoundedBox( 0, 4, 3, w - 8, h - 8, foodNPCConfig.Color_2 )
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
		
		--原描边draw.RoundedBox(0,0,0,w,h, foodNPCConfig.Color_1 )
		--原底面draw.RoundedBox(0,1,1,w -2,h -2, foodNPCConfig.Color_2 )
		
		

	   draw.NoTexture()
       surface.SetDrawColor( 255, 255, 255, 255 )
	   surface.DrawPoly( triangle )
	   draw.NoTexture()

    end
} 

--注册一个面板供以后创建。
vgui.Register( "food_menu_npc", NPCPANEL )


--画生成按钮面板
local PANEL = {}

function PANEL:Init()
	
	self:SetSize( 400, 210 )
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
			--货架类价格
			if !data.cost then
				draw.SimpleText( data.price .. "$", "DermaDefault", 5, 46, color_black, TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				draw.SimpleText( data.price .. "$", "DermaDefault", 4, 45, Color( 255, 250, 33, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
				return
			end
			--食物类成本
			draw.SimpleText( data.cost .. "$", "DermaDefault", 5, 46, color_black, TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
			draw.SimpleText( data.cost .. "$", "DermaDefault", 4, 45, Color( 255, 250, 33, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
		end

		icon.DoClick = function()
			RunConsoleCommand("buyitmes_food", data.type)
		end

		self:AddItem(icon)	--添加到DPanelList
	end
end
vgui.Register("food:spawnmune", PANEL,"DPanelList")


--画npc头顶3D字体
function ENT:Draw()

    self:DrawModel()

    if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

        local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 90 )

        cam.IgnoreZ( false )
        cam.Start3D2D( self:GetPos() + Vector( 0, 0, 78 ), ang, .1 )
			if foodNPCConfig.HeaderOutline == true then
				if ( #foodNPCConfig.HeaderText > 6 )then --若有npc头部标签3个中文字扩大矩形
					draw.RoundedBox(5,-71 -10,-17,146 + 26,40,foodNPCConfig.HeaderOutlineColour)
				else
					draw.RoundedBox(5,-71,-17,146,40,foodNPCConfig.HeaderOutlineColour)
				end	
			end
            draw.SimpleTextOutlined( foodNPCConfig.HeaderText, "trebuchet50", 5, 0, foodNPCConfig.HeaderTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color( 0, 0, 0, 255 ) )
        cam.End3D2D()

    end

end





