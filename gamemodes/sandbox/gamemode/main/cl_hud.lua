-- Created by Azrod and Gaerisson
ectaliahud = {}
hasava = 1
avaonce = 0
local HiddenElements = {['CHudHealth']=true,['CHudBattery']=true,['CHudAmmo']=true,['CHudSecondaryAmmo']=true} 
local function hidehud( el ) if HiddenElements[el] then return false end end 
hook.Add("HUDShouldDraw", "Hide", hidehud)

surface.CreateFont("Hud",{font = "TabLarge", size = 40, weight = 500})
surface.CreateFont("Indicator",{font = "TabLarge", size = 26, weight = 500})
surface.CreateFont("Indicator2",{font = "TabLarge", size = 25, weight = 500})

local ply = LocalPlayer()
function InitFile()
	if( !file.Exists("Whud.txt", "DATA") ) then
		file.Write("Whud.txt", "av_hide: 1")
	end
	if (file.Read("Whud.txt", "DATA") == "av_hide: 1") then
		hasava = 1
	end
	if (file.Read("Whud.txt", "DATA") == "av_hide: 0") then
		hasava = 0
	end
end

	--饥饿值hud	
function hungerhud()
		local x = 110
		local y = ScrH() - 74
		local w = 392
		local h = 20

		-- ==饥饿值描边框
		surface.SetDrawColor( 25, 5, 25, 200)
		surface.DrawRect( 110, ScrH() - 76, 395, 20)
		-- 底面
		surface.SetDrawColor( 213, 100, 0, 200)
		surface.DrawRect( x+2, y, w-1, h-4)
		-- 值 LocalPlayer():GetNWFloat("shm_hunger")*2.4-6,h-6,Color(255,200,0,200)
		if not LocalPlayer():Alive() then return end
		draw.RoundedBox(0,x+2,y,391 * LocalPlayer():GetNWFloat("hunger") / 100,h-4,Color(255,200,0,200))
		draw.SimpleText( LocalPlayer():GetNWFloat("hunger"), "Indicator2", 315 - (string.len(LocalPlayer():GetNWFloat("hunger")) * 6 ), ScrH() - 79, color_black, 0, 0)

end
	hook.Add("HUDDrawTargetID", "Hungerhud", hungerhud)
function HUDdraw()
	ColorHUD = Color(57, 57, 57)
	local ply = LocalPlayer()
	--武器变量
	local special = {"weapon_ar2", "weapon_smg1", "weapon_rpg"}
	local special2 = {"weapon_frag", "weapon_rpg", "fas2_m67", "tfa_csgo_frag", "tfa_csgo_flash", "tfa_csgo_smoke", "tfa_csgo_incen", "weapon_slam"}
	local ignore = {"weapon_physcannon", "weapon_physgun"}
	--判断武器
    	if !(ply and ply:Alive()) then return end
    	if !(ply:GetActiveWeapon() and IsValid(ply:GetActiveWeapon())) then return end
    	local wep = ply:GetActiveWeapon():Clip1().."/"..ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType())
    	local wep2 = ply:GetAmmoCount(ply:GetActiveWeapon():GetSecondaryAmmoType())

--判断武器弹药显示hud
	if(ply:GetActiveWeapon():Clip1() != -1) then
    	if(!table.HasValue(ignore,ply:GetActiveWeapon():GetClass())) then
        	if(table.HasValue(special,ply:GetActiveWeapon():GetClass()) and ply:GetAmmoCount(ply:GetActiveWeapon():GetSecondaryAmmoType()) != 0) then
				//主
				--描边
				draw.RoundedBox(5 ,ScrW() - 257, ScrH() - 82, 154, 64, Color( 0, 0, 0, 200))
				--面
				draw.RoundedBox(5, ScrW() - 255, ScrH() - 30 - 50 , 150, 60, ColorHUD)
				--弹药数
            	draw.DrawText(wep,"Hud", ScrW() - 180, ScrH() - 72, Color( 255, 255, 255) , TEXT_ALIGN_CENTER)
				//次要
				--描边
				draw.RoundedBox(5 ,ScrW() - 87, ScrH() - 82, 54, 64, Color( 0, 0, 0, 200))
				--面
				draw.RoundedBox(5, ScrW() - 85, ScrH() - 30 - 50 , 50, 60, ColorHUD)
				--弹药数
				draw.DrawText(ply:GetAmmoCount(ply:GetActiveWeapon():GetSecondaryAmmoType()),"Hud", ScrW() - 60, ScrH() - 72, Color( 255, 255, 255) , TEXT_ALIGN_CENTER)
			else
				//主
				--描边
				draw.RoundedBox(5 ,ScrW() - 162, ScrH() - 82, 154, 64, Color( 0, 0, 0, 200))				
				--面
				draw.RoundedBox(5, ScrW() - 160, ScrH() - 30 - 50 , 150, 60, ColorHUD)
				--弹药数
            	draw.DrawText(wep,"Hud", ScrW() - 85, ScrH() - 72, Color( 255, 255, 255) , TEXT_ALIGN_CENTER)
        	end
    	end
	end
