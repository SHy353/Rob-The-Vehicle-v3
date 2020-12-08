// Sahil's useful functions here...

function FindPlayer( player )
{
	local plr = Handler.Handlers.Script.FindPlayer( player );
	return plr;
}

function GetCountry( player )
{
	from = GeoIP.GetDIsplayInfo( player.IP )
	return from;
}

function GetPlayers()
{
	local tp = 0, plr;
	for ( local i=0; i<100; i++ )
	{
		plr = FindPlayer( i );
		if ( plr ) tp++;
	}
	return tp;
}

function GetAdminList()
{
	local alist = "", plr;
	for ( local i=0; i<GetPlayers() + 10; i++ )
	{
		plr = FindPlayer( i );
		if ( plr ) 
		{
			if ( plr.Authority > 1 )	
			{
				if ( alist=="" ) alist += plr.Name;
				else alist += ( ", " + plr.Name );
			}
		}
	}
	return alist;
}

function AdminMessage( text )
{
	local plr;
	for( local i=0; i<GetPlayers() + 10; i ++ )
	{
		plr = FindPlayer( i );
		if ( plr && plr.Authority > 1 ) plr.Message( "[#ffea00][ADMIN] [#75ff9a]" + text );
	}
}

function MM( text )
{
	local plr;
	for( local i=0; i<GetPlayers() + 10; i ++ )
	{
		plr = FindPlayer( i );
		if ( plr && plr.Authority > 4 ) plr.Message( "[#ff2e62][MANAGER] [#75ff9a]" + text );
	}
}

function random( one, two )
{
	local plrs = GetPlayers();
	if ( plrs%2 != 0 ) return one;
	else return two;
}

function HealAll()
{
	local i = 0, p = GetPlayers() + 10, plr;
	while ( i <= p )
	{
		plr = FindPlayer(i);
		if (plr) plr.Health = 100;
		i++;
	}
}

function GetRankWColor( level )
{
	switch ( level )
	{
		case 0: return "Unregistered Player"; break;
		case 1: return "Player"; break;
		case 2: return "[#ffea00]Referee"; break;
		case 3: return "[#38bd57]Moderator"; break;
		case 4: return "[#ff4a00]Administrator"; break;
		case 5: return "[#1f83ff]Manager"; break;
		case 6: return "[#ff2a7f]Developer"; break;
		default: return "[#ff2a7f]Developer"; break;
	}
}

function GetRank( level )
{
	switch ( level )
	{
		case 0: return "Unregistered Player"; break;
		case 1: return "Player"; break;
		case 2: return "Referee"; break;
		case 3: return "Moderator"; break;
		case 4: return "Administrator"; break;
		case 5: return "Manager"; break;
		case 6: return "Developer"; break;
		default: return "Developer"; break;
	}
}

function SMessage( text )
{
	local i = 0, p = GetPlayers() + 10, plr;
	while ( i <= p )
	{
		plr = FindPlayer(i);
		if (plr) plr.Message( "[#00cc00]-> [#ffb0f3]" + text );
		i++;
	}
}

function EM( player, text )
{
	player.Message( "[#ff0000][Error] " + text );
}

function GetWeatherName( id )
{
	switch( id )
	{
		case 0: return "Partly Cloudy"; break; 
		case 1: return "Overcast Cloudy Skies"; break;
		case 2: return "Lightning"; break;
		case 3: return "Fog with Low Visibility"; break; 
		case 4: return "Clear Skies"; break;
		case 5: return "Rain"; break;
		case 6: return "Darkness from the Eclipse"; break;
		case 7: return "Light sky partly cloudy"; break;
		case 8: return "Overcast partly cloudy"; break;
		case 9: return "Grey sky black clouds"; break;
		case 10: return "Fog And Gray"; break;
		default: return id; break;
	}
}

function playsound( player, id )
{
	if ( player.Data.Sounds == 1 || id == 50028 ) PlaySoundForWorld( player.UniqueWorld, id );
}

function playsoundforall( id )
{
	SqForeach.Player.Active( this, function( player ) 
	{
		if ( player.Data.Sounds == 1 ) 
		{
			PlaySoundForWorld( player.UniqueWorld, id );
			PlaySoundForWorld( player.UniqueWorld, id );
			PlaySoundForWorld( player.UniqueWorld, id );
			PlaySoundForWorld( player.UniqueWorld, id );
			PlaySoundForWorld( player.UniqueWorld, id );
		}
	});
}

function PMessage( player, text )
{
	player.Message( "[#FFFFFF]=> [#ffea00]" + text );
}

function PlayJingles( player )
{
	if ( Handler.Handlers.Gameplay.Status < 3 && player.Data.Jingles == 1 && Handler.Handlers.Script.FestiveCeleb ) 
	{
		playsound( player, random( 50025, 50026 ) ); 
		PMessage( player, "It's the festive season! You can toggle jingles using /jingles, have a merry christmas and a happy new year!" );
	}
}

function Teleport( player, posx, posy, posz )
{
	if ( player.Spawned )
	{
		if( player.Vehicle ) 
		{
			player.Vehicle.Pos = Vector3( -966.268921,-252.156738,369.886597 );
			player.Disembark();
			player.Pos = Vector3( posx, posy, posz );
		}
		else player.Pos = Vector3( posx, posy, posz );
	}
}

