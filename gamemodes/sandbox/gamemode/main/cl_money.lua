--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	简单的货币体系。由KRisU。特别感谢fghdx Rubat.
	Version: 2.0

]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

AddCSLuaFile() -- 标记文件,客户端下载

if (CLIENT) then

surface.CreateFont( "SMSBountyFont", {
	font = "Trebuchet", -- 使用的字体名字查看器显示你的操作系统,而不是文件名
	extended = false,
	size = 13,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false
} )

surface.CreateFont( "SMSMoneyFont", { 
	font = "Myriad Pro", -- 使用的字体名字查看器显示你的操作系统,而不是文件名
	extended = false,
	size = 36,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
} )

local function checkIfAdmin() -- 一个非常好的客户端功能来检查玩家是否是管理员，涵盖所有领域; 随意复制和分发这个，只有这个功能.
	local ply = LocalPlayer()
	if ply:IsValid() then
		if ( ply:IsAdmin() || ply:IsSuperAdmin() || ply:IsUserGroup( "server owner" ) || ply:IsUserGroup( "serverowner" ) || ply:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			return true
		else
			return false
		end
	end
	return false
end


player_data = FindMetaTable("Player") -- 获取影响玩家的所有功能。


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	客户化的CONVARS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CreateConVar( "money_displayhud", 1, FCVAR_ARCHIVE )
CreateConVar( "money_notifications", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )
CreateConVar( "money_weaponpickup", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )
CreateConVar( "money_bounty_marker", 1, { FCVAR_ARCHIVE, FCVAR_USERINFO } )

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	主要main
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	
	function drawMoneyBoxOnHUD() -- 使我们的HudPaint功能来赚钱。
		
		local money = LocalPlayer():GetNWInt( "money" ) -- 从网络中获得玩家的钱int。
		--[[
		if (GetConVar("money_displayhud"):GetInt() == 0) then
			return
		elseif (GetConVar("money_displayhud"):GetInt() == 1) then
			draw.WordBox(8, 10, 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		elseif (GetConVar("money_displayhud"):GetInt() == 2) then
			draw.WordBox(8, 10, 230, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		elseif (GetConVar("money_displayhud"):GetInt() == 3) then
			draw.WordBox(8, 10, (ScrH()/2), money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		elseif (GetConVar("money_displayhud"):GetInt() == 4) then
			draw.WordBox(8, 10, (ScrH()/2)+(ScrH()/5), money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		elseif (GetConVar("money_displayhud"):GetInt() == 5) then
			draw.WordBox(8, 230, 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。	
		elseif (GetConVar("money_displayhud"):GetInt() == 6) then
			draw.WordBox(8, (ScrW()/2)+(ScrW()/5), 230, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		elseif (GetConVar("money_displayhud"):GetInt() == 7) then
			draw.WordBox(8, (ScrW()/2)+(ScrW()/5), 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		else
			draw.WordBox(8, ((ScrW()/2)-(ScrW()/32)), 10, money .. "$", "SMSMoneyFont", Color(0, 0, 0, 180), Color(255,255,255)) -- 制作一个wordbox容器。
		end
		--]]
	end
	hook.Add("HUDPaint", "drawMoneyBoxOnHUD", drawMoneyBoxOnHUD) -- Hook up连接	.
	
	
	hook.Add("HUDPaint", "SMSBountyMarker", function()
		
		if (GetConVar( "money_bounty_marker" ):GetBool() == false) then
			return
		end
		
		local bStatus = false
		local bTarget = nil
		
		for key, ply in pairs(player.GetAll()) do
			if (ply:GetNWBool( "isHunted" ) == true and ply:GetNWInt( "bountyPrice" ) > 1) then
				bStatus = true
				bTarget = ply
				break
			end
		end
		
		if (bStatus == false) then 
			return 
		elseif (bTarget == LocalPlayer() or bTarget == nil) then
			return
		end
		
		local targetPos = (bTarget:GetPos() + Vector(0,0,75))
		local targetDistance = 0
		
		if ((math.floor((LocalPlayer():GetPos():Distance(targetPos))/30.5)-1) < 2) then
			targetDistance = 1 
		else 
			targetDistance = (math.floor((LocalPlayer():GetPos():Distance(targetPos))/30.5)-1)
		end
		
		local targetScreenPos = targetPos:ToScreen()
		
		surface.SetTextColor(255,75,0)
		surface.SetFont("SMSBountyFont")
	    
		surface.SetTextPos( tonumber(targetScreenPos.x)-tonumber(ScrW()*0.022), tonumber(targetScreenPos.y)-tonumber(ScrH()*0.009)-13 )
		surface.DrawText("Bounty: +" .. bTarget:GetNWInt( "bountyPrice" ) .. "$")
		
		surface.SetTextColor(255,75,0)
		surface.SetFont("SMSBountyFont")
	    
		if (targetDistance % 73 >= tonumber(0+math.random(2,9)) && targetDistance % 73 <= tonumber(30+math.random(-2,9))) then
			surface.SetTextPos( tonumber(targetScreenPos.x)-tonumber(ScrW()*0.022), tonumber(targetScreenPos.y)-tonumber(ScrH()*0.009) )
			surface.DrawText("Distance: " .. targetDistance .. "u")
		end
	
	end)
	


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	CONCOMMANDS命令行
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- LISTPLAYERS (NON-ADMIN)列出玩家（非管理员）
	function listplayers( client, command, arguments ) -- 添加控制台命令
		PrintTable( player.GetAll() )
	end
	concommand.Add("listplayers", listplayers , nil, "用于打印连接播放列表的命令.")
	
	-- CHECK ACCOUNT (NON-ADMIN)查看帐户（非管理员）
	function money_check_CC( client, command, arguments ) -- 添加控制台命令
		client:PrintMessage( HUD_PRINTTALK , ">> 您的帐户余额是: " .. (tonumber(client:GetNWInt( "money" ))) .. "$.\n")
		if (GetConVar("money_roi"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> 你的兴趣是: " .. ((math.floor(client:GetNWFloat( "moneyROI" )*100))*0.01) .. "%.\n")
		end
		if (GetConVar("money_bounty_system"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> 你的名气是: " .. (tonumber(client:GetNWFloat( "bountyFame" ))) .. ".\n")
		end
		if (GetConVar("money_freeze"):GetBool() == true) then
			client:PrintMessage( HUD_PRINTTALK , ">> 银行账户被冻结.\n")
		end
		client:PrintMessage( HUD_PRINTTALK , ">> 你最近的开支是: " .. client:GetNWInt( "latestExpense3" ) .. "$, " .. client:GetNWInt( "latestExpense2" ) .. "$, " .. client:GetNWInt( "latestExpense1" ) .. "$.\n")
	end
	concommand.Add("money_check", money_check_CC , nil, "用于打印自我帐户信息的命令.")

	

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	面板： 金钱系统 - 客户端 > 客户端，命令列表； 金钱系统 -服务器 > 综合管理， 金钱系统，玩家动作， 死亡相关， 团队设置
								1		2							3		4			5		6			7
	PANELS: Money System - Client > Client, Commands List; Money System - Server > General Management, Money Systems, Player Actions, Death-related, Team Settings
									1		2										3					4				5				6			 7								
	1 Addon Info, Clientside (Notifications, HUDPos, Check)
	1.客户端附加信息，Clientside（Notifications，HUDPos，Check）	
	2 All commands with descriptons
	2.所有带说明的命令	
	3 Freeze, SetAll, Defaults, CheckAll, SENTSpawn --综合管理

	4 Paydays, Payday Amount, Payday Time Interval, ROI, ROI offset, Bounty, Bounty Time Interval, Spawncosts, Multipliers --金钱系统
	   工资日，	  发薪日金额，	   发薪日时间间隔，	投资回报率，回报率抵消，赏金，	    赏金时间间隔		复活成本	 增加者
	5 Mugging/Robbing, Threatening, Unbuying, Dropping --玩家动作
		抢劫/打劫	，	   威胁，	  非购买，	 掉落	
	6 NPC Killcounter, On Insufficient Respawn, On Killplayer Steal, On Killplayer Stolen Fraction --死亡相关
		NPC杀敌计数器，		重生不足，				杀戮玩家偷盗，			杀戮者盗取分数
	7 Distinguish Teams, Team Payday Percentages, Team Awards Perentages --团队设置
		区分团队，			团队发薪日百分比，			团队奖励等
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	-- -- -- -- --
	-- 客户端   --
	-- -- -- -- --
	
    -- -- -- -- --
    -- 客户端   --
    -- -- -- -- --
    
    function SMS1_Client(Panel)

        Panel:AddControl    ("Label" ,{ Text = ">> 1. 插件信息" })
        
        if game.SinglePlayer() then
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:ControlHelp   ("这件物品在单人模式时并不合适.")
        end
        
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        Panel:ControlHelp   ("经济系统")
        Panel:ControlHelp   ("汉化by：phone哥")
        Panel:ControlHelp   ("(c) KRisU, with special thanks to fghdx, Rejn, Romanov.") -- 控制帮助是主文本下的这些蓝色小字符串。

        Panel:AddControl    ("Label" ,{ Text = "" })
        Panel:AddControl    ("Label" ,{ Text = ">> 2. 客户端" })
        
        Panel:AddControl    ("CheckBox" ,{ Label = "切换通知", Command = "money_notifications" }) -- Notifications
        Panel:ControlHelp   ("只切换最频繁的(在聊天时).")
        
        Panel:AddControl    ("CheckBox" ,{ Label = "赏金猎人制造者", Command = "money_bounty_marker" }) -- Notifications
        Panel:ControlHelp   ("当赏金事件发生时切换文本来显示赏金目标.")
        
        Panel:AddControl    ("CheckBox" ,{ Label = "切换武器拾起", Command = "money_weaponpickup" }) -- Notifications
        Panel:ControlHelp   ("另外如果禁用，重生后将不会得到任何武器.")
        
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        --[[
        Panel:AddControl("Slider", {            -- HUDPos   
                Label = "金钱显示POS机",
                Command = "money_displayhud",
                Type = "Int",
                Min = "0",
                Max = "8" })
        --]]  
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
        Panel:Button("打印银行信息", "money_check")  -- 自检
        
    end

	
    -- -- -- -- -- -- --
    -- COMMANDS LIST命令列表  --
    -- -- -- -- -- -- --
    
    function SMS1_CommandsList(Panel)
    
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- 用上述文本创建一个标签（单行）。
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        Panel:AddControl    ("Label" ,{ Text = ">> 客户端命令列表" })
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台) money_give #"})
        Panel:AddControl    ("Label" ,{ Text = "(在聊天中) /givemoney #"})
        Panel:AddControl    ("Label" ,{ Text = "(在聊天中) !givemoney #"})
        Panel:ControlHelp   ("# 给金币到准星瞄准着的玩家.")
        
        Panel:ControlHelp   ("-- AND --") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台) money_transfer @ #"})
        Panel:ControlHelp   ("# 金钱从你的余额中到玩家 @ 代表ID.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        --[[
        Panel:AddControl    ("Label" ,{ Text = "(在控制台) money_steal #"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) /rob #"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !rob #"})
        Panel:ControlHelp   ("为了金钱在十字瞄准的位置下抢劫玩家.")
        
        Panel:ControlHelp   ("-- AND --") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !mug"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !mug"})
        Panel:ControlHelp   ("为了金钱的随机有效量在十字瞄准的位置下绑架玩家.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) money_threaten"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) /threaten"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !threaten"})
        Panel:ControlHelp   ("在十字瞄准的位置下欺骗玩家.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        --]]
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) weapon_sell"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) /sellweapon"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !sellweapon"})
        Panel:ControlHelp   ("售卖目前已装备的武器.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) weapon_drop"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) /dropweapon"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !dropweapon"})
        Panel:ControlHelp   ("丢下目前已装备的武器.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) money_check"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) /money_check"})
        Panel:AddControl    ("Label" ,{ Text = "(聊天中) !money_check"})
        Panel:ControlHelp   ("打印账户余额和有趣的百分比速率.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) money_notifications 0/1"})
        Panel:ControlHelp   ("切换在聊天中的赚取金钱通知.")
        
        Panel:ControlHelp   (" --- ") -- 创建一个更小的垂直空间。
        
        Panel:AddControl    ("Label" ,{ Text = "(在控制台中) listplayers"})
        Panel:ControlHelp   ("打印目前已连接的玩家列表至控制台.")
        
        Panel:AddControl    ("Label" ,{ Text = "" }) -- 我鼓励去推动一些在底部的空间，来确保没有大部分内容隐藏在边缘.
        
    end

		
    -- -- -- -- -- -- -- -- --
    -- 综合管理   --
    -- -- -- -- -- -- -- -- --
    
    function SMS2_GeneralManagement(Panel)
    
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- Create a label (single-liner) with said text.
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
        Panel:ControlHelp   (">> 综合管理")
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
        if game.SinglePlayer() then
            Panel:ControlHelp   ("这项物品在单人模式时并不适用.")
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        end 
            
        if checkIfAdmin() then

            Panel:AddControl    ("CheckBox" ,{ Label = "冻结账户", Command = "money_freeze" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
            Panel:ControlHelp   ("允许 (关) 或 不允许 (开) 任何银行账户操作.")
            Panel:ControlHelp   ("并且切换收获日, 赏金事件和车辆并且发送生产.")
            Panel:ControlHelp   ("默认:关.")
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
            Panel:Button("-重置为默认", " money_default")
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
            Panel:Button("检查所有玩家", "money_checkall")
            Panel:ControlHelp   ("将所有玩家信息打印到控制台中.")
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
            Panel:Button("建立所有开始", "money_setall")
            Panel:ControlHelp   ("在新访客中重置所有已连接的玩家金钱' $ (启动账号).")
            
            Panel:AddControl("Slider", {
                Label = "新访客' $",
                Command = "money_starting",
                Type = "Int",
                Min = "300",
                Max = "7000" })
            Panel:ControlHelp   ("默认: 2500")
            
        else 
        
            Panel:ControlHelp   ("您不是管理员.") -- 控制帮助是主文本下的这些蓝色小字符串。
            Panel:ControlHelp   ("")
            
        end
end

	
    -- -- -- -- --
    -- 系统  --
    -- -- -- -- --
    
    function SMS2_MoneySystems(Panel)
    
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- 创造一个(单人航线)已说文本.
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
        if game.SinglePlayer() then
            Panel:ControlHelp   ("这项物品在单人模式中并不适用.")
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        end 
            
        if checkIfAdmin() then
        
            Panel:AddControl    ("Label" ,{ Text = ">> 1.发薪日" }) --创造一个(单人航线)已说文本.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
            Panel:AddControl    ("CheckBox" ,{ Label = "发薪日", Command = "money_paydays" })
            Panel:ControlHelp   ("收获日会在规定的时间内给予金钱.")
            
            Panel:AddControl    ("Textbox"   ,{ Label = "^基本现金数额", Command = "money_payday_amount"}) -- Textbox is user *string* input, single-lined. Remember to handle other types of data inside functions, because these babies can't.
            Panel:ControlHelp   ("改变收获日所给予现金的基准量. 重置计时器.")   -- Explode into two lines for better reading
            Panel:ControlHelp   ("单位: $. 默认: 505. 分: 10.")                                -- on small-width screen resolutions.
            
            Panel:AddControl    ("Textbox"   ,{ Label = "^时间间隔", Command = "money_payday_time_interval"}) -- WaitForEnter flag is to refresh ONLY after Textbox lost focus or is pressed ENTER.
            Panel:ControlHelp   ("在收获日之间改变时间间隔. 重置计时器.")
            Panel:ControlHelp   ("单位: 秒. 默认: 240. 分: 30.")
            
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:AddControl    ("Label" ,{ Text = ">> 2. 利率" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        
        
            Panel:AddControl    ("CheckBox" ,{ Label = "投资回报率", Command = "money_roi" })
            Panel:ControlHelp   (" 基于他们的活动，投资回报率将从收获日中改变玩家的金钱数额 .")
            
            Panel:AddControl("Slider", {
                Label = "投资回报率的最大偏移量 ",
                Command = "money_roi_maxoffset",
                Type = "Float",
                Min = "0.05",
                Max = "0.50" })
            Panel:ControlHelp   ("投资回报率的最大绝对值(一的分数).")  
            Panel:ControlHelp   ("默认: 0.25")
            
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:AddControl    ("Label" ,{ Text = ">> 3. 赏金系统" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            
            Panel:AddControl    ("CheckBox" ,{ Label = "赏金事件", Command = "money_bounty_system" })
            Panel:ControlHelp   ("基于他们的活动，在规定时间之后附加价格会显示在玩家的头上.")
            
            Panel:AddControl    ("Textbox"   ,{ Label = "^时间间隔", Command = "money_bounty_time_interva"}) -- WaitForEnter flag is to refresh ONLY after Textbox lost focus or is pressed ENTER.
            Panel:ControlHelp   ("在赏金事件之间改变时间间隔. 重置计时器.")
            Panel:ControlHelp   ("单元: 秒. 默认: 360. 分: 90.")
            
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:AddControl    ("Label" ,{ Text = ">> 4. 生产成本" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            
            Panel:AddControl    ("CheckBox" ,{ Label = "生产成本", Command = "money_spawncosts" })
            Panel:ControlHelp   ("切换生产和召唤价格.")
            Panel:ControlHelp   ("默认: ON.")
            
            Panel:AddControl    ("CheckBox" ,{ Label = "为了自由解除武装", Command = "money_defaultweaponsforfree" })
            Panel:ControlHelp   ("切换默认的GMod/HL2/RP 武器是自由的.")
            Panel:ControlHelp   ("只在自定义的服务器中有用.")
            Panel:ControlHelp   ("默认: ON.")
            
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:AddControl    ("Label" ,{ Text = ">> 5. 乘数" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:AddControl("Slider", {
                Label = "惩罚",
                Command = "money_multiplier_penalty",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改金钱惩罚.")
            
            Panel:AddControl("Slider", {
                Label = "奖励",
                Command = "money_multiplier_award",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改金钱奖励.")
                
            Panel:AddControl("Slider", {
                Label = "NPCs",
                Command = "money_multiplier_spawncost_npc",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改NPC的生产成本.")
            
            Panel:AddControl("Slider", {
                Label = "武器",
                Command = "money_multiplier_spawncost_swep",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改武器的价格.")
            
            Panel:AddControl("Slider", {
                Label = "车辆",
                Command = "money_multiplier_spawncost_vehicle",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改车辆和座位的生产成本.")
            
            Panel:AddControl("Slider", {
                Label = "发送",
                Command = "money_multiplier_spawncost_sent",
                Type = "Float",
                Min = "1.0",
                Max = "10.0" })
            Panel:ControlHelp   ("在多人中更改发送的生产成本.")
            
            Panel:AddControl("Slider", {
                Label = "道具 ",
                Command = "money_multiplier_spawncost_prop",
                Type = "Float",
                Min = "0.5",
                Max = "5.0" })
            Panel:ControlHelp   ("在多人中更改道具的生产成本.")
            
            Panel:AddControl    ("Label" ,{ Text = "" }) -- 我鼓励去推动一些在底部的空间，来确保没有大部分内容隐藏在边缘.
            
        else 
        
            Panel:ControlHelp   ("您并不是管理.") -- 控制帮助是主文本下的这些蓝色小字符串。
            Panel:ControlHelp   ("")
            
        end
    
end

	
    -- -- -- -- -- -- -- --
    -- 玩家动作             --
    -- -- -- -- -- -- -- --
    
    function SMS2_PlayerActions(Panel)
    
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- Create a label (single-liner) with said text.
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
        if game.SinglePlayer() then
            Panel:ControlHelp   ("这项物品在单人模式下并不适用.")
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        end 
            
        if checkIfAdmin() then
        
            Panel:AddControl    ("Label" ,{ Text = ">>玩家动作" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
            Panel:AddControl    ("CheckBox" ,{ Label = "偷袭/抢劫", Command = "spc_mugging" })
            Panel:ControlHelp   ("切换窃取金钱的能力指令.")
            
            Panel:AddControl    ("CheckBox" ,{ Label = "威胁", Command = "spc_threatening" })
            Panel:ControlHelp   ("切换使用威胁交出金钱的能.")
            
            Panel:AddControl    ("CheckBox" ,{ Label = "武器售卖", Command = "spc_weapon_unbuying" })
            Panel:ControlHelp   ("切换使用武器售卖的能力指令.")
            
            Panel:AddControl    ("CheckBox" ,{ Label = "武器掉落", Command = "spc_weapon_dropping" })
            Panel:ControlHelp   ("切换使用武器掉落的能力指令.")
            
        else 
        
            Panel:ControlHelp   ("您不是管理员.") -- 控制帮助是主文本下的这些蓝色小字符串。
            Panel:ControlHelp   ("")
            
        end
            
    end

	
    -- -- -- -- -- -- --
    -- 死亡相关  --
    -- -- -- -- -- -- --
    
    function SMS2_DeathRelated(Panel)
    
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- Create a label (single-liner) with said text.
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
        if game.SinglePlayer() then
            Panel:ControlHelp   ("这项物品在单人模式中并不适用.")
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        end 
            
        if checkIfAdmin() then
        
            Panel:AddControl    ("Label" ,{ Text = ">> 死亡-相关 / 分数-相关" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
            Panel:AddControl    ("CheckBox" ,{ Label = "NPC 杀敌计数器", Command = "npc_killcounter" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
            Panel:ControlHelp   ("切换任何NPC在计分板计数.")
            Panel:ControlHelp   ("默认: 开.")
            
            Panel:AddControl    ("CheckBox" ,{ Label = "当在没钱时重生", Command = "money_oninsufficient_respawn" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
            Panel:ControlHelp   ("当玩家资金不足时切换重生.")
            Panel:ControlHelp   ("默认: 开.")
        
            Panel:AddControl    ("CheckBox" ,{ Label = "偷走受害者的金钱", Command = "money_onkillplayer_steal" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
            Panel:ControlHelp   ("切换无论何时杀手在服务器得到的奖励或是从受害者那窃取一部分金钱.")
            Panel:ControlHelp   ("默认: 关.")
            
            Panel:AddControl("Slider", {
                Label = "^ PvP stolen frac.",
                Command = "money_onkillplayer_steal_fraction",
                Type = "Float",
                Min = "0.01",
                Max = "0.25" })
            Panel:ControlHelp   ("默认: 0.05.")
        
        else 
        
            Panel:ControlHelp   ("您不是管理员.") -- 控制帮助是主文本下的这些蓝色小字符串。
            Panel:ControlHelp   ("")
            
        end
        
    end

	
    -- -- -- -- -- -- --
    -- 团队设置  --
    -- -- -- -- -- -- --
    
    function SMS2_TeamSettings(Panel)
        
        Panel:AddControl    ("Label" ,{ Text = "经济系统" }) -- Create a label (single-liner) with said text.
        Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
    
        if game.SinglePlayer() then
            Panel:ControlHelp   ("这件物品在单人模式中并不适用.")
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
        end 
            
        if checkIfAdmin() then
        
            Panel:AddControl    ("Label" ,{ Text = ">> 1. 团队设置" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:AddControl    ("CheckBox" ,{ Label = "区分队伍", Command = "money_distinguish_teams" }) -- CheckBox defaultly uses 0 and 1, so don't worry.
            Panel:ControlHelp   ("切换无论何时队伍彼此都很优秀时.")
            Panel:ControlHelp   ("同时也切换无论何时收获日和奖励百分比奏效时.")
            Panel:ControlHelp   ("默认: 关.")
            
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            Panel:AddControl    ("Label" ,{ Text = ">> 2. 发薪日百分比" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:ControlHelp   ("这些百分比变量在一时有用 = 1% 类比.") -- 创建一个更小的垂直空间。
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:AddControl("Slider", {
                Label = "Team #0",
                Command = "money_payday_percentage_team0",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #1",
                Command = "money_payday_percentage_team1",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #2",
                Command = "money_payday_percentage_team2",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #3",
                Command = "money_payday_percentage_team3",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #4",
                Command = "money_payday_percentage_team4",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #5",
                Command = "money_payday_percentage_team5",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #6",
                Command = "money_payday_percentage_team6",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #7",
                Command = "money_payday_percentage_team7",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #8",
                Command = "money_payday_percentage_team8",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #9",
                Command = "money_payday_percentage_team9",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:AddControl    ("Label" ,{ Text = ">> 3. 奖励百分比" }) -- Create a label (single-liner) with said text.
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:ControlHelp   ("这些百分比变量在一时有用 = 1% 类比.") -- 创建一个更小的垂直空间。
            Panel:ControlHelp   ("") -- 创建一个更小的垂直空间。
            
            Panel:AddControl("Slider", {
                Label = "Team #0",
                Command = "money_awards_percentage_team0",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #1",
                Command = "money_awards_percentage_team1",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #2",
                Command = "money_awards_percentage_team2",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #3",
                Command = "money_awards_percentage_team3",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #4",
                Command = "money_awards_percentage_team4",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #5",
                Command = "money_awards_percentage_team5",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #6",
                Command = "money_awards_percentage_team6",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #7",
                Command = "money_awards_percentage_team7",
                Type = "Int",
                Min = "5",
                Max = "200" })
                
            Panel:AddControl("Slider", {
                Label = "Team #8",
                Command = "money_awards_percentage_team8",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl("Slider", {
                Label = "Team #9",
                Command = "money_awards_percentage_team9",
                Type = "Int",
                Min = "5",
                Max = "200" })
            
            Panel:AddControl    ("Label" ,{ Text = "" }) -- I encourage to force some space at the bottom, to make sure nothing is hidden over the edges with that much of content.
            
        else 
        
            Panel:ControlHelp   ("您不是管理员.") -- 控制帮助是主文本下的这些蓝色小字符串。
            Panel:ControlHelp   ("")
            
        end
            
    end

	
	-- -- -- --
	-- HOOKS --
	-- -- -- --
	
	hook.Add("PopulateToolMenu", "SMSMenus", function () -- Look the function and the hook up on wiki.garrysmod.com for more info.
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Client", "SMS1_Client", "客户端", "", "", SMS1_Client)
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Client", "SMS1_CommandsList", "命令列表", "", "", SMS1_CommandsList)
		
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Server", "SMS2_GeneralManagement", "1. 综合管理", "", "", SMS2_GeneralManagement)
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Server", "SMS2_MoneySystems", "2. 货币系统", "", "", SMS2_MoneySystems)
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Server", "SMS2_PlayerActions", "3. 玩家行为", "", "", SMS2_PlayerActions)
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Server", "SMS2_DeathRelated", "4. 死亡相关", "", "", SMS2_DeathRelated)
		spawnmenu.AddToolMenuOption("Utilities", "Sys - Server", "SMS2_TeamSettings", "5. 团队设置", "", "", SMS2_TeamSettings)
	end)
	
	
	print( "[Sandbox Simple Money System] Clientside initialized." )
	
	
end



-- END OF FILE --