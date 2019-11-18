LevelBase = LevelBase or {}

function LevelBase:toString()
    return self.ply .. self.level
end

JobLevel = JobLevel or {}

function JobLevel:toString()
    return self.ply .. self.group .. self.level .. self.xp
end

--PrintTable(LevelBase)
--[[
lua模拟对象例子
aClass = { 
    var1 = nil,
    var2 = nil,
    var3 = nil,
}

function aClass:new(var1, var2, var3)
    local obj = {}          --对象初始化表,为return obj用，等于新建一个obj出去
    setmetatable(obj, self) --设置元表关系
    self.__index = self;    --绑定关键字
    obj.var1 = var1         
    obj.var2 = var2
    obj.var3 = var3
    return obj
end

function aClass:toString()
    return self.ply .. self.group .. self.level .. self.xp
end

--]]