local ply = FindMetaTable("Player")

local teams = {}

--[[
JOB_CITIZEN = nxrp.Createjob(
    "Citizen",
    Color( 25, 25, 25, 200 ),
    { "models/player/group01/male_02.mdl" },
    { "models/player/group01/female_06.mdl" },
    "是一个养老职业，可玩性不差，工资是服保。类型：可成为小偷，渔民，妓工，黑帮，黑帮boss，的小职业。",
    { "weapon_crowbar", "weapon_physgun" },
    0,                      --使用这个职业上限数
    200,                    --工资
    0,                      --只允许管理员
    false,                  --有许可
    false                   --检查职业
)
--]]

--[[
JOB_CITIZEN = nxrp.Createjob( "citizen", "Citizen", { 
    color = Color( 25, 25, 25, 200 ),
    malemodel = { "models/player/group01/male_02.mdl" },
    famalemodel = { "models/player/group01/female_06.mdl" },
    description = "是一个养老职业，可玩性不差，工资是服保。类型：可成为小偷，渔民，妓工，黑帮，黑帮boss，的小职业。",
    weapons = { "weapon_crowbar", "weapon_physgun" },
    max = 0,                        --使用这个职业上限数
    salary = 200,                   --工资
    admin = 0,                      --只允许管理员
    haslicense = false,             --有许可
    check = false,                  --检查职业
})


JOB_PROJECT = nxrp.Createjob( "project", "Project" , {
    color = Color( 25, 25, 25, 200 ),
    malemodel = { "models/player/kleiner.mdl" },
    famalemodel = { "models/player/p2_chell.mdl" },
    description = "主要是沙盒玩法的职业。类型：可成为组装载具，黑帮，渔民，防御工事，的小职业。",
    weapons = { "weapon_crowbar", "weapon_physgun" },
    max = 0,                        --使用这个职业上限数
    salary = 200,                   --工资
    admin = 0,                      --只允许管理员
    haslicense = false,             --有许可
    check = false,                  --检查职业
})

JOB_POILCE = nxrp.Createjob( "poilce", "Poilce" , {
    color = Color( 25, 25, 25, 200 ),
    malemodel = { "models/player/urban.mdl" },
    famalemodel = { "models/player/alyx.mdl" },
    description = "主要和黑帮进行对抗，夺回黑帮领地保护玩家，工资可以按任务加成。类型：可成为警察局长，警察队长，渔民，的小职业。",
    weapons = { "weapon_crowbar", "weapon_physgun" },
    max = 0,                        --使用这个职业上限数
    salary = 200,                   --工资
    admin = 0,                      --只允许管理员
    haslicense = false,             --有许可
    check = false,                  --检查职业
})

JOB_DOCTOR = nxrp.Createjob( "doctor", "Doctor" , {
    color = Color( 25, 25, 25, 200 ),
    malemodel = { "models/player/group03m/male_02.mdl" },
    famalemodel = { "models/player/group03m/female_05.mdl" },
    description = "主要医疗和急救玩家，工资可以按任务加成。类型：可成为渔民，食物摆摊，食物商店，的小职业。",
    weapons = { "weapon_crowbar", "weapon_physgun" },
    max = 0,                        --使用这个职业上限数
    salary = 200,                   --工资
    admin = 0,                      --只允许管理员
    haslicense = false,             --有许可
    check = false,                  --检查职业
})
--]]

teams[0] = {
    name = "Citizen",
    color = Vector( 0, 1.0, 0),
    weapons = { "weapon_crowbar", "weapon_physgun" },
    models = { male = "models/player/group01/male_02.mdl", famale = "models/player/group01/female_06.mdl" },     --男左女右
    
}
teams[1] = {
    name = "Poilce",
    color = Vector( 0, 1.0, 0),
    weapons = { "weapon_crowbar", "weapon_physgun" },
    models = { male = "models/player/group01/male_02.mdl", famale = "models/player/group01/female_06.mdl" },     --男左女右
    
}
teams[2] = {
    name = "Doctor",
    color = Vector( 0, 1.0, 0),
    weapons = { "weapon_crowbar", "weapon_physgun" },
    models = { male = "models/player/group01/male_02.mdl", famale = "models/player/group01/female_06.mdl" },     --男左女右
    
}


--加入工作
function ply:CagTeam( n, string )
    --检查玩家所处的工作
    if ( string == "check" ) then

        if ( tonumber( self:GetNWInt( "Team" ) ) == n ) then 
            return print( "你已经是这个工作")
        else
            self:SetNWString( "Team", n )
            self:SetPData( "Team", self:GetNWInt( "Team" ) )
        end
        
    end


        self:RemoveAllItems()
        self:SetupTeam( n )
        self:SetNWString( "Team", n )
        self:SetPData( "Team", self:GetNWInt( "Team" ) )
end

--工作配置
function ply:SetupTeam( n )

    if ( not teams[n] ) then return end

    self:SetTeam ( n )
    self:SetPlayerColor( teams[n].color )
    self:gendermodel( n )     --性别/模型
    self:SetHealth( 100 )
    self:SetWalkSpeed( 200 )
    self:SetRunSpeed( 250 )
    

    self:GiveWeapons( n )   --武器配置

end

--性别/模型设置
function ply:gendermodel( n )

    --for k , model in pairs ( teams[n].models ) do

        if ( tostring( self:GetNWString( "Gender" ) ) == "male" ) then          --是男性
            self:SetModel( teams[n].models["male"] )
        elseif ( tostring( self:GetNWString( "Gender" ) ) == "famale" ) then        --是女性
            self:SetModel( teams[n].models["famale"] )
        else
            self:SetModel( teams[n].models["male"] )
        end
    --end    

end

--武器配置
function ply:GiveWeapons( n )
    for k , weapon in pairs( teams[n].weapons ) do
        self:Give( weapon )
    end
end
    --ULib.ucl.users
    --groups.modelList
    --xgui.data.teams
    --local string = table.ToString( ulx.teams, "test", true )
    --print( string )

--nxrp.Joinjob( ply:UniqueID(), "superadmin" )

--local teamname, number = checkNewTeamExists( "New_Team", "" )

--print( teamname .."/".. number )
--PrintTable( ULib.ucl.groups[ "citizen" ].team )


