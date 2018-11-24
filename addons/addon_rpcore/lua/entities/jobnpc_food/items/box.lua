if SERVER then
util.AddNetworkString("localent")
end
--客户端精准定位需要使用固定功能的实体
if CLIENT then
    hook.Add("KeyPress", "cding:client", function( ply, key )
        local tr = LocalPlayer():GetEyeTraceNoCursor()    --得到眼前
        local ent = tr.Entity
        --print(ent)
        if IsValid( ent ) then
            if key == IN_RELOAD and ent:GetPos():Distance(ply:GetShootPos()) < 120 then
                net.Start( "localent" )
                    net.WriteFloat( ent:EntIndex() )
                net.SendToServer()
            end
        end
    end)
end

function CDing( ent )
    if ent then
        --print(ent)
        if ent.inbox and ent.Ding then      --如果是一开始就放入揽中自动固定则用这里取消固定,否则用下面
            --print("不可固定")
            ent.Ding = false
            ent:SetParent(nil)
            ent:SetColor(Color( 255, 255, 255, 0 ))
        else
            if ent.Ding then       --不可固定状态
                --print("不可固定")
                ent.Ding = false
                ent:SetParent(nil)
                ent:SetColor(Color( 255, 255, 255, 0 ))
            else                    --可以固定状态
                --print("可以固定")
                ent.Ding = true
                ent:SetColor(Color( 150, 150, 150, 1 ))
            end
        end
    end
end

hook.Add("KeyPress", "cding:shared", function( ply, key )
    if key == IN_RELOAD then
        net.Receive( "localent", function( len, ply ) 
            local entindex = net.ReadFloat()
            local ent = ents.GetByIndex( entindex )
            if ent:GetPos():Distance(ply:GetShootPos()) < 120 then
                for _, v in pairs( items.food ) do
                    if ent:GetClass() == v.class then
                        local owner = player.GetByUniqueID( ent.data.ownerid )
                        if owner == ply then                    --食物是自己的话可以固定/取消固定
                            --print("no")
                            if v.isbox then return end          --如果实体是货架类不能R
                            CDing( ent )
                        end
                    end
                end
            end
        end)
    end
end)

--服务端精准处理购买物品功能
if SERVER then
    hook.Add("KeyPress", "cding:server", function(ply, key)
        local tr = ply:GetEyeTraceNoCursor()    --得到眼前
        local ent = tr.Entity   --实体
        if IsValid(ent) then
            if key == IN_RELOAD and ent:GetPos():Distance(ply:GetShootPos()) < 120 then
                --print(ent)
                for _, v in pairs( items.food ) do
                    if ent:GetClass() == v.class then
                        local owner = player.GetByUniqueID( ent.data.ownerid )
                        if owner ~= ply then    --如果物品所有者不是自己则需要购买
                            if v.isbox then return end          --如果实体是货架类不能R
                            if !ply:money_take(v.price) then return end
                            ply:SendLua("notification.AddLegacy( \"花了" .. v.price .. "$购买下了,按E吃掉\", NOTIFY_GENERIC, 2.5 )")
                            owner:money_give(v.price)
                            owner:SendLua("notification.AddLegacy( \"收到了" .. v.price .. "$付款\", NOTIFY_GENERIC, 2.5 )")
                            ent.is_food = true
                            ent.data = data
                            ent.data.owner = ply
                            ent.data.ownerid = ply:UniqueID()
                            NADMOD.PlayerMakePropOwner(ply, ent)			--props所以有人
                            ply:AddCount( "props", ent )					--添加为是玩家所创建的
                            --print("yes")
                        end     
                    end
                end
            end
        end
    end)
end

--[[
if CLIENT then
    function NADMOD.FindPlayer(nick) 
		if not nick or nick == "" then return end 
		nick = string.lower(nick)
		local num = tonumber(nick)
		for _,v in pairs(player.GetAll()) do
			if string.lower(v:Nick()) == nick then return v -- 确切的名称匹配
			elseif v:UserID() == num then return v 			-- 用户标识相匹配 (从状态)
			end
		end
		-- 如果上述两个精确搜索失败,尝试进行局部搜索
		for _,v in pairs(player.GetAll()) do
			if string.find(string.lower(v:Nick()), nick) then return v end
		end
    end

    hook.Add("KeyPress", "cding:server", function(ply, key)
        local tr = LocalPlayer():GetEyeTraceNoCursor()    --得到眼前
        local ent = tr.Entity

        if IsValid(ent) then
            if key == IN_RELOAD and ent:GetPos():Distance(ply:GetShootPos()) < 120 then
                --print(ent)
                for _, v in pairs( items.food ) do
                    if ent:GetClass() == v.class then
                        local owner = NADMOD.FindPlayer(NADMOD.PropOwners[ent:EntIndex()])  --名字找到玩家
                        if owner == ply then                    --食物是自己的话可以固定/取消固定
                            --print("no")
                            if v.isbox then return end          --如果实体是货架类不能R
                            RunConsoleCommand( "items_food_CDing", ent:EntIndex() )
                        end
                    end
                end
            end
        end
    end)
end
--]]

