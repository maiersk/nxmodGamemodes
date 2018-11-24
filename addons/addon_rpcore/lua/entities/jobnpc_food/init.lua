AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.foodTable = {}

function items.AddFoodTable(data)
	data.value = data.value or 0
	items.foodTable[data.name] = data
end

function items.RemoveFoodTable(name)
	items.foodTable[name] = nil
end

for key, name in pairs(file.Find("lua/entities/jobnpc_food/items/*.lua", "GAME")) do
	local path = "entities/jobnpc_food/items/"..name
	include(path)
	AddCSLuaFile(path)
end
------------------------------------------------------------------------------------------
include('shared.lua')

function ENT:Initialize()

	self:SetModel( foodNPCConfig.NpcModel )
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:CapabilitiesAdd(CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetBloodColor(BLOOD_COLOR_RED)

	self:SetMoveType( MOVETYPE_STEP )

	self:SetMaxYawSpeed(100)

end

function ENT:OnTakeDamage()
	return false
end


util.AddNetworkString( "Buttonflow" )
util.AddNetworkString( "food_NPCPANEL" )			--需每个npc不一样网络信息的名字

function ENT:AcceptInput( name, activator, caller )
	if name == "Use" and caller:IsPlayer() then

		self:EmitSound( foodNPCConfig.SoundWelcome, 50) 
	net.Start("food_NPCPANEL")					--需每个npc不一样网络信息的名字

	net.Send(caller)

  	end
end

concommand.Add("buyitmes_food", function(ply, command, arguments)
	if !arguments then return end
	data = data or {}
	local type = table.concat(arguments, " ")	--读取table值
	local data = items.food[type]
	if !data then return end
	PrintTable(data)
	if data.price then
		if !ply:CheckLimit( "props" ) then return end	--检查生成限制：不限制返回true，限制返回false
		if !data.isbox then 
			if !ply:money_take(data.cost) then return end	--不够钱/不能扣钱就不继续执行了
		elseif data.isbox then
			if !ply:money_take(data.price) then return end	--不够钱/不能扣钱就不继续执行了
		end
		local ent = ents.Create( data.class )
		local pos = ply:GetPos() + Vector( -30, 30, 10 )
		ent.is_food = true
		ent.data = data
		ent.data.owner = ply
		ent.data.ownerid = ply:UniqueID()
		ent:SetPos( pos )
		ent:SetModel(table.Random(data.models))
		ent:Spawn()
		NADMOD.PlayerMakePropOwner(ply, ent)			--props所以有人
		ply:AddCount( "props", ent )					--添加为是玩家所创建的
	end
end)
