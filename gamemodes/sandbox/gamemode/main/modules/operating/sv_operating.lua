util.AddNetworkString( "Operating" )

NetOperating = NetOperating or {}

NetOperating.Send = function (ply, str, funs) 
    net.Start("Operating")
        net.WriteString(str)
        if type(funs) == "function" then
            funs(net)
        end
    net.Send(ply)
end

NetOperating.AddReceive("test1",function()
    local tbl = net.ReadTable()
    PrintTable(tbl)
end)


--[[
--应用实例
NetOperating.AddReceive("test1",function()
    local tbl = net.ReadTable()
    PrintTable(tbl)
end)

local ply = FindMetaTable("Player")
NetOperating.Send(ply, "toclient", function()
    net.WriteString("hello client")
    print("to client ok")
end)
--]]