items.AddFoodTable{
    name = "货箱",
    class = "food_mod_plasticcrate",
    price = 100,
    models = {"models/props_junk/PlasticCrate01a.mdl"},
    textinfo = "",
    isbox = true,
}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 

    function ENT:Initialize()
        self:SetModel("models/props_junk/PlasticCrate01a.mdl")
        --self:SetModelScale( self:GetModelScale() * 1.5, 0 )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

	end

	function ENT:Use(activator, caller)
        
    end

    function ENT:Touch(hitEnt)
        if not IsValid(hitEnt) then print(hitEnt) return end        --如果触碰物不是可见的，那么打印触碰物返回结束
        for _, v in pairs( items.food ) do
            if self:GetClass() != hitEnt:GetClass() then
                if hitEnt:GetClass() == v.class and !hitEnt.inbox and hitEnt.Ding then  --可到箱中改变属性
                    --print(hitEnt)
                    hitEnt:Cv( true, true )    --变为已固定状态
                    hitEnt:SetColor(Color( 150, 150, 150, 1 ))
                    hitEnt:SetParent(self)
                end
            end
        end
    end

end

if CLIENT then

    function ENT:Draw()
        self:DrawModel()
        
        local pos = self:GetPos()                           --将指定的位置和角度从指定的局部坐标系转换为世界空间坐标。
        local ang = self:GetAngles()                        --角度：取当前物品角度 + 显示角度——这样物品移动界面跟着移动
        --[[
        --设置按钮点
        local slot1Pos = self:GetPos() + self:GetUp() *-4 + self:GetRight() *6 + self:GetForward() *1
        --测量按钮用的点
        render.SetMaterial( Material( "sprites/glow04_noz" ) )
        --1.1
        render.DrawSprite( slot1Pos, 2, 2, Color( 255, 255, 255 ) )
        --]]
    end

end

scripted_ents.Register(ENT, "food_mod_plasticcrate", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "售卖柜",
    class = "food_mod_cooler",
    price = 100,
    models = {"models/props_c17/display_cooler01a.mdl"},
    textinfo = "",
    isbox = true,
}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 

    function ENT:Initialize()
        self:SetModel("models/props_c17/display_cooler01a.mdl")
        --self:SetModelScale( self:GetModelScale() * 1.5, 0 )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

	end

	function ENT:Use(activator, caller)
        
    end

    function ENT:Touch(hitEnt)
        if not IsValid(hitEnt) then print(hitEnt) return end        --如果触碰物不是可见的，那么打印触碰物返回结束
        for _, v in pairs( items.food ) do
            if self:GetClass() != hitEnt:GetClass() then
                if hitEnt:GetClass() == v.class and !hitEnt.inbox and hitEnt.Ding then  --可到箱中改变属性
                    --print(hitEnt)
                    hitEnt:Cv( true, true )    --变为已固定状态
                    hitEnt:SetColor(Color( 150, 150, 150, 1 ))
                    hitEnt:SetParent(self)
                end
            end
        end
    end

end

scripted_ents.Register(ENT, "food_mod_cooler", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "自定义货柜板",
    class = "food_mod_traincar",
    price = 100,
    models = {"models/props_trainstation/traincar_rack001.mdl"},
    textinfo = "",
    isbox = true,
}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 

    function ENT:Initialize()
        self:SetModel("models/props_trainstation/traincar_rack001.mdl")
        --self:SetModelScale( self:GetModelScale() * 1.5, 0 )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

	end

	function ENT:Use(activator, caller)
        
    end

    function ENT:Touch(hitEnt)
        if not IsValid(hitEnt) then print(hitEnt) return end        --如果触碰物不是可见的，那么打印触碰物返回结束
        for _, v in pairs( items.food ) do
            if self:GetClass() != hitEnt:GetClass() then
                if hitEnt:GetClass() == v.class and !hitEnt.inbox and hitEnt.Ding then  --可到箱中改变属性
                    --print(hitEnt)
                    hitEnt:Cv( true, true )    --变为已固定状态
                    hitEnt:SetColor(Color( 150, 150, 150, 1 ))
                    hitEnt:SetParent(self)
                end
            end
        end
    end

end

scripted_ents.Register(ENT, "food_mod_traincar", true)