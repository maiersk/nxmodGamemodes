NetOperating = NetOperating or {}
NetOperating.rcvds = NetOperating.rcvds or {}

NetOperating.AddReceive = function(str, funs)
    NetOperating.rcvds[str] = funs
end

NetOperating.Receive = function(len, ply)
    local key = net.ReadString()
    -- for name, funs in pairs(NetOperating.rcvds) do
    --     if key == name then
    --         funs(len, ply)
    --     end
    -- end
    if (NetOperating.rcvds[key]) then
        local funs = NetOperating.rcvds[key]
        funs(len, ply)
    end
end
net.Receive("Operating",NetOperating.Receive)

--PrintTable(NetOperating.rcvds)