end
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
function hudui()	
		local nameboxwidth = string.len(LocalPlayer():Nick()) * 8 + 10
		--底描边框
		surface.SetDrawColor( 0, 0, 0, 200)
		surface.DrawRect( 8, ScrH() - 110, 504, 104)
		--面
		surface.SetDrawColor( ColorHUD )
		surface.DrawRect( 10, ScrH() - 108, 500, 100)

		-- ==血条描边框
		surface.SetDrawColor( 25, 5, 25, 200)
		surface.DrawRect( 110, ScrH() - 102, 395, 20)
		--血条护甲大小
		local x = 112
		local y = ScrH() - 100
		local w = 391
		local h = 16
		--血条底色
		surface.SetDrawColor( 130, 0, 10, 200)
		surface.DrawRect( x, y, w, h)
		--进度条
		surface.SetDrawColor( 240, 90, 90, 200)
		if LocalPlayer():Health() < 101 then
			surface.DrawRect( x, y, w * LocalPlayer():Health() / 100, h)
		end
		if LocalPlayer():Health() > 100 then
			surface.DrawRect( x, y, w, h)
		end
		--护甲
		surface.SetDrawColor( 238, 238, 238, 200)
		if LocalPlayer():Armor() < 101 then
			surface.DrawRect( x, y, w * LocalPlayer():Armor() / 100, h)
		end
		if LocalPlayer():Armor() > 100 then
			surface.DrawRect( x, y, w, h)
		end
		--surface.DrawRect( 88, ScrH() - 55, 416 * LocalPlayer():Health() / 100, 17)
		--血值
		draw.SimpleText( LocalPlayer():Health(), "Indicator2", 315 - (string.len(LocalPlayer():Health()) * 6 ), ScrH() - 105, color_black, 0, 0)
		--画血值图片		
		draw.RoundedBoxEx( 30, 85, ScrH() - 102, 19, 19, color_white, true, true, true, true )
		surface.SetDrawColor( 240, 90, 90)
		surface.DrawRect( 86, ScrH() - 95, 17, 5) -- y - 7, x + 1
		surface.DrawRect( 92, ScrH() - 101, 5, 17) -- y - 1, x + 7
		--饥饿值图片
		--底
		draw.RoundedBoxEx( 30, 85, ScrH() - 76, 19, 19, color_white, true, true, true, true )
		--包面
		draw.RoundedBox( 7, 87, ScrH() - 76, 15, 16, Color( 255, 134, 70))		
		--包底
		draw.RoundedBox( 3, 87, ScrH() - 66, 15, 7, Color( 255, 167, 84))
		--陷
		draw.RoundedBox( 2, 86, ScrH() - 67, 17, 4, Color( 133, 69, 61))
		--芝麻
		draw.RoundedBox( 2, 88, ScrH() - 71, 2, 2, Color( 255, 255, 255))
		draw.RoundedBox( 2, 93, ScrH() - 75, 2, 2, Color( 255, 255, 255))
		draw.RoundedBox( 2, 97, ScrH() - 72, 2, 2, Color( 255, 255, 255))
		draw.RoundedBox( 2, 93, ScrH() - 72, 2, 2, Color( 255, 255, 255))
		draw.RoundedBox( 2, 90, ScrH() - 74, 2, 2, Color( 255, 255, 255))

		--draw.RoundedBox( 128, ScrW() / 2 - 100, ScrH() - 250, 76, 76, color_black )
		--draw.RoundedBox( 128, ScrW() / 2 - 84, ScrH() - 226, 36, 36, color_white )
		--draw.RoundedBox( 128, ScrW() / 2 - 79, ScrH() - 221, 26, 26, color_black )

		
		-- 头像描边
		local money = LocalPlayer():GetNWInt( "money" )
		surface.SetDrawColor( 0, 128, 0, 255)
		surface.DrawRect( 10, ScrH() - 108, 68, 68)
		--金钱值
		draw.SimpleText(money .. "$",  "Indicator2", 15, ScrH() - 37, color_white, 0, 0)		
		--]]
		--画名字hud
		draw.RoundedBox(7, 100, ScrH() - 150,500-180, 30, Color( 25, 25, 25, 220))
		draw.SimpleText( LocalPlayer():Name() , "Indicator",270 - (string.len(LocalPlayer():Nick()) * 6 ), ScrH() - 150, color_white, 0, 0)
		--性别=====
		local Gender = LocalPlayer():GetNWString( "Gender" )
		if ( Gender == "wait" ) then
			draw.SimpleText( "性别: " .. "待确定", "default",110, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Gender == "male" ) then
			draw.SimpleText( "性别: " .. "男", "default", 110, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Gender == "female" ) then
			draw.SimpleText( "性别: " .. "女", "default", 110, ScrH() - 12 - 40, color_white, 0, 0 )
		end
		local Group = LocalPlayer():GetUserGroup()
		if ( Group == "user" ) then
			draw.SimpleText( "职业: " .. "游客", "default",185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "citizen" ) then
			draw.SimpleText( "职业: " .. "公民", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "doctor" ) then
			draw.SimpleText( "职业: " .. "医生", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "poilce" ) then
			draw.SimpleText( "职业: " .. "警察", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "project" ) then
			draw.SimpleText( "职业: " .. "工程", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "admin" ) then
			draw.SimpleText( "职业: " .. "管理员", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		elseif ( Group == "superadmin" ) then
			draw.SimpleText( "职业: " .. "腐竹", "default", 185, ScrH() - 12 - 40, color_white, 0, 0 )
		end
		--draw.SimpleText( "小职业: " .. nxrp.Getsmalljob( LocalPlayer() ), "default", 275, ScrH() - 12 - 40, color_white, 0, 0 )
		--速度=====
		function clamp(num,min,max)
			if num > max then return max elseif num < min then return min else return num end
		end
		local speedhud_type = CreateClientConVar("speedhud_type", "Mph", true, false)
		local speed = 0
		local ent = LocalPlayer()
		if speedhud_type:GetString() == "Mph" then
			speed = ent:GetVelocity():Length() * (3600 / 84480)
		end
		draw.SimpleText("速度: "..math.floor(speed).." "..speedhud_type:GetString(), "default",  445, ScrH() - 12 -40, color_white)
		--[[
		if math.floor(speed) > 8 then
			ent:SetNWFloat("hungerspeed", 1 + math.random(1, 3) )
			print(ent:GetNWFloat("hungerspeed"))
		else
			ent:SetNWFloat("hungerspeed", 1 + math.random(1, 2) )
			print(ent:GetNWFloat("hungerspeed"))
		end
		--]]
end
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

--[[hook.Add( "HUDPaint", "PolygonCircleTest", function()

	surface.SetDrawColor( 0, 0, 0, 200 )
	draw.NoTexture()
	draw.Circle( ScrW() / 2, ScrH() / 2, 200, 200 )

	--Usage:
	--draw.Circle( x, y, radius, segments )

end )--]]

--画头像
function drawAvatar()
	local Avatar
	if LocalPlayer():IsValid() then
		if hasava == 1 then
			if avaonce == 0 then
				Avatar = vgui.Create( "AvatarImage", panel)
				Avatar:SetSize( 64, 64 )
				Avatar:SetPos( 12, ScrH() - 106 )
			 	Avatar:SetPlayer( LocalPlayer(), 64)
				Avatar:ParentToHUD()
			end
				    
			avaonce = 1
		end	
		if hasava == 0 then
				avaonce = 0
				--draw.SimpleText( "W", "HUDServer", 14, ScrH() - 80, color_white, 0, 0)
		
		end
	end
end
--hook.Add('HUDPaint', 'HudDraw', HUDdraw)
hook.Add( "HUDPaint",  "HudDraw", function()
	HUDdraw()
	hudui()
	if hasava == 1 then
	drawAvatar()
	end
end )


