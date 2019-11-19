local ply = FindMetaTable( "Player" )   --使用Player元表，增加function和操作玩家function

--新建一个保存玩家数据function
function ply:StatsSave()
    --self是ply元表本身，加冒号后的是Player元表内的官方function
    local tbl = {
        "citizen",
        "doctor",
        "poilce",
        "project"
    }
    for _, v in pairs( tbl ) do
        self:SetPData( "Level" .. "_" .. v, self:GetNWInt( "Level" .. "_" .. v ) )  --设置PData的等级保存进数据库，值是网络整数
        self:SetPData( "XP" .. "_" .. v, self:GetNWInt( "XP" .. "_" .. v ) )    --设置PData的经验保存进数据库，值是网络整数
        --打印调试信息
        print( "save " .. v .. " Level:" .. self:GetNWInt( "Level" .. "_" .. v ) )
        print( "save " .. v ..  " XP:" .. self:GetNWInt( "XP" .. "_" .. v ) )
    end

    self:SetPData( "Gender", self:GetNWString( "Gender") )  --设置PData的性别保存进数据库，值是网络整数
    print( "save Gender:" .. self:GetNWString( "Gender" ) )

end

--新建一个玩家配置加载/初始化function
--加載玩家每中职业的经验等级
function ply:StatsLoad()
    local tbl = {
        "citizen",
        "doctor",
        "poilce",
        "project"
    }
    if( self:GetPData( "Gender" ) == nil ) then     --如果没有PData名的数据
        self:SetPData( "Gender", 0 )                --设置PData名
        self:SetNWString( "Gender", "wait" )        --设置网络字符串
    else
        self:SetNWString( "Gender", self:GetPData( "Gender" ) )     --否则网络字符串，将使用保存了的PData数据
    end
    --[[
    if( self:GetPData( "Level" ) == nil ) then
        self:SetPData( "Level", 0 )
        self:SetNWInt( "Level", 0 )
    else
        self:SetNWInt( "Level", self:GetPData( "Level" ) )
    end
    if( self:GetPData( "XP" ) == nil ) then
        self:SetPData( "XP", 0 )
        self:SetNWInt( "XP", 0 )
    else
        self:SetNWInt( "XP", self:GetPData( "XP" ) )
    end
    --]]
    for _, v in pairs( tbl ) do
        if( self:GetPData( "Level" .. "_" .. v ) == nil ) then
            self:SetPData( "Level" .. "_" .. v, 0 )
            self:SetNWInt( "Level" .. "_" .. v, 0 )
        else
            self:SetNWInt( "Level" .. "_" .. v, self:GetPData( "Level" .. "_" .. v ) )
        end
        if( self:GetPData( "XP" .. "_" .. v ) == nil ) then
            self:SetPData( "XP" .. "_" .. v, 0 )
            self:SetNWInt( "XP" .. "_" .. v, 0 )
        else
            self:SetNWInt( "XP" .. "_" .. v, self:GetPData( "XP" .. "_" .. v ) )
        end
    end

end

--增加经验function
function ply:StatsAddXp( n, jobname )
    self:SetNWInt( "XP" .. "_" .. jobname, self:GetNWInt( "XP" .. "_" .. jobname ) + n )    --网络整数值相加function的n变量
    if( tonumber( self:GetNWInt( "XP" .. "_" .. jobname ) ) > 99 && tonumber( self:GetNWInt( "Level" .. "_" .. jobname ) ) < 5 ) then  --如果经验大于99和等级小于5，那么
        local tempxp = self:GetNWInt( "XP" .. "_" .. jobname ) - 100      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( jobname )                                --运行升级function
        self:SetNWInt( "XP" .. "_" .. jobname, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self:GetNWInt( "Level" .. "_" .. jobname ) .. "  经验：" .. self:GetNWInt( "XP" .. "_" .. jobname ) )
    elseif( tonumber( self:GetNWInt( "XP" .. "_" .. jobname ) ) > 199 && tonumber( self:GetNWInt( "Level" .. "_" .. jobname ) ) < 10 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self:GetNWInt( "XP" .. "_" .. jobname ) - 200      --缓存经验变量等于，当前xp变量减200
        self:StatsLevelup( jobname )                             --运行升级function
        self:SetNWInt( "XP" .. "_" .. jobname, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self:GetNWInt( "Level" .. "_" .. jobname ) .. "  经验：" .. self:GetNWInt( "XP" .. "_" .. jobname ) )
    elseif( tonumber( self:GetNWInt( "XP" .. "_" .. jobname ) ) > 299 && tonumber( self:GetNWInt( "Level" .. "_" .. jobname ) ) < 15 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self:GetNWInt( "XP" .. "_" .. jobname ) - 300      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( jobname )                             --运行升级function
        self:SetNWInt( "XP" .. "_" .. jobname, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self:GetNWInt( "Level" .. "_" .. jobname ) .. "  经验：" .. self:GetNWInt( "XP" .. "_" .. jobname ) )
    elseif( tonumber( self:GetNWInt( "XP" .. "_" .. jobname ) ) > 399 && tonumber( self:GetNWInt( "Level" .. "_" .. jobname ) ) < 20 ) then  --如果经验大于99和等级小于10，那么
        local tempxp = self:GetNWInt( "XP" .. "_" .. jobname ) - 400      --缓存经验变量等于，当前xp变量减100
        self:StatsLevelup( jobname )                             --运行升级function
        self:SetNWInt( "XP" .. "_" .. jobname, tempxp )                   --设置经验值
        print( "你升级了！！！现在的等级是：" .. self:GetNWInt( "Level" .. "_" .. jobname ) .. "  经验：" .. self:GetNWInt( "XP" .. "_" .. jobname ) )
    elseif( tonumber( self:GetNWInt( "XP" .. "_" .. jobname ) ) > 399 && tonumber( self:GetNWInt( "Level" .. "_" .. jobname ) ) == 20 ) then    --最高级设置
        self:SetNWInt( "XP" .. "_" .. jobname, 400 )
    end
end

--玩家升级
function ply:StatsLevelup( jobname ) 
    --self:SetPData( "XP" .. "_" .. jobname, 0 )
    self:EmitSound( "garrysmod/sound/common/talk.wav" )
    self:SetNWInt( "Level" .. "_" .. jobname, self:GetNWInt( "Level" .. "_" .. jobname ) + 1 )
end

function ply:DeXpandLevel( jobname )
    --if (self:GetNWInt("XP" .. "_" .. jobname) > 0 and self:GetNWInt("Level" .. "_" .. jobname) > 0 ) then --###
        self:SetNWInt("XP" .. "_" .. jobname, 0)
        self:SetNWInt("Level" .. "_" .. jobname, 0)
    --end
end

function ply:SetXPLevel( n, jobname )
    self:SetNWInt("XP" .. "_" .. jobname, 0)
    self:SetNWInt("Level" .. "_" .. jobname, n)
end

