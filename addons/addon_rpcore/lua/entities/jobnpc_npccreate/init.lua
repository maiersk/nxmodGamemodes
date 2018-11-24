AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.npcTable = {}

function items.AddNpcTable(data)
	data.value = data.value or 0
	items.npcTable[data.name] = data
end

function items.RemoveNpcTable(name)
	items.npcTable[name] = nil
end

for key, name in pairs(file.Find("lua/entities/jobnpc_npccreate/items/*.lua", "GAME")) do
	local path = "entities/jobnpc_npccreate/items/"..name
	include(path)
	AddCSLuaFile(path)
end
------------------------------------------------------------------------------------------
include('shared.lua')

function ENT:Initialize()

	self:SetModel( npccreateNPCConfig.NpcModel )
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

function StartFollowing(src,ply)	--跟随函数
		
		
	local function StopFollowing(src)
		if(!m_tbDisp) then return end
		if(!m_tbDisp[src]) then return end
		for ply,disp in pairs(m_tbDisp[src]) do
			if(ply:IsValid()) then
				hook.Remove("Think","npctool_follower" .. src:EntIndex() .. ply:EntIndex())
				src:AddEntityRelationship(ply,disp,100)
				m_tbDisp[src][ply] = nil
				if(!ply:IsPlayer()) then
					if(m_tbDisp[ply] && m_tbDisp[ply][src]) then
						ply:AddEntityRelationship(src,m_tbDisp[ply][src],100)
						m_tbDisp[ply][src] = nil
					else 
						ply:AddEntityRelationship(src,disp,100) 
					end
				end
			end
		end
	end
	
	
	StopFollowing(src)												--停止src的跟随（如果有的话）
	m_tbDisp = m_tbDisp || {}								--建立 self.m_tbDisp
		local hk = "npctool_follower" .. src:EntIndex() .. ply:EntIndex()	--字符串连接
	m_tbDisp[src] = m_tbDisp[src] || {}					--建立 m_tbDisp中key为src的对象（开辟空间）
	m_tbDisp[src][ply] = src:Disposition(ply)					--key src的对象也是表格 储存的ply对象为src对ply的情感
	if(ply:IsNPC()) then											--如果ply是npc
		m_tbDisp[ply] = m_tbDisp[ply] || {}				--建立 m_tbDisp的对象ply 
		m_tbDisp[ply][src] = ply:Disposition(src)				--ply同为表格 储存的src对象为ply对src的情感
		ply:AddEntityRelationship(src,D_LI,100)						--使ply非常喜欢src
	end
	if(ply:IsNPC() || ply:IsPlayer()) then src:AddEntityRelationship(ply,D_LI,100) end		--如果ply是npc或者是玩家 则让src非常喜欢ply
	if(src.bScripted) then src.fFollowDistance = 200; src:SetBehavior(1,ply); return end	--猜测：bScripted 是否是完全由lua控制的实体 如果是 设置跟随距离200 设置对ply的Behavior为1
	local nextUpdate = CurTime()
	local last
	hook.Add("Think",hk,function()												--hook 事件名称Think hook标识符hk THINK-HK方程如下
		if(!src:IsValid() || !ply:IsValid()) then hook.Remove("Think",hk)		--如果src ply任何一个不存在 则取消
		elseif(CurTime() >= nextUpdate) then
			nextUpdate = CurTime() +0.5											
			local posSrc = src:GetPos()											--获取位置
			local posply = ply:GetPos()											--获取位置
			if(!last || !src:IsCurrentSchedule(SCHED_FORCED_GO_RUN) || posply:Distance(last) > 200) then	--last不存在 或者 不在“强制跑向某一地点状态下” 或者 ply现在的位置到last距离大于200
				last = posply																				--last等于ply当前位置
				local d =posSrc:Distance(posply)															--OBBMaxs：物体模型最高点的位置
				local schd = SCHED_FORCED_GO_RUN															-- SCHED_FORCED_GO_RUN会让npc跑向last positon
				if(d > 200) then
					src:SetLastPosition(posply)
					src:SetSchedule(schd)
				elseif(src:IsCurrentSchedule(schd)) then src:ClearSchedule(); src:StopMoving() end			--如果有schedule 就取消掉schedule 停止移动
			end
		end
	end)
end

util.AddNetworkString( "Buttonflow" )
util.AddNetworkString( "npccreate_NPCPANEL" )			--需每个npc不一样网络信息的名字

function ENT:AcceptInput( name, activator, caller )
	if name == "Use" and caller:IsPlayer() then

		self:EmitSound( npccreateNPCConfig.SoundWelcome, 50) 
	net.Start("npccreate_NPCPANEL")					--需每个npc不一样网络信息的名字

	net.Send(caller)

  	end
end

concommand.Add("buyitmes_npcs", function(ply, command, arguments)

	local type = table.concat(arguments, " ")	--读取table值
	local data = items.npc[type]
	if data.price then
		if !ply:CheckLimit( "npcs" ) then return end	--检查生成限制：不限制返回true，限制返回false
		if !ply:money_take(data.price) then return end	--不够钱/不能扣钱就不继续执行了
		local npc = ents.Create( data.class )
		if data.Weapons then 
			for _, v in pairs(data.Weapons) do
				npc:Give(v)
			end
		end
		if data.KeyValues then
			for k, v in pairs( data.KeyValues ) do
				NPC:SetKeyValue( k, v )
			end
		end
		if data.SpawnFlags then
			npc:SetKeyValue("spawnflags", data.SpawnFlags)
		end
		if data.models then
			npc:SetModel(table.Random(data.models))
		end
		local pos = ply:GetPos() + Vector( -30, 30, 0 )
		npc:SetPos( pos )
		npc:SetNPCState(NPC_STATE_NONE)
		npc:Classify(CLASS_CITIZEN_PASSIVE)
		npc:Spawn()

		StartFollowing(npc,ply)
		
		npc:AddEntityRelationship(ply,D_LI,100)
		for _, ent in pairs( ents.GetAll() ) do
			if ent:GetClass() == "jobnpc_npccreate" then
				npc:AddEntityRelationship(ent,D_LI,100)
			--[[
			elseif ent:IsNPC() then
				for _, data in pairs(items.npc) do
					if ent:GetClass() == data.class then
						npc:AddEntityRelationship(ent,D_LI,100)
					end
				end
			--]]
			end
		end

		NADMOD.PlayerMakePropOwner(ply, npc)		--npc所有人
		ply:AddCount( "npcs", npc )					--添加为是玩家所创建的

		ply:GetCount( "npcs" )
	end
end)



