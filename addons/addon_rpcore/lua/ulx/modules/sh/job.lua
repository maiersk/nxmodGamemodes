local CATEGORY_NAME = "rp core"


function ulx.resetgender( calling_ply, target_plys, arg )

    target_plys:SetNWString("Gender", arg )
    
    print( "ok")
    ulx.fancyLogAdmin( calling_ply, "#A 重置了 #T 到 #s 性别", target_plys, arg )
end

local resetgender = ulx.command( CATEGORY_NAME, "ulx resetgender", ulx.resetgender, "!resetgender" )
resetgender:help( "Reset the player gender." )
resetgender:addParam{ type=ULib.cmds.PlayerArg }
resetgender:addParam{ type=ULib.cmds.StringArg, hint="wait" }    
resetgender:defaultAccess( ULib.ACCESS_SUPERADMIN )

--改变工作命令
function ulx.userjob( calling_ply, target_ply, group_name )
	local userInfo = ULib.ucl.authed[ target_ply:UniqueID() ]

	local id = ULib.ucl.getUserRegisteredID( target_ply )
    if not id then id = target_ply:SteamID() end
    
    target_ply:RemoveAllItems() --清理个人物品

	ULib.ucl.addUser( id, userInfo.allow, userInfo.deny, group_name ) --设置工作

	ulx.fancyLogAdmin( calling_ply, "#A 手动添加 #T 到工作 #s", target_ply, group_name )
end
local userjob = ulx.command( CATEGORY_NAME, "ulx userjob", ulx.userjob, nil, false, false, true )
userjob:addParam{ type=ULib.cmds.PlayerArg }
userjob:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names_no_user, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
userjob:defaultAccess( ULib.ACCESS_SUPERADMIN )
userjob:help( "Add a user to specified group." )

--抢劫命令
function ulx.mug( calling_ply, arg )
    calling_ply:plyMug_Pos( tonumber(arg) )
	ulx.fancyLogAdmin( calling_ply, "#A 勒索了玩家 #s $", arg )
end
local mug = ulx.command( CATEGORY_NAME, "ulx mug", ulx.mug, "!mug", false, false, true )
mug:addParam{ type=ULib.cmds.StringArg }
mug:defaultAccess( ULib.ACCESS_SUPERADMIN )
mug:help( "能对玩家进行抢劫." )