SQLite = SQLite or {}
SQLite.tables = SQLite.tables or {}

function SQLite:Init()
    if self.tables then
        for k, v in pairs(self.tables) do
            self:CreateTable(k)
        end
    end
end

function SQLite:ReisterTable(name, tbl)
    self.tables[name] = tbl
end

function SQLite:CreateTable(name)
    local tbl = self.tables[name]
    if tbl && tbl.create then
        local queryStr = {}
        for k, v in pairs(tbl.create) do
            table.insert(queryStr, sql.SQLStr(v.name) .. " " .. v.ctype)
        end
        MySQLite.query("CREATE TABLE IF NOT EXISTS " .. name .. "( " .. table.concat(queryStr, ", ") .. " )", nil,
            function(error)
                print(error)
            end
        )
    end
end

function SQLite:InsertTo(name, tbl)
    local cols, vals = {}, {}
    local res = true
    for k, v in pairs(tbl) do
        table.insert(cols, MySQLite.SQLStr(k))
        table.insert(vals, MySQLite.SQLStr(v))
    end
    
    print(table.concat(cols, ", "))
    print(table.concat(vals, ", "))

    MySQLite.query("INSERT INTO " .. name .. "( " .. table.concat(cols, ", ") .. " ) " ..
        "VALUES( " .. table.concat(vals, ", ") .. " )", nil, 
        function(error)
            print(error)
            res = false
        end
    )
    return res
end

function SQLite:UpdateByid(name, cols, vals, sets)
    local setsTbl = {}
    if type(sets) == "table" then
        for k, v in pairs(sets) do
            table.insert(setsTbl, k .. " = " .. MySQLite.SQLStr(v))
        end
        sets = table.concat(setsTbl, ", ")
        print(sets)
        MySQLite.query("UPDATE " .. name .. " SET " .. sets .. " WHERE " .. cols .. " = " .. MySQLite.SQLStr(vals), nil, 
            function(error)
                print(error)
                return false
            end
        )
        return true
    end
end

function SQLite:DeleteByid(name, cols, vals, ands)
    local res = true
    local str = ""
    if ands then
        str = " and " .. ands.cols .. " = " .. MySQLite.SQLStr(ands.vals)
    end
    MySQLite.query("DELETE FROM " .. name .. " WHERE " .. cols .. " = " .. MySQLite.SQLStr(vals) .. str, nil, 
        function(error)
            print(error)
            res = false
        end
    )
    return res
end

function SQLite:SelectAll(name)
    return MySQLite.query("SELECT * FROM " .. name) or {}
end

function SQLite:SelectVal(name, out, cols, value)
    return MySQLite.queryValue("SELECT " .. out .. " FROM " .. name .. " WHERE " .. cols .. " = " .. MySQLite.SQLStr(value), nil, 
        function(error)
            print(error)    
        end
    )
end

function SQLite:SelectWhere(name, cols, value)
    local tbl = self.tables[name]
    if tbl then
        return MySQLite.query("SELECT * FROM " .. name .. " WHERE " .. cols .. " = " .. MySQLite.SQLStr(value), nil, 
            function(error)
                print(error)
            end
        )
    end
end