function HPAddon( killer )
{
	if( Handler.Handlers.Script.AllowHealthRegen )
	{
		if ( ( Handler.Handlers.Gameplay.Status >= 4 ) && ( killer.Health < 100 ) )
		{ 
			local addHPAlgorithm = killer.Health / 2;
			if ( addHPAlgorithm < 15 ) addHPAlgorithm = 15;
			else if ( ( killer.Health + addHPAlgorithm ) > 100 ) addHPAlgorithm = 100 - killer.Health;

			SqCast.MsgPlr( killer, "KillBonus", addHPAlgorithm );
			
			killer.Health += addHPAlgorithm;
		}
		
		else 
		{
		//	PMessage( killer, "[#FF0000]Kill Bonus: [#ffffff]Score: [#00cc00]+2" );
			
			return 0;
		}
	}
}

function eightball()
{
	local plrs = GetPlayers();
	if ( plrs%2 != 0 ) return true;
	else return false;
}

function Drown( target )
{
	Teleport( target, -597.7496,-1858.9531,28.1291 ), playsound( target, random( 3003, 3015 ) );
	target.SetAnimation( 144 );   
}

function SpawnBanCheck( player )
{
	if ( player.Data.SpawnBan )
	{
		Drown( player );
		
		SqCast.MsgPlr( player, "SpawnBanAlert" );
		return 1;
	}
	else return 0;
}

function SetServerPass()
{
	local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_server;" );
	if ( Handler.Handlers.Script.Password != "" ) 
	{
		SqServer.SetPassword( Handler.Handlers.Script.Password );
		print( "[SERVER] Server is locked with password = " + Handler.Handlers.Script.Password );
	}
	else if ( result.Step() )
	{ 
		local pass = result.GetString("ServPass");
		SqServer.SetPassword( pass );
		print( "[SERVER] Server is locked with password = " + pass );
	}
}

function PlaySoundForTeam ( team, id )
{
	SqForeach.Player.Active( this, function( player ) 
	{
		if ( player.Team == team ) PlaySoundForWorld( player.UniqueWorld, id );
	});
}

function abs( i )
{
  return i < 0 ? -i : i;
}

function Freeze( player )
{
	if( player.Vehicle ) 
	{
		player.Disembark();
	}
	player.SetOption( SqPlayerOption.Controllable, 0 );			
}

function AnnounceAll( text, style )
{
	SqForeach.Player.Active( this, function( player ) 
	{
		player.AnnounceEx( style, text );
	});
}

function getAssignedTeamPlayers( team )
{
	local count = 0;
	SqForeach.Player.Active( this, function( player ) 
	{
		if ( player.Team == team && player.Team == player.Data.AssignedTeam && player.Spawned ) count++; 
	});
	return count;
}

function CheckFreeze( player )
{
	if ( player.Data.Freeze ) Freeze( player );
}

function FixMarkers()
{
    local gameplay = Handler.Handlers.Gameplay;
	if ( gameplay.Status > 2 )
	{
        if( gameplay.TargetVehicle.ID != -1 ) gameplay.TargetVehicle.Destroy();
        if( gameplay.VehicleMarker.ID != -1 ) gameplay.VehicleMarker.Destroy();
        if( gameplay.DefenderMarker.ID != -1 ) gameplay.DefenderMarker.Destroy();
        if( gameplay.vehicleMarker.ID != -1 ) gameplay.vehicleMarker.Destroy();
		
		gameplay.TargetVehicle = SqVehicle.Create( Handler.Handlers.Bases.Bases[ gameplay.Bases ].VehicleModel, 0, Handler.Handlers.Bases.Bases[ gameplay.Bases ].VehiclePos, Handler.Handlers.Bases.Bases[ gameplay.Bases ].VehicleAngle, gameplay.getDefVehicleColor(), gameplay.getDefVehicleColor() );
		gameplay.VehicleMarker = SqBlip.Create( 0, Handler.Handlers.Bases.Bases[ gameplay.Bases ].VehiclePos, 2, Color4( 255, 255, 255, 255 ), gameplay.getSpriteIDBySide() );
		gameplay.DefenderMarker = SqBlip.Create( 0, Handler.Handlers.Bases.Bases[ gameplay.Bases ].SpherePos, 2, Color4( 255, 255, 255, 255 ), 101 );
		
		local tim = SqRoutine( this, function()
		{
			gameplay.vehicleMarker =  SqCheckpoint.Create( 0, true, Handler.Handlers.Bases.Bases[ gameplay.Bases ].SpherePos, gameplay.getAttSphereColor(), 5 );
		}, 100, 1 );	
	}
}

function seconds_to_mmss( seconds )
{
	local t_minutes = floor( seconds / 60 );
	local t_seconds = seconds % 60;
	
	if( t_seconds < 10 ) t_seconds = "0" + t_seconds;
	
	return t_minutes + ":" + t_seconds;
}

function GetSpreeCount()
{
	local count = 0;
	SqForeach.Player.Active( this, function( player ) 
	{
		if ( player.Data.CurrentStats.RoundSpree > 4 ) count++; 
	});
	return count;
}

function GetSprees()
{
	local sprees = "";
	SqForeach.Player.Active( this, function( player )
	{
		if ( player.Data.CurrentStats.RoundSpree > 4 )
		{
			if ( sprees == "" ) sprees += player.Name + "'s kills in a row: " + player.Data.CurrentStats.RoundSpree;
			else sprees += ", " + player.Name + "'s kills in a row: " + player.Data.CurrentStats.RoundSpree;
		}
	});
	if ( sprees == "" ) sprees = "None";
	return sprees;
}