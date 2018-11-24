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
net.Receive( "fishermen_NPCPANEL", function()		--需每个npc不一样网络信息的名字

	local ply = LocalPlayer()
	if ply:GetFishingRod() and not vgui.CursorVisible() then
		local menu = fishingmod.UpgradeMenu
		if not menu:IsVisible() then
			menu:SetVisible(true)
			menu:MakePopup()
		end
	else
		if ply:GetUserGroup() ~= "citizen" then
			notification.AddLegacy( "你的职业不能当渔民", NOTIFY_GENERIC, 5 )
		else
			notification.AddLegacy( "拿着鱼竿再来吧年轻人", NOTIFY_GENERIC, 5 )
		end
	end

end )



function ENT:Draw()

    self:DrawModel()

    if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

        local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 90 )

        cam.IgnoreZ( false )
        cam.Start3D2D( self:GetPos() + Vector( 0, 0, 78 ), ang, .1 )
			if fishermenNPCConfig.HeaderOutline == true then
				if ( #fishermenNPCConfig.HeaderText > 6 )then --若有npc头部标签3个中文字扩大矩形
					draw.RoundedBox(5,-71 -10,-17,146 + 26,40,fishermenNPCConfig.HeaderOutlineColour)
				else
					draw.RoundedBox(5,-71,-17,146,40,fishermenNPCConfig.HeaderOutlineColour)
				end	
			end
            draw.SimpleTextOutlined( fishermenNPCConfig.HeaderText, "trebuchet50", 5, 0, fishermenNPCConfig.HeaderTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color( 0, 0, 0, 255 ) )
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





