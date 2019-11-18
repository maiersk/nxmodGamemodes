NetOperating = NetOperating or {}

NetOperating.SendToServ = function(str,tbl)
    net.Start("Operating")
        net.WriteString(str)
        net.WriteTable(tbl)
    net.SendToServer()
end


NetOperating.AddReceive("tocl_notify",function(len, ply)
    local tbl = net.ReadTable()
    notification.AddLegacy(tbl["txt"], tbl["type"], tbl["len"])
    surface.PlaySound( tbl["sound"] )
end)

--[[
应用实例
NetOperating.SendToServ("test", {"test"})

NetOperating.SendToServ("test1", {"test1"})

NetOperating.AddReceive("toclient",function(len,ply)
    local str = net.ReadString()
    print("tocl :: " .. str)
end)
--]]