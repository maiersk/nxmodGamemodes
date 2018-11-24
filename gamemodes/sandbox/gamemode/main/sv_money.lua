--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	沙箱简单的货币体系。由KRisU。特别感谢fghdx Rubat.
	Version: 2.0

]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


AddCSLuaFile() -- 标记文件,客户端下载

--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	游戏为基础的CONVARS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

CreateConVar( "money_starting", 1000, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- 浮动; 给每个新玩家的金额。
CreateConVar( "money_freeze", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool布尔型;防止任何银行帐户操作？

CreateConVar( "money_paydays", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 有工资吗？
--发薪日金额和发薪日时间间隔不是控制台变量 - 请参阅下面的设置[]。

CreateConVar( "money_bounty_system", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 赏金系统是否启用？
-- 赏金事件时间间隔不是控制台变量 - 请参阅下面的设置[]。

CreateConVar( "money_spawncosts", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- BOOL; 是否启用了生产成本
CreateConVar( "money_oninsufficient_respawn", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 是否因资金不足（如0美元）而重生？

CreateConVar( "money_roi", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Bool; ROI是否生效？
CreateConVar( "money_roi_maxoffset", 0.25, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float;最大绝对ROI值。

CreateConVar( "money_defaultweaponsforfree", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或禁止免费武器.

CreateConVar( "money_onkillplayer_steal", 0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 杀手是从服务器获取钱还是从受害者身上偷取？
CreateConVar( "money_onkillplayer_steal_fraction", 0.05, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; 受害者的银行账户杀手的百分之几（0.07 = 7％）盗窃？

CreateConVar( "money_multiplier_penalty", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float;  惩罚的增加者。
CreateConVar( "money_multiplier_award", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; 奖项的增加者。
CreateConVar( "money_multiplier_spawncost_npc", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; NPC成本的增加者。
CreateConVar( "money_multiplier_spawncost_swep", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; SWEP成本的增加者。
CreateConVar( "money_multiplier_spawncost_vehicle", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; 车辆成本的增加者。
CreateConVar( "money_multiplier_spawncost_sent", 5.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; SENT成本的增加者。
CreateConVar( "money_multiplier_spawncost_prop", 1.0, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } ) -- Float; PROP成本的增加者.

CreateConVar( "money_distinguish_teams", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY } ) -- Bool; 在金钱系统设置方面，团队是否有区别？ 请参阅下面的更多信息。

CreateConVar( "money_payday_percentage_team0", 250, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team1", 200, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team2", 300, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team3", 400, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team4", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team5", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team6", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team7", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team8", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_payday_percentage_team9", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )

CreateConVar( "money_awards_percentage_team0", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team1", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team2", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team3", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team4", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team5", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team6", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team7", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team8", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )
CreateConVar( "money_awards_percentage_team9", 100, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_USERINFO } )

CreateConVar( "spc_mugging", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或禁止手动抢劫。
CreateConVar( "spc_threatening", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或禁止手动威胁（冻结玩家并使他们采取随机行动）。
CreateConVar( "spc_weapon_unbuying", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或不允许手工销售装备的武器或物品。
CreateConVar( "spc_weapon_dropping", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或禁止手动武器掉落。

CreateConVar( "npc_killcounter", 1, { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_NOTIFY , FCVAR_USERINFO } ) -- Bool; 允许或不允许计数死亡的NPC到记分牌。

--CreateConVar( "money_randomevents", 0, { FCVAR_ARCHIVE , FCVAR_NOTIFY } ) -- Bool; 随机挣钱或亏钱事件是否会发生？| 未来的计划

--function notifySpecOnConVarChanged( name, old, new ) -- 内部钩子可以与默认系统convars和concommands状态改变公告方便。
--hook.Add("OnConVarChanged", "notifySpecOnConVarChanged", notifySpecOnConVarChanged) --不建议。


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	主表MAIN TABLES
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local settings = {

	-- 发薪日; 设置小于1将不起作用。
	
		payday_amount = 100, 		-- 在一个发薪日里要增加多少钱。 不应该仅仅是开始赚钱.
		payday_time_interval = 240, -- 工作日之间的时间，以秒为单位。 默认270秒。 请不要少于2秒，这会在游戏中变得凌乱。 游戏中的游戏时间不能少于30秒。
		
	-- 赏金; 设置小于1将不起作用。
	
		bounty_time_interval = 360,	-- 赏金事件之间的时间间隔以秒为单位。 不应少于90秒。 就像这一次真实一样。
		
	-- 对行为的处罚; 设置小于1将不起作用。
	
		penalty_deathby_self = 75, 		-- 最佳设置略小于2 *'award_on_killnpc_else'。
		penalty_deathby_entity = 45,	-- 通过除自我或玩家以外的其他来源定义死亡。 最佳设置不到“award_on_killplayer”的一半。
		penalty_deathby_player = 8,		-- 它应该循环2到5次'penalty_respawn'值。
		penalty_respawn = 2,			-- 如果这个设置超过10个，那将会是一场抢劫。
		
	-- 行动奖; 设置小于1将不起作用。

		award_on_killplayer = 99,			-- 在'on_killplayer_steal'设置为false时使用。 应该是发薪日金额的25％-40％。
		award_on_killnpc_ultrabig = 2004,	-- 最佳设置约为npc_big奖励值的四倍。
		award_on_killnpc_big = 460, 		-- 最佳设置是将以下三个值相加，乘以10，然后除以2.5。
		award_on_killnpc_else = 65,  		-- 除大，小和友善以外的NPC奖 - 最好在“award_on_killplayer”的一半左右。
		award_on_killnpc_small = 35, 		-- 最佳设置是在'其他'和'友好'之间，不超过发薪日数额的15％。
		award_on_killnpc_friendly = 15	 	-- 为了禁用磨钱，必须将其设置为比“spawncost_npc_friendly”小得多。
	
}


local spawncosts = {

	-- Others; 没有任何乘数效应和布娃娃的成本。
		
		effect = 2, 	-- 让它2或4。
		ragdoll = 15,	-- 为获得最佳结果，应该等于'award_on_killnpc_friendly'。

	-- 武器成本; 设置小于1将不起作用。 任何和免费的武器都在下面的“free_weapons”表中定义。 总是免费的武器列在“true_weapons”表中。
		
		weapon = 73, -- 最佳设置是2 *'award_on_killnpc_else'。
		m9k_gdcw_app = 9, -- 这些'应用'对于这种武器的成本来说只是少数增加。
		fas2_app = 8,
		cw20_app = 4,
		q3_app = 3,
		cs_ttt_rp_dod_app = 2,
		eq_gmod_stranded_app = -1,
		
	-- NPC费用; 设置小于1将不起作用。
		
		npc_ultrabig = 606, -- NPC列为超大型; 见下文（关于npc_big的三倍左右）。
		npc_big = 150, 		-- NPC列为大; 见下文。
		npc_else = 40, 	 	-- 每个未被列为小型，大型，超大型或友善的NPC。
		npc_small = 30,	 	-- NPC列为小型; 见下文。
		npc_friendly = 25, 	-- NPC列为友好; 见下文。
		
	-- 车辆成本; 设置小于1将不起作用。
		
		vehicle_seat = 88, 		-- 任何座位的基地。
		vehicle_airboat = 400, 	-- 汽艇的基地。
		vehicle_jeep_old = 275,	-- 旧的，红色的吉普（吉普）的基地。
		vehicle_hl2apc = 900, 	-- HL2 APC的基地。 尽管如此，它并没有真正被使用。
		vehicle_jeep = 333, 	-- 新的黄色肌肉车（Jalopy）的基地和未知车辆的处理者！
		vehicle_tank = 775,		-- -vv-------------------vv- -- 
		vehicle_delorean = 455,	--  SCars 2.0 by sakarias88  -- 
		vehicle_junk = 255,		--  SCars 2.0 by sakarias88  --
		vehicle_gtone = 440,	-- -^^-------------------^^- --  
		
	-- SENT成本; 设置小于1将不起作用。
		
		-- SENT的成本乘以'sent_multiplier'; 以下除外：
		
		sent_stat = 288,					-- 其他HL2内容和附加功能+其他人+座位+此插件 -
		sent_jet = 2250,					-- -vv-------------------vv- --
		sent_jet_nonadmin = 1850,			-- AirVehicles by sakarias88 --
		sent_helicopter = 1450,				-- AirVehicles by sakarias88 --
		sent_helicopter_nonadmin = 1050,	-- -^^-------------------^^- --
		sent_gasstation = 2000,		        -- SCars 2.0 by sakarias88 -- 
		sent_combinemech = 1150,			-- Combine Mech Fixed addon --
		cw_ammo_crate_regular = 444,		-- -vv-------------------vv- --
		cw_ammo_crate_small = 299, 			-- Customizable Weaponry 2.0 --
		cw_ammo_kit_regular = 123,			-- Customizable Weaponry 2.0 --
		cw_ammo_kit_small = 75,				-- -^^-------------------^^- --
		anomaly = 1250,						-- Stalker RP Anomalies --
		sent_tardis = 3600,					-- TARDIS by MattJeanes --
		
	-- 由“实体质量”定义的PROP费用; 如果实体的质量小于<< N，那么它相应地花费组; 设置小于1将不起作用。

		prop_under_5 = 2,
		prop_under_10 = 5,
		prop_under_20 = 8,
		prop_under_40 = 11,
		prop_under_60 = 15,
		prop_under_80 = 19,
		prop_under_100 = 23,
		prop_under_150 = 28,
		prop_under_200 = 33,
		prop_under_300 = 39,
		prop_under_400 = 45,
		prop_under_600 = 50,
		prop_under_800 = 55,
		prop_under_1200 = 60,
		prop_under_1600 = 65,
		prop_under_2400 = 73,
		prop_under_3200 = 81,
		prop_under_4800 = 95,
		prop_under_6400 = 110,
		prop_under_9999 = 140,
		prop_over_9999 = 175
		
}


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	> 免费武器
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- 当“money_defaultweaponsforfree”设置为true时免费。
local free_weapons = { -- Add Weapon:GetClass() name string at the end of the table to recognize it as free. A-Z sorting is optional.
	"eq_flashlight", "eq_parachute", "eq_torch", "eq_torch_bms", "eq_wrench", "eq_zparachute", "flashlight", "gm_hands", "gmod_camera", "gmod_fists", "gmod_hands", 
	"gmod_tool", "rp_hands", "rphands", "stalker_bolt", "ttt_hands", "weapon_357", "weapon_ar1", "weapon_ar2", "weapon_bolt", "weapon_crossbow", "weapon_crowbar", 
	"weapon_fists", "weapon_flashlight", "weapon_frag", "weapon_knife", "weapon_parachute", "weapon_physcannon", "weapon_physgun", "weapon_pistol", "weapon_rock", 
	"weapon_rpg", "weapon_scarkeys", "weapon_shotgun", "weapon_smg1", "weapon_smoke", "weapon_smokegrenade", "weapon_stick", "weapon_stone", "weapon_stunstick", 
	"weapon_torch", "zparachute"
}

-- Free when "money_defaultweaponsforfree" is set to false.
local true_weapons = { -- Add Weapon:GetClass() name string at the end of the table to recognize it as always free. A-Z sorting is optional.
	"eq_flashlight", "eq_parachute", "eq_torch", "eq_torch_bms", "eq_zparachute", "flashlight", "gmod_camera", "gmod_fists", "gmod_hands", "gmod_tool", "rp_hands", 
	"rphands", "stalker_bolt", "weapon_bolt", "weapon_crowbar", "weapon_fists", "weapon_flashlight", "weapon_knife", "weapon_parachute", "weapon_physcannon", 
	"weapon_physgun", "weapon_rock", "weapon_stick", "weapon_stone", "weapon_stunstick", "weapon_torch", "zparachute"
}



--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	> NPC GROUPS; Every Entity:NPC with name not contained in one of these three groups will be labeled as 'else'.
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local npc_friendly = { -- Add entity.npc string name here to list it with others allies. A-Z sorting is optional.
	"monster_barney", "monster_freeman", "monster_gman", "monster_otis", "monster_rosenberg", "monster_wheelchair", "npc_alyx", "npc_barney", "npc_breen", "npc_dog", 
	"npc_eli", "npc_fisherman", "npc_freeman", "npc_friendly", "npc_gman", "npc_kleiner", "npc_magnusson", "npc_monk", "npc_mossman"
}

local npc_small = { -- Add entity.npc string name here to list it with others smalls. A-Z sorting is optional.
	"combine_mine", "monster_alien_babyvoltigore", "monster_babycrab", "monster_cockroach", "monster_headcrab", "monster_penguin", "npc_antlion_grub", "npc_barnacle", 
	"npc_chicken", "npc_chumtoad", "npc_clawscanner", "npc_combine_camera", "npc_combine_mine", "npc_crow", "npc_cscanner", "npc_bird", "npc_headcrab", 
	"npc_headcrab_black", "npc_headcrab_fast", "npc_manhack", "npc_owl", "npc_parrot", "npc_pigeon", "npc_seagull", "npc_turret_ceiling"
}

local npc_big = { -- Add entity.npc string name here to list it with others bigs. A-Z sorting is optional.
	"combine_apc", "monster_babygarg", "monster_bigmomma", "monster_gargantua", "monster_gargantuar", "npc_advisor", "npc_antlionguard", "npc_antlionguardian", 
	"npc_apache", "npc_apc", "npc_blackhawk", "npc_combineapc", "npc_combinedropship", "npc_combinegunship", "npc_crabsynth", "npc_deathclaw", "npc_deathclaw_alphamale", 
	"npc_deathclaw_mother", "npc_dragon", "npc_dragon_ancient", "npc_dragon_blood", "npc_dragon_elder", "npc_dragon_frost", "npc_dragon_revered", "npc_dragon_serpentine",
	"npc_dragon_skeleton", "npc_gecko_gojira", "npc_heli", "npc_helicopter", "npc_hellknight", "npc_mudcrab_legendary", "npc_strider", "npc_tank", "npc_ultron", 
	"npc_vj_tank", "npc_vj_zss_zboss", "npc_vj_zps_zboss"
}

local npc_ultrabig = { -- Add entity.npc string name here to list it with others super-bigs. A-Z sorting is optional.
	"monster_nihilanth", "npc_guardian",  "npc_vj_fo3ene_libertyprime", "npc_vj_fo3bhs_libertyprime", "npc_vj_libertyprime", "npc_dragon_alduin", "npc_dragon_odahviing", 
	"npc_dragon_paarthurnax", "npc_libertyprime", "npc_spaceship"
}



--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	INITIALIZATION AND PRE-LOAD
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	
	function GetPaydayAmount()
		return settings['payday_amount']
	end
	
	
if (SERVER) then
	
	
	player_data = FindMetaTable("Player") -- Gets all the functions that affect player.
	
	
	-- Money:
	
	function player_data:money_initLoad()
		if self:GetPData( "money" ) == nil then -- See if there is data under "money" for the player.
			self:SetPData( "money", GetConVar("money_starting"):GetInt() ) -- If not, add money.
		end
		self:SetNWInt("money", self:GetPData( "money" )) -- Set the network int so the client can grab the info.
	end
	
	-- Money' Rate of Interest:
	
	function player_data:roi_initLoad()
		if self:GetPData( "moneyROI" ) == nil then -- See if there is data under "moneyROI" for the player.
			self:SetPData( "moneyROI", 0.00 ) -- If not, set 0.
		end
		self:SetNWFloat("moneyROI", (math.floor(self:GetPData( "moneyROI" )*100)*0.01)) -- Set the network float so the client can grab the info. This function gets rid of any unnecessary numbers after the second decimal position.
	end
	
	-- Fame Points (Bounty System):
	
	function player_data:fame_initLoad()
		if self:GetPData( "bountyFame" ) == nil then -- See if there is data under "bountyFame" for the player.
			self:SetPData( "bountyFame", 1 ) -- If not, set 1.
		end
		self:SetNWInt("bountyFame", (math.ceil(self:GetPData( "bountyFame" )))) -- Set the network int so the client can grab the info.
	end
	
	-- 玩家初始产卵钩:
	
	function system_initLoadOnSpawn( ply ) -- 加载系统播放器初始产卵.
		ply:money_initLoad()
		ply:roi_initLoad()
		ply:fame_initLoad()
		ply:fame_interact(1,1)
		ply:SetNWBool( "isHunted" , false )
		ply:SetNWInt( "bountyPrice" , 0 )
		ply:SetNWBool( "antitheftEq" , false )
		ply:SetNWInt( "latestExpense1", 0 )
		ply:SetNWInt( "latestExpense2", 0 )
		ply:SetNWInt( "latestExpense3", 0 )
	end
	hook.Add( "PlayerInitialSpawn", "SMSInitLoadOnSpawn", system_initLoadOnSpawn )

	
	-- Init message:
	
	hook.Add( "Initialize", "SMSInit", function ()
		print("[系统] 服务端初始化.")
	end )
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SYSTEMS INTERACTION METHODS 系统交互函数
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- 钱方法.
	-- 货币被解释为全尺寸货币。 没有便士和小狗屎.
	function player_data:money_interact( method, amount ) -- 添加或拿钱.
		if (GetConVar( "money_freeze" ):GetBool() == false) then
			for _, v in pairs( player.GetAll() ) do
				if IsValid( v ) then
					local wallet = v:PS2_GetWallet()
					local ply = v
					local money = self:GetNWInt( "money" ) -- 获得球员的钱.
					if wallet then
						if v:GetNWInt( "KPlayerId" ) == wallet.ownerId then
							if (method == 0) then-- 方法0是拿钱，方法1（不是0）是给钱的.
								if self:IsBot() then 
								return 
								else
								Pointshop2Controller:getInstance():adminChangeWallet( self, wallet.ownerId, "points", wallet.points - amount )
								end
								self:SetNWInt("money", money - amount) 	-- 设置网络int为钱。 这样我们就可以在客户端上获取它.
								self:SetPData("money", money - amount) 	-- 用户资金更新为当前所拥有的金额 - 来自互动的金额.
							elseif (method == 1) then 
								if self:IsBot() then 
								return 
								else
								Pointshop2Controller:getInstance():adminChangeWallet( self, wallet.ownerId, "points", wallet.points + amount )
								end
								self:SetNWInt("money", money + amount)	-- 设置网络int为钱。 这样我们就可以在客户端上获取它.
								self:SetPData("money", money + amount) 	-- 用户资金被更新为当前具有的内容+来自交互的金额.
							elseif (method == 2) then 
								if self:IsBot() then 
								return 
								else
								Pointshop2Controller:getInstance():adminChangeWallet( self, wallet.ownerId, "points", amount )
								end
								self:SetNWInt("money", amount)	-- 设置网络int为钱。 这样我们就可以在客户端上获取它.
								self:SetPData("money", amount) 	-- 用户资金被更新为当前具有的内容+来自交互的金额.
							end
						end
					end
				end
			end
		else
			return
		end
	end
	
	-- ROI Method.
	-- Amount is interpreted as number of percents (e.g. 3% is 3.0).
	function player_data:roi_interact( method, amount ) -- Increase or decrease ROI.
		
		if (GetConVar("money_roi"):GetBool() == true) then 	-- The one and only check for money roi availability - 
															-- there is no need to check for it anywhere else, the function simply won't do anything if it retrieves false.
			
			local roi = self:GetNWFloat( "moneyROI" ) -- Gets the players ROI.
			
			if (method == 0) then -- Method 0 is subtract
				if ( ((roi - amount - 0.01)/100) < (GetConVar("money_roi_maxoffset"):GetFloat()*(-1)) ) then
					self:SetNWFloat("moneyROI", ((math.ceil((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(-1)) )
					self:SetPData("moneyROI", ((math.ceil((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(-1)) )
				else
					self:SetNWFloat("moneyROI", ((math.ceil((roi - amount)*100))*0.010)) -- Set the network float for the roi. This way we can get it on the client.
					self:SetPData("moneyROI", ((math.ceil((roi - amount)*100))*0.010)) 	 -- Update PData.
				end
			else -- Method NOT 0 (e.g. 1) is add.
				if ( ((roi + amount + 0.01)/100) > (GetConVar("money_roi_maxoffset"):GetFloat()*1) ) then
					self:SetNWFloat("moneyROI", ((math.floor((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(1)) )
					self:SetPData("moneyROI", ((math.floor((GetConVar("money_roi_maxoffset"):GetFloat()*100))*0.010)*(1)) )
				else
					self:SetNWFloat("moneyROI", ((math.floor((roi + amount)*100))*0.010))	-- Set the network float for the roi. This way we can get it on the client.
					self:SetPData("moneyROI", ((math.floor((roi + amount)*100))*0.010)) 	-- Update PData.
				end
			end
		
		else
			return
		end
		
	end

	-- 赏金方法.
	-- 系统适用于从0开始的整数。 money_interact的类比功能.
	function player_data:fame_interact( method, amount ) -- 添加或获取名望积分.
		
		if (GetConVar("money_bounty_system"):GetBool() == true) then	-- 唯一的检查赏金系统可用性 - 
																		-- 没有必要在其他地方检查它，如果它检索错误，该函数根本不会做任何事情.
			
			local fame = self:GetNWInt( "bountyFame" )
			
			if (method == 0) then -- 方法0是降低名气，方法1（不是0）是增加名气.
				if (fame - amount <= 0) then
					self:SetNWInt("bountyFame", 0)
					self:SetPData("bountyFame", 0)
				else
					self:SetNWInt("bountyFame", fame - amount)
					self:SetPData("bountyFame", fame - amount)
				end
			else
				self:SetNWInt("bountyFame", fame + amount)
				self:SetPData("bountyFame", fame + amount)
			end
		
		else
			return
		end
		
	end
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	MONEY BASIC METHODS 钱基本方法
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	
	-- 这用于检查玩家是否有足够的钱来做他们要求的事情。
	function player_data:money_enough( amount ) 		-- 检查玩家是否有足够的钱购买一个动作。
		
		local money = tonumber(self:GetNWInt( "money" )) 	
		
		if (money >= amount) then 	-- 如果有,它将返回true.					
			return true
		else						-- 如果没有，该函数将返回false.
			return false
		end
	end
	
	-- 这用于为玩家提供内部正确性检查.
	function player_data:money_give( amount )
		if (tonumber(amount) > 0) then 		-- 检查金额是否超过0，以防止玩家发送或给予负数.
			self:money_interact(1, amount) 	-- 加钱 .
		end
	end

	-- 这用于从玩家那里拿钱.
	function player_data:money_take( amount )
		if ((tonumber(amount) > 0) and self:money_enough(amount) == true) then -- 检查金额是否超过0，以防止玩家发送或给予负数.
			self:money_interact(0, amount) -- 取钱.
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", amount )
			return true
		else
			return false
		end
	end
	--设置钱数
	function player_data:money_set( amount )
		if ((tonumber(amount) >= 0)) then -- 检查金额是否超过0，以防止玩家发送或给予负数.
			self:money_interact(2, amount) -- 取钱.
			return true
		else
			return false
		end
	end

	-- 如果付款超过余额，此功能从玩家获取资金并将银行帐户归零.
	function player_data:money_take_absolute( amount )
		
		local money = tonumber(self:GetNWInt( "money" ))	-- 获取玩家的钱.
		
		if (amount > 0 and money > amount) then 			-- 检查金额是否超过0以防止发送或给出负数.
			self:money_interact(0, amount)
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", amount )
		elseif (amount > 0 and money <= amount) then 		-- 如果作为参数给出的金额超过玩家所拥有的金额，则将其全部收入（零银行账户）.
			self:money_interact(0, money)
			self:SetNWInt( "latestExpense1", self:GetNWInt( "latestExpense2" ))
			self:SetNWInt( "latestExpense2", self:GetNWInt( "latestExpense3" ))
			self:SetNWInt( "latestExpense3", money )
		end
	end

	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SYSTEMS 系统
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- BASIC PAYDAY FUNCTION	基本工作日功能
	
	function doPayday()
		
		-- Declare variables and initiate them always outside of any loops when writing in C or any derivative or deviation.
		-- 当用C或任何导数或偏差书写时，声明变量并始终在任何循环之外启动它们
		
		local randomFactor = math.random() -- 生成伪随机数.
		local roi = 0 			-- 声明并启动局部变量，供以后使用.
		local paydayMoney = 0	-- 声明并启动局部变量，供以后使用.
		local teamIndex = 0		-- 声明并启动局部变量，供以后使用.
		
		for key, ply in pairs(player.GetAll()) do 	-- 迭代服务器中的每个玩家.
		
			-- 计算.
		
			teamIndex = ply:Team()

			roi = ply:GetNWFloat( "moneyROI" ) -- 获取球员的兴趣率.
			
			if (teamIndex != nil and GetConVar("money_distinguish_teams"):GetBool() == true) then -- 区分团队.

				if ( teamIndex == tonumber( ULib.ucl.groups["citizen"].team.index ) ) then
					print( "payday is citizen ok" )
					--paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team0"):GetInt())/100))
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(ULib.ucl.groups["citizen"].team.wage)/100))
				elseif ( teamIndex == tonumber( ULib.ucl.groups["doctor"].team.index ) ) then
					print( "payday is doctor ok" )
					--paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team1"):GetInt())/100))
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(ULib.ucl.groups["doctor"].team.wage)/100))
				elseif ( teamIndex == tonumber( ULib.ucl.groups["poilce"].team.index ) ) then
					print( "payday is poilce ok" )
					--paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team2"):GetInt())/100))
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(ULib.ucl.groups["poilce"].team.wage)/100))
				elseif ( teamIndex == tonumber( ULib.ucl.groups["project"].team.index ) ) then
					print( "payday is project ok" )
					--paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team3"):GetInt())/100))
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(ULib.ucl.groups["project"].team.wage)/100))
				end
				--[[
				if (teamIndex == 0) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team0"):GetInt())/100))
				elseif (teamIndex == 1) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team1"):GetInt())/100))
				elseif (teamIndex == 2) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team2"):GetInt())/100))
				elseif (teamIndex == 3) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team3"):GetInt())/100))
				elseif (teamIndex == 4) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team4"):GetInt())/100))
				elseif (teamIndex == 5) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team5"):GetInt())/100))
				elseif (teamIndex == 6) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team6"):GetInt())/100))
				elseif (teamIndex == 7) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team7"):GetInt())/100))
				elseif (teamIndex == 8) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team8"):GetInt())/100))
				elseif (teamIndex == 9) then
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*2.1))*(1.0+(roi/100.0))*(math.abs(GetConVar("money_payday_percentage_team9"):GetInt())/100))
				else
					paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*3.1))*(1.0+(roi/100.0)))
				end
				--]]
			else
				print("no")
				paydayMoney = math.ceil((settings['payday_amount']+math.floor(randomFactor*3.1))*(1.0+(roi/100.0)))
			end
			
			-- 确保发薪日总是至少提供10美元。
			
			if (paydayMoney < 11) then 
				paydayMoney = 10
			end
			
			-- 减少名气.
		
			ply:fame_interact(0, math.ceil(paydayMoney/99))
			
			-- 奖励管理员.
			
			if ( ply:IsAdmin() or ply:IsSuperAdmin() or ply:IsUserGroup( "server owner" ) or ply:IsUserGroup( "serverowner" ) or ply:IsUserGroup( "owner" )  ) then -- 检查用户是否为admin或更高版本
				paydayMoney = paydayMoney + math.ceil(math.random(11,33))
			end
			
			-- 给钱.
		
			ply:money_give(paydayMoney)
		
			-- 通知，如果有的话.
		
			if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then -- 检索客户端变量值并检查它是否为1（true）。
					
				ply:roi_interact(1, 0.01)
				
				if (randomFactor < 0.34) then -- 生成两个公告以获得更多种类。
					ply:PrintMessage( HUD_PRINTTALK, ">> 发薪日到了！拿到普通工资 " .. paydayMoney .. "$.") -- 打印聊天.
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> 发薪日到了！拿到最多的工资 " .. paydayMoney .. "$.") -- 打印聊天.
				end

			end
			
		end
		
	end

	
	-- 基本赏金功能
	
	local bountyStatus = false
	
	function doBounty()
		
		-- 当用C或任何导数或偏差书写时，声明变量并始终在任何循环之外启动它们.
		
		if (#player.GetHumans() >= 2 and bountyStatus != true) then
			
			local plyBounty = 0
			local bountyTarget = nil
			local bountyPrice = 1
		
			for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
				if (ply:GetNWInt( "bountyFame" ) >= plyBounty and ply:HasGodMode() != true and ply:TimeConnected() > 25 and ply:IsFrozen() != true and ply:Alive() == true) then
					plyBounty = ply:GetNWInt( "bountyFame" )
					bountyTarget = ply
					bountyPrice = (math.ceil((ply:GetNWInt( "money" )/(math.ceil(math.random(4,8))))+(ply:GetNWInt( "bountyFame" )*1.25)+math.random(-1,32)))
				end
			end			
			
			if (bountyTarget == nil) then
				bountyTarget = ply:GetByID(1)
				bountyPrice = 16
			end
			
			if (bountyPrice > settings['payday_amount']*4) then
				bountyPrice = math.floor((settings['payday_amount']*math.random(3.33,4.44))+math.random(-2.22,5.55))
			elseif (bountyPrice < 16) then
				bountyPrice = 16
			end
			
			bountyStatus = true
			
			bountyTarget:SetNWBool( "isHunted", true )
			bountyTarget:SetNWInt( "bountyPrice", bountyPrice)
			
			timer.Simple( 59, function()
			
				if (bountyStatus == false) then
					
					for key, ply in pairs(player.GetAll()) do
						ply:SetNWBool( "isHunted", false )
						ply:SetNWInt( "bountyPrice", 0 )
					end
					
				else
				
					bountyStatus = false
					
					for key, ply in pairs(player.GetAll()) do
						if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then
								ply:PrintMessage( HUD_PRINTTALK, ">> 赏金无人认领的.") -- 告诉他们发生了什么.
						end
						ply:SetNWBool( "isHunted", false )
						ply:SetNWInt( "bountyPrice", 0 )
					end
					
				end
				
			end)
			
		else
			return
		end
		
	end
	
	hook.Add("PlayerDeath", "SMSBountyEvent", function(victim, inflictor, killer)
				if (bountyStatus == true) then
					if (victim != killer and victim:GetNWBool("isHunted") == true and victim:IsPlayer() == true and killer:IsPlayer() == true) then
						
						bountyStatus = false
						victim:SetNWBool( "isHunted", false )
						killer:money_give(victim:GetNWInt( "bountyPrice" ))
						killer:fame_interact(1, 6)
						killer:roi_interact(1, 0.01)
						victim:fame_interact(0, 7)
						
						if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
							killer:PrintMessage( HUD_PRINTTALK, ">> 你声称 " .. victim:GetNWInt( "bountyPrice" ) .. "$ 赏金.") -- 告诉他们发生了什么事.
						end
						
						for key, ply in pairs(player.GetAll()) do
							if ply != killer then
								if (ply:GetInfoNum( "money_notifications", 1 ) == 1) then
									ply:PrintMessage( HUD_PRINTTALK, ">> 赏金声称!") -- 告诉他们发生了什么.
								end
							end
						end
						
					end
				end
			end)
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Systems Initialization and loop-through.  --系统初始化和循环
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function systemsCheckInit( method )
	
		if (method == 0) then
		
			if (GetConVar("money_paydays"):GetBool() == true and GetConVar("money_freeze"):GetBool() == false) then -- 如果启用了发薪日，那么：
				if (timer.Exists( "paydayTimer" ) == false) then -- 如果计时器不存在。
					timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- 创造它.
				else -- 我们不想创建计时器，如果它存在不重置它的时间.
					return
				end
			else -- 如果发薪日被禁用，那么：..我们不必在这里检查计时器是否存在，因为只有调用删除才能提高资源效率.
				timer.Remove( "paydayTimer" ) -- 为了CPU而删除计时器.
			end
			
		else
		
			if (GetConVar("money_bounty_system"):GetBool() == true and GetConVar("money_freeze"):GetBool() == false) then -- 如果启用赏金，则：
				if (timer.Exists( "bountyTimer" ) == false) then -- 如果计时器不存在.
					timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- 创造它.
				else -- 我们不想创建计时器，如果它存在不重置它的时间.
					return
				end
			else -- 如果赏金被禁用，那么：..我们不必检查计时器是否存在，因为只有调用remove才能提高资源效率.
				timer.Remove( "bountyTimer" ) -- 为了CPU而删除计时器.
			end
			
		end
		
	end
		
	timer.Create( "paydayChecker" , 2 , 0 ,  function() systemsCheckInit(0) end) -- 启动时添加计时器。 为了效率，每2秒发生一次。
	timer.Create( "bountyChecker" , 2 , 0 ,  function() systemsCheckInit(1) end) -- 启动时添加计时器。 为了效率，每2秒发生一次。
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	GIVE/TAKE (EYETRACE) FUNCTIONS	给予/采取（EYETRACE）功能
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Give Money to player @ CrosshairPos (In-Game).  给钱玩家--
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyGiveMoney_Pos( amount )
		
		if (amount == nil or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTTALK, ">> 无效值转移!" )
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
			
			local target = self:GetEyeTrace().Entity -- 获取玩家正在查看的实体.
			
			if target:IsPlayer() then -- 如果实体是玩家:
			
				-- 始终确保Ints将成为Ints - 这就是为什么有地板功能.
			
				if ( self:money_enough(math.floor(tonumber(amount))) ) then	-- 如果玩家有足够的钱，继续.
					target:money_give(math.floor(tonumber(amount))) 		-- 给他们正在看的球员钱.
					self:money_take(math.floor(tonumber(amount)))			-- 从玩家那里拿钱.
					self:PrintMessage( HUD_PRINTTALK, ">> 转账 " .. math.floor(amount) .. "$ 到 " .. target:Nick() .. ".") -- 打印聊天.
					target:PrintMessage( HUD_PRINTTALK, ">> " .. self:Nick() .. " 付你 " .. math.floor(amount) .. "$.") 	 -- 打印到目标聊天.
					
					self:roi_interact(1, 0.07)
					self:fame_interact(0, 9)
				else
					self:PrintMessage( HUD_PRINTTALK, ">> 你没有足够的钱!" ) -- 如果玩家没有足够的钱打印它聊天.
				end
			else
				self:PrintMessage( HUD_PRINTTALK, ">> 没有瞄准任何玩家." ) -- 如果玩家没有瞄准玩家打印聊天.
			end
		
		else
			self:PrintMessage( HUD_PRINTTALK, ">> 由于银行账户被冻结，交易被拒绝." )
		end
		
	end

-- Creating the console command for func plyGiveMoney_Pos
	function plyGiveMoney_CC1( client, command, arguments )
		client:plyGiveMoney_Pos(arguments[1])
	end
concommand.Add("money_give", plyGiveMoney_CC1, nil, "给在准星瞄准中的玩家提供一定数量的金钱. 参数: <金钱量>") -- 命令名称，func回调，nil，帮助信息.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Give Money to player with given ID (In-Game).给给定ID的玩家钱   --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyGiveMoney_ID( playerid, amount )
				
		if (amount == nil or playerid == nil or tonumber(playerid) < 0 or playerid == error or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTCONSOLE, " 无效的值!" )
			self:ConCommand("help money_transfer")
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
		
			if ( player.GetByID( tonumber(playerid) ) != nil ) then
			
				if ( self:money_enough(math.floor(tonumber(amount))) ) then
					player.GetByID( tonumber(playerid) ):money_give( math.floor(tonumber(amount)) ) -- 通过playerid索引给玩家钱.
					self:money_take(math.floor(tonumber(amount)))									-- 从玩家那里扣钱.
					self:PrintMessage( HUD_PRINTCONSOLE, " 转账 " .. math.floor(amount) .. "$ 到 " .. target:Nick() .. ".") -- 打印聊天.
					player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK, ">> " .. self:Nick() .. " 付你 " .. math.floor(amount) .. "$.") -- 打印到目标聊天.
					
					self:roi_interact(1, 0.03)
					self:fame_interact(0, 3)
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " 你没有足够的钱!" ) -- 如果玩家没有足够的钱打印它聊天.
				end
			
			else
				self:PrintMessage( HUD_PRINTCONSOLE, " 找不到该玩家!" )
			end
			
		else
			self:PrintMessage( HUD_PRINTCONSOLE, " 由于银行账户被冻结，交易被拒绝." )
		end
		
	end
	
-- 为func plyGiveMoney_ID创建控制台命令
	function plyGiveMoney_CC2( client, command, arguments )
		client:plyGiveMoney_ID(arguments[1], arguments[2])
	end
concommand.Add("money_transfer", plyGiveMoney_CC2, nil, "用于向给定ID的玩家提供一定数量的金钱。 参数: <id,金钱量>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Take money from (mug) player @ CrosshairPos (In-Game). 从玩家里偷钱	--
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	
	function player_data:plyMug_Pos( amount )
		
		if (amount == nil or amount == error or tonumber(amount) <= 0) then
			self:PrintMessage( HUD_PRINTTALK, ">> 用于执行操作的值无效!" )
			return
		end
		
		if (GetConVar( "money_freeze" ):GetBool() != true) then
		
			if (GetConVar("spc_mugging"):GetBool() == true) then -- 如果允许抢劫，继续.
				
				local randomfactor = math.random()*2.0 		-- 生成成功因子的伪随机数.
				local target = self:GetEyeTrace().Entity 	-- 获取玩家正在查看的实体.
				
				if ( target:IsPlayer() ) then -- 如果实体是玩家:
				
					if ( target:GetNWBool( "antitheftEq" ) == false ) then
					
						self:roi_interact(0, 0.05)
					
						if (tonumber(amount) > (math.floor(2.34*settings['payday_amount']))) then
						
							self:PrintMessage( HUD_PRINTTALK, ">> 你不能抢这么多.") -- 打印信息自我.
							
						else
							if target:money_enough(math.floor(tonumber(amount))) then -- If the TARGET player has enough money, continue.
								
								if (tonumber(amount) <= math.floor(0.67*settings['payday_amount'])) then -- Not much money, high probability.
									
									
									if (randomfactor < 1.00) then -- Success in theft
									
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> 你成功抢了 " .. target:Nick() .. " 的 " .. math.floor(tonumber(amount)) .. "$!") -- 打印信息聊天.
										
										self:fame_interact(1, 16)
										target:fame_interact(0, 2)
										
										for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
											ply:PrintMessage( HUD_PRINTTALK, ">> 有人被抢劫了!") -- Let them know.
										end
										
									elseif (randomfactor > 1.88) then -- Epic fail in theft, they know you tried to rob them.
									
										self:roi_interact(0, 0.02)
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " 发现了你的犯罪行为!")	-- 打印信息自我.
										target:PrintMessage( HUD_PRINTTALK, ">> 玩家 " .. self:Nick() .. " 试图抢劫你!")	-- Let them know.
									
										self:fame_interact(1, 6)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> 你没有办法抢劫 " .. target:Nick() .. ".") -- 打印信息自我.
										self:fame_interact(1, 1)
									end
							
								elseif (tonumber(amount) > math.floor(0.67*settings['payday_amount']) and tonumber(amount) <= math.floor(1.67*settings['payday_amount'])) then -- Medium money, medium probability.
									
									if (randomfactor < 0.84) then -- Success in theft
										
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> 你成功抢了 " .. target:Nick() .. " for " .. math.floor(tonumber(amount)) .. "$!") -- 打印信息聊天.
										
										self:fame_interact(1, 25)
										target:fame_interact(0, 6)
										
										for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
											ply:PrintMessage( HUD_PRINTTALK, ">> 有人被抢劫了!") -- Let them know.
										end
										
									elseif (randomfactor > 1.66) then -- Epic fail in theft, they know you tried to rob them
										
										self:roi_interact(0, 0.01)
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " 发现了你的犯罪行为!")	-- 打印信息自我.
										target:PrintMessage( HUD_PRINTTALK, ">> 玩家 " .. self:Nick() .. " 试图抢劫你!")	-- Let them know.
									
										self:fame_interact(1, 10)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> 你没有办法抢劫 " .. target:Nick() .. ".") -- 打印信息自我.
										self:fame_interact(1, 1)
									end
								
								else -- 大量的钱,低概率.
									
									if (randomfactor < 0.66) then -- Success in theft
										
										target:money_take(math.floor(tonumber(amount))-1)	-- Rob player (take their money).
										self:money_give(math.floor(tonumber(amount)))		-- Give money to self.
										self:PrintMessage( HUD_PRINTTALK, ">> 你成功抢了 " .. target:Nick() .. " 的 " .. math.floor(tonumber(amount)) .. "$!") -- 打印信息聊天.
										
										self:fame_interact(1, 39)
										target:fame_interact(0, 10)
										
										for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
											ply:PrintMessage( HUD_PRINTTALK, ">> 有人被抢劫了!") -- Let them know.
										end
										
									elseif (randomfactor > 1.44) then -- Epic fail in theft, they know you tried to rob them
									
										self:PrintMessage( HUD_PRINTTALK, ">> " .. target:Nick() .. " 发现了你的犯罪行为!")	-- 打印信息自我.
										target:PrintMessage( HUD_PRINTTALK, ">> Player " .. self:Nick() .. " tried to rob you!")	-- Let them know.
									
										self:fame_interact(1, 17)
									
									else -- You didn't manage to rob them.
										self:PrintMessage( HUD_PRINTTALK, ">> 你没有办法抢劫 " .. target:Nick() .. ".") -- 打印信息自我.
										self:fame_interact(1, 1)
									end
								
								end						
								
							else
								self:PrintMessage( HUD_PRINTTALK, ">> 有些事情会让你远离犯下这种罪行." ) -- If the player does not have enough money print it to chat.
							end
							
						end
					
					else
						self:PrintMessage( HUD_PRINTTALK, ">> 它们受到防盗模块的保护." ) -- If the player is not aiming at player 打印聊天.
					end
					
				else
					self:PrintMessage( HUD_PRINTTALK, ">> 请瞄准一名玩家." ) -- If the player is not aiming at player 打印聊天.
				end
			
			else -- If robbing is not allowed, 打印聊天.
			
				self:PrintMessage( HUD_PRINTTALK, ">> 现在不可能进行抢劫." )
				
			end
		
		else
			self:PrintMessage( HUD_PRINTTALK, ">> 由于银行帐户被冻结，行动被取消." )
		end
		
	end
	
-- Creating the console command for func plyMug_Pos
function plyMug_CC( client, command, arguments )
		client:plyMug_Pos(arguments[1])
	end
concommand.Add("money_steal", plyMug_CC, nil, "用于从准星位置的玩家那里偷取一定数量的金额。参数: <amount>") -- Name of command, func callback, nil, help info.


	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Threat player @ CrosshairPos (In-Game). 	 勒索玩家拿出钱--
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyThreat_Pos()
		
		if (GetConVar("spc_threatening"):GetBool() == true) then -- 如果允许抢劫，继续.
			
			local randomfactor = math.random()*2.0 		-- 生成成功因子的伪随机数.
			local target = self:GetEyeTrace().Entity 	-- 获取玩家正在查看的实体.
			
			if ( target:IsPlayer() ) then -- 如果实体是玩家:
			
				self:roi_interact(0, 0.05)
				target:roi_interact(0, 0.03)
				
				local money = (math.floor(settings['payday_amount']/10.1 + randomfactor*10.1))
			
				sound.Play( "physics/glass/glass_sheet_break3.wav", target:GetPos() )
			
				if (randomfactor < 0.66) then -- 成功盗窃.
				
					target:money_take_absolute(money) -- Rob玩家（拿走他们的钱）.
					self:money_give(money) -- 给自己钱.
					self:PrintMessage( HUD_PRINTTALK, ">> 你勒索 " .. target:Nick() .. "交出钱来!") -- 打印信息聊天.
					target:PrintMessage( HUD_PRINTTALK, ">> 你受到了 " .. self:Nick() .. "的勒索!")
					
					self:fame_interact(1, 20)
					target:fame_interact(0, 8)
					
					if (randomfactor < 0.33) then
						target:ConCommand( "weapon_drop" )
					end
					
					target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
					
					timer.Simple( 2.5, function() 
							if (target:Alive() == true) then
								target:ConCommand( "weapon_drop" )
								target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
							end
						end)
					
				elseif (randomfactor > 1.55) then -- 部分成功.
				
					self:PrintMessage( HUD_PRINTTALK, ">> 你勒索 " .. target:Nick() .. "交出钱来!") -- 打印信息聊天.
					target:PrintMessage( HUD_PRINTTALK, ">> 你受到了 " .. self:Nick() .. "的勒索!")
					
					self:fame_interact(1, 15)
					target:fame_interact(0, 6)
					
					if (randomfactor > 1.80) then
						target:SendLua( "RunConsoleCommand( \"act\", \"zombie\" )" )
					else
						target:ConCommand( "weapon_drop" )
						timer.Simple( 0.5, function() 
								if (target:Alive() == true) then
									target:ConCommand( "weapon_drop" )
								end
							end)
					end
				
				else -- 你没有设法抢劫他们.
				
					self:PrintMessage( HUD_PRINTTALK, ">> 你不能勒索 " .. target:Nick() .. "!") -- 将信息打印到自己.
					self:fame_interact(0, 1)
					target:fame_interact(1, 7)
					
				end
				
			else
				self:PrintMessage( HUD_PRINTTALK, ">> 请瞄准一名玩家" ) -- 如果玩家不瞄准玩家 打印聊天.
			end
			
		else -- 如果不允许抢劫, 打印聊天.
		
			self:PrintMessage( HUD_PRINTTALK, ">> 能冷静下来?" )
			
		end
	
	end
	
-- 为func plyMug_Pos创建控制台命令
function plyThreat_CC( client, command, arguments )
		client:plyThreat_Pos()
	end
concommand.Add("money_threaten", plyThreat_CC, nil, "用于勒索瞄准着的玩家. Args: <>") -- 命令名称，func回调，nil，帮助信息。


	-- -- -- -- -- -- -- -- -- -- -- -- --
	-- Weapon unbuy / drop (In-Game).   --
	-- -- -- -- -- -- -- -- -- -- -- -- --
	
	
	function player_data:plyWeaponAction( method )
	
		local currentWep = self:GetActiveWeapon()
		
		if !(currentWep and IsValid(currentWep)) then 
			return
		elseif (method == 0 and GetConVar( "spc_weapon_unbuying"):GetBool() == false) then
			self:PrintMessage( HUD_PRINTTALK , ">> 你不能卖武器." )
			return
		elseif (method == 0 and GetConVar( "money_freeze"):GetBool() == true) then
			self:PrintMessage( HUD_PRINTTALK, ">> 由于银行账户被冻结，交易被拒绝." )
			return
		elseif (method == 1 and (GetConVar( "spc_weapon_dropping"):GetBool() == false or GetConVar( "sbox_weapons" ):GetInt() == 0)) then
			self:PrintMessage( HUD_PRINTTALK , ">> 出于安全原因，您不能丢弃武器." )
			return
		end
		
		local retCost = 0

		if (table.HasValue(free_weapons, currentWep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == true) then
			self:fame_interact(0, 1)
			retCost = 1
		elseif (table.HasValue(true_weapons, currentWep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == false) then
			self:fame_interact(0, 1)
			retCost = 2
		else

			local wgt = 0
			local app = 0
			
			if (currentWep:GetWeight() != nil) then
				if (currentWep:GetWeight() > (spawncosts['weapon']*0.75)) then
					wgt = (spawncosts['weapon']*0.75)
				else
					wgt = currentWep:GetWeight()
				end
			else
				wgt = 0
			end
			
			if (string.match( currentWep:GetClass() , 'm9k_.-') != nil or string.match( currentWep:GetClass() , 'gdcw_.-') != nil) then
				app = spawncosts['m9k_gdcw_app']
			elseif (string.match( currentWep:GetClass() , 'fas_.-') != nil or string.match( currentWep:GetClass() , 'fas2_.-') != nil or string.match( currentWep:GetClass() , 'fas20_.-') != nil) then
				app = spawncosts['fas2_app']
			elseif (string.match( currentWep:GetClass() , 'cw20_.-') != nil or string.match( currentWep:GetClass() , 'cw2_.-') != nil or string.match( currentWep:GetClass() , 'cw_.-') != nil) then
				app = spawncosts['cw20_app']
			elseif (string.match( currentWep:GetClass() , 'q3_.-') != nil or string.match( currentWep:GetClass() , 'q3a_.-') != nil) then
				app = spawncosts['q3_app']
			elseif (string.match( currentWep:GetClass() , 'cs_.-') != nil or string.match( currentWep:GetClass() , 'ttt_.-') != nil or string.match( currentWep:GetClass() , 'rp_.-') != nil or string.match( currentWep:GetClass() , 'dod_.-') != nil or string.match( currentWep:GetClass() , 'ww2_.-') != nil) then
				app = spawncosts['cs_ttt_rp_dod_app']
			elseif (string.match( currentWep:GetClass() , 'eq_.-') != nil or string.match( currentWep:GetClass() , 'gmod_.-') != nil or string.match( currentWep:GetClass() , 'stranded_.-') != nil) then
				app = spawncosts['eq_gmod_stranded_app']
			else
				app = 0
			end
			
			retCost = (spawncosts['weapon']+wgt+app-6)
			self:roi_interact(1, 0.08)
			self:fame_interact(1, 2)
			
		end
		
		if ( method == 0 ) then -- 方法0是卖武器。
		
			self:money_give(math.floor(retCost*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))
			self:StripWeapon(currentWep:GetClass())
			
		else -- 方法1（或不是0）是掉落武器。

			self:money_give(math.floor(1.23*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))
			
			local newWeapon = ents.Create(currentWep:GetClass())
		 
			newWeapon:SetClip1(currentWep:Clip1())
			newWeapon:SetClip2(currentWep:Clip2())

			self:StripWeapon(currentWep:GetClass())

			newWeapon:SetPos(self:GetShootPos() + (self:GetAimVector() * 80) + Vector(0,0,1))

			newWeapon:Spawn()
			
			newWeapon:SetVelocity((self:GetAimVector() * 150) + ((Vector(0,0,1):Cross(self:GetAimVector())):GetNormalized() * (math.random(0, 80))))
			
		end
		
	end
	
-- 为funcs plyWeaponAction创建控制台命令

function plyWeaponUnbuy_CC( client, command, arguments )
		client:plyWeaponAction( 0 )
	end
concommand.Add("weapon_sell", plyWeaponUnbuy_CC, nil, "用于出售目前持有的武器. Args: <>") -- Name of command, func callback, nil, help info.

function plyWeaponDrop_CC( client, command, arguments )
		client:plyWeaponAction( 1 )
	end
concommand.Add("weapon_drop", plyWeaponDrop_CC, nil, "用于丢弃目前持有的武器. Args: <>") -- Name of command, func callback, nil, help info.


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	聊天命令
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	function SMSChatCommands(ply, text)

		text = string.lower(text) -- 将消息发送为小写，因此命令不区分大小写.
		text = string.Explode(" ", text) -- 将字符串分解为每个空间的表格.
										 -- 我们这样做，所以我们可以得到论点.

		if (text[1] == "!givemoney" or text[1] == "/givemoney") then 
			ply:plyGiveMoney_Pos(tonumber(text[2]))
			return "Transaction: Sent."	-- 不要显示有人转移了多少钱.
		--elseif (text[1] == "!rob" or text[1] == "/rob") then
		--	ply:plyMug_Pos(tonumber(text[2]))
		--	return "" -- 不要在聊天中显示某人写的内容.
		--elseif (text[1] == "!mug" or text[1] == "/mug") then
		--	ply:plyMug_Pos(tonumber(math.floor(math.random(math.ceil(settings['payday_amount']/10),math.floor(settings['payday_amount']*1.9)))))
		--	return "" -- 不要在聊天中显示某人写的内容.	
		--elseif (text[1] == "!threaten" or text[1] == "/threaten") then
		--	ply:plyThreat_Pos()
		--	return "举起双手! 就现在!"
		elseif (text[1] == "!check" or text[1] == "/check") then
			ply:ConCommand( "money_check" )
			return ""
		--elseif (text[1] == "!sellweapon" or text[1] == "/sellweapon") then
		--	ply:plyWeaponAction( 0 )
		--	return ""
		elseif (text[1] == "!dropweapon" or text[1] == "/dropweapon") then
			ply:plyWeaponAction( 1 )
			return "Hurgh!"
		end
	end
		
	hook.Add("PlayerSay", "SMSChatCommands", SMSChatCommands) 
	-- 挂钩到PlayerSay，这样每次玩家发出聊天消息时都会调用该功能。 Clientside钩子将在OnPlayerChat上.


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	ADMIN COMMANDS. Remember, that concommands should do nothing if supplied with invalid amount of arguments or invalid variables.
		管理员命令。 请记住，如果提供了无效数量的参数或无效变量，则concommands应该不执行任何操作
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


	-- -- -- -- -- -- -- -- -- -- --
	-- Money Commands (In-Game). 钱命令  --
	-- -- -- -- -- -- -- -- -- -- --

	
	-- 给玩家带来金钱
	
	function player_data:adminInteractMoney_ID( method, playerid , amount )

		if (amount == nil or playerid == nil or tonumber(playerid) < 0 or playerid == error or tonumber(amount) <= 0) then
			if (method == 0) then
				self:ConCommand("help money_take_admin")
			else
				self:ConCommand("help money_give_admin")
			end
			return
		end
			
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- 检查用户是否为admin或更高版本
			if (GetConVar( "money_freeze" ):GetBool() != true) then
				if ( player.GetByID( tonumber(playerid) ) != nil ) then
					if (method == 0) then
						player.GetByID( tonumber(playerid) ):money_take_absolute(math.floor(tonumber(amount))) -- 通过playerid索引给玩家钱.
						player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK , ">> 你没了 " .. math.floor(tonumber(amount)) .. "$!")
						player.GetByID( tonumber(playerid) ):roi_interact(0, 0.09)
					else
						player.GetByID( tonumber(playerid) ):money_give( math.floor(tonumber(amount)) ) -- 通过playerid索引给玩家钱.
						player.GetByID( tonumber(playerid) ):PrintMessage( HUD_PRINTTALK, ">> 你赚取了 " .. math.floor(tonumber(amount)) .. "$!")
						player.GetByID( tonumber(playerid) ):roi_interact(1, (0.23+(math.ceil((((tonumber(amount))/(settings['payday_amount']))*0.005)*100)*0.01)))
					end
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " 找不到该玩家!" )
				end
			else
					self:PrintMessage( HUD_PRINTCONSOLE, " 由于银行账户被冻结，交易被拒绝." )
			end
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " 您不能使用此命令!" )
		end
			
	end

	function adminGiveMoney_CC( client, command, arguments ) -- 添加控制台命令.
		client:adminInteractMoney_ID(1, arguments[1], arguments[2])
	end
	concommand.Add("money_give_admin", adminGiveMoney_CC , nil, "Admin-only命令用于向具有给定ID的玩家提供资金. Args: <id,amount>")

	function adminTakeMoney_CC( client, command, arguments ) -- 添加控制台命令.
		client:adminInteractMoney_ID(0, arguments[1], arguments[2])
	end
	concommand.Add("money_take_admin", adminTakeMoney_CC, nil, "Admin-only命令用于从具有给定ID的玩家那里获取资金. Args: <id,amount>")


	-- 检查钱，在你做任何事之前
	function player_data:adminCheckMoney_ID( playerid )

			if (playerid == nil or tonumber(playerid) < 0 or playerid == error) then
				self:ConCommand("help money_check_admin")
				return
			end

			if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- 检查用户是否为admin或更高版本
				if ( player.GetByID( tonumber(playerid) ) != nil ) then
					self:PrintMessage( HUD_PRINTCONSOLE, " 玩家: [" .. player.GetByID(tonumber(playerid)):Nick() .. "] 银行账户余额是: " .. (tonumber(player.GetByID(tonumber(playerid)):GetNWInt( "money" ))) .. "$.\n")
				else
					self:PrintMessage( HUD_PRINTCONSOLE, " 找不到该玩家!" )
				end
			else
				self:PrintMessage( HUD_PRINTCONSOLE , " 您不能使用此命令!" )
			end
		end

	function adminCheckMoney_CC1( client, command, arguments ) -- 添加控制台命令.
		client:adminCheckMoney_ID(arguments[1])
	end
	concommand.Add("money_check_admin", adminCheckMoney_CC1, nil, "Admin-only命令用于检查具有给定ID银行账户余额的玩家. Args: <id>")

	
	-- -- -- -- -- -- -- -- -- -- -- --
	-- For-All Commands (In-Game).	 --
	-- -- -- -- -- -- -- -- -- -- -- --
	
	
	-- 检查所有已连接的球员钱
	function player_data:adminCheckMoney_All()

		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher

			local moneyAvg = 0
			local fameAvg = 0
			
			for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家。
				moneyAvg = moneyAvg + ply:GetNWInt( "money" )
				fameAvg = fameAvg + ply:GetNWInt( "bountyFame" )
			end	
				
			moneyAvg = (math.ceil((1.5+GetConVar("money_roi_maxoffset"):GetFloat())*(moneyAvg/(#player.GetAll()))))
			fameAvg = (math.ceil(4.5+fameAvg/(#player.GetAll())))
			
			local moneyStatus = ""
			local fameStatus = ""
			local roiStatus = ""
				
			for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
				
				if (ply:GetNWInt( "money" ) > moneyAvg) then
					moneyStatus = "(too much?) "
				elseif (ply:GetNWInt( "money" ) < settings['payday_amount']) then
					moneyStatus = "(not enough?) "
				else
					moneyStatus = ""
				end
				
				if (GetConVar( "money_bounty_system" ):GetBool() == true) then
					if (ply:GetNWInt( "bountyFame") > fameAvg) then
						fameStatus = "(可疑?)"
					elseif (ply:GetNWInt( "bountyFame") < 33) then
						fameStatus = "(新人?)"
					else
						fameStatus = ""
					end
				else
					fameStatus = ""
				end
				
				if (GetConVar( "money_roi" ):GetBool() == true) then
					roiStatus = "ROI: [ " .. ply:GetNWFloat( "moneyROI" ) .. "]% ; "
				else
					roiStatus = ""
				end
				
				-- SteamID (Unused in Money System): [" .. ply:SteamID() .. "];
				self:PrintMessage( HUD_PRINTCONSOLE, "连接ID: [" .. ply:EntIndex() .. "]; 玩家名: [" .. ply:Nick() .. "]; 余额: [" .. ply:GetNWInt( "money" ) .. "]$ " .. moneyStatus .. "; " .. roiStatus .. "名声: [" .. ply:GetNWInt("bountyFame") .. "] " .. fameStatus .. ".")
			end	
					
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
	end

	function adminCheckMoney_CC2( client, command, arguments ) -- 添加控制台命令.
		client:adminCheckMoney_All()
	end
	concommand.Add("money_checkall", adminCheckMoney_CC2, nil, "Admin-only command used to list out players' money system significant info. Args: <>")

	
	-- 重置所有玩家的钱开始
	function player_data:adminSetAccounts_All()
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
				ply:SetNWInt( "bountyFame", math.ceil(ply:GetNWInt( "bountyFame" )/2))
				ply:SetNWInt( "moneyROI", (math.ceil(ply:GetNWInt( "moneyROI" )/2*100))/100)
				ply:SetPData( "money", GetConVar("money_starting"):GetInt() )
				ply:SetNWInt( "money", GetConVar("money_starting"):GetInt() )
				ply:PrintMessage( HUD_PRINTTALK , ">> 银行帐户已重置为 " .. GetConVar("money_starting"):GetInt() .. "$!" )
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
	end

	function adminSetAccounts_CC( client, command, arguments ) -- 添加控制台命令.
		client:adminSetAccounts_All(arguments[1])
	end
	concommand.Add("money_setall", adminSetAccounts_CC, nil, "Admin-only command used to set all connected players money to Starting (Newcomers') Amount. Args: <>")

	
	-- RESET ALL TO DEFAULTS
	function player_data:adminResetToDefaults()

		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher

			GetConVar( "money_starting" ):SetInt( GetConVar( "money_starting" ):GetDefault())
			GetConVar( "money_paydays" ):SetInt( GetConVar( "money_paydays" ):GetDefault())
			GetConVar( "money_spawncosts" ):SetInt( GetConVar( "money_spawncosts" ):GetDefault())
			GetConVar( "money_oninsufficient_respawn" ):SetInt( GetConVar( "money_oninsufficient_respawn" ):GetDefault())
			GetConVar( "money_freeze" ):SetInt( GetConVar( "money_freeze" ):GetDefault())
			GetConVar( "money_bounty_system" ):SetInt( GetConVar( "money_bounty_system" ):GetDefault())
			GetConVar( "money_roi" ):SetInt( GetConVar( "money_roi" ):GetDefault())
			GetConVar( "money_roi_maxoffset" ):SetFloat( GetConVar( "money_roi_maxoffset" ):GetDefault())
			GetConVar( "money_defaultweaponsforfree" ):SetInt( GetConVar( "money_defaultweaponsforfree" ):GetDefault())
			GetConVar( "money_distinguish_teams" ):SetInt( GetConVar( "money_distinguish_teams" ):GetDefault())
			
			GetConVar( "money_onkillplayer_steal" ):SetInt( GetConVar( "money_onkillplayer_steal" ):GetDefault())
			GetConVar( "money_onkillplayer_steal_fraction" ):SetFloat( GetConVar( "money_onkillplayer_steal_fraction" ):GetDefault())
			
			GetConVar( "money_multiplier_penalty" ):SetFloat( GetConVar( "money_multiplier_penalty" ):GetDefault())
			GetConVar( "money_multiplier_award" ):SetFloat( GetConVar( "money_multiplier_award" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_npc" ):SetFloat( GetConVar( "money_multiplier_spawncost_npc" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_swep" ):SetFloat( GetConVar( "money_multiplier_spawncost_swep" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_vehicle" ):SetFloat( GetConVar( "money_multiplier_spawncost_vehicle" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_sent" ):SetFloat( GetConVar( "money_multiplier_spawncost_sent" ):GetDefault())
			GetConVar( "money_multiplier_spawncost_prop" ):SetFloat( GetConVar( "money_multiplier_spawncost_prop" ):GetDefault())
			
			GetConVar( "npc_killcounter" ):SetInt( GetConVar( "npc_killcounter" ):GetDefault())
			
			GetConVar( "spc_mugging" ):SetInt( GetConVar( "spc_mugging" ):GetDefault())
			GetConVar( "spc_threatening" ):SetInt( GetConVar( "spc_threatening" ):GetDefault())
			GetConVar( "spc_weapon_unbuying" ):SetInt( GetConVar( "spc_weapon_unbuying" ):GetDefault())
			GetConVar( "spc_weapon_dropping" ):SetInt( GetConVar( "spc_weapon_dropping" ):GetDefault())
			
			settings['payday_amount'] = 505
			settings['payday_time_interval'] = 240
			settings['bounty_time_interval'] = 360
			
			GetConVar( "money_payday_percentage_team0" ):SetInt( GetConVar( "money_payday_percentage_team0" ):GetDefault())
			GetConVar( "money_payday_percentage_team1" ):SetInt( GetConVar( "money_payday_percentage_team1" ):GetDefault())
			GetConVar( "money_payday_percentage_team2" ):SetInt( GetConVar( "money_payday_percentage_team2" ):GetDefault())
			GetConVar( "money_payday_percentage_team3" ):SetInt( GetConVar( "money_payday_percentage_team3" ):GetDefault())
			GetConVar( "money_payday_percentage_team4" ):SetInt( GetConVar( "money_payday_percentage_team4" ):GetDefault())
			GetConVar( "money_payday_percentage_team5" ):SetInt( GetConVar( "money_payday_percentage_team5" ):GetDefault())
			GetConVar( "money_payday_percentage_team6" ):SetInt( GetConVar( "money_payday_percentage_team6" ):GetDefault())
			GetConVar( "money_payday_percentage_team7" ):SetInt( GetConVar( "money_payday_percentage_team7" ):GetDefault())
			GetConVar( "money_payday_percentage_team8" ):SetInt( GetConVar( "money_payday_percentage_team8" ):GetDefault())
			GetConVar( "money_payday_percentage_team9" ):SetInt( GetConVar( "money_payday_percentage_team9" ):GetDefault())
			
			GetConVar( "money_awards_percentage_team0" ):SetInt( GetConVar( "money_awards_percentage_team0" ):GetDefault())
			GetConVar( "money_awards_percentage_team1" ):SetInt( GetConVar( "money_awards_percentage_team1" ):GetDefault())
			GetConVar( "money_awards_percentage_team2" ):SetInt( GetConVar( "money_awards_percentage_team2" ):GetDefault())
			GetConVar( "money_awards_percentage_team3" ):SetInt( GetConVar( "money_awards_percentage_team3" ):GetDefault())
			GetConVar( "money_awards_percentage_team4" ):SetInt( GetConVar( "money_awards_percentage_team4" ):GetDefault())
			GetConVar( "money_awards_percentage_team5" ):SetInt( GetConVar( "money_awards_percentage_team5" ):GetDefault())
			GetConVar( "money_awards_percentage_team6" ):SetInt( GetConVar( "money_awards_percentage_team6" ):GetDefault())
			GetConVar( "money_awards_percentage_team7" ):SetInt( GetConVar( "money_awards_percentage_team7" ):GetDefault())
			GetConVar( "money_awards_percentage_team8" ):SetInt( GetConVar( "money_awards_percentage_team8" ):GetDefault())
			GetConVar( "money_awards_percentage_team9" ):SetInt( GetConVar( "money_awards_percentage_team9" ):GetDefault())
			
			for key, ply in pairs(player.GetAll()) do -- 迭代服务器中的每个玩家.
				ply:PrintMessage( HUD_PRINTCONSOLE , "[货币] 已将设置重置为默认值." )
			end	
			
		else
			self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
		
	end

	function adminResetToDefaults_CC( client, command, arguments ) -- 添加控制台命令.
		client:adminResetToDefaults()
	end
	concommand.Add("money_defaults", adminResetToDefaults_CC, nil, "Admin-only command to reset ALL options to default values. Args: <>")
	
	
	-- -- -- -- -- -- -- -- -- -- --
	-- Payday Commands (In-Game). 发薪日命令--
	-- -- -- -- -- -- -- -- -- -- --

	
	--ADMIN PAYDAY AMOUNT
	function player_data:paydayAmount( amount )
	
		if (amount == nil or tonumber(amount) < 1) then
			self:ConCommand("help money_payday_amount")
		end
		
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher
			
			if (tonumber(amount) > 10) then
				settings['payday_amount'] = (math.ceil(tonumber(amount)))
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- 创造它.
				
			else -- 你不能设置发薪日不到 10$ in-game.
				settings['payday_amount'] = 10
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- 创造它.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
	end

	function paydayAmount_CC( client, command, arguments ) -- 添加控制台命令.
		client:paydayAmount(arguments[1])
	end
	concommand.Add("money_payday_amount",  paydayAmount_CC, nil, "Admin-only command used to change payday cash amount. 500 by default. Args: <amount>")


	--管理发薪日时间间隔
	function player_data:paydayTimeInterval ( amount )
	
		if (amount == nil or tonumber(amount) < 2) then
			self:ConCommand("help money_payday_time_interval")
			return
		end
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher.
			if (tonumber(amount) > 30) then
				settings['payday_time_interval'] = math.floor(tonumber(amount))
			
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- 创造它.
				
			else
				settings['payday_time_interval'] = 30 -- You cannot set the payday time interval less than half a minute in-game.
				
				timer.Create( "paydayTimer" , settings['payday_time_interval'] , 0 ,  doPayday ) -- 创造它.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
	end

	function paydayTimeInterval_CC( client, command, arguments ) -- 添加控制台命令.
		client:paydayTimeInterval(arguments[1])
	end
	concommand.Add("money_payday_time_interval",  paydayTimeInterval_CC, nil, "Admin-only command used to change payday time interval (in seconds). Not less than 30 secs. 240 by default. Args: <amount>")

	
	-- -- -- -- -- -- -- -- -- -- -- --
	-- Bounties Commands (In-Game). 赏金命令 --
	-- -- -- -- -- -- -- -- -- -- -- --
	
	
	--ADMIN BOUNTY TIME INTERVAL
	function player_data:bountyTimeInterval ( amount )
	
		if (amount == nil or tonumber(amount) < 2) then
			self:ConCommand("help money_payday_time_interval")
			return
		end
	
		if ( self:IsAdmin() or self:IsSuperAdmin() or self:IsUserGroup( "server owner" ) or self:IsUserGroup( "serverowner" ) or self:IsUserGroup( "owner" )  ) then -- Check if user is admin or higher.
			if (tonumber(amount) > 90) then
			
				settings['bounty_time_interval'] = math.floor(tonumber(amount))
			
				timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- 创造它.
				
			else
			
				settings['bounty_time_interval'] = 90 -- You cannot set the payday time interval less than half a minute in-game.
				
				timer.Create( "bountyTimer" , settings['bounty_time_interval'] , 0 ,  doBounty ) -- 创造它.
				
			end
		else
				self:PrintMessage( HUD_PRINTCONSOLE , " 你是不允许使用这个命令!" )
		end
	end

	function bountyTimeInterval_CC( client, command, arguments ) -- 添加控制台命令.
		client:bountyTimeInterval(arguments[1])
	end
	concommand.Add("money_bounty_time_interval",  bountyTimeInterval_CC, nil, "Admin-only command used to change bounty time interval (in seconds). Not less than 90 secs. 404 by default. Args: <amount>")


	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	KILLS AND DEATHS
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

	-- 钱杀死
	function addMoneyOnKillPlayer(victim, inflictor, killer) -- Function start:
	
		local money = 0
		local victimRoi = ((victim:GetNWFloat( "moneyROI" ))/10)
		
		if (victim == killer) then -- Check if victim and killer is the same person:
			
			victim:money_take_absolute(math.floor((settings['penalty_deathby_self']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))-victimRoi))
			victim:roi_interact(0, 0.29)
			victim:fame_interact(0, 7)
		
		elseif (killer:IsPlayer() and (victim != killer)) then -- Check if killer is player and is not the same player as victim:

			if (GetConVar("money_onkillplayer_steal"):GetBool() == true) then
			
				money = (math.floor(((tonumber(victim:GetNWInt( "money" ))*(math.abs(GetConVar("money_onkillplayer_steal_fraction"):GetFloat()))*(math.abs(GetConVar("money_multiplier_award"):GetFloat()))))+((killer:GetNWFloat( "moneyROI" ))/11)))
			
				if (victim:GetNWInt( "antitheftEq" ) == true) then
					money = math.ceil(money/4)+1
				end
			
				killer:money_give(money) -- Award the killer
				killer:roi_interact(1, 0.06)
				killer:fame_interact(1, 6)
				
				if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
					killer:PrintMessage( HUD_PRINTTALK, ">> 你杀掉了 " .. victim:Nick() .. " 得到了 " .. money .. "$") -- Tell them what happened.
				end
				
				money = math.floor((money*0.98)-victimRoi)
				
				victim:money_take_absolute(money) -- Rob the victim
				victim:roi_interact(0, 0.05)
				victim:fame_interact(0, 3)
				
				if (victim:GetInfoNum( "money_notifications", 1 ) == 1) then
					if (victim:GetNWInt( "antitheftEq" ) == true) then
						victim:PrintMessage( HUD_PRINTTALK, ">> With [Anti-Theft Module] you lost " .. money .. "$.") -- Tell them what happened.
					else
							victim:PrintMessage( HUD_PRINTTALK, ">> 你没了 " .. money .. "$.") -- Tell them what happened.
					end
				end
			
			else
				
				local teamIndex = killer:Team()
				
				if (teamIndex != nil and GetConVar( "money_distinguish_teams" ):GetBool() != false) then
					if (tonumber(teamIndex) == 0) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team0"))/100))
					elseif (tonumber(teamIndex) == 1) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team1"))/100))
					elseif (tonumber(teamIndex) == 2) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team2"))/100))
					elseif (tonumber(teamIndex) == 3) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team3"))/100))
					elseif (tonumber(teamIndex) == 4) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team4"))/100))
					elseif (tonumber(teamIndex) == 5) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team5"))/100))
					elseif (tonumber(teamIndex) == 6) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team6"))/100))
					elseif (tonumber(teamIndex) == 7) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team7"))/100))
					elseif (tonumber(teamIndex) == 8) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team8"))/100))
					elseif (tonumber(teamIndex) == 9) then
						money = (math.floor(((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1)*math.abs(GetConVar("money_awards_percentage_team9"))/100))
					else
						money = (math.floor((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1))
					end
				else
					money = (math.floor((settings['award_on_killplayer']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+victim:Frags()-victim:Deaths()+1))
				end
					
					
				killer:money_give(money) -- Award the killer
				killer:roi_interact(1, 0.06)
				killer:fame_interact(1, 6)
				
				if (killer:GetInfoNum( "money_notifications", 1 ) == 1) then
					killer:PrintMessage( HUD_PRINTTALK, ">> 你杀掉了 " .. victim:Nick() .. " 得到了 " .. money .. "$") -- Tell them what happened.
				end
				
				money = (math.floor((settings['penalty_deathby_player']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))+killer:Deaths()-victimRoi))
			
				victim:money_take_absolute(money) -- Penalty for victim
				victim:roi_interact(0, 0.05)
				victim:fame_interact(0, 3)
				
				if (victim:GetInfoNum( "money_notifications", 1 ) == 1) then
					victim:PrintMessage( HUD_PRINTTALK, ">> 你没了 " .. money .. "$.") -- Tell them what happened.
				end
			
			end
		
		else -- If the source of player death is different, it is some sort of entity (world/sent/veh/npc/prop):
			
			if (killer:IsPlayer() == true) then
				victim:fame_interact(1, 2)
			end
			
			victim:money_take_absolute(math.floor((settings['penalty_deathby_entity']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))-victimRoi))
			victim:roi_interact(0, 0.04)
			victim:fame_interact(0, 4)
		
		end
		
		if (GetConVar("money_oninsufficient_respawn"):GetBool() == false and victim:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))) == false) then
			victim:PrintMessage( HUD_PRINTTALK, ">> 由于资金不足，你现在无法生成物品.")
		end
		
	end
	hook.Add("PlayerDeath", "addMoneyOnKillPlayer", addMoneyOnKillPlayer)
	
	
	-- MONEY AWARDED WHEN KILLED AN NPC杀死NPC时获得的奖金
	function addMoneyOnKillNPC( npc, attacker, inflictor) -- 奖励玩家杀死NPC的功能：
		
		if (attacker:IsPlayer() and IsValid( attacker )) then
		
			local randomFactor = (math.random()*3.0)
			local roi = attacker:GetNWFloat( "moneyROI" ) -- 获取球员的兴趣率.
			local mp = 1.0
			local teamIndex = attacker:Team()
				
				if (teamIndex != nil and GetConVar( "money_distinguish_teams" ):GetBool() != false) then
					if (tonumber(teamIndex) == 0) then
						mp = (math.abs(GetConVar("money_awards_percentage_team0"))/100)
					elseif (tonumber(teamIndex) == 1) then
						mp = (math.abs(GetConVar("money_awards_percentage_team1"))/100)
					elseif (tonumber(teamIndex) == 2) then
						mp = (math.abs(GetConVar("money_awards_percentage_team2"))/100)
					elseif (tonumber(teamIndex) == 3) then
						mp = (math.abs(GetConVar("money_awards_percentage_team3"))/100)
					elseif (tonumber(teamIndex) == 4) then
						mp = (math.abs(GetConVar("money_awards_percentage_team4"))/100)
					elseif (tonumber(teamIndex) == 5) then
						mp = (math.abs(GetConVar("money_awards_percentage_team5"))/100)
					elseif (tonumber(teamIndex) == 6) then
						mp = (math.abs(GetConVar("money_awards_percentage_team6"))/100)
					elseif (tonumber(teamIndex) == 7) then
						mp = (math.abs(GetConVar("money_awards_percentage_team7"))/100)
					elseif (tonumber(teamIndex) == 8) then
						mp = (math.abs(GetConVar("money_awards_percentage_team8"))/100)
					elseif (tonumber(teamIndex) == 9) then
						mp = (math.abs(GetConVar("money_awards_percentage_team9"))/100)
					else
						mp = 1.0
					end
				else
					mp = 1.0
				end
				
			if (	table.HasValue(npc_small, npc:GetClass())) then 	-- 处理“npc_small”组中列出的npcs。
				attacker:money_give(math.floor((settings['award_on_killnpc_small']*(math.abs(GetConVar("money_multiplier_award"):GetFloat()))+(roi/11))*mp))
				attacker:roi_interact(1, 0.07)
				attacker:fame_interact(1, 5)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> 你赚了一些钱.")
				end
				
			elseif (table.HasValue(npc_big, npc:GetClass())) then 		-- Handle npcs listed in "npc_big" group.
				attacker:money_give(math.floor(((settings['award_on_killnpc_big']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/9))*mp))
				attacker:roi_interact(1, 0.75)
				attacker:fame_interact(1, 23)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> 你赚了一些适当的钱." )
				end
				
			elseif (table.HasValue(npc_ultrabig, npc:GetClass())) then 	-- Handle npcs listed in "npc_big" group.
				attacker:money_give(math.floor(((settings['award_on_killnpc_ultrabig']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/8))*mp))
				attacker:roi_interact(1, 5.0)
				attacker:fame_interact(1, 75)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> 你赚了一些坏钱!")
				end
				
			elseif (table.HasValue(npc_friendly, npc:GetClass())) then 	-- Handle npcs listed in "npc_friendly" group.
				attacker:money_give(math.floor((settings['award_on_killnpc_friendly']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))*mp))
				attacker:roi_interact(0, 0.16)
				attacker:fame_interact(1, 3)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> 你赚了一些血钱.")
				end
				
			else														-- Handle unlisted npcs.
				attacker:money_give(math.floor(((settings['award_on_killnpc_else']*(math.abs(GetConVar("money_multiplier_award"):GetFloat())))+randomFactor+(roi/10))*mp))
				attacker:roi_interact(1, 0.40)
				attacker:fame_interact(1, 11)
				
				if (attacker:GetInfoNum( "money_notifications", 1 ) == 1) then
					attacker:PrintMessage( HUD_PRINTTALK, ">> 你赚了一些钱.")
				end
				
			end
			
			-- NPC KILLCOUNTER
			if (GetConVar("npc_killcounter"):GetBool() == true) then	-- If npc killcounter is enabled, then add frags on npc killed.
				attacker:AddFrags(1)
			else 
				return
			end
		end
	end
	hook.Add("OnNPCKilled", "addMoneyOnKillNPC", addMoneyOnKillNPC)

			
	-- MONEY LOST ON RESPAWN
		function loseMoneyOnRespawn( ply )
			ply:money_take(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))))  -- Take money from respawning player
			ply:PrintMessage( HUD_PRINTCONSOLE , " 你没了 " .. math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))) .. "$ 重生.") -- Log it in simple form in console
		end
		hook.Add("PlayerSpawn", "loseMoneyOnRespawn", loseMoneyOnRespawn) -- Add hook
	
	
	
--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	PLAYER RESPAWN TOGGLER; enabler or disabler of playerspawns when their bank account has less money than the cost of respawn. See concommand below in ADMIN MISC COMMANDS.
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	function togglePlayerSpawn( ply )
		if (GetConVar("money_oninsufficient_respawn"):GetBool() == true or ply:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat()))+0.1)) == true) then
			return -- YOU HAVE TO RETURN NULL, returning true will result in ALWAYS true.
		elseif (GetConVar("money_oninsufficient_respawn"):GetBool() == false and ply:money_enough(math.floor(settings['penalty_respawn']*(math.abs(GetConVar("money_multiplier_penalty"):GetFloat())))) == false) then
			return false
		end
	end
	hook.Add("PlayerDeathThink", "togglePlayerSpawn", togglePlayerSpawn)
	


--[[ -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	SPAWNING PENALTIES
]]-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	
	function toggleSpawncosts()
		
		if (GetConVar("money_spawncosts"):GetBool() == true) then -- If func takes true, add hooks (hook up script functions to game events)

			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnEffect", "effect_cost", function ( ply, model ) -- Effect cost
				if (ply:money_take(spawncosts['effect']) and GetConVar("sbox_maxeffects"):GetInt() != 0) then
					ply:roi_interact(1, 0.01)
					return true
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> 你没有足够的钱购买." )
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnRagdoll", "ragdoll_cost", function( ply, model ) -- Ragdoll cost
				if (ply:money_take(spawncosts['ragdoll']) and GetConVar("sbox_maxragdolls"):GetInt() != 0)  then
					ply:roi_interact(1, 0.02)
					ply:fame_interact(1, 1)
					return true
				else
					ply:PrintMessage( HUD_PRINTTALK, ">> 你没有足够的钱购买." )
					return false
				end
			end )
				
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add ("PlayerCanPickupWeapon", "swep_pickup_cost", function ( ply, wep )
				if (GetConVar( "sbox_weapons" ):GetInt() != 0 or ply:Alive() != false) then -- I know it's pedantic and not really necessary, but it makes it work /more/.
					if (ply:GetInfoNum( "money_weaponpickup", 1 ) == 1) then -- Retrieve clientsided variable value and check if it is 1 (true).
						if (table.HasValue(free_weapons, wep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == true) then
							return true
						elseif (table.HasValue(true_weapons, wep:GetClass()) and GetConVar("money_defaultweaponsforfree"):GetBool() == false) then
							ply:fame_interact(0, 1)
							return true
						else
							local wgt = 0
							local app = 0
							
							if (wep:GetWeight() != nil) then
								if (wep:GetWeight() > (spawncosts['weapon']*0.75)) then
									wgt = (spawncosts['weapon']*0.75)
								else
									wgt = wep:GetWeight()
								end
							else
								wgt = 0
							end
							
							if (string.match( wep:GetClass() , 'm9k_.-') != nil or string.match( wep:GetClass() , 'gdcw_.-') != nil) then
								app = spawncosts['m9k_gdcw_app']
							elseif (string.match( wep:GetClass() , 'fas_.-') != nil or string.match( wep:GetClass() , 'fas2_.-') != nil or string.match( wep:GetClass() , 'fas20_.-') != nil) then
								app = spawncosts['fas2_app']
							elseif (string.match( wep:GetClass() , 'cw20_.-') != nil or string.match( wep:GetClass() , 'cw2_.-') != nil or string.match( wep:GetClass() , 'cw_.-') != nil) then
								app = spawncosts['cw20_app']
							elseif (string.match( wep:GetClass() , 'q3_.-') != nil or string.match( wep:GetClass() , 'q3a_.-') != nil) then
								app = spawncosts['q3_app']
							elseif (string.match( wep:GetClass() , 'cs_.-') != nil or string.match( wep:GetClass() , 'ttt_.-') != nil or string.match( wep:GetClass() , 'rp_.-') != nil or string.match( wep:GetClass() , 'dod_.-') != nil or string.match( wep:GetClass() , 'ww2_.-') != nil) then
								app = spawncosts['cs_ttt_rp_dod_app']
							elseif (string.match( wep:GetClass() , 'eq_.-') != nil or string.match( wep:GetClass() , 'gmod_.-') != nil or string.match( wep:GetClass() , 'stranded_.-') != nil) then
								app = spawncosts['eq_gmod_stranded_app']
							else
								app = 0
							end
							
							if (ply:money_take(math.floor((spawncosts['weapon']+wgt+app)*(math.abs(GetConVar("money_multiplier_spawncost_swep"):GetFloat()))))) then
								ply:roi_interact(0, 0.15)
								ply:fame_interact(1, tonumber(math.floor(3+(app/3))))
								return true
							else
								if (timer.Exists( "wepPickupCheckFalse1" )) then
									return false
								else
									timer.Create( "wepPickupCheckFalse1", 1, 1, function()
										ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to get this weapon." )
									end)
								end
								return false
							end
						end
					else
						if (timer.Exists( "wepPickupCheckFalse2" )) then
							return false
						else
							timer.Create( "wepPickupCheckFalse2", 1, 1, function()
								ply:PrintMessage( HUD_PRINTTALK, ">> You manually disabled weapon pickup." )
							end)
						end
						return false
					end
				else
					return false
				end
			end)
		
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnNPC", "npc_costs", function( ply, npc_type, weapon ) -- Npc costs
				if (GetConVar( "sbox_maxnpcs"):GetInt() != 0) then
					if (	table.HasValue(npc_small, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_small']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.07)
							ply:fame_interact(0, 1)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to summon that." )
							return false
						end
					elseif 	(table.HasValue(npc_ultrabig, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_ultrabig']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 2.25)
							ply:fame_interact(1, 9)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to unleash that much power." )
							return false
						end			
					elseif 	(table.HasValue(npc_big, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_big']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.67)
							ply:fame_interact(1, 3)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy that." )
							return false
						end
					elseif (table.HasValue(npc_friendly, npc_type)) then
						if (ply:money_take(math.floor(spawncosts['npc_friendly']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(1, 0.09)
							ply:fame_interact(1, 1)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to hire them." )
							return false
						end
					else	-- Everything else
						if (ply:money_take(math.floor(spawncosts['npc_else']*(math.abs(GetConVar("money_multiplier_spawncost_npc"):GetFloat())))) == true) then -- Execute spawncost penalty
							ply:roi_interact(0, 0.33)
							ply:fame_interact(1, 2)
							return true
						else
							ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to summon that." )
							return false
						end
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnVehicle", "vehicle_cost", function( ply, model, name, info) -- Vehicle cost
				if (GetConVar( "sbox_maxvehicles"):GetInt() != 0) then
					if (GetConVar( "money_freeze" ):GetBool() != true) then	
						if (table.HasValue(info, "prop_vehicle_prisoner_pod") or table.HasValue(info, "prop_vehicle_seat")) then -- Seat/chair/pod cost
							if ply:money_take(math.floor(spawncosts['vehicle_seat']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(1, 0.05)
								ply:fame_interact(1, 2)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a seat." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_airboat")) then -- Airboat base cost
							if ply:money_take(math.floor(spawncosts['vehicle_airboat']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.03)
								ply:fame_interact(1, 1)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this hovering vehicle." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_jeep_old")) then -- Jeep base (red, old) cost
							if ply:money_take(math.floor(spawncosts['vehicle_jeep_old']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.04)
								ply:fame_interact(1, 3)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						elseif (table.HasValue(info, "prop_vehicle_apc") or table.HasValue(info, "prop_vehicle_zapc")) then
							if ply:money_take(math.floor(spawncosts['vehicle_hl2apc']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.25)
								ply:fame_interact(1, 10)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy an APC." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_abrams") or table.HasValue(info, "sent_tank") or table.HasValue(info, "sent_abrams")) then -- SCars 2.0 tank and tank handlers costs.
							if ply:money_take(math.floor(spawncosts['vehicle_tank']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.25)
								ply:fame_interact(1, 8)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a tank." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_delorean")) then -- SCars 2.0 DeLorean DMC-12 cost.
							if ply:money_take(math.floor(spawncosts['vehicle_delorean']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.05)
								ply:fame_interact(1, 2)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy a DeLorean." )
								return false
							end
						elseif (table.HasValue(info, "sent_sakarias_car_toyotagtone")) then -- SCars 2.0 Toyota GT One cost.
							if ply:money_take(math.floor(spawncosts['vehicle_gtone']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(0, 0.05)
								ply:fame_interact(1, 1)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy Toyota GT One." )
								return false
							end
						-- SCars 2.0 Junk cars
						elseif (table.HasValue(info, "sent_sakarias_car_junker1") or table.HasValue(info, "sent_sakarias_car_junker2") or table.HasValue(info, "sent_sakarias_car_junker3") or table.HasValue(info, "sent_sakarias_car_junker4") or table.HasValue(info, "sent_sakarias_car_junker5") or table.HasValue(info, "sent_vehicle_junker")) then
							if ply:money_take(math.floor(spawncosts['vehicle_junk']*((math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat()))))) then
								ply:roi_interact(1, 0.03)
								ply:fame_interact(0, 4)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						else  -- Jalopy base (yellow muscle car) cost, and everything else (unhandled).
							if ply:money_take(math.floor(spawncosts['vehicle_jeep']*(math.abs(GetConVar("money_multiplier_spawncost_vehicle"):GetFloat())))) then
								ply:roi_interact(0, 0.04)
								ply:fame_interact(1, 4)
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, ">> You do not have enough to buy this vehicle." )
								return false
							end
						end
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> 由于银行账户被冻结，交易被拒绝." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnSENT", "sent_prespawn", function( ply, class ) -- SENT Cost.
				if (GetConVar( "sbox_maxsents" ):GetInt() != 0) then
					if (GetConVar( "money_freeze" ):GetBool() != true) then
				
						local money = 1.0
						local message = ""
						
						if (class == "sent_sakariasjet" or class == "sent_sakariasjet_rfl") then -- Sakarias88 AirVehicles Armed Jet 
							money = spawncosts['sent_jet']
							message = ">> You do not have enough to buy fully-armed military jet."
						elseif (class == "sent_sakariasjet_nonadmin" or class == "sent_sakariasjet_nonadmin_rfl") then -- Sakarias88 AirVehicles Unarmed Jet cost
							money = spawncosts['sent_jet_nonadmin']
							message = ">> You do not have enough to buy a military jet."
						elseif (class == "sent_helicopter" or class == "sent_sakariashelicopter" or class == "sent_blackhawk") then -- Sakarias88 AirVehicles Armed Heli cost
							money = spawncosts['sent_helicopter']
							message = ">> You do not have enough to buy a fully-equipped transport vehicle."
						elseif (class == "sent_helicopter_nonadmin" or class == "sent_sakariashelicopter_nonadmin") then -- Sakarias88 AirVehicles Unarmed Heli cost
							money = spawncosts['sent_helicopter_nonadmin']
							message = ">> You do not have enough to buy a heli."
						elseif (class == "sent_zar3" or class == "sent_emplacementgun" or class == "sent_emplacement" or class == "turret_bullets") then -- Emplacement gun cost
							money = spawncosts['sent_stat']
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "sent_zar4" or class == "turret_bullets2" or class == "turret_rail" or class == "turret_grenade") then -- Emplacements gun cost
							money = spawncosts['sent_stat']*1.21
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "item_healthcharger" or class == "sent_healthcharger") then -- Health charger cost
							money = (spawncosts['sent_stat']-GetConVar( "money_multiplier_spawncost_sent" ):GetFloat())
							message = ">> You do not have enough to buy a health charger."
						elseif (class == "item_suitcharger" or class == "sent_suitcharger") then -- Suit charger cost
							money = (spawncosts['sent_stat']-(2.1*GetConVar( "money_multiplier_spawncost_sent" ):GetFloat()))
							message = ">> You do not have enough to buy a suit charger."
						elseif (class == "prop_thumper" or class == "sent_thumper" or class == "sent_vj_fireplace" or class == "sent_sakarias_gaspump") then -- Thumper (HL2), fireplace (VJ Base) and Gas Pump (SCars 2.0) cost
							money = (spawncosts['sent_stat']-(4*GetConVar( "money_multiplier_spawncost_sent" ):GetFloat()))
							message = ">> You do not have enough to buy an emplacement."
						elseif (class == "zombies_mysterybox" or class == "zombie_mysterybox" or class == "cod_mysterybox" or class == "codwaw_mysterybox" or class == "zombies_weaponbox") then -- Mystery Box cost
							money = (spawncosts['sent_stat']*2.02)
							message = ">> You do not have enough to buy a Mystery Box."
						elseif (class == "sent_sakarias_gasstation") then -- SCars 2.0 gas station cost
							money = spawncosts['sent_gasstation']
							message = ">> You do not have enough to buy a gas station."
						elseif (class == "sent_combinemech" or class == "sent_zcombinemech" or class == "sent_mechatron") then -- Combine Mech cost
							money = spawncosts['sent_combinemech']
							message = ">> You do not have enough to buy a mech."
						elseif (class == "cw_ammo_crate_regular") then -- Customizable Weaponry 2.0 36x ammo crate cost
							money = spawncosts['cw_ammo_crate_regular']
							message = ">> You do not have enough to buy an ammo emplacement."
						elseif (class == "cw_ammo_crate_small") then -- Customizable Weaponry 2.0 24x ammo crate cost
							money = spawncosts['cw_ammo_crate_small']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "cw_ammo_kit_regular") then -- Customizable Weaponry 2.0 10x ammo crate cost
							money = spawncosts['cw_ammo_kit_regular']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "cw_ammo_kit_small") then -- Customizable Weaponry 2.0 6x ammo crate cost
							money = spawncosts['cw_ammo_kit_small']
							message = ">> You do not have enough to buy an ammo crate."
						elseif (class == "sent_tardis") then -- Tardis cost
							money = spawncosts['sent_tardis']
							message = ">> You do not have enough to buy TARDIS."
						elseif ((string.match( class , 'anom_.-') != nil) or (string.match( class , 'anomaly_.-') != nil)) then -- Customizable Weaponry 2.0 6x ammo crate cost
							money = spawncosts['anomaly']
							message = ">> You do not have enough to summon an anomaly."
						elseif (class == "sent_sms_antitheftmodule") then -- SMS Anti-Theft Module
							money = math.floor(spawncosts['sent_stat']*0.66)
							message = ">> You need more to be able to buy Anti-Theft Module."
						elseif (class == "sent_sms_moneyprinter") then -- SMS Anti-Theft Module
							money = math.ceil(spawncosts['sent_stat']*0.67)
							message = ">> You need more to be able to get a Money Printer."
						else
							money = 0
							message = ">> You need more to be able to spawn SENTs."
						end
						
						money = math.floor(money*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))/5.0))
						
						if (money <= 0) then
							if ply:money_enough(math.floor(200*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))/5.0))+1) then
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, message )
								return false
							end
						else
							if ply:money_take(money) then
								return true
							else
								ply:PrintMessage( HUD_PRINTTALK, message )
								return false
							end
						end
						
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> 由于银行账户被冻结，交易被拒绝." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add("PlayerSpawnedSENT", "sent_postspawn", function (ply, ent) -- SENT spawncost penalty executor

				local mass = 0
				local phys = ent:GetPhysicsObject() -- Get Physics Object from Entity
				
				local senthelper = { 
					"anom_beads", "anom_bubble", "anom_burner", "anom_circus", "anom_damage", "anom_divide", "anom_electro", "anom_static", "anom_well", 
					"cw_ammo_crate_regular", "cw_ammo_crate_small", "cw_ammo_kit_regular", "cw_ammo_kit_small", "item_healthcharger", "item_suitcharger", "prop_thumper", 
					"sent_abrams", "sent_sms_antitheftmodule", "sent_blackhawk", "sent_combinemech", "sent_emplacement", "sent_emplacementgun", "sent_healthcharger", 
					"sent_helicopter", "sent_helicopter_nonadmin", "sent_mechatron", "sent_sakarias_car_abrams", "sent_sakarias_car_delorean", "sent_sakarias_car_junker1", 
					"sent_sakarias_car_junker2", "sent_sakarias_car_junker3", "sent_sakarias_car_junker4", "sent_sakarias_car_junker5", "sent_sakarias_car_toyotagtone", 
					"sent_sakarias_gaspump", "sent_sakarias_gasstation", "sent_sakariashelicopter", "sent_sakariashelicopter_nonadmin", "sent_sakariasjet", 
					"sent_sakariasjet_nonadmin", "sent_sakariasjet_nonadmin_rfl", "sent_sakariasjet_rfl", "sent_suitcharger", "sent_tank", "sent_tardis", "sent_thumper", 
					"sent_vj_fireplace", "sent_zar3", "sent_zar4", "sent_zcombinemech", "turret_bullets", "turret_bullets2", "turret_grenade", "turret_rail",
					"sent_sms_moneyprinter"
				}
				
				ply:fame_interact(1, 5)
				
				if (table.HasValue(senthelper, ent:GetClass())) then -- If a name of an entity matches anything handled specifically, then do nothing.
					return
				else
					if phys:IsValid() then -- If physics models are valid:
						mass = math.ceil(tonumber(phys:GetMass())) -- Get mass.
						ply:money_take_absolute(math.floor(mass*((math.abs(GetConVar("money_multiplier_spawncost_sent"):GetFloat()))))) -- Execute.
					else
						return
					end
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnProp", "prop_prespawn", function( ply, model ) -- Prop spawncost CHECKER
				if (GetConVar( "sbox_maxprops"):GetInt() != 0) then
					if ply:money_enough(math.floor((spawncosts['prop_under_3200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat())))-1.1)) then
						ply:roi_interact(1, 0.01)
						ply:fame_interact(0, 2)
						return true
					else
						ply:PrintMessage( HUD_PRINTTALK, ">> You have to have more to be able to buy props." )
						return false
					end
				else
					return false
				end
			end )
			
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			hook.Add( "PlayerSpawnedProp", "prop_postspawn", function ( ply, model, ent ) -- Prop spawncost penalty executor
				
				local mass = 0
				local phys = ent:GetPhysicsObject()
				
				if phys:IsValid() then
				
					mass = math.ceil(tonumber(phys:GetMass())) -- Get mass and execute spawncost penalty based on mass factor
					
					if (mass < 5) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_5']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 10) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_10']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 20) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_20']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 40) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_40']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 60) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_60']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 80) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_80']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 100) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_100']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 150) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_150']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 300) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_300']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 600) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_600']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 800) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_800']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 1200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_1200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 1600) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_1600']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 2400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_2400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					elseif (mass < 3200) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_3200']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 4800) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_4800']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 6400) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_6400']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					elseif (mass < 9999) then
						ply:money_take_absolute(math.floor(spawncosts['prop_under_9999']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:roi_interact(1, 0.01)
					else
						ply:money_take_absolute(math.floor(spawncosts['prop_over_9999']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
						ply:fame_interact(0, 1)
						ply:roi_interact(1, 0.01)
					end
				else
					ply:money_take_absolute(math.floor(spawncosts['prop_under_5']*(math.abs(GetConVar("money_multiplier_spawncost_prop"):GetFloat()))))
					return
				end
				
			end )
			
		else
			
			hook.Remove( "PlayerSpawnEffect", "effect_cost")
			hook.Remove( "PlayerSpawnRagdoll", "ragdoll_cost")
			hook.Remove( "PlayerCanPickupWeapon", "swep_pickup_cost")
			
			hook.Remove( "PlayerSpawnNPC", "npc_costs")
			hook.Remove( "PlayerSpawnVehicle", "vehicle_cost")
			
			hook.Remove( "PlayerSpawnSENT", "sent_prespawn")
			hook.Remove( "PlayerSpawnedSENT", "sent_postspawn")

			hook.Remove( "PlayerSpawnProp", "prop_prespawn")
			hook.Remove( "PlayerSpawnedProp", "prop_postspawn")	
				
		end
		
	end
	
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- SPAWNCOSTS INITIALIZATION. Creates a timer to check everything over time.  --
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	
		timer.Create( "SMSSpawncostChecker" , 2 , 0 ,  toggleSpawncosts )
	
	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

end

-- END OF FILE --