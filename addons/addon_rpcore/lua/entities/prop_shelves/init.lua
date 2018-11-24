AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel( "models/props_c17/display_cooler01a.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )          --初始化的物理对象实体使用当前的模型
    self:SetMoveType( MOVETYPE_VPHYSICS )       --设置实体移动类型
    self:SetSolid( SOLID_VPHYSICS )             --设置坚固实体
	self:SetNWInt("num", 0)                     --个数
    self:SetNWInt("distance", 512)              --距离
	self:SetPos(self:GetPos())					--设置位置为取位置
	self.jailWall = true						--设置实体布尔变量——监狱的墙
	self.CanUse = true							--设置实体布尔变量——能用
		local phys = self:GetPhysicsObject()	--如果实体具有物理效果，则返回实体的物理对象。
    phys:Wake()									--唤醒物理对象
    
    --设置网络值
    self:SetNWString( "slot1", "空" )
    self:SetNWFloat( "slot1price", 0 )
    self:SetNWFloat( "slot1maxvalue", 0 )
    self:SetNWFloat( "slot1size", 0 )
    --
    self:SetNWString( "slot2", "空" )
    self:SetNWFloat( "slot2price", 0 )
    self:SetNWFloat( "slot2maxvalue", 0 )
    self:SetNWFloat( "slot2size", 0 )
    --
    self:SetNWString( "slot3", "空" )
    self:SetNWFloat( "slot3price", 0 )
    self:SetNWFloat( "slot3maxvalue", 0 )
    self:SetNWFloat( "slot3size", 0 )
    --
    self:SetNWString( "slot4", "空" )
    self:SetNWFloat( "slot4price", 0 )
    self:SetNWFloat( "slot4maxvalue", 0 )
    self:SetNWFloat( "slot4size", 0 )
    --
    self:SetNWString( "slot5", "空" )
    self:SetNWFloat( "slot5price", 0 )
    self:SetNWFloat( "slot5maxvalue", 0 )
    self:SetNWFloat( "slot5size", 0 )
    --
    self:SetNWString( "slot6", "空" )
    self:SetNWFloat( "slot6price", 0 )
    self:SetNWFloat( "slot6maxvalue", 0 )
    self:SetNWFloat( "slot6size", 0 )
    --
    self:SetNWString( "slot7", "空" )
    self:SetNWFloat( "slot7price", 0 )
    self:SetNWFloat( "slot7maxvalue", 0 )
    self:SetNWFloat( "slot7size", 0 )
    --
    self:SetNWString( "slot8", "空" )
    self:SetNWFloat( "slot8price", 0 )
    self:SetNWFloat( "slot8maxvalue", 0 )
    self:SetNWFloat( "slot8size", 0 )
    --
    self:SetNWString( "slot9", "空" )
    self:SetNWFloat( "slot9price", 0 )
    self:SetNWFloat( "slot9maxvalue", 0 )
    self:SetNWFloat( "slot9size", 0 )    
end

function ENT:SpawnFunction( ply, tr, ClassName )
    if ( !tr.Hit ) then return end

    local SpawnPos = tr.HitPos + tr.HitNormal * 10
    local SpawnAng = ply:EyeAngles()
    SpawnAng.p = 0
    SpawnAng.y = SpawnAng.y + 180

    local ent = ents.Create( ClassName )
    ent:SetPos( SpawnPos )
    ent:SetAngles( SpawnAng )
    ent:Spawn()
    ent:Activate()

    return ent

end

function ENT:Touch(hitEnt)
    if not IsValid(hitEnt) then print(hitEnt) return end        --如果触碰物不是可见的，那么打印触碰物返回结束
    
    --写跟踪数据——开始和结束点都是用已经测量好的红线两点
    local traceS1 = {}
    traceS1.start = self:GetPos() + self:GetUp() *38 + self:GetRight() *-5 + self:GetForward() *43.3
    traceS1.endpos = self:GetPos() + self:GetUp() *38 + self:GetRight() *-10 + self:GetForward() *43.3
    traceS1.filter = self
    local trace1 = util.TraceLine( traceS1 )

    local traceS2 = {}
    traceS2.start = self:GetPos() + self:GetUp() *38 + self:GetRight() *-5 + self:GetForward() *-30
    traceS2.endpos = self:GetPos() + self:GetUp() *38 + self:GetRight() *-10 + self:GetForward() *-30
    traceS2.filter = self
    local trace2 = util.TraceLine( traceS2 )
    
    local traceS3 = {}
    traceS3.start = self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-9 + self:GetForward() *43.3
    traceS3.endpos = self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-14 + self:GetForward() *43.3
    traceS3.filter = self
    local trace3 = util.TraceLine( traceS3 )

    local traceS4 = {}
    traceS4.start = self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-9 + self:GetForward() *-30
    traceS4.start = self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-14 + self:GetForward() *-30
    traceS4.filter = self
    local trace4 = util.TraceLine( traceS4 )

    local traceS5 = {}
    traceS5.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *43.3
    traceS5.endpos = self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *43.3
    traceS5.filter = self
    local trace5 = util.TraceLine( traceS5 )

    local traceS6 = {}
    traceS6.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *25.3
    traceS6.endpos = self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *25.3
    traceS6.filter = self
    local trace6 = util.TraceLine( traceS6 )

    local traceS7 = {}
    traceS7.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *7
    traceS7.endpos = self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *7
    traceS7.filter = self
    local trace7 = util.TraceLine( traceS7 )

    local traceS8 = {}
    traceS8.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *-11.5
    traceS8.endpos = self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *-11.5
    traceS8.filter = self
    local trace8 = util.TraceLine( traceS8 )

    local traceS9 = {}
    traceS9.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *-30
    traceS9.start = self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *-30
    traceS9.filter = self
    local trace9 = util.TraceLine( traceS9 )
		
    if ( self.CanUse and hitEnt:GetClass() != "" ) then
        local Ang = self:GetAngles()

        if IsValid( trace1.Entity ) then
            if ( trace1.Entity:GetClass() == "hotdog" ) then
                print("1ok")
                trace1.Entity:SetPos( self:GetPos() + self:GetUp() *24 + self:GetRight() *1 + self:GetForward() *38 )
                attribute(trace1.Entity)
            end  
        elseif IsValid( trace2.Entity ) then
            if ( trace2.Entity:GetClass() == "prop_goods" ) then
                print("2ok")
                --trace2.Entity:Remove()
                self:SetNWString( "slot2", "有" )    
            end
        elseif IsValid( trace3.Entity ) then
            if ( trace3.Entity:GetClass() == "prop_goods" ) then
                print("3ok")
            end
        elseif IsValid( trace4.Entity ) then
            if ( trace4.Entity:GetClass() == "prop_goods" ) then
                print("4ok")
            end
        elseif IsValid( trace5.Entity ) then
            if ( trace5.Entity:GetClass() == "prop_goods" ) then
                print("5ok")
            end
        elseif IsValid( trace6.Entity ) then
            if ( trace6.Entity:GetClass() == "prop_goods" ) then
                print("6ok")
            end
        elseif IsValid( trace7.Entity ) then
            if ( trace7.Entity:GetClass() == "prop_goods" ) then
                print("7ok")
            end
        elseif IsValid( trace8.Entity ) then
            if ( trace8.Entity:GetClass() == "prop_goods" ) then
                print("8ok")
            end
        elseif IsValid( trace9.Entity ) then
            if ( trace9.Entity:GetClass() == "prop_goods" ) then
                print("9ok")
            end
        end

        function attribute( ent )  
            ent:SetAngles(Angle(Ang.p, Ang.y, Ang.r))	--触碰物设置角度为，本实体角度
            ent:SetCollisionGroup(4)						--设置触碰物的碰撞属性——COLLISION_GROUP_INTERACTIVE	4	碰撞一切，除了互动式碎片或碎屑
            ent:SetParent(self)							--设置触碰物父句柄
        end
    end
    --[[
    if ( self.CanUse ) then
        local traceS1 = {}
        traceS1.start = self:GetPos() 

        
        if ( hitEnt:GetClass() == "prop_goods" ) then
            local Ang = self:GetAngles()
            local newEnt = ents.Create( "" )
            if ( self:GetNWInt( "num" ) == 0 ) then
                newEnt:SetPos( self:GetPos() + Ang:Right() + Ang:Up() + Ang:Forward() * -15 )
                self:SetNWInt( "num", self:GetNWInt() + 1 )
            end;
            if ( self:GetNWInt( "num" ) == 1 ) then
                newEnt:SetPos( self:GetNWInt() + Ang:Right() + Ang:Up() + Ang:Forward() * 15 )
                self:SetNWInt( "num", self:GetNWInt() + 1 )
            end;
            newEnt:SetAngles( Angle( Ang.p, Ang.y, Ang.r ) )
            newEnt:Spawn()
            newEnt:SetCollisionGroup(4)
            newEnt:SetParent(self)
        end
        

    end
    --]]
end

function ENT:Use( activator, caller )
    local curTime = CurTime()

    --设置按钮点
    local slot1Pos = self:GetPos() + self:GetUp() *36.8 + self:GetRight() *-5 + self:GetForward() *36.5
    local slot2Pos = self:GetPos() + self:GetUp() *36.8 + self:GetRight() *-5 + self:GetForward() *-37
    local slot3Pos = self:GetPos() + self:GetUp() *23.3 + self:GetRight() *-9 + self:GetForward() *36.5
    local slot4Pos = self:GetPos() + self:GetUp() *23.3 + self:GetRight() *-9+ self:GetForward() *-37
    local slot5Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *36.5
    local slot6Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *18.6
    local slot7Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-0.1
    local slot8Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-18.3
    local slot9Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-37

    if (  !self.nextUse or curTime >= self.nextUse ) then
        if activator:GetPos():Distance( self:GetPos() ) < 72 then
            --or locked
            if ( ( activator:GetEyeTrace().HitPos:Distance(slot1Pos) < 4 ) and ( self:GetNWString("slot1") != "空" ) ) then
                trace1.Entity:Remove()
                print("1按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot2Pos) < 4 ) and ( self:GetNWString("slot2") != "空" ) ) then
                print("2按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot3Pos) < 4 ) and ( self:GetNWString("slot3") != "空" ) ) then
                print("3按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot4Pos) < 4 ) and ( self:GetNWString("slot4") != "空" ) ) then
                print("4按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot5Pos) < 4 ) and ( self:GetNWString("slot5") != "空" ) ) then
                print("5按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot6Pos) < 4 ) and ( self:GetNWString("slot6") != "空" ) ) then
                print("6按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot7Pos) < 4 ) and ( self:GetNWString("slot7") != "空" ) ) then
                print("7按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot8Pos) < 4 ) and ( self:GetNWString("slot8") != "空" ) ) then
                print("8按了")
            elseif ( ( activator:GetEyeTrace().HitPos:Distance(slot9Pos) < 4 ) and ( self:GetNWString("slot9") != "空" ) ) then
                print("9按了")
            end
        end
    end


end

function ENT:OnRemove()
    if not IsValid(self) then return end
end