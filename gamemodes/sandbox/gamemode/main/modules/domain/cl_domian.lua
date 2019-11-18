--[]
Domain = Domain or {}
Domain.data = Domain.data or {}

Domain.show = false

surface.CreateFont("Domain_hudinfo_SM", {
    font = "Abel",
	size = 21,
})

surface.CreateFont("Domain_hudinfo_XSM", {
    font = "Abel",
	size = 17,
})

--画进入领地hud
hook.Add("HUDPaint", "Domain_indomain_hud", function()
    if (Domain.data) then
        for i = 0, #Domain.data do
            local tbl = table.Copy(Domain.data[i])
            if (tbl) then
                local ply = LocalPlayer()
                local inbox = ply:EyePos():WithinAABox(tbl.position.pos1, tbl.position.pos2)
                
                if (inbox) then
                    local ent = false
                    local faction = Faction:getGang(tbl.factionid)
                    local plyfaction = ply:GetGang()

                    if (tbl.flag) then
                        ent = ents.GetByIndex(tbl.flag.entindex)
                    end

                    local bx, by = ScrW() * 0.5, ScrH() * 0.01
                    local bw, bh = 135, 55

                    draw.RoundedBoxEx(5, bx - bw, by * 0.8, bw, bh, Color(0, 0, 0, 255), true, true, true, true)
                    draw.SimpleText("地名: " .. tbl.name, "Domain_hudinfo_XSM", bx - (bw * 0.5), by * 1.8, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    
                    
                    
                    local status = "未占领"
                    if (ent.occupytime || (ent.occupytime && tbl.factionid != "-1")) then
                        status = "在占领"
                    end
                    
                    local str
                    local pcol, fcol = {}, {}
                    if (tbl.factionid != "-1") then
                        status = "已占领"
                        str = faction:getName()
                        fcol = faction:getColor()
                    else
                        str = "无"
                    end
                    if (plyfaction) then
                        pcol = plyfaction:getColor()
                    end

                    local info = "" ..
                    "帮派: " .. str .. "\n" ..
                    "状态: " .. status
                    draw.DrawText(info, "Domain_hudinfo_XSM", bx - (bw - 2), by * 2.6, Color(255,255,255,255), TEXT_ALIGN_LEFT)
                    draw.RoundedBoxEx(5, bx - (15 + 3), by * 4.8, 15, 15, Color((fcol.r or 255), (fcol.g or 255), (fcol.b or 255), 255 * math.sin(CurTime())), true, true, true, true)

                    if (#tbl.description > 0) then
                        draw.RoundedBoxEx(5, bx - (bw - (bw + 1)), by * 0.8, 40, 20, Color(0, 0, 0, 255), true, true, true, true)
                        draw.DrawText("描述:", "Domain_hudinfo_XSM", bx - (bw - (bw + 4)), by * 0.8, Color(255,255,255,255), TEXT_ALIGN_LEFT)

                        draw.RoundedBoxEx(5, bx - (bw - (bw + 1)), by * 3.1, surface.GetTextSize(tbl.description) + 5, 20, Color(0, 0, 0, 255), true, true, true, true)
                        draw.DrawText(tbl.description, "Domain_hudinfo_XSM", bx - (bw - (bw + 4)), by * 3.1, Color(255,255,255,255), TEXT_ALIGN_LEFT)
                    end

                    if (ent.occupytime) then
                        local barw = (2 * Domain.occupytime)
                        draw.RoundedBoxEx(5, bx - (bw - (bw + 1)), by * 5.4, barw, 13, Color(0, 0, 0, 255), true, true, true, true)
                        draw.RoundedBoxEx(5, bx - (bw - (bw + 1)) + 2, by * 5.4 + 2, barw - 4, 13 - 4, Color(pcol.r or 0, pcol.g or 0, pcol.b or 0, pcol.a or 255), true, true, true, true)

                        draw.RoundedBoxEx(5, bx - (bw - (bw + 1)) + 2, by * 5.4 + 2, (barw * ent.occupytime / Domain.occupytime) - 4, 13 - 4, Color((fcol.r or 255), (fcol.g or 255), (fcol.b or 255), 255), true, true, true, true)
                    end

                end
            end
        end
    end
end)

concommand.Add("domain_show", function()
    if (!Domain.show && Domain.data) then

        hook.Add("PostDrawOpaqueRenderables", "domain_show", function()
            for k, v in pairs(Domain.data) do
                if (v.position && v.color) then
                    local color = Color(v.color.r, v.color.g, v.color.b, v.color.a) or Color(100, 255, 0, 155)
                    render.SetColorMaterial()
                    render.DrawBox(Vector(0, 0, 0), Angle(0, 0, 0), v.position.pos1, v.position.pos2, color)
                end
            end
            Domain.show = true
        end)
    else
        hook.Remove("PostDrawOpaqueRenderables", "domain_show")
        Domain.show = false
    end
end)  

--Q键菜单设置
local function DomainSetting(panel)
    panel:AddControl("DLable", {"领地设置"})

    panel:AddControl("CheckBox", { Label = "显示领地", Command = "domain_show"})
    panel:ControlHelp("显示已经创建的领地")

end

hook.Add("PopulateToolMenu", "PopulateToolMenu_domain_setting", function()
    spawnmenu.AddToolMenuOption("Utilities", "Domain", "DomainSetting", "领地设置", "", "", DomainSetting)
end)