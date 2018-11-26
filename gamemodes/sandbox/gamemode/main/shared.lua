include( "sv_money.lua" )
include( "cl_money.lua" )
include( "sv_job.lua" )


--添加工作
nxrp.Addsmalljob( "渔民", { ["color"] = Color( 3, 162, 209, 255 ) } )
nxrp.Addsmalljob( "小偷", { ["color"] = Color( 255, 255, 255, 255 ) } )
nxrp.Addsmalljob( "摊贩", { ["color"] = Color( 255, 255, 255, 255 ) } )
nxrp.Addsmalljob( "防御工事", { ["color"] = Color( 232, 198, 152, 255 ) } )

--每两秒执行一次, 根据手中的武器设定正确的职业
timer.Create("smalljob", 2, 0, function()
    for _, v in pairs( player.GetAll() ) do
        local playerweapons = v:GetWeapons()
        for _, weapons in pairs( playerweapons ) do
            if weapons:GetClass() == "weapon_fishing_rod" then
                nxrp.Joinsmalljob( "渔民", v, v:SteamID() )
            elseif weapons:GetClass() == "swep_pickpocket" then
                nxrp.Joinsmalljob( "小偷", v, v:SteamID() )
            elseif weapons:GetClass() == "alydus_fortificationbuildertablet" then
                nxrp.Joinsmalljob( "防御工事", v, v:SteamID() )
            else 
                nxrp.Exitmalljob( "渔民", v, v:SteamID() )
                nxrp.Exitmalljob( "防御工事", v, v:SteamID() )
                nxrp.Exitmalljob( "小偷", v, v:SteamID() )
            end
        end
    end
end)



