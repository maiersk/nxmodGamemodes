LevelBase = {
    ply = nil,
    level = nil,
    xp = nil,
}

function LevelBase:new(ply, level, xp)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.ply = ply
    o.level = level
    o.xp = xp
    return o
end

--增加经验function
function LevelBase:StatsAddXp( n )
    self.ply:SetNWInt( "XP", self.ply:GetNWInt( "XP" ) + n )    --网络整数值相加function的n变量
    if( tonumber( self.ply:GetNWInt( "XP" ) ) > 99 && tonumber( self.ply:GetNWInt( "Level" ) ) < 5 ) then  --如果经验大于99和等级小于5，那么
        local tempxp = self.ply:GetNWInt( "XP" ) - 100      --缓存经验变量等于，当前xp变量减100
        self.ply:StatsLevelup()                                --运行升级function
        self.ply:SetNWInt( "XP", tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self.ply:GetNWInt( "Level" ) .. "  经验：" .. self.ply:GetNWInt( "XP" ) )
    end
end

--玩家升级
function LevelBase:StatsLevelup() 
    --self.ply:SetPData( "XP" .. "_" .. jobname, 0 )
    self.ply:EmitSound( "garrysmod/sound/common/talk.wav" )
    self.ply:SetNWInt( "Level", self.ply:GetNWInt( "Level" ) + 1 )
end

function LevelBase:DeXpandLevel()
    --if (self.ply:GetNWInt("XP" .. "_" .. jobname) > 0 and self.ply:GetNWInt("Level" .. "_" .. jobname) > 0 ) then --###
        self.ply:SetNWInt("XP", 0)
        self.ply:SetNWInt("Level", 0)
    --end
end

function LevelBase:SetXPLevel( n )
    self.ply:SetNWInt("XP", 0)
    self.ply:SetNWInt("Level", n)
end


JobLevel = {}

JobLevel = LevelBase:new()

function JobLevel:new(group, level, xp)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.group = group
    o.level = level
    o.xp = xp
    return o
end

function JobLevel:StatsAddXp( ply, n )
    self.ply = ply
    self.ply:SetNWInt( "XP" .. "_" .. self.group, self.ply:GetNWInt( "XP" .. "_" .. self.group ) + n )    --网络整数值相加function的n变量
    if( tonumber( self.ply:GetNWInt( "XP" .. "_" .. self.group ) ) > 99 && tonumber( self.ply:GetNWInt( "Level" .. "_" .. self.group ) ) < 5 ) then  --如果经验大于99和等级小于5，那么
        local tempxp = self.ply:GetNWInt( "XP" .. "_" .. self.group ) - 100      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( self.group )                                --运行升级function
        self.ply:SetNWInt( "XP" .. "_" .. self.group, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self.ply:GetNWInt( "Level" .. "_" .. self.group ) .. "  经验：" .. self.ply:GetNWInt( "XP" .. "_" .. self.group ) )
    elseif( tonumber( self.ply:GetNWInt( "XP" .. "_" .. self.group ) ) > 199 && tonumber( self.ply:GetNWInt( "Level" .. "_" .. self.group ) ) < 10 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self.ply:GetNWInt( "XP" .. "_" .. self.group ) - 200      --缓存经验变量等于，当前xp变量减200
        self:StatsLevelup( self.group )                             --运行升级function
        self.ply:SetNWInt( "XP" .. "_" .. self.group, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self.ply:GetNWInt( "Level" .. "_" .. self.group ) .. "  经验：" .. self.ply:GetNWInt( "XP" .. "_" .. self.group ) )
    elseif( tonumber( self.ply:GetNWInt( "XP" .. "_" .. self.group ) ) > 299 && tonumber( self.ply:GetNWInt( "Level" .. "_" .. self.group ) ) < 15 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self.ply:GetNWInt( "XP" .. "_" .. self.group ) - 300      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( self.group )                             --运行升级function
        self.ply:SetNWInt( "XP" .. "_" .. self.group, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self.ply:GetNWInt( "Level" .. "_" .. self.group ) .. "  经验：" .. self.ply:GetNWInt( "XP" .. "_" .. self.group ) )
    elseif( tonumber( self.ply:GetNWInt( "XP" .. "_" .. self.group ) ) > 399 && tonumber( self.ply:GetNWInt( "Level" .. "_" .. self.group ) ) < 20 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self.ply:GetNWInt( "XP" .. "_" .. self.group ) - 400      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( self.group )                             --运行升级function
        self.ply:SetNWInt( "XP" .. "_" .. self.group, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self.ply:GetNWInt( "Level" .. "_" .. self.group ) .. "  经验：" .. self.ply:GetNWInt( "XP" .. "_" .. self.group ) )
    elseif( tonumber( self.ply:GetNWInt( "XP" .. "_" .. self.group ) ) > 399 && tonumber( self.ply:GetNWInt( "Level" .. "_" .. self.group ) ) == 20 ) then    --最高级设置
        self.ply:SetNWInt( "XP" .. "_" .. self.group, 400 )
    end  
end