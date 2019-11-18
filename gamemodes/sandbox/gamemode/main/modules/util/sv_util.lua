notice = notice or {}

notice.NOTIFY_GENERIC = 0
notice.NOTIFY_ERROR = 1
notice.NOTIFY_UNDO = 2
notice.NOTIFY_HINT = 3
notice.NOTIFY_CLEANUP = 4

function notice.Add(ply, str, type, len, sound)
    NetOperating.Send(ply, "tocl_notify", function()
        net.WriteTable({
            txt = str,
            type = type,
            len = len,
            sound = sound,
        })
    end)
end

--[[
    "str", NOTIFY_GENERIC, 5, "buttons/lever1.wav"
]]
