Domain = Domain or {}
Domain.sql = SQLite or {}

Domain.sql:ReisterTable("domain", {
    create = {
        {name = "id", ctype = "integer PRIMARY KEY AUTOINCREMENT"},
        {name = "flagid", ctype = "integer UNIQUE"},
        {name = "name", ctype = "varchar(150) UNIQUE"},
        {name = "position", ctype = "varchar(255) UNIQUE"},
        {name = "description", ctype = "varchar(255)"},
        {name = "color", ctype = "varchar(50)"},
        {name = "factionid", ctype = "integer"}
    }
})

Domain.sql:ReisterTable("domain_flag", {
    create = {
        {name = "id", ctype = "integer PRIMARY KEY AUTOINCREMENT"},
        {name = "name", ctype = "varchar(150) UNIQUE"},
        {name = "entindex", ctype = "integer UNIQUE"},
        {name = "position", ctype = "varchar(150) UNIQUE"}
    }
})