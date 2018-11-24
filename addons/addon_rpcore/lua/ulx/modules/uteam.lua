local next_team_index
local starting_team_index = 21
ulx.teams = ulx.teams or {}
local team_by_name = {}

local function sortTeams( team_a, team_b )
	if team_a.order then
		if team_a.order ~= team_b.order then
			return not team_b.order or team_a.order < team_b.order
		end
	elseif team_b.order then
		return false -- Ordered always comes before non-ordered
	end

	return team_a.name < team_b.name
end

local function sendDataTo( ply )
	ULib.clientRPC( ply, "ulx.populateClTeams", ulx.teams )
end
--分配队伍参数
local function assignTeam( ply )
	local team = ULib.ucl.groups[ ply:GetUserGroup() ].team
	if team then
		local team_data = team_by_name[ team.name ]
		ULib.queueFunctionCall( function()
			if not ply:IsValid() then return end -- In case they drop quickly
            ply:SetTeam( team_data.index )
			--分配玩家性别模型
			if ply:GetNWString("Gender") == "wait" then
				if team_data.malemodel then
					ply:SetModel( team_data.malemodel )
                end
            elseif ply:GetNWString("Gender") == "female" then
                if team_data.femalemodel then
                    ply:SetModel( team_data.femalemodel )
                end
            elseif ply:GetNWString("Gender") == "male" then
                if team_data.malemodel then
					ply:SetModel( team_data.malemodel )
                end
			end
			--分配玩家武器
			if team_data.weapons then
				local weaponstable = {}
				local temp = string.gsub( team_data.weapons, [[']], [["]] )
				weaponstable = util.JSONToTable(temp) 
				for _, v in pairs( weaponstable ) do
					ply:Give( v )
				end
			end
            --分配玩家其余mod参数
			for key, value in pairs( team_data ) do
				local candidate_function = ply[ "Set" .. key:sub( 1, 1 ):upper() .. key:sub( 2 ) ]
				if type( value ) == "number" and type( candidate_function ) == "function" then
					candidate_function( ply, value )
				end
			end
		end )
	elseif ply:Team() >= starting_team_index and ply:Team() < next_team_index then
		ULib.queueFunctionCall( ply.SetTeam, ply, 1001 ) -- Unassigned
	end
end

function ulx.saveTeams()
	-- First clear the teams
	for group_name, group_data in pairs( ULib.ucl.groups ) do
		group_data.team = nil
	end

	local to_remove = {}
	for i=1, #ulx.teams do
		local teamdata = table.Copy( ulx.teams[ i ] ) -- Copy since we'll be removing data as we go
		if not teamdata.groups or #teamdata.groups == 0 then
			table.insert( to_remove, 1, i )
		else
			local groupdata = {}
			local groups = teamdata.groups
			teamdata.groups = nil
			if teamdata.color then
				groupdata.color_red = teamdata.color.r
				groupdata.color_green = teamdata.color.g
				groupdata.color_blue = teamdata.color.b
				teamdata.color = nil
			end
			table.Merge( groupdata, teamdata )
			ULib.ucl.groups[ groups[ 1 ] ].team = groupdata
			for i = 2, #groups do
				ULib.ucl.groups[ groups[ i ] ].team = {
					name = teamdata.name,
					order = teamdata.order
				}
			end
		end
	end

	for i=1, #to_remove do
		table.remove( ulx.teams, to_remove[ i ] )
	end

	ULib.ucl.saveGroups()
end

function ulx.refreshTeams()
	if not ulx.uteamEnabled() then
		return
	end

	next_team_index = starting_team_index
	ulx.teams = {}
	team_by_name = {}

	for group_name, group_data in pairs( ULib.ucl.groups ) do
		if group_data.team then
			local team_name = group_data.team.name or ("Team" .. tostring( next_team_index ))
			group_data.team.name = team_name
			local team_color
			if group_data.team.color_red or group_data.team.color_green or group_data.team.color_blue then
				team_color = Color( tonumber( group_data.team.color_red ) or 255, tonumber( group_data.team.color_green ) or 255, tonumber( group_data.team.color_blue ) or 255 )
			end
			local team_femalemodel
			if group_data.team.femalemodel then
				team_femalemodel = group_data.team.femalemodel     --改动位置
				if not ULib.fileExists( team_femalemodel ) then
					team_femalemodel = player_manager.TranslatePlayerModel( team_femalemodel )
				end
			end
			local team_malemodel  
			if group_data.team.malemodel then
				team_malemodel = group_data.team.malemodel
				if not ULib.fileExists( team_malemodel ) then
					team_malemodel = player_manager.TranslatePlayerModel( team_malemodel )
				end
			end
			local new_team = {                              --改动位置
				name = team_name,
				color = team_color,
                femalemodel = team_femalemodel,
                malemodel = team_malemodel,
                description = group_data.team.description,
				weapons = group_data.team.weapons,
				mcost = group_data.team.mcost,
				lcost = group_data.team.lcost,
				wage = group_data.team.wage,
			}
			for key, value in pairs( group_data.team ) do   --改动位置
                if key ~= "femalemodel" and 
                key ~= "malemodel" and 
                key ~= "description" and 
				key ~= "weapons" and 
				key ~= "mcsot" and
				key ~= "lcsot" and
				key ~= "wage" and
				key ~= "name" and 
                not key:find( "color" ) then
					new_team[ key ] = tonumber( value )
				end
            end
            --print( table.ToString( new_team, "out12", true ) )
            --print( table.ToString( group_data.team, "out13", true ) )
			if team_by_name[ team_name ] then
				table.insert( team_by_name[ team_name ].groups, group_name )
				table.Merge( team_by_name[ team_name ], new_team )
			else
				-- Make sure there's a color
				new_team.color = new_team.color or Color( 255, 255, 255, 255 )
				new_team.groups = { group_name }
				table.insert( ulx.teams, new_team )
				team_by_name[ team_name ] = new_team
            end
            --print( table.ToString( new_team, "out21", true ) )
            --print( table.ToString( group_data.team, "out22", true ) )
		end
	end
    
	table.sort( ulx.teams, sortTeams )
	for i=1, #ulx.teams do
		local team_data = ulx.teams[ i ]
		team.SetUp( next_team_index, team_data.name, team_data.color )
		team_data.index = next_team_index
		next_team_index = next_team_index + 1
	end
    --print( table.ToString( ulx.teams, "out3", true ) )
	local plys = player.GetAll()
	for i=1, #plys do
		local ply = plys[ i ]
		sendDataTo( ply )
		assignTeam( ply )
	end

	hook.Add( "PlayerInitialSpawn", "UTeamInitialSpawn", sendDataTo, HOOK_MONITOR_HIGH )
	hook.Add( "PlayerSpawn", "UTeamSpawnAuth", assignTeam, HOOK_MONITOR_HIGH )
	hook.Add( "UCLAuthed", "UTeamAuth", assignTeam, HOOK_MONITOR_HIGH )
end
hook.Add( "Initialize", "UTeamInitialize", ulx.refreshTeams, HOOK_MONITOR_HIGH )
