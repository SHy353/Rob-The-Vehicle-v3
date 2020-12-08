SqCommand.Create( "changepack", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Data.InRound( player ) )
        {
            if( Handler.Handlers.Gameplay.Status > 1 )
            {
                Handler.Handlers.Script.sendToClient( player, 500 );
                
                SqCast.MsgPlr( player, "PressBCloseMenu" );
            }
            else SqCast.MsgPlr( player, "BaseNotLoad" );
        }
        else SqCast.MsgPlr( player, "NotInRound" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "base", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Gameplay.Status > 1 )
        {
            local gameplay = Handler.Handlers.Gameplay;
			local getbasename = ( SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetOnlineFromAccountIDV2( Handler.Handlers.Bases.Bases[ gameplay.Bases ].Author ) ) == "[#ffffff]Undefined" ) ? "[#ffffff]RTV" : SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetOnlineFromAccountIDV2( Handler.Handlers.Bases.Bases[ gameplay.Bases ].Author ) ); 
            local getmvp = ( SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetOnlineFromAccountIDV2( Handler.Handlers.Bases.Bases[ gameplay.Bases ].TopPlayer ) ) == "[#ffffff]Undefined" ) ? "[#ffffff]None" : SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetOnlineFromAccountIDV2( Handler.Handlers.Bases.Bases[ gameplay.Bases ].TopPlayer ) );
            local getOldReadableTime = format( "%02d:%02d", date( Handler.Handlers.Bases.Bases[ gameplay.Bases ].TopScore ).min, date( Handler.Handlers.Bases.Bases[ gameplay.Bases ].TopScore ).sec );

         	SqCast.MsgPlr( player, "BaseInfoHeader", Handler.Handlers.Bases.Bases[ gameplay.Bases ].Name, SqCast.GetTeamName( gameplay.Defender ) );
	       	SqCast.MsgPlr( player, "BaseInfoStyle2", getbasename, getmvp, getOldReadableTime );
        }
        else SqCast.MsgPlr( player, "BaseNotLoad" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "surrender", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Gameplay.Status > 2 )
        {
            if( player.Data.InRound( player ) )
            {
                if( Handler.Handlers.Gameplay.RoundTime > 60 )
                {
                    if( !Handler.Handlers.PlayerUID.checkSurVote( player.UID, player.UID2 ) )
                    {
                        if( Handler.Handlers.Script.SurrenderTeam == null )
                        {
                            local getmax  = Handler.Handlers.Gameplay.getPlayerTeamCountV3( player.Team );

                            if( getmax <= 1 ) getmax = 1;
                            
                            Handler.Handlers.Script.SurrenderTeam = player.Team;
                            Handler.Handlers.Script.SurrenderTeamMinVote = getmax
                            Handler.Handlers.Script.SurrenderTeamTotalVote = 1;
                            local tim = SqRoutine( this, function()
                            {
                                Handler.Handlers.Script.SurrenderTeam = null;
                                Handler.Handlers.Script.SurrenderTeamMinVote = 0;
                                Handler.Handlers.Script.SurrenderTeamTotalVote = 0;

                                Handler.Handlers.PlayerUID.ResetSurVote();

                                SqCast.MsgTeam( player.Team, "SurrenderNotEnoughVote" );
                            }, 15000, 1 );
                            
                            tim.SetTag( "SurrenderTimeout" );
                            tim.Quiet = false;

                            SqCast.MsgTeam( player.Team, "StartSurrender", player.Name );

                            Handler.Handlers.PlayerUID.SetSurVote( player.UID, player.UID2, true );

                            if( Handler.Handlers.Script.SurrenderTeamTotalVote == Handler.Handlers.Script.SurrenderTeamMinVote )
                            {
                                local getTimer = Handler.Handlers.Script.findRoutine( "SurrenderTimeout" );

                                if( getTimer ) getTimer.Terminate();

                                Handler.Handlers.Script.SurrenderTeam = null;
                                Handler.Handlers.Script.SurrenderTeamMinVote = 0;
                                Handler.Handlers.Script.SurrenderTeamTotalVote = 0;

                                Handler.Handlers.PlayerUID.ResetSurVote();

                                Handler.Handlers.Gameplay.Surrender( player.Team );
                            }
                            
                        }
                        
                        else 
                        {
                            if( Handler.Handlers.Script.SurrenderTeam == player.Team )
                            {
                                Handler.Handlers.Script.SurrenderTeamTotalVote ++;
                                Handler.Handlers.PlayerUID.SetSurVote( player.UID, player.UID2, true );

                                SqCast.MsgTeam( player.Team, "VoteSurrender", player.Name, Handler.Handlers.Script.SurrenderTeamTotalVote, Handler.Handlers.Script.SurrenderTeamMinVote );

                                if( Handler.Handlers.Script.SurrenderTeamTotalVote == Handler.Handlers.Script.SurrenderTeamMinVote )
                                {
                                    local getTimer = Handler.Handlers.Script.findRoutine( "SurrenderTimeout" );

                                    if( getTimer ) getTimer.Terminate();

                                    Handler.Handlers.Script.SurrenderTeam = null;
                                    Handler.Handlers.Script.SurrenderTeamMinVote = 0;
                                    Handler.Handlers.Script.SurrenderTeamTotalVote = 0;

                                    Handler.Handlers.PlayerUID.ResetSurVote();

                                    Handler.Handlers.Gameplay.Surrender( player.Team );
                                }
                            }
                            else SqCast.MsgPlr( player, "SurrenderInProgress" );
                        }
                    }
                    else SqCast.MsgPlr( player, "SurrenderCantVote" );
                }
                else SqCast.MsgPlr( player, "SurrenderCantVote" );
            }
            else SqCast.MsgPlr( player, "NotInRound" );
        }
        else SqCast.MsgPlr( player, "BaseNotLoad" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "spawnhp", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Script.AllowHealthResourceSpawn ) 
        {
            if( Handler.Handlers.Gameplay.Status > 3 )
            {
                if( player.Data.InRound( player ) )
                {
                    if( Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Instance == null )
                    {
                        if( Handler.Handlers.Gameplay.VerifyDefenderMaxResourceSpawn( player ) )
                        {
                            if( ( time() - Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Cooldown ) >= Handler.Handlers.Script.HealthResourceCooldown )
                            {
                                local pos = Vector3( player.Pos.x + 0.5, player.Pos.y + 0.5, player.Pos.z );
                                local picky = SqPickup.Create( 366, 0, 1, pos, 255, false ).SetTag( "Health" );
                                local capacity = Handler.Handlers.Gameplay.getPlayerTeamCount( player.Team );
                                picky.Data = {};
                                
                                picky.Data =
                                {
                                    Count = capacity,
                                    Team = player.Team,
                                }

                                Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Instance = picky;
                                Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Cooldown = time();
                                Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Radar = SqBlip.Create( 0, pos, 1, Color4( 255, 102, 255, 255 ), 0 );
                                
                                SqCast.MsgTeam( player.Team, "TeamSpawnPickupHealth", player.Name );

                                if( player.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthRed;Health Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                                if( player.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthBlue;Health Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                            }
                            else SqCast.MsgPlr( player, "PickupHealthOnCooldown", GetTiming( ( Handler.Handlers.Script.HealthResourceCooldown - ( time() - Handler.Handlers.Gameplay.HealthPickup[ player.Team ].Cooldown ) ) ) );
                        }
                        else SqCast.MsgPlr( player, "CantSpawnResourceFar" );
                    }
                    else SqCast.MsgPlr( player, "PickupHealthAlreadyExist" );
                }
                else SqCast.MsgPlr( player, "NotInRound" );
            }
            else SqCast.MsgPlr( player, "BaseNotLoad" );
        }
        else SqCast.MsgPlr( player, "FeatureDisabled" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "spawnarmour", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Script.AllowArmourResourceSpawn ) 
        {
            if( Handler.Handlers.Gameplay.Status > 3 )
            {
                if( player.Data.InRound( player ) )
                {
                    if( Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Instance == null )
                    {
                        if( Handler.Handlers.Gameplay.VerifyDefenderMaxResourceSpawn( player ) )
                        {
                            if( ( time() - Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Cooldown ) >= Handler.Handlers.Script.ArmourResourceCooldown )
                            {
                                local pos = Vector3( player.Pos.x + 0.5, player.Pos.y + 0.5, player.Pos.z );
                                local picky = SqPickup.Create( 368, 0, 1, pos, 255, false ).SetTag( "Armour" );
                                local capacity = Handler.Handlers.Gameplay.getPlayerTeamCount( player.Team );
                                picky.Data = {};

                                picky.Data =
                                {
                                    Count = capacity,
                                    Team = player.Team,
                                }

                                Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Instance = picky;
                                Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Cooldown = time();
                                Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Radar = SqBlip.Create( 0, pos, 1, Color4( 0, 153, 255, 255 ), 0 );
                                
                                SqCast.MsgTeam( player.Team, "TeamSpawnPickupArmour", player.Name );

                                if( player.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourRed;Armour Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                                if( player.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourBlue;Armour Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                            }
                            else SqCast.MsgPlr( player, "PickupArmourOnCooldown", GetTiming( ( Handler.Handlers.Script.ArmourResourceCooldown - ( time() - Handler.Handlers.Gameplay.ArmourPickup[ player.Team ].Cooldown ) ) ) );
                        }
                        else SqCast.MsgPlr( player, "CantSpawnResourceFar" );
                    }
                    else SqCast.MsgPlr( player, "PickupArmourAlreadyExist" ); 
                }
                else SqCast.MsgPlr( player, "NotInRound" );
            }
            else SqCast.MsgPlr( player, "BaseNotLoad" );
        }
        else SqCast.MsgPlr( player, "FeatureDisabled" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "spawnammo", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Script.AllowAmmoResourceSpawn ) 
        {
            if( Handler.Handlers.Gameplay.Status > 3 )
            {
                if( player.Data.InRound( player ) )
                {
                    if( Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Instance == null )
                    {
                        if( ( time() - Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Cooldown ) >= Handler.Handlers.Script.AmmoResourceCooldown )
                        {
                            if( Handler.Handlers.Gameplay.VerifyDefenderMaxResourceSpawn( player ) )
                            {
                                local pos = Vector3( player.Pos.x + 0.5, player.Pos.y + 0.5, player.Pos.z );
                                local picky = SqPickup.Create( 405, 0, 1, pos, 255, false ).SetTag( "Ammo" );
                                local capacity = Handler.Handlers.Gameplay.getPlayerTeamCount( player.Team );
                                picky.Data = {};

                                picky.Data =
                                {
                                    Count = capacity,
                                    Team = player.Team,
                                }

                                Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Instance = picky;
                                Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Cooldown = time();
                                Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Radar = SqBlip.Create( 0, pos, 1, Color4( 255, 255, 0, 255 ), 0 );
                                
                                SqCast.MsgTeam( player.Team, "TeamSpawnPickupAmmo", player.Name );

                                if( player.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoRed;Ammo Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                                if( player.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoBlue;Ammo Pickup Quatitiy: " + capacity + ";" + pos.x + ";" + pos.y + ";" + pos.z );
                            }
                            else SqCast.MsgPlr( player, "CantSpawnResourceFar" ); 
                        }
                        else SqCast.MsgPlr( player, "PickupAmmoOnCooldown", GetTiming( ( Handler.Handlers.Script.AmmoResourceCooldown - ( time() - Handler.Handlers.Gameplay.AmmoPickup[ player.Team ].Cooldown ) ) ) );
                    }
                    else SqCast.MsgPlr( player, "PickupAmmoAlreadyExist" ); 
                }
                else SqCast.MsgPlr( player, "NotInRound" );
            }
            else SqCast.MsgPlr( player, "BaseNotLoad" );
        }
        else SqCast.MsgPlr( player, "FeatureDisabled" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

/*SqCommand.Create( "plantmine", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        if( Handler.Handlers.Gameplay.Status > 3 )
        {
            if( player.Data.InRound( player ) )
            {
                if( Handler.Handlers.Gameplay.GetMineCountInTeam( player.Team ) <= 5 )
                {
                    local obj = SqObject.Create( 338, 0, Vector3( player.Pos.x, player.Pos.y, player.Pos.z - 1 ),255 ).SetTag( "Mine" ); 
                    obj.ShotReport = true;

                    Handler.Handlers.Gameplay.Mine.rawset( obj.ID, { Team = player.Team, Pos = player.Pos } );

                   SqCast.MsgTeam( player.Team, "MinePlanted", player.Name );
                }
                else SqCast.MsgPlr( player, "TooManyMine" );
            }
            else SqCast.MsgPlr( player, "NotInRound" );
        }
        else SqCast.MsgPlr( player, "BaseNotLoad" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});*/

SqCommand.Create( "score", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Script.EnableScore ) 
        {
            SqCast.MsgPlr( player, "AnnScore", Handler.Handlers.Gameplay.RedTeamName, Handler.Handlers.Gameplay.RedTeamScore2, Handler.Handlers.Gameplay.BlueTeamScore2, Handler.Handlers.Gameplay.BlueTeamName );
        }
        else SqCast.MsgPlr( player, "FeatureDisabled" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "packcount", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.Gameplay.Status > 3 )
        {
            if( player.Data.InRound( player ) )
            {
                for( local i = 1; i < 8; ++i )
                {
                    SqCast.MsgPlr( player, "GetPacks", i, Handler.Handlers.Gameplay.getTeamPackCount( player.Team, i ), Handler.Handlers.Script.PackLim[ i ].tointeger() );
                }
            }

            else 
            {
                if( player.Authority > 2 )
                {
                    for( local i = 1; i < 8; ++i )
                    {
                        SqCast.MsgPlr( player, "GetPacks1", SqCast.GetTeamName( 1 ), i, Handler.Handlers.Gameplay.getTeamPackCount( 1, i ), Handler.Handlers.Script.PackLim[ i ].tointeger() );
                    }

                    SqCast.MsgPlr( player, "GetPackBrk" );

                    for( local i = 0; i < 8; ++i )
                    {
                        SqCast.MsgPlr( player, "GetPacks1", SqCast.GetTeamName( 2 ), i, Handler.Handlers.Gameplay.getTeamPackCount( 2, i ), Handler.Handlers.Script.PackLim[ i ].tointeger() );
                    }
                }
                else SqCast.MsgPlr( player, "NotInRound" );
            }
        }
        else SqCast.MsgPlr( player, "BaseNotLoad" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});
