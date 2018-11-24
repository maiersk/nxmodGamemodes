AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sv_job.lua" )
AddCSLuaFile( "cl_init.lua" )
--AddCSLuaFile( "teamconfig.lua" )
AddCSLuaFile( "vgui/menu_main.lua" )
AddCSLuaFile( "vgui/columnsheet.lua" )
AddCSLuaFile( "playerstats.lua" )

include( "playerstats.lua" )
--include( "teamconfig.lua" )
include( "sv_money.lua" )
include( "cl_money.lua" )
include( "sv_hud.lua" )
include( "sv_job.lua" )
include( "shared.lua" )



--注册网络字符串
util.AddNetworkString("firstspawn")
util.AddNetworkString("f1help")
util.AddNetworkString("f4menu")

--玩家第一次复活
hook.Add( "PlayerInitialSpawn", "PlayerfirstSpawn", function( ply )
    
    --===设置
    ply:StatsLoad()
    --发送给cl_init.lua作为第一次进服后客户端执行function的事件
    if ( ply:GetNWString( "Gender" ) == "wait" ) then   --如果性别是待确定状态
        net.Start( "firstspawn" )
            net.WriteString( "GenderPlane" )    --发送给客户端判断
        net.Send( ply )
    else
        net.Start( "firstspawn" )
        net.Send( ply )
    end
    --打印调试信息
    print( "-=======进服了" )
    local tbl = {
        "citizen",
        "doctor",
        "poilce",
        "project"
    }
    for _, v in pairs( tbl ) do
        --打印调试信息
        print( "save " .. v .. " Level:" .. ply:GetNWInt( "Level" .. "_" .. v ) )
        print( "save " .. v ..  " XP:" .. ply:GetNWInt( "XP" .. "_" .. v ) )
    end
    --print( "Level:" .. ply:GetNWInt( "Level" ) )
    --print( "XP:" .. ply:GetNWInt( "XP" ) )
    print( "Gender:" .. ply:GetNWString( "Gender" ) )

end)

--玩家死后
hook.Add("PlayerDeath", "playerdeath", function( ply )
    --调试经验增加function
    ply:StatsAddXp( 55, ply:GetUserGroup() )

end)

--玩家复活
hook.Add( "PlayerSpawn", "revive", function( ply ) 

    print( "-=======复活了" )
    --设置玩家手部模型function
    ply:SetupHands()

end)


--当玩家断开连接时
hook.Add( "PlayerDisconnected", "PlyDied", function( ply )
    --调试用途——重置玩家参数
    --ply:SetNWString( "Gender", "wait" ) 
    print( "-=======退出了" )

    --===玩家配置保存
    ply:StatsSave()

end)


--F1按钮
function ShowHelp( ply )
    net.Start( "f1help" )
    net.Send( ply )    
end
hook.Add("ShowHelp", "f1help", ShowHelp )
--F4按钮
function GM:ShowSpare2( ply )
    net.Start( "f4menu" )
    net.Send( ply )
end


--设置显示手部模型function
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

--xp命令
concommand.Add("xp_add", function(ply, cmd, arg)
    if !IsValid(ply) then print("没有玩家") end
    if !arg then return end
    ply:StatsAddXp(tonumber(arg[1]), arg[2])

end)

function SMSChatCommands(ply, text)

    text = string.lower(text) -- 将消息发送为小写，因此命令不区分大小写.
    text = string.Explode(" ", text) -- 将字符串分解为每个空间的表格.
                                     -- 我们这样做，所以我们可以得到论点.

    if (text[1] == "!run" or text[1] == "/run") then 
        if text[2] == nil then return end
        ply:money_give( tonumber(text[2]) )
        return
    end
    if (text[1] == "!dexplevel") then
        if text[2] == nil then return end
        ply:DeXpandLevel(text[2])
    end
    if (text[1] == "!checkxp") then
        if text[2] == nil then return end
        print(ply:GetNWInt("XP" .. "_" .. text[2]))
        print(ply:GetNWInt("Level" .. "_" .. text[2]))
    end
    if (text[1] == "!set" or text[1] == "/run") then 
        if text[2] == nil then return end
        ply:money_take( tonumber(text[2]) )
        return
    end
    if (text[1] == "!test") then 
        local roi = ply:GetNWFloat( "moneyROI" ) -- 获取球员的兴趣率.
        print( math.ceil( ( 100 + math.floor( math.random() * 2.1 ) ) * ( 1.0 + ( roi / 100.0 ) ) * ( -100/100 ) ) )
        return ""
    end
    if (text[1] == "!de" ) then
        --ply:money_set( 0 )
        PrintTable(nxrp.Crime)
        print(nxrp.GetCrime(ply))
        return
    end
    if (text[1] == "!add" ) then
        if text[2] == nil and text[3] == nil then return end
        print( "Level:" .. ply:GetNWInt( "Level" .. "_" .. tostring( text[3] ) ) )
        print( "XP:" .. ply:GetNWInt( "XP" .. "_" .. tostring( text[3] ) ) )
        ply:StatsAddXp( text[2], tostring( text[3] ) )
        return ""
    end
    if ( text[1] == "!jobxp" ) then
        local tbl = {
            "citizen",
            "doctor",
            "poilce",
            "project"
        }
        for _, v in pairs( tbl ) do
            --打印调试信息
            print( "save " .. v .. " Level:" .. ply:GetNWInt( "Level" .. "_" .. v ) )
            print( "save " .. v ..  " XP:" .. ply:GetNWInt( "XP" .. "_" .. v ) )
        end
    end
