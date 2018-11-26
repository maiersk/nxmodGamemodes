--按钮流，判断按钮使用哪些功能
net.Receive( "Buttonflow", function( len, ply )

    local str = net.ReadString()        --读按钮发送的字节
    local jobid = net.ReadString()
    local money = net.ReadFloat()

    if ( jobid == "superadmin" and jobid == "admin" and jobid == "operator" ) then return end
    
    --npc按钮
    if ( str == "cagjob" ) then
        if money == 0 then
            nxrp.Joinjob( ply, ply:SteamID(), jobid )
            ply:SendLua("notification.AddLegacy( \"你已成为" .. jobid .. "职业\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/lever8.wav\" ) ")
        else
            if !ply:money_take( tonumber(money) ) then
                ply:PrintMessage( HUD_PRINTTALK, ">> 对不起！你的账号余额不足" .. money .. "$.")
            else
                nxrp.Joinjob( ply, ply:SteamID(), jobid )
                ply:SendLua("notification.AddLegacy( \"你已成为" .. jobid .. "职业\", NOTIFY_GENERIC, 5 ) notification.AddLegacy( \"并从你的账号扣除" .. money .. "$入职费用\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/lever8.wav\" ) ")
            end
        end
    elseif ( str == "rejob" ) then
        nxrp.Joinjob( ply, ply:SteamID(), "citizen" )
        if money then 
            ply:money_give( tonumber(money) )
            ply:SendLua("notification.AddLegacy( \"你辞去了 旧的 职业\", NOTIFY_GENERIC, 5 ) notification.AddLegacy( \"返还" .. money .. "$就职费用\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/lever8.wav\" ) ")
        end
    elseif ( str == "reuser" ) then
        nxrp.Joinjob( ply, ply:SteamID(), "user" )
        ply:SendLua("notification.AddLegacy( \"你辞去了 公民 职业\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/lever8.wav\" ) ")
    end

    --性别选择按钮流
    if ( str == "malebutton" ) then     --判断字节执行哪些功能
        ply:SetNWString( "Gender", "male" )
        SetGenderModel(ply)
        --ply:gendermodel( 0 )
        --选择好性别后打开f1菜单
        net.Start( "f1help" )
        net.Send( ply )
    elseif ( str == "famalebutton" ) then
        ply:SetNWString( "Gender", "female" )
        SetGenderModel(ply)
        --ply:gendermodel( 0 )
        --选择好性别后打开f1菜单
        net.Start( "f1help" )
        net.Send( ply )
    end 
    --[[
        for _,teamdata in pairs( xgui.teams ) do
            string.lower(teamdata.name)
            if str == teamdata.name then
                print(teamdata.name)
            end
        end
    --]]
    
end)



--全局功能
--三个table
nxrp = {}
nxrp.Crime = nxrp.Crime or {}   --crime hash表 键ply, 值data
nxrp.SmallJob = nxrp.SmallJob or {}

--玩家选择了一个工作
function nxrp.Joinjob( ply, id, group_name )

    ply:RemoveAllItems()    --移除玩家身上的武器和子弹
    ULib.ucl.addUser( id, allows, denies, group_name )  --加入ulx group

end

----------------------------------------------
--crime相关

--加入到crime hash表中
function nxrp.SetCrime( ply, data )
    nxrp.Crime[ply] = data
end

function nxrp.GetCrime( ply )
    -- for k, v in pairs(nxrp.Crime) do     --没有必要循环, 直接返回即可
    --     if ply == k then                 --qqq 修改调用处
    --         return true, v
    --     end
    -- end
    if nxrp.Crime[ply] then                 --临时
        return true, nxrp.Crime[ply]
    end
    --return nxrp.Crime[ply]      --调用的时候进行判断, 如果为nil 说明没有数据
end

function nxrp.DeleCrime(ply)
    nxrp.Crime[ply] = nil
end

------------------------------------------------
--smalljob 相关

--添加工作
function nxrp.Addsmalljob( smalljobname,data )
    nxrp.SmallJob[smalljobname] = data
end

function nxrp.Joinsmalljob( smalljobname, ply, steamid )
    nxrp.SmallJob[smalljobname][ply] = {} or nxrp.SmallJob[smalljobname][ply]
    table.insert( nxrp.SmallJob[smalljobname][ply], steamid )
end

function nxrp.Exitmalljob( smalljobname, ply, steamid )
    nxrp.SmallJob[smalljobname][ply] = {} or nxrp.SmallJob[smalljobname][ply]
    nxrp.SmallJob[smalljobname][ply] = nil`
end

function nxrp.Getsmalljob( ply )
    for k, data in pairs( nxrp.SmallJob ) do
        for tblply, v in pairs(data) do
            if tblply == ply then
                if player.GetBySteamID(v[1]) == ply then
                    return k
                end
            end
        end
    end
end

function nxrp.GetsmalljobColor( teamname )
    for k, data in pairs( nxrp.SmallJob ) do
        if k == teamname then
            return data.color
        end
    end   
end

----------------------------------------------


function SetGenderModel( ply )
    local team = ULib.ucl.groups[ ply:GetUserGroup() ].team
    if team then
        if ( ply:GetNWString("Gender") == "female" ) then
            if team.femalemodel then
                ply:SetModel( team.femalemodel )
            end
        elseif ( ply:GetNWString("Gender") == "male" ) then
            if team.malemodel then
                ply:SetModel( team.malemodel )
            end
        end
    end
end

