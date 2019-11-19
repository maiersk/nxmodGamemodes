--[[
items.AddNpcTable{
    name = "迅捷僵尸",
    class = "npc_fastzombie",
    models = {"models/zombie/fast.mdl"},
    img = {"materials/spawnicons/models/zombie/fast.png"},
    price = 1000, 
    textinfo = "能快速跑/跳到敌人附近近战",

}
items.AddNpcTable{
    name = "僵尸",
    class = "npc_zombie",
    models = {"models/zombie/classic.mdl"},
    img = {"materials/spawnicons/models/zombie/classic.png"},
    price = 300,
    textinfo = "速度慢，血量低",

}
items.AddNpcTable{
    name = "狮蚁骑兵",
    class = "npc_antlionguard",
    models = {"Models/antlion_guard/antlionGuard2.mdl"},
    img = {"materials/spawnicons/models/antlion_guard.png"},
    price = 9000, 
    textinfo = "血量高，攻/速高",

}
--]]
items.AddNpcTable{
    name = "医疗兵",
    class = "npc_citizen",
    --models = {"models/player/group03m/female_01.mdl"},
    img = {"materials/spawnicons/models/player/group03m/female_01.png"},
    SpawnFlags = 8 + 131072,	--npc属性
    KeyValues = { citizentype = CT_REBEL, SquadName = "resistance" },
    price = 300, 
    textinfo = "能给自己补血治疗",
    Weapons = { "weapon_pistol", "weapon_smg1" },
}
items.AddNpcTable{
    name = "工兵",
    class = "npc_alyx",
    models = {"models/alyx.mdl"},
    img = {"materials/spawnicons/models/alyx.png"},
    price = 300, 
    textinfo = "普通士兵高攻武器",
    Weapons = { "weapon_alyxgun", "weapon_smg1", "weapon_shotgun" },
}
items.AddNpcTable{
    name = "外星人",
    class = "npc_vortigaunt",
    models = {"models/vortigaunt_slave.mdl"},
    img = {"materials/spawnicons/models/vortigaunt.png"},
    price = 1000, 
    textinfo = "攻击波！？",
}
items.AddNpcTable{
    name = "士兵",
    class = "npc_barney",
    models = {"models/player/barney.mdl"},
    img = {"materials/spawnicons/models/barney.png"},
    price = 500, 
    textinfo = "高血量士兵",
    Weapons = { "weapon_pistol", "weapon_ar2", "weapon_smg1", "weapon_shotgun" },
}