end
    
hook.Add("PlayerSay", "ChatCommands", SMSChatCommands) 

function GM:Think()
    for _, v in pairs( player.GetAll() ) do
        --print( v )
        if IsValid( v ) then
            local wallet = v:PS2_GetWallet()
           --PrintTable(wallet)
            if wallet then
                if v:GetNWInt( "KPlayerId" ) == wallet.ownerId then
                    if v:GetNWInt("money") ~= wallet.points then
                        v:money_set( tonumber(wallet.points) )
                    end
                end
            end
        end
        break
    end
end



--生成菜单禁用
--武器
function GM:PlayerGiveSWEP( ply, class, swep )
	if ( !IsValid(ply) ) then return false end 
    if ( ply:IsAdmin() ) then 
        return true 
    else
        ply:SendLua("notification.AddLegacy( \"这里不可以~,需要的话要到npc处\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/combine_button6.wav\" ) ")
        return false
    end
end
--实体
function GM:PlayerSpawnSENT( ply, class )
	if ( !IsValid(ply) ) then return false end 
    if ( ply:IsAdmin() ) then 
        return true 
    else
        ply:SendLua("notification.AddLegacy( \"如果需要实体需要特殊的方式，不是这里哦\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/combine_button6.wav\" ) ")
        return false
    end
end
--NPC
function GM:PlayerSpawnNPC( ply, npc_type, weapon )
	if ( !IsValid(ply) ) then return false end 
    if ( ply:IsAdmin() ) then 
        return true 
    else
        ply:SendLua("notification.AddLegacy( \"如果需要npc可以到npc招聘里购买生成\", NOTIFY_GENERIC, 5 ) surface.PlaySound( \"buttons/combine_button6.wav\" ) ")
        return false
    end
end
--[[
timer.Create( "cmoney", 1, 0, function()
    for _, v in pairs( player.GetAll() ) do
        if IsValid( v ) then
            local wallet = v:PS2_GetWallet()
            if wallet then
                if v:GetNWInt("money") ~= wallet.points then
                    v:money_set( tonumber(wallet.points) )
                end
            end
        end
        break
    end
end)
--]]


--[[
for k, v in pairs( player.GetAll() ) do
    local wallet = v:PS2_GetWallet()
    PrintTable(wallet)
end
for k, v in pairs( player.GetAll( ) ) do
    print(v)
end
--]]
--[[
timer.Create( "cpoint", 2, 0, function()
    for _, v in pairs( player.GetAll() ) do
        local wallet = v:PS2_GetWallet()
        local ply = v
        if wallet.points ~= v:GetNWInt("money") then
            Pointshop2Controller:getInstance():adminChangeWallet( ply, wallet.ownerId, "points", v:GetNWInt("money") )
        end
        break
    end
end)
--]]

--[[
local points, ownerId = 0, 0
if LocalPlayer().PS2_Wallet then
        points, ownerId = LocalPlayer().PS2_Wallet.points, LocalPlayer().PS2_Wallet.ownerId
end
--print( points, ownerId )
local money = LocalPlayer():GetNWInt( "money" )
if points ~= money then
    if type(ownerId) == "number" then
        --Pointshop2Controller:getInstance():adminChangeWallet( ply, ownerId, "points", money )
        --print("?")
    end
end

for k, v in pairs( player.GetAll( ) ) do
    print( v )
    if v.PS2_Wallet then
        PrintTable( v.PS2_Wallet )
    end
end
--]]