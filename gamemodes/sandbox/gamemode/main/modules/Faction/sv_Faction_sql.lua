Faction = Faction or {}
Faction.sql = SQLite or {}
Faction.sql.tables = Faction.sql.tables or {}

Faction.sql:ReisterTable("faction", {
    create = {
        {name = "id", ctype = "integer PRIMARY KEY AUTOINCREMENT"},
        {name = "name", ctype = "varchar(100)"},
        {name = "ownerid", ctype = "int(4) UNIQUE"},
        {name = "color", ctype = "varchar(100)"},
        {name = "level", ctype = "int(4)"},
        {name = "cash", ctype = "integer"}
    }
})

Faction.sql:ReisterTable("faction_menubar", {
    create = {
        {name = "id", ctype = "integer PRIMARY KEY"},
        {name = "steamid", ctype = "int(4) UNIQUE"},
        {name = "factionid", ctype = "integer"},
        {name = "groupid", ctype = "int(4)"},
        {name = "name", ctype = "varchar(100)"}
    }
})

Faction.sql:ReisterTable("faction_group", {
    create = {
        {name = "id", ctype = "integer PRIMARY KEY AUTOINCREMENT"},
        {name = "name", ctype = "varchar(100) UNIQUE"},
        --{name = "permission", ctype = "varchar(150)"},
    }
})

--Faction.sql:DeleteByid(2)
--[[
    CREATE TABLE IF NOT EXISTS Faction( 
            id integer PRIMARY KEY AUTOINCREMENT,
            name varchar(16),
            ownerid int(4), 
            level int(4), 
            cash int
]]
--[[MySQLite.query("create table faction( Name char(16), Ownerid int(4), Level int(4), Cash int );", function(data) 
    if data then
        PrintTable(data)
    end
end, function(data) print(data) end)--]]

--PrintTable(MySQLite.query("select * from faction;"))

--[[Faction.sql:InsertTo("faction", {
    name = "test",
    ownerid = 1,
    level = 0,
    cash = 100,
})--]]

-- Faction.sql:InsertTo("faction_menubar", {
--     id = 2,
--     factionid = 4,
--     steamid = "STEAM_0:1:68948284",
--     name = "ABTTEX"
-- })

-- Faction.sql:UpdateByid(6, {
--     cash = "20000"
-- })

--PrintTable(Faction.sql:Data())

--[[
    CREATE TABLE `libk_player` (`player` VARCHAR(255) NOT NULL, `updated_at` TIMESTAMP NULL, `uid` BIGINT(20) NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `steam64` BIGINT(20) NOT NULL, `name` VARCHAR(255) NOT NULL, `created_at` TIMESTAMP NULL);

CREATE TABLE IF NOT EXISTS Faction_Menubar (
		ownerid integer,
		factionid integer,
		steam64 char,
		name varchar(255)
);

INSERT INTO Faction_Menubar (ownerid, factionid, steam64, name)
VALUES(
	(SELECT id FROM libk_player WHERE player = 'STEAM_0:1:68948284'),
	1,
	'STEAM_0:1:68948284',
	'testplayer'
);

SELECT * FROM Faction_Menubar;

DROP TABLE Faction_Menubar;
]]


