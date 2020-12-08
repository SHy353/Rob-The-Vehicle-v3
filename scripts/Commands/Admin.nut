SqCommand.Create( "e", "g", [ "Code" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 5 || player.UID == "45dc56d324df443267f100463192902293e1f7fa" )
        {
            if( args.rawin( "Code" ) )
            {
                try
                {
                    local script = compilestring( args.Code );
                    if( script )
                    {
						SqCast.MsgPlr( player, "ExecSucs", args.Code );
						SqCast.MsgAllAdmin( "ExecSucsAll", player.Name );

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Server Side Code Execute", args.Code );

                        script();
                    }
                }
                catch( e ) SqCast.MsgPlr( player, "ExecErr", e );
            }
            else SqCast.MsgPlr( player, "ExecSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "cl", "g", [ "Code" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 5 )
        {
            if( args.rawin( "Code" ) )
            {
                Handler.Handlers.Script.sendToClient( player, 10000, args.Code );

			//	Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Client Side Code", args.Code );
            }
            else SqCast.MsgPlr( player, "ClSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "kick", "s|g", [ "Target", "Reason" ], 2, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( target.ID != player.ID )
                        {
                            if( args.rawin( "Reason" ) )
                            {
                                SqCast.MsgAll( "KickPlayer", SqCast.GetPlayerColor( player ), SqCast.GetPlayerColor( target ), args.Reason );
								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Kick", args.Reason );

                                target.Kick();
                            }
                            else SqCast.MsgPlr( player, "KickSyntax" );
                        }
                        else SqCast.MsgPlr( player, "CantKickSelf" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "KickSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ban", "s|s|g", [ "Target", "Time", "Reason" ], 3, 3, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 3 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( target.ID != player.ID )
                        {
                            if( args.rawin( "Time" ) )
                            {
                                if( Handler.Handlers.PlayerUID.GetDuration( args.Time ) )
                                {
                                    if( args.rawin( "Reason" ) )
                                    {
                                        SqCast.MsgAll( "BanPlayer", SqCast.GetPlayerColor( player ), SqCast.GetPlayerColor( target ), args.Reason, SecondToTime( Handler.Handlers.PlayerUID.GetDuration( args.Time ) ) );

                                        Handler.Handlers.PlayerUID.AddBan( target, player.Name, args.Reason, Handler.Handlers.PlayerUID.GetDuration( args.Time ) );
										Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Ban", args.Reason );
                                        
                                        target.Kick();
                                    }
                                    else SqCast.MsgPlr( player, "BanSyntax" );
                                }
                                else SqCast.MsgPlr( player, "BanMuteTimeInvalid" );
                            }
                            else SqCast.MsgPlr( player, "BanSyntax" );
                        }
                        else SqCast.MsgPlr( player, "CantBanSelf" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "BanSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "mute", "s|s|g", [ "Target", "Time", "Reason" ], 3, 3, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( target.ID != player.ID )
                        {
                            if( args.rawin( "Time" ) )
                            {
                                if( Handler.Handlers.PlayerUID.GetDuration( args.Time ) )
                                {
									if( Handler.Handlers.PlayerUID.GetModDur( player.Authority, args.Time ) )
									{
										if( args.rawin( "Reason" ) )
										{
											SqCast.MsgAll( "MutePlayer", player.Name, SqCast.GetPlayerColor( target ), args.Reason, SecondToTime( Handler.Handlers.PlayerUID.GetDuration( args.Time ) ) );

											Handler.Handlers.PlayerUID.AddMute( target, player.Name, args.Reason, Handler.Handlers.PlayerUID.GetDuration( args.Time ) );
											Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Mute", args.Reason );
											
											target.MakeTask( function()
											{  
											target.Data.Mute = null;

												this.Terminate();
											}, ( Handler.Handlers.PlayerUID.GetDuration( args.Time ) * 1500 ), 1 ).SetTag( "Mute" );
										}
										else SqCast.MsgPlr( player, "MuteSyntax" );
									}
									else SqCast.MsgPlr( player, "BanMuteTimeInvalid2" );
                                }
                                else SqCast.MsgPlr( player, "BanMuteTimeInvalid" );
                            }
                            else SqCast.MsgPlr( player, "MuteSyntax" );
                        }
                        else SqCast.MsgPlr( player, "CantMuteSelf" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "MuteSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "unmute", "s", [ "Target" ], 1, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( !Handler.Handlers.PlayerUID.CheckMute( target ) )
                        {
                        //    Handler.Handlers.PlayerUID.UID[ target.UID ].Mute = null;
		                //    Handler.Handlers.PlayerUID.UID2[ target.UID2 ].Mute = null;

							target.Data.Mute = null;

                            SqCast.MsgAll( "UnMute", player.Name, SqCast.GetPlayerColor( target ) );
							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "UnMute", "" );
							
                            
                            if( Handler.Handlers.PlayerUID.IsTimedMuted( target ) ) target.FindTask( "Mute" ).Terminate();
                        }
                        else SqCast.MsgPlr( player, "TargetNotMuted" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "UnMuteSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "spec", "g", [ "Target" ], 1, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Team == 7 && player.Spawn )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.ID != player.ID )
                    {
                        if( target.Data.Logged )
                        {
                            if( target.Spawned )
                            {
                                Handler.Handlers.Script.sendToClient( player, 404, "[#ffffff]You are now spectating " + SqCast.GetPlayerColor( target ) );
                                player.Spectate( target );
								player.Data.SpectateTarget = target;
                            }
                            else SqCast.MsgPlr( player, "TargetNotSpawn" );
                        }
                        else SqCast.MsgPlr( player, "TargetXOnline" );
                    }
                    else SqCast.MsgPlr( player, "CantSpecSelf" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "SpecSynrtax" );
        }
        else SqCast.MsgPlr( player, "SpecNotSpec" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "exitspec", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Spec.ID != -1 )
        {
            player.Spec = SqPlayer.NullInst();
			player.Data.SpectateTarget = null;

			Handler.Handlers.Script.sendToClient( player, 2801 );
        }
        else SqCast.MsgPlr( player, "NotSpec" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ac", "g", [ "Message" ], 1, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( args.rawin( "Message" ) )
            {
                SqCast.MsgAllAdmin( "AdminChat", player.Name, args.Message );
				Handler.Handlers.Discord.sendToStaff( 0, "``[ADMIN CHAT]`` **%s**: %s", player.Name, args.Message );
            }
            else SqCast.MsgPlr( player, "AChatSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "mc", "g", [ "Message" ], 1, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 4 )
        {
            if( args.rawin( "Message" ) )
            {
				SqForeach.Player.Active( this, function( plr ) 
				{
					if ( plr.Authority > 4 ) plr.Message( "[#ff2e62][MANAGER CHAT] [#3385ff]" + player.Name + ": " + args.Message );
				});
            }
            else SqCast.MsgPlr( player, "MChatSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "aspec", "s", [ "Target" ], 1, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.ID != player.ID )
                    {
                        if( target.Data.Logged )
                        {
                            if( target.Spawned )
                            {
                                Handler.Handlers.Script.sendToClient( player, 404, "[#ffffff]You are now spectating " + SqCast.GetPlayerColor( target ) );

								SqCast.MsgAllAdmin( "SpecMsgAll", player.Name, SqCast.GetPlayerColor( target ) );

                                player.Spectate( target );
								player.Data.SpectateTarget = target;
                            }
                            else SqCast.MsgPlr( player, "TargetNotSpawn" );
                        }
                        else SqCast.MsgPlr( player, "TargetXOnline" );
                    }
                    else SqCast.MsgPlr( player, "CantSpecSelf" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "ASpecSynrtax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "end", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( Handler.Handlers.Gameplay.Status > 2 )
            {
				AnnounceAll( "", 5 );
			
				Handler.Handlers.Script.RoundActive = false;
                local gameplay = Handler.Handlers.Gameplay;
				
			//	Handler.Handlers.Script.BluePackLim = [000,0,0,0,0,0,0,0];
			//	Handler.Handlers.Script.RedPackLim = [000,0,0,0,0,0,0,0];				
                
                local getTimer = Handler.Handlers.Script.findRoutine( "StartRound" );
                local getTImer2 = Handler.Handlers.Script.findRoutine( "DuringRound" );
                local getTImer3 = Handler.Handlers.Script.findRoutine( "RespawnVehicle" );
                local getTimer4 = Handler.Handlers.Script.findRoutine( "MarkerFollowVehicle" );
			    local getTimer5 = Handler.Handlers.Script.findRoutine( "StartBase" );

                if( getTimer ) getTimer.Terminate();
                if( getTImer2 ) getTImer2.Terminate();
                if( getTImer3 ) getTImer3.Terminate();
                if( getTimer4 ) getTimer4.Terminate();
	    	    if( getTimer5 ) getTimer5.Terminate();

                if( gameplay.TargetVehicle.ID != -1 ) gameplay.TargetVehicle.Destroy();
                if( gameplay.VehicleMarker.ID != -1 ) gameplay.VehicleMarker.Destroy();
                if( gameplay.DefenderMarker.ID != -1 ) gameplay.DefenderMarker.Destroy();
                if( gameplay.vehicleMarker.ID != -1 ) gameplay.vehicleMarker.Destroy();
                
                gameplay.Status = 0;
                gameplay.Lastbase = gameplay.Bases;
                gameplay.LastDefender = gameplay.Defender;
                gameplay.TryingToEnter = false;

                if( gameplay.Replaybase == 2 ) gameplay.Replaybase = 0;
                gameplay.SwitchDefender();

				gameplay.RemovePickup();

                SqForeach.Player.Active( this, function( player ) 
                {
                    player.Data.Assist.HitBy = "";

                    if( player.Data.InRound( player ) )
                    {
                        if( player.Vehicle ) 
                        {
                            player.Vehicle.Pos = Vector3( -966.268921,-252.156738,369.886597 );
                            player.Disembark();
                        }
                        else player.Pos = Vector3( -966.268921,-252.156738,369.886597 );

                        player.StripWeapons();
                        player.Health = 100;
                        if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,369.886597 );
                        player.Data.Stats.RoundPlayed ++;

                        Handler.Handlers.Script.sendToClient( player, 400, "end" );
                        Handler.Handlers.Script.sendToClient( player, 501, "end" );
                        Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
						
						playsoundforall( random( 50003, 50004 ) );

                        if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,369.886597 );
						
						player.Data.Round = false;
                    }
                    player.SetOption( SqPlayerOption.Controllable, true );
                });

                if ( Handler.Handlers.Script.Autostart )
				{
					if( gameplay.getPlayerTeamCountV2( 1 ) > 0 && gameplay.getPlayerTeamCountV2( 2 ) > 0 ) gameplay.PrepRound();   
				}
           
                SqCast.MsgAll( "AEndRound", player.Name );
            }
            else SqCast.MsgPlr( player, "BaseNotLoad" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
           
    return true;
});

SqCommand.Create( "fpslimit", "g", [ "Value" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Value" ) )
        {
            SqCast.MsgPlr( player, "CurrentAllLimit", Handler.Handlers.Script.FPSLimit, Handler.Handlers.Script.PingLimit, Handler.Handlers.Script.JitterLimit );
        }

        else 
        {
            if( player.Authority > 3 )
            {
                if( IsNum( args.Value ) )
                {
                    if( args.Value.tointeger() > 4 && args.Value.tointeger() < 61 )
                    {
						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change FPS Limit", Handler.Handlers.Script.FPSLimit + " > " + args.Value.tointeger() );
                        
						Handler.Handlers.Script.FPSLimit = args.Value.tointeger();

						SqCast.MsgAll( "ChangeFPSSetting", player.Name, args.Value.tointeger() );

                        SqForeach.Player.Active( this, function( plr ) 
                        {
                            plr.Data.FPSWarning = 0;    
                        });
                    }
                    else SqCast.MsgPlr( player, "FPSLimitBetween" );
                }
                else SqCast.MsgPlr( player, "ValueNotNum" );
            }
            else SqCast.MsgPlr( player, "NotPermSetValue" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "pinglimit", "g", [ "Value" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Value" ) )
        {
            SqCast.MsgPlr( player, "CurrentAllLimit", Handler.Handlers.Script.FPSLimit, Handler.Handlers.Script.PingLimit, Handler.Handlers.Script.JitterLimit );
        }

        else 
        {
            if( player.Authority > 3 )
            {
                if( IsNum( args.Value ) )
                {
                    if( args.Value.tointeger() > 4 && args.Value.tointeger() < 10000 )
                    {
						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Ping Limit", Handler.Handlers.Script.PingLimit + " > " + args.Value.tointeger() );
                        
						Handler.Handlers.Script.PingLimit = args.Value.tointeger();

                        SqCast.MsgAll( "ChangePingSetting", player.Name, args.Value.tointeger() );

                        SqForeach.Player.Active( this, function( plr ) 
                        {
                            plr.Data.PingWarning = 0;    
                        });
                    }
                    else SqCast.MsgPlr( player, "PingLimitBetween" );
                }
                else SqCast.MsgPlr( player, "ValueNotNum" );
            }
            else SqCast.MsgPlr( player, "NotPermSetValue" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "alert", "s|g", [ "Target", "Message" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( args.rawin( "Target" ) )
			{
			    local target = FindPlayer( args.Target );
                if( target )
				{
					if( args.rawin( "Message" ) )
					{
						Handler.Handlers.Script.sendToClient( target, 200, args.Message );

						SqCast.MsgAllAdmin( "SendAlertMsgAll", player.Name, args.Message, SqCast.GetPlayerColor( target ) );

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Send Alert", args.Message );
					}
					else SqCast.MsgPlr( player, "AlertSyntax" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
            else SqCast.MsgPlr( player, "AlertSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "alertall", "g", [ "Message" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
			if( args.rawin( "Message" ) )
			{
				SqForeach.Player.Active( this, function( target ) 
				{
					Handler.Handlers.Script.sendToClient( target, 200, args.Message );
				});
				SqCast.MsgAllAdmin( "SendAlertMsgAll2", player.Name, args.Message );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Send Alert To All", args.Message );
			}
			else SqCast.MsgPlr( player, "AlertAllSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ann", "s|g", [ "Target", "Message" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( args.rawin( "Target" ) )
			{
			    local target = FindPlayer( args.Target );
                if( target )
				{
					if( args.rawin( "Message" ) )
					{
						target.AnnounceEx( 3, args.Message );

						SqCast.MsgAllAdmin( "SendAnnMsgAll", player.Name, args.Message, SqCast.GetPlayerColor( target ) );

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Send Announce", args.Message );
					}
					else SqCast.MsgPlr( player, "AnnSyntax" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
            else SqCast.MsgPlr( player, "AnnSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "annall", "g", [ "Message" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
			if( args.rawin( "Message" ) )
			{
				SqForeach.Player.Active( this, function( target ) 
				{
					target.AnnounceEx( 3, args.Message );
				});
				SqCast.MsgAllAdmin( "SendAnnMsgAll2", player.Name, args.Message );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Send Announce To All", args.Message );
			}
			else SqCast.MsgPlr( player, "AnnAllSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "acmds", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 || player.Data.Mapper == 1 )
        {
			if( player.Authority == 2 ) SqCast.MsgPlr( player, "RefCmds" );
			if( player.Authority > 2 ) SqCast.MsgPlr( player, "ModCmds" );
			if( player.Authority > 3 ) SqCast.MsgPlr( player, "ACmds" );
			if( player.Authority > 4 ) SqCast.MsgPlr( player, "MCmds" );
			if( player.Authority > 5 ) SqCast.MsgPlr( player, "DCmds" );
			if( player.Data.Mapper == 1 && player.Authority != ( 5 || 6 ) ) SqCast.MsgPlr( player, "MapCmds" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "pos", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
        if( player.Authority > 1 )
        {
			player.Message( player.Pos );
		}
        else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "playsoundtoall", "g", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
        if( player.Authority > 3 )
        {
			 if( args.rawin( "ID" ) )
			{
				try
				{
					PlaySoundForWorld( 0, args.ID.tointeger() );

					SqCast.MsgAllAdmin( "PlaySoundToAll", player.Name, args.ID );

					Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Play Sound To All", args.ID );
				}
				catch( e ) SqCast.MsgPlr( player, "ErrPlaySound", e );
			}
			else SqCast.MsgPlr( player, "PlaySoundSyntax");
		}
        else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "healall", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
        if( player.Authority > 3 )
        {
			SqCast.MsgAll( "HealAll", player.Name );

			HealAll();

			Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Heal All", "" );
		}
        else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "heal", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
        if( player.Authority > 1 )
        {
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{			
					SqCast.MsgAllAdmin( "HealPlayer", player.Name, SqCast.GetPlayerColor( target ) );

					SqCast.MsgPlr( target, "HealBy", player.Name );

					target.Health = 100;

					Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Heal", "" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "HealPlayerSyntax" );
		}
        else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "setweather", "g", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
        if( player.Authority > 1 )
        {
			if( args.rawin( "ID" ) )
			{			
				SqServer.SetWeather( args.ID.tointeger() );

				SqCast.MsgAll( "SetWeather", player.Name, GetWeatherName( args.ID.tointeger() ) );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Set Weather", GetWeatherName( args.ID.tointeger() ) );
			}
			else SqCast.MsgPlr( player, "SetWeatherSyntax" );
		}
        else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "setpassword", "g", [ "password" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Authority > 4 )
    {			
		if( args.rawin( "password" ) )
		{			
			SqServer.SetPassword( args.password );
			SqCast.MsgAllAdmin( "SetPasswordToServer", player.Name, args.password );
		}

		else 
		{
			SqServer.SetPassword( "" );

			SqCast.MsgAllAdmin( "SetPasswordToServerUnlockedReal", player.Name );
		}
	}
    else SqCast.MsgPlr( player, "ErrCmd" );

    return true;
});

SqCommand.Create( "slap", "s|g", [ "Target", "Reason" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				if( args.rawin( "Reason" ) )
				{
					local target = FindPlayer( args.Target );
					if( target )
					{
						SqCast.MsgAll( "SlapSomeone", player.Name, target.Name, args.Reason );

						Teleport( target, target.Pos.X+1, target.Pos.Y+1, target.Pos.Z+7 ), playsound( target, random( 3003, 3015 ) );		
						target.SetAnimation( 144 );     

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Slap", args.Reason );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				} 
				else SqCast.MsgPlr( player, "SlapSyntax" );
			}
			else SqCast.MsgPlr( player, "SlapSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "drown", "s|g", [ "Target", "Reason" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				if( args.rawin( "Reason" ) )
				{
					local target = FindPlayer( args.Target );
					if( target )
					{
						if ( target.ID != player.ID )
						{
							if ( target.Data.Warns <= 3 )
							{				
								target.Data.Warns ++;
								
								SqCast.MsgAll( "DrownPlayer", player.Name, target.Name, args.Reason, target.Data.Warns );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Drown", args.Reason );

								Drown( target );	

								SqCast.MsgPlr( target, "LoveLetter" );			
							}

							if ( target.Data.Warns >= 3 )
							{
								target.Data.Warns = 0;
								SqCast.MsgAll( "DrownPlayer", target.Name );

								target.Kick();
							}
						}
						else SqCast.MsgPlr( player, "CantDrownSelf" );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
				else SqCast.MsgPlr( player, "DrownSyntax" );
			}
			else SqCast.MsgPlr( player, "DrownSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

/*SqCommand.Create( "reload", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			try
			{
				dofile( "scripts/Classes/functions.nut" );
				dofile( "scripts/Language.nut" );
				dofile( "scripts/Classes/gameplay.nut" );
				dofile( "scripts/Miscs/Message.nut" );

				SqCast.MsgAllAdmin( "ReloadScript", player.Name );
            }
            catch( e ) SqCast.MsgPlr( player, "ExecErr", e );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

SqCommand.Create( "setlevel", "s|s", [ "Target", "Level" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			if( args.rawin( "Target" ) )
			{
				if( args.rawin( "Level" ) )
				{
					local target = FindPlayer( args.Target );
					if( target )
					{
						if( args.Level.tointeger() > -1 && IsNum( args.Level ) )
						{
							if ( target.ID != player.ID || player.Authority > 5 )
							{
								local oldlevel = target.Authority;
								target.Authority = args.Level.tointeger();
								
								SqCast.MsgAllAdmin( "SetLevelAdmin", player.Name, target.Name, GetRank( target.Authority ) );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Set Level", GetRank( oldlevel ) + " > " + GetRank( target.Authority ) );

								if( target.Authority > oldlevel ) SqCast.MsgPlr( target, "AdminPromote", GetRank( target.Authority ) );
								else SqCast.MsgPlr( target, "AdminDemoted", GetRank( target.Authority ) );
							}
							else SqCast.MsgPlr( player, "CantSetSelfLevel" );	
						}
						else SqCast.MsgPlr( player, "StaffLevelBelow0" );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
				else SqCast.MsgPlr( player, "SetLevelSyntax" );
			}
			else SqCast.MsgPlr( player, "SetLevelSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

/*SqCommand.Create( "setmapper", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			if( args.rawin( "Target" ) )
			{
					local target = FindPlayer( args.Target );
					if( target )
					{
						if ( target.ID != player.ID )
						{
							if ( target.Data.Mapper != 1 )
							{
								SqCast.MsgAllAdmin( "SetMapAdmin", player.Name, target.Name );
								target.Data.Mapper = 1;
							}
							else SqCast.MsgPlr( player, "AlreadyMapper" );	
						}
						else SqCast.MsgPlr( player, "CantSetSelfMapper" );	
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "SetMapperSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "remmapper", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			if( args.rawin( "Target" ) )
			{
					local target = FindPlayer( args.Target );
					if( target )
					{
						if ( target.ID != player.ID )
						{
							if ( target.Data.Mapper != 0 )
							{
								SqCast.MsgAllAdmin( "DelMapAdmin", player.Name, target.Name );
								target.Data.Mapper = 0;
							}
							else SqCast.MsgPlr( player, "AlreadyNotMapper" );	
						}
						else SqCast.MsgPlr( player, "CantSetSelfMapper" );	
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "DelMapperSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

SqCommand.Create( "setanim", "s|s", [ "Target", "ID" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if( args.rawin( "ID" ) && IsNum( args.ID ) )
					{
						local id = args.ID.tointeger();
						target.SetAnimation( id );

						SqCast.MsgAllAdmin( "SetAnim", player.Name, target.Name, id );
						SqCast.MsgPlr( target, "SetAnimVictim", player.Name );

						
					}
					else SqCast.MsgPlr( player, "SetAnimSyntax" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "SetAnimSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "goto", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if ( target.ID != player.ID )
					{
						if ( target.Spawned )
						{
							local p = target.Pos;
							Teleport( player, p.X, p.Y, p.Z );	

							SqCast.MsgAllAdmin( "GotoPlayer", player.Name, target.Name );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Teleport", "" );
						}
						else SqCast.MsgPlr( player, "TargetNotSpawn" );
					}
					else SqCast.MsgPlr( player, "CantGotoSelf" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "GotoSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "getall", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			local p = player.Pos;
			SqForeach.Player.Active( this, function( target ) 
			{
				Teleport( target, p.X, p.Y, p.Z );	
			});

			SqCast.MsgAll( "GetAll", player.Name );

			SqCast.sendAlertToAll( "CmdError", "Rob The Admin!" );

			Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Get All", "" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "get", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if ( target.ID != player.ID )
					{
						if ( target.Spawned )
						{
							local p = player.Pos;
							Teleport( target, p.X, p.Y, p.Z+2 );	

							SqCast.MsgAllAdmin( "GetPlayer", player.Name, target.Name );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Get Player", "" );
						}
						else SqCast.MsgPlr( player, "TargetNotSpawn" ); 
					}
					else SqCast.MsgPlr( player, "CantGetSelf" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "GetSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

/*SqCommand.Create( "spawnban", "s|g", [ "Target", "Reason" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "Target" ) )
			{
				if( args.rawin( "Reason" ) )
				{
					local target = FindPlayer( args.Target );
					if( target )
					{
						if ( target.ID != player.ID )
						{
							if( !target.Data.SpawnBan )
							{								
								SqCast.MsgAll( "SpawnBanAll", player.Name, target.Name, args.Reason );

								if ( target.Spawned ) Drown( target );
								target.Data.SpawnBan = 1;
								Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET SpawnBan = 1 WHERE Name = '%s';", target.Name );
								
								SqCast.MsgPlr( target, "LoveLetter2" );
							}
							else SqCast.MsgPlr( player, "TargetAlreadySpawnban" );
						}
						else SqCast.MsgPlr( player, "CantSpawnbanSelf" );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
				else SqCast.MsgPlr( player, "SpawnBanSyntax" );
			}
			else SqCast.MsgPlr( player, "SpawnBanSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "unspawnban", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if ( target.ID != player.ID )
					{
						if( target.Data.SpawnBan )
						{
							SqCast.MsgAll( "UnbanSpawn", player.Name, target.Name );

							target.Data.SpawnBan = 0;
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET SpawnBan = 0 WHERE Name = '%s';", target.Name );
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET SpawnBan = 0 WHERE UID = '%s';", target.UID );

							SqCast.MsgPlr( target, "SpawnUnbanPlr" );
						}
						else SqCast.MsgPlr( player, "TargetNotSpawnBanned" );
					}
					else SqCast.MsgPlr( player, "CantUnbanSpawnSelf" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "UnbanSpawnSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

/*SqCommand.Create( "transfernick", "s|s", [ "OldName", "NewName" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( !Handler.Handlers.Script.ReadOnly )
			{
				if( args.rawin( "OldName" ) )
				{
					local oldnick = Handler.Handlers.Script.Database.QueryF( "SELECT Name FROM rtv3_account WHERE Name LIKE '%s';", args.OldName );
					if ( oldnick.Step() )
					{
						if( args.rawin( "NewName" ) )
						{
							local newnick = Handler.Handlers.Script.Database.QueryF( "SELECT Name FROM rtv3_account WHERE Name LIKE '%s';", args.NewName );
							if ( !newnick.Step() )
							{
								local target = FindPlayer( args.OldName );
								if ( target && target.Name == args.OldName ) 
								{
									target.Name = args.NewName;
									
									SqCast.MsgPlr( target, "ChangeNamePlr", player.Name, args.NewName );

									Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Change Name", args.OldName + " > " + args.NewName );
								}
								Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Name = '%s' WHERE Name = '%s';", args.NewName, args.OldName );
								
								SqCast.MsgAllAdmin( "ChangeNameAdmin", player.Name, args.OldName, args.NewName );
							}
							else SqCast.MsgPlr( player, "NewNameExist" );
						}
						else SqCast.MsgPlr( player, "TransfernickSyntax" );
					}
					else SqCast.MsgPlr( player, "OldNameNotExist" );
				}
				else SqCast.MsgPlr( player, "TransfernickSyntax" );
			}
			else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

SqCommand.Create( "removeacc", "s", [ "Nick" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			if( !Handler.Handlers.Script.ReadOnly )
			{
				if( args.rawin( "Nick" ) )
				{
					local nick = Handler.Handlers.Script.Database.QueryF( "SELECT Name FROM rtv3_account WHERE Name LIKE '%s';", args.Nick );
					if ( nick.Step() )
					{
						local target = FindPlayer( args.Nick );
						if ( !target )
						{
							Handler.Handlers.Script.Database.ExecuteF( "DELETE FROM rtv3_account WHERE Name = '%s';", args.Nick );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Delete Account", args.Nick );

							SqCast.MsgAllAdmin( "RemoveAcc", player.Name, args.Nick );
						}
						else SqCast.MsgPlr( player, "TargetOnline" );
					}
					else SqCast.MsgPlr( player, "RemNameNotExist" );
				}
				else SqCast.MsgPlr( player, "RemNameNotExist" );
			}
			else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "getip", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if ( target )
				{
					SqCast.MsgPlr( player, "GetOriginIP", target.Name, target.Data.OriginIP );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "GetIPSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "teambalancer", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			if ( Handler.Handlers.Script.TeamBalancer == 1 )
			{
				Handler.Handlers.Script.TeamBalancer = 0;

				SqCast.MsgAll( "DisableTBlr", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Team Balancer", "Disable" );
			}
			else
			{
				Handler.Handlers.Script.TeamBalancer = 1;

				SqCast.MsgAll( "EnableTBlr", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Team Balancer", "Enable" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "aduty", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			if( player.Data.aduty == 0 )
			{
				player.Data.aduty = 1;

				player.Immunity = 31;

				player.Colour = Color3( 0, 255, 0 );

				SqCast.MsgAll( "AdutyOn", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Admin Duty", "Enable" );

				Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Admin Duty" );
			}
			else
			{
				player.Data.aduty = 0;

				if( player.Team != 7 ) player.Immunity = 0;

				SqCast.MsgAll( "AdutyOff", player.Name );

				switch( player.Team )
				{
					case 1:
					player.Color = Color3( 255, 51, 0 );

					if( Handler.Handlers.Gameplay.Defender == 1 ) Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Defender" );
					else Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Attacker" );
					break;

					case 2:
					player.Color = Color3( 51, 102, 255 );

					if( Handler.Handlers.Gameplay.Defender == 2 ) Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Defender" );
					else Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Attacker" );
					break;

					default:
					player.Color = Color3( 255, 234, 0 );

					Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
					break;
				}

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Admin Duty", "Disable" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "autostart", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if ( Handler.Handlers.Script.Autostart == 0 )
			{
				Handler.Handlers.Script.Autostart = 1;

				SqCast.MsgAll( "EnableAutoStart", player.Name );

				if ( Handler.Handlers.Gameplay.Status < 3 )
				{
					if( Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) > 0 && Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) > 0 ) Handler.Handlers.Gameplay.PrepRound();
				}
				Handler.Handlers.Gameplay.voteBase[ 0 ].ID == 0;

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Auto Start", "Enable" );
			}
			else
			{
                if ( Handler.Handlers.Gameplay.Status < 3 )
                {
					Handler.Handlers.Script.Autostart = 0;
					Handler.Handlers.Gameplay.Status = 0;

					SqCast.MsgAll( "DisableAutoStart", player.Name );

					Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Auto Start", "Disable" );
					
					try
					{
						local Timer = Handler.Handlers.Script.findRoutine( "PrepRound" );
						if ( Timer )
						{
							Timer.Terminate();
							if ( Handler.Handlers.Gameplay.Replaybase == 0 ) SqCast.sendAlertToAll( "StopVoteAdmin" );
							else SqCast.sendAlertToAll( "StopRVoteAdmin" );
						}
					}
					catch( e ) SqCast.MsgPlr( player, "AutoStartErr", e );
					
		        	SqForeach.Player.Active( this, function( plr ) 
		        	{
			        	Handler.Handlers.Script.sendToClient( plr, 302 );
						plr.Data.voteBase = true;
						Handler.Handlers.PlayerUID.SetVote( plr.UID, plr.UID2, true );
						Handler.Handlers.PlayerUID.SetVote( plr.UID, plr.UID2, true );
						for( local i = 0;i<6;i++ )
						{
							Handler.Handlers.Gameplay.voteBase[ i ].ID = 0;
						}
						Handler.Handlers.Script.sendToClient( plr, 303, "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" );
						Handler.Handlers.Script.sendToClient( plr, 300, "0" + "," + "0" + "," + "0" + "," + "0" + "," + "0" + "," + "0" );
		        	});  
                }
				else SqCast.MsgPlr( player, "RoundActiveErr" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "startbase", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Base" ) )
			{
                if ( !Handler.Handlers.Script.Autostart )
                {
					if ( Handler.Handlers.Gameplay.Status < 3  )
					{
						if ( Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) > 0 && Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) > 0 )
						{
							local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
							if( mybase.Step() )
							{
								local basename = Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name;
								try
								{
									local Timer = Handler.Handlers.Script.findRoutine( "PrepRound" );
									if ( Timer ) Timer.Terminate();
								}
								catch( e ) SqCast.MsgPlr( player, "StartBaseError", e );
																
								SqCast.MsgAll( "ManualStartbase", player.Name, basename );

								Handler.Handlers.Gameplay.Bases = args.Base.tointeger();
								Handler.Handlers.Gameplay.StartBase( args.Base.tointeger() );    

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Start Base", basename );
							}
							else SqCast.MsgPlr( player, "InvalidBaseID" );
						}
						else SqCast.MsgPlr( player, "NotEnoughPlr" );
					}
					else SqCast.MsgPlr( player, "RoundArAct" );
                }
                else SqCast.MsgPlr( player, "AutostartAlreadyEnable" );
			}
			else SqCast.MsgPlr( player, "StartbasrSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "freeze", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if ( target.ID != player.ID )
					{
						if ( target.Spawned )
						{
							if ( target.GetOption( SqPlayerOption.Controllable ) == 1 )
							{
								SqCast.MsgAll( "FreezePlr", player.Name, target.Name );

								Freeze( target );
								target.Data.Freeze = true;

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Freeze", "" );
							}
							else SqCast.MsgPlr( player, "TargetAlreadyFreeze" );
						}
						else SqCast.MsgPlr( player, "TargetNotSpawn" );
					}
					else SqCast.MsgPlr( player, "CantFreezeSelf" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "FreezeSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "unfreeze", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if( target )
				{
					if ( target.Spawned )
					{					
						if ( target.GetOption( SqPlayerOption.Controllable ) == 0 )
						{
							SqCast.MsgAll( "UnFreezePlr", player.Name, target.Name );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "UnFreeze", "" );

							target.SetOption( SqPlayerOption.Controllable, 1 ); 
							target.Data.Freeze = false;
						}
						else SqCast.MsgPlr( player, "TargetNotFreeze" );
					}
					else SqCast.MsgPlr( player, "TargetNotSpawn" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "UnFreezeSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "spawnveh", "g", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "ID" ) )
			{
				local model = ( IsNum( args.ID ) ) ? args.ID.tointeger() : GetAutomobileID( args.ID );

	            if( IsAutomobileValid( model ) )
	            {
					if ( Handler.Handlers.Gameplay.Status < 3 )
					{
						if ( model >= 130 && model <= 236 )
						{
							local veh = SqVehicle.Create( model, player.World, player.Pos, player.Angle, 1, 1 );
							if ( veh )
							{
								player.Embark( veh );

								SqCast.MsgAllAdmin( "SpawnVehicle", player.Name, GetAutomobileName( model ) );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Spawn Vehicle", GetAutomobileName( model ) );
							}
						}
						else SqCast.MsgPlr( player, "SpawnVehicleErr" );
					}
					else SqCast.MsgPlr( player, "CantSpawnVehInRound" );
				}
				else SqCast.MsgPlr( player, "SpawnVehicleErr" );
			}
			else SqCast.MsgPlr( player, "SpawnVehSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "resetrb", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			Handler.Handlers.Gameplay.Replaybase = 0;
			SqCast.MsgAllAdmin( "ReserRB", player.Name );

			Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Reset Replay Base", "" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "resetpass", "s|s", [ "Target", "NewPass" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( !Handler.Handlers.Script.ReadOnly )
			{
				if( args.rawin( "Target" ) )
				{
					local target = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_account WHERE Name LIKE '%s';", args.Target );
					if ( target.Step() )
					{
						if( args.rawin( "NewPass" ) )
						{
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Password = '%s' WHERE Name = '%s';", SqHash.GetSHA256( args.NewPass ), args.Target );
							local targeton = FindPlayer( args.Target );
							if ( targeton ) 
							{
								SqCast.MsgPlr( targeton, "ResetPassword2", player.Name, args.NewPass );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Reset Password", "" );
							}

							SqCast.MsgAllAdmin( "ChangePasswordAdmin", player.Name, args.Target );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.GetInteger( "ID" ), "Reset Password", "" );
						}
						else SqCast.MsgPlr( player, "ResetPassSyntax" );
					}
					else SqCast.MsgPlr( player, "RemNameNotExist" );
				}
				else SqCast.MsgPlr( player, "ResetPassSyntax" );
			}
			else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "givewep", "s|s|s", [ "Target", "Wep", "Ammo" ], 0, 3, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "Target" ) )
			{
				if ( args.Target == "all" )
				{
					local wepdata = { "Weapon": 0, "Ammo": 9999 };
					local weapon = ( IsNum( args.Wep ) ) ? args.Wep.tointeger() : GetWeaponID( args.Wep );

					if ( weapon >= 0 && weapon <= 33 )
					{
						if ( !args.rawin( "Ammo" ) )
						{
							wepdata.Weapon = weapon;

							SqCast.MsgAllAdmin( "GiveWeaponAll", player.Name, GetWeaponName( weapon ) );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Give Weapon To All", GetWeaponName( weapon ) + " with ammo 9999" );
						}

						else
						{
							local ammo;
							if ( IsNum( args.Ammo ) ) ammo = args.Ammo.tointeger();
							else ammo = -1;
								
							if ( ammo >= 0 && ammo <= 9999 )
							{
								wepdata.Weapon = weapon;
								wepdata.Ammo = ammo;

								SqCast.MsgAllAdmin( "GiveWeaponAllWithAmmo", player.Name, GetWeaponName( weapon ), ammo );		

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Give Weapon To All", GetWeaponName( weapon ) + " with ammo " + ammo );
							}
							else SqCast.MsgPlr( player, "GiveWeaponAmmoError" );
						}

						SqForeach.Player.Active( this, function( all ) 
						{
							all.SetWeapon( wepdata.Weapon, wepdata.Ammo );
						});
					}
					else SqCast.MsgPlr( player, "GiveWeaponError" );
				}
				else
				{
					local target = FindPlayer( args.Target );
					if ( target )
					{
						if( args.rawin( "Wep" ) )
						{
							local weapon = ( IsNum( args.Wep ) ) ? args.Wep.tointeger() : GetWeaponID( args.Wep );
							if ( weapon >= 0 && weapon <= 33 )
							{
								if ( !args.rawin( "Ammo" ) )
								{
									target.SetWeapon( weapon, 9999 );

									SqCast.MsgAllAdmin( "GiveWeaponPlr", player.Name, GetWeaponName( weapon ), target.Name );

									Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Give Weapon", GetWeaponName( weapon ) + " with ammo 9999" );
								}
								else
								{
									local ammo;
									if ( IsNum( args.Ammo ) ) ammo = args.Ammo.tointeger();
									else ammo = -1;
									
									if ( ammo >= 0 && ammo <= 9999 )
									{
										target.SetWeapon( weapon, ammo );

										SqCast.MsgAllAdmin( "GiveWeaponPlrWithAmmo", player.Name, GetWeaponName( weapon ), ammo, target.Name );		

										Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Give Weapon", GetWeaponName( weapon ) + " with ammo " + ammo );
									}
									else SqCast.MsgPlr( player, "GiveWeaponAmmoError" );
								}
							}
							else SqCast.MsgPlr( player, "GiveWeaponError" );
						}
						else SqCast.MsgPlr( player, "GiveWepSyntax" );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
			}
			else SqCast.MsgPlr( player, "GiveWepSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "changeteam", "s|s", [ "Target", "NewTeam" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if( args.rawin( "Target" ) )
			{
				local target = FindPlayer( args.Target );
				if ( target )
				{
					if( args.rawin( "NewTeam" ) && ( args.NewTeam == "att" || "def" || "spec" ) )
					{
						local att, attpos, def, defpos, spec = 7;
						local attskin, defskin, attcolor, defcolor;
						local acolor, dcolor;
						if( Handler.Handlers.Gameplay.Defender == 1 ) att = 2, def = 1;
						else att = 1, def = 2;
						if( att == 1 ) acolor = "[#ff3300]", dcolor = "[#3366ff]", attskin = 47, defskin = 33, attcolor = Color3( 255, 51, 0 ), defcolor = Color3( 51, 102, 255 );
						else acolor = "[#3366ff]", dcolor = "[#ff3300]", attskin = 33, defskin = 47, attcolor = Color3( 51, 102, 255 ), defcolor = Color3( 255, 51, 0 );
						if( Handler.Handlers.Gameplay.Status >= 3 )
						{
							attpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team2Pos;	
							defpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team1Pos;
						}

						if ( target.Spawned )
						{
							switch( args.NewTeam )
							{
								case "att":
								if ( target.Team != att ) 
								{
									if ( target.Team == 7 ) Handler.Handlers.Script.sendToClient( target, 404, "Press B to choose a weapon set" );										
									SqCast.MsgAll( "ChangeteamAdmin", player.Name, target.Name, "Attacker" );
									SqCast.MsgPlr( target, "ChangeTeamPlrAtt", player.Name );	

									target.Team = att;	
									target.Immunity = 0;
									target.SetOption( SqPlayerOption.CanAttack, true );
									
									target.Skin = attskin;
									target.Color = attcolor; 
									Handler.Handlers.Script.sendToClient( target, 401, target.Color.R + "$" + target.Color.G + "$" + target.Color.B + "$-Playing as Attacker" );										
									
									if ( Handler.Handlers.Gameplay.Status >= 3 )
									{
										target.Pos = attpos;
										target.Health = 100;
										target.Data.Round = true;		
										target.StripWeapons();
										Handler.Handlers.Gameplay.giveSetWeapon( target );
										if ( target.Data.wepSet == 4 && Handler.Handlers.Gameplay.GetRPGSetInTeam( target.Team ) != null ) target.Data.wepSet = 1;		
									}

									Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Change Team", "To Attacker" );
								}
								else SqCast.MsgPlr( player, "TargetAlreadyAtt" );
								break;

								case "def":
								if ( target.Team != def ) 
								{
									if ( target.Team == 7 ) Handler.Handlers.Script.sendToClient( target, 404, "Press B to choose a weapon set" );
									SqCast.MsgAll( "ChangeteamAdmin", player.Name, target.Name, "Defender" );
									SqCast.MsgPlr( target, "ChangeTeamPlrDef", player.Name );	
									
									
									target.Team = def;			
									target.Immunity = 0;	
									target.SetOption( SqPlayerOption.CanAttack, true );
									target.Skin = defskin;
									target.Color = defcolor; 
									Handler.Handlers.Script.sendToClient( target, 401, target.Color.R + "$" + target.Color.G + "$" + target.Color.B + "$-Playing as Defender" );		
									
									if ( Handler.Handlers.Gameplay.Status >= 3 )
									{
										target.Pos = defpos;							
										target.Health = 100;
										target.Data.Round = true;
										target.StripWeapons();
										Handler.Handlers.Gameplay.giveSetWeapon( target );
										if ( target.Data.wepSet == 4 && Handler.Handlers.Gameplay.GetRPGSetInTeam( target.Team ) != null ) target.Data.wepSet = 1;								
									}								

									Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Change Team", "To Defender" );
								}
								else SqCast.MsgPlr( player, "TargetAlreadyDef" );
								break;

								default:
								SqCast.MsgPlr( player, "ChangeteamTargetNotGiven" );
								break;
							}
						}
						else SqCast.MsgPlr( player, "TargetNotSpawn" );
					}
					else SqCast.MsgPlr( player, "ChangeTeamSyntax" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}
			else SqCast.MsgPlr( player, "ChangeTeamSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

/*SqCommand.Create( "createobj", "s", [ "Obj" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 )
		{
			if( args.rawin( "Obj" ) )
			{
				local obj;
				if ( IsNum( args.Obj ) ) obj = args.Obj.tointeger();
				else obj = -1;
				if ( obj != -1 )
				{
					SqObject.Create( obj, 1, Vector3( player.Pos.x,player.Pos.y,player.Pos.z ), 255 ).RotateToEuler( Vector3( player.Angle ), 0 );
					player.Message( "SqObject.Create( " + obj + ", 0, Vector3( " + player.Pos + " ), 255 ).RotateToEuler( Vector3( 0, 0, " + player.Angle + " ), 0 );" );
				
					SqCast.MsgAllAdmin( "SpawnObj", player.Name, obj, player.Pos.tostring(), player.Angle.tostring() );
				}
				else SqCast.MsgPlr( player, "WrongObjID" );
			}
			else SqCast.MsgPlr( player, "CreateObjSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

/*SqCommand.Create( "eventmode", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
			if ( Handler.Handlers.Script.EventMode == 1 )
			{
				Handler.Handlers.Script.EventMode = 0;

				SqCast.MsgAll( "EnableEventMode", player.Name );
			}
			else
			{
				Handler.Handlers.Script.EventMode = 1;

				SqCast.MsgAll( "DisableEventMode", player.Name );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});*/

SqCommand.Create( "packlimit", "s|s", [ "Pack", "Limit" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if( args.rawin( "Pack" ) )
			{
				local pack;	
				if( IsNum( args.Pack ) ) pack = args.Pack.tointeger();
				else pack = -1;
				
				if( pack > 0 && pack < 8 )
				{
					if( args.rawin( "Limit" ) && IsNum( args.Limit ) )
					{
						Handler.Handlers.Script.PackLim[ pack ] = args.Limit;

						SqCast.MsgAll( "SetPackLimitAll", player.Name, pack, args.Limit.tointeger() );		
					}
					else SqCast.MsgPlr( player, "ViewCurrentPackLimit", pack, Handler.Handlers.Script.PackLim[ pack ].tointeger() );
				}
				else SqCast.MsgPlr( player, "PackLimitErr" );
			}
			else SqCast.MsgPlr( player, "SetPackLimitSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "setdefpos", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if ( player.Spawned )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Base" ) )
					{
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if( mybase.Step() )
						{
							local coords = ( player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z );
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Team1Pos = Vector3( player.Pos.x,player.Pos.y,player.Pos.z );
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET DefPos = '%s' WHERE ID = '%d';", coords, args.Base.tointeger() );
							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Set Base Defender Pos", "[" + args.Base.tointeger() + "] " + coords );

							SqCast.MsgAllAdmin( "ChangeDefSpawn", player.Name, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name );
							player.Message( coords );

							FixMarkers();
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetdefPosSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "NotSpawned" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "setattpos", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if ( player.Spawned )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Base" ) )
					{
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if( mybase.Step() )
						{
							local coords = ( player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z );
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Team2Pos = Vector3( player.Pos.x,player.Pos.y,player.Pos.z );
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET AttPos = '%s' WHERE ID = '%d';", coords, args.Base.tointeger() );
							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Set Base Attacker Pos", "[" + args.Base.tointeger() + "] " + coords );						
							
							SqCast.MsgAllAdmin( "ChangeAttSpawn", player.Name, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name );
							player.Message( coords );

							FixMarkers();
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetattPosSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "NotSpawned" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "setcppos", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if ( player.Spawned )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Base" ) )
					{
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if( mybase.Step() )
						{
							local coords = ( player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z );
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].SpherePos = Vector3( player.Pos.x,player.Pos.y,player.Pos.z );
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET CheckpointPos = '%s' WHERE ID = '%d';", coords, args.Base.tointeger() );
							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Set Base CP Pos", "[" + args.Base.tointeger() + "] " + coords );

							SqCast.MsgAllAdmin( "ChangeCPPos", player.Name, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name );
							player.Message( coords );

							FixMarkers();
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetCPPosSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "NotSpawned" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "settvpos", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if ( player.Spawned )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Base" ) )
					{
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if( mybase.Step() )
						{
							local coords = ( player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z );
							local angle = player.Angle + "";
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].VehiclePos = Vector3( player.Pos.x,player.Pos.y,player.Pos.z );
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].VehicleAngle = player.Angle;
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET VehiclePos = '%s', VehicleAngle = '%s' WHERE ID = '%d';", coords, angle, args.Base.tointeger() );
							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Set Base Vehicle Pos", "[" + args.Base.tointeger() + "] " + coords );

							SqCast.MsgAllAdmin( "ChangeVehiclePos", player.Name, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name );
							player.Message( coords );

							FixMarkers();
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetTVPosSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "NotSpawned" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "setbasename", "i|g", [ "Base", "Name" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if( args.rawin( "Base" ) )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Name" ) )
					{			
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if( mybase.Step() )
						{
							local OldbaseName = Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name;

							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name = args.Name;
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET Name = '%s' WHERE ID = '%d';", Handler.Handlers.Script.Database.EscapeString( args.Name ), args.Base.tointeger() );

							SqCast.MsgAllAdmin( "ChangeBaseName", player.Name, OldbaseName, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Base Name", "[" + args.Base.tointeger() + "] " + OldbaseName + " > " + Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name  );
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetbasenameSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "SetbasenameSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "settvmodel", "s|g", [ "Base", "Model" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if( args.rawin( "Base" ) )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					if( args.rawin( "Model" ) )
					{			
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if ( mybase.Step() )
						{
							Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].VehicleModel = args.Model.tointeger();
							Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_bases SET VehicleModel = '%d' WHERE ID = '%d';", args.Model.tointeger(), args.Base.tointeger() );
						
							SqCast.MsgAllAdmin( "ChangeTVModel", player.Name, Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name, GetAutomobileName( args.Model.tointeger() ) );					

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Base Vehicle", "[" + args.Base.tointeger() + "] " + GetAutomobileName( args.Model.tointeger() ) );

							FixMarkers();
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "SetTVModelSyntax" );
				}
				else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
			}
			else SqCast.MsgPlr( player, "SetTVModelSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "getbasename", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
				if( args.rawin( "Base" ) )
				{
					local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
					if( mybase.Step() )
					{
						local basename = Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name;

						SqCast.MsgPlr( player, "GetBaseID", args.Base.tointeger(), basename );
					}
					else SqCast.MsgPlr( player, "InvalidBaseID" );
				}
				else SqCast.MsgPlr( player, "GetBaseNameSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "searchbase", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 1 )
		{
				if( args.rawin( "Base" ) )
				{
					local mybase = Handler.Handlers.Script.Database.Query( "SELECT * FROM rtv3_bases WHERE Lower(Name) LIKE '%" + args.Base.tolower() + "%';" );
					if ( mybase.Step() )
					{
						local baseid = mybase.GetInteger("ID");
						local basename = mybase.GetString("Name");

						SqCast.MsgPlr( player, "GetBaseID", baseid, basename );
					}
					else SqCast.MsgPlr( player, "BaseNotFound" );
				}
				else SqCast.MsgPlr( player, "SearchBaseSyntax" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "addbase", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 4 || player.Data.Mapper == 1 )
		{
			if( !Handler.Handlers.Script.ReadOnly )
			{
				if( args.rawin( "Base" ) )
				{
					local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
					if ( !mybase.Step() )
					{					
						SqCast.MsgPlr( player, "AddBase1", args.Base.tointeger() );
						SqCast.MsgPlr( player, "AddBaseWarn" );

						Handler.Handlers.Script.Database.ExecuteF( "INSERT INTO rtv3_bases ( ID, Name, DefPos, AttPos, CheckpointPos, VehicleModel, VehiclePos, VehicleAngle, Score, Author ) VALUES ( %d, 'newbase', '-966.268921,-252.156738,369.886597', '-966.268921,-252.156738,369.886597', '-966.268921,-252.156738,369.886597', 154, '-966.268921,-252.156738,369.886597', 2.3824, 0, %d );", args.Base.tointeger(), player.Data.ID );
						Handler.Handlers.Bases.LoadBases();
					}
					else SqCast.MsgPlr( player, "BaseIDExist" );
				}
				else SqCast.MsgPlr( player, "AddBaseSyntax" );
			}
			else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "delbase", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
   if( player.Data.Logged )
   {
       if( player.Authority > 4 || player.Data.Mapper == 1 )
       {
		   if( !Handler.Handlers.Script.ReadOnly )
		   {
				if( args.rawin( "Base" ) )
				{
					local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
					if ( mybase.Step() )
					{
						SqCast.MsgPlr( player, "DelBase", args.Base.tointeger() );
						Handler.Handlers.Script.Database.ExecuteF( "DELETE FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						Handler.Handlers.Bases.LoadBases();
					}
					else SqCast.MsgPlr( player, "BaseIDNotExist" );
				}
				else SqCast.MsgPlr( player, "DelBaseSyntax" );
		   }
		   else SqCast.MsgPlr( player, "ServerOnWriteOnlyMode" );
       }
       else SqCast.MsgPlr( player, "ErrCmd" );
   }
   else SqCast.MsgPlr( player, "ErrCmdNoLog" );
        
    return true;
});


SqCommand.Create( "reloadbases", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			Handler.Handlers.Bases.LoadBases();

			SqCast.MsgAllAdmin( "ReloadBase", player.Name );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "gotobase", "g", [ "Base" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			if ( player.Spawned )
			{
				if( args.rawin( "Base" ) )
				{
					if( IsNum( args.Base ) )
					{
						local mybase = Handler.Handlers.Script.Database.QueryF( "SELECT ID FROM rtv3_bases WHERE ID = '%d';", args.Base.tointeger() );
						if ( mybase.Step() )
						{
							player.Pos = Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].SpherePos;
							local basename = Handler.Handlers.Bases.Bases[ args.Base.tointeger() ].Name;
						
							SqCast.MsgAllAdmin( "GotoBase", player.Name, basename );
						}
						else SqCast.MsgPlr( player, "InvalidBaseID" );
					}
					else SqCast.MsgPlr( player, "InvalidBaseID" );
				}
				else SqCast.MsgPlr( player, "GotobaseSyntax" );
			}
			else SqCast.MsgPlr( player, "NotSpawned" );
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "rpgban", "s|s|g", [ "Target", "Time", "Reason" ], 0, 3, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( target.ID != player.ID )
                        {
                            if( args.rawin( "Time" ) )
                            {
                                if( Handler.Handlers.PlayerUID.GetDuration( args.Time ) )
                                {
									if( Handler.Handlers.PlayerUID.GetModDur( player.Authority, args.Time ) )
									{
										if( args.rawin( "Reason" ) )
										{
											SqCast.MsgAll( "RPGBanPlayer", player.Name, SqCast.GetPlayerColor( target ), args.Reason, SecondToTime( Handler.Handlers.PlayerUID.GetDuration( args.Time ) ) );

											Handler.Handlers.PlayerUID.AddRPGBan( target, player.Name, args.Reason, Handler.Handlers.PlayerUID.GetDuration( args.Time ) );

											target.Data.wepSet = 1;

											if( Handler.Handlers.Gameplay.Status > 1 )
											{
												SqCast.MsgPlr( target, "DisarmRPGBan" );

												Handler.Handlers.Gameplay.giveSetWeapon( target );
											}
											
											target.MakeTask( function()
											{  
											//   Handler.Handlers.PlayerUID.UID[ target.UID ].RPGBan = null;
											//    Handler.Handlers.PlayerUID.UID2[ target.UID2 ].RPGBan = null;

												target.Data.RPGBan = null;

												this.Terminate();
											}, ( Handler.Handlers.PlayerUID.GetDuration( args.Time ) * 1500 ), 1 ).SetTag( "RPGBan" );

											Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "RPG Ban", args.Reason );
										}
										else SqCast.MsgPlr( player, "RPGBanSyntax" );
									}
									else SqCast.MsgPlr( player, "BanMuteTimeInvalid2" );
                                }
                                else SqCast.MsgPlr( player, "BanMuteTimeInvalid" );
                            }
                            else SqCast.MsgPlr( player, "RPGBanSyntax" );
                        }
                        else SqCast.MsgPlr( player, "CantRPGBanSelf" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "RPGBanSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "unrpgban", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( !Handler.Handlers.PlayerUID.CheckRPGBan( target ) )
                        {
                         //   Handler.Handlers.PlayerUID.UID[ target.UID ].RPGBan = null;
		                //    Handler.Handlers.PlayerUID.UID2[ target.UID2 ].RPGBan = null;

							target.Data.RPGBan = null;

                            SqCast.MsgAll( "UnRPGBan", player.Name, SqCast.GetPlayerColor( target ) );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "RPG UnBan", "" );
                            
                            if( Handler.Handlers.PlayerUID.IsTimedRPGBan( target ) ) target.FindTask( "RPGBan" ).Terminate();
                        }
                        else SqCast.MsgPlr( player, "TargetNotRPGBan" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "UnRPGBanSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "getmodule", "s", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
						target.GetModuleList();

						SqCast.MsgAllAdmin( "GetModule", player.Name, target.Name );
					}
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "GetModuleSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "changeteamname", "s|g", [ "Target", "New" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
	            if( args.rawin( "New" ) )
           	 	{
					switch( args.Target )
					{
						case "red":
						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Team Name", Handler.Handlers.Gameplay.RedTeamName + " > " + args.New );
						
				        SqCast.MsgAll( "ChangeteamName", player.Name, "Red Team", args.New );
						Handler.Handlers.Gameplay.RedTeamName = args.New;
						break;

						case "blue":
						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Team Name", Handler.Handlers.Gameplay.BlueTeamName + " > " + args.New );
				       
					    SqCast.MsgAll( "ChangeteamName", player.Name, "Blue Team", args.New );
						Handler.Handlers.Gameplay.BlueTeamName = args.New;
						break;

						default:
						SqCast.MsgPlr( player, "ChangeteamNameWrongTeam" );
						break;
					}
            	}
            	else SqCast.MsgPlr( player, "ChangeteamNameSyntax" );
            }
            else SqCast.MsgPlr( player, "ChangeteamNameSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "speedtest", "s", [ "Target",  ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 3 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( target.Spawn )
                        {
							SqCast.MsgPlr( player, "SpeedtestInt", target.Name );

							target.MakeTask( function() {
								Handler.Handlers.Script.sendToClient( target, 5000 );
							}, 1000, 1 );

							target.MakeTask( function() {
								Handler.Handlers.Script.sendToClient( target, 5001 );
							}, 6000, 1 );

							target.MakeTask( function() {
 
							local tick1 = target.Data.Jticks.tointeger();
							local tick2 = target.Data.Lticks.tointeger();
							local time2 = tick1 - tick2;
						
							SqCast.MsgAllAdmin( "GetSpeedtestResult", target.Name, time2 );
							}, 7000, 1 );
                        }
                        else SqCast.MsgPlr( player, "TargetNotSpawn" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "SpeedtestSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

/*SqCommand.Create( "changesetting", "s|s|g", [ "Type", "Option", "Option1" ], 0, 3, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 3 )
        {
            if( args.rawin( "Type" ) )
            {
				switch( args.Type )
				{
					case "hpspawn":

					case "armourspawn":

					case "ammospawn":

					case "hpregen":

					case "limitspawn":

					case "fpslimit":

					case "pinglimit":

					case "jitterlimit":

					case "autostart":
					if( Handler.Handlers.Script.Autostart == 0 )
					{
						Handler.Handlers.Script.Autostart = 1;

						SqCast.MsgAll( "EnableAutoStart", player.Name );

						if ( Handler.Handlers.Gameplay.Status < 3 )
						{
							if( Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) > 0 && Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) > 0 ) Handler.Handlers.Gameplay.PrepRound();
						}
						Handler.Handlers.Gameplay.voteBase[ 0 ].ID == 0;

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Auto Start", "Enable" );
					}
					else
					{
						if ( Handler.Handlers.Gameplay.Status < 3 )
						{
							Handler.Handlers.Script.Autostart = 0;
							Handler.Handlers.Gameplay.Status = 0;

							SqCast.MsgAll( "DisableAutoStart", player.Name );

							Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Auto Start", "Disable" );
							
							try
							{
								local Timer = Handler.Handlers.Script.findRoutine( "PrepRound" );
								if ( Timer )
								{
									Timer.Terminate();
									if ( Handler.Handlers.Gameplay.Replaybase == 0 ) SqCast.sendAlertToAll( "StopVoteAdmin" );
									else SqCast.sendAlertToAll( "StopRVoteAdmin" );
								}
							}
							catch( e ) SqCast.MsgPlr( player, "AutoStartErr", e );
							
							SqForeach.Player.Active( this, function( plr ) 
							{
								Handler.Handlers.Script.sendToClient( plr, 302 );
								plr.Data.voteBase = true;
								Handler.Handlers.PlayerUID.SetVote( plr.UID, plr.UID2, true );
								Handler.Handlers.PlayerUID.SetVote( plr.UID, plr.UID2, true );
								for( local i = 0;i<6;i++ )
								{
									Handler.Handlers.Gameplay.voteBase[ i ].ID = 0;
								}
								Handler.Handlers.Script.sendToClient( plr, 303, "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" + "," + "Autostart Disabled" );
								Handler.Handlers.Script.sendToClient( plr, 300, "0" + "," + "0" + "," + "0" + "," + "0" + "," + "0" + "," + "0" );
							});  
						}
						else SqCast.MsgPlr( player, "RoundActiveErr" );
					}
					break;

					case "teambalancer":
					switch( Handler.Handlers.Script.TeamBalancer )
					{
						case 1:
						Handler.Handlers.Script.TeamBalancer = 0;

						SqCast.MsgAll( "DisableTBlr", player.Name );

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Team Balancer", "Disable" );
						break;

						case 0:
						Handler.Handlers.Script.TeamBalancer = 1;

						SqCast.MsgAll( "EnableTBlr", player.Name );

						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Team Balancer", "Enable" );
					}
					break;

					case "publicchat":

				}
            }
            else SqCast.MsgPlr( player, "ChangesettingSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});*/

SqCommand.Create( "legacyspawn", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 2 )
		{
			if ( Handler.Handlers.Script.LegacySpawn == true )
			{
				Handler.Handlers.Script.LegacySpawn = false;

				SqServer.SetOption( SqServerOption.UseClasses, Handler.Handlers.Script.LegacySpawn );

				SqCast.MsgAll( "DisableLegacySpawn", player.Name );

				Handler.Handlers.Script.sendToClientToAll( 10, Handler.Handlers.Script.LegacySpawn.tostring() );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Legacy Spawn", "Disable" );
			}
			else
			{
				Handler.Handlers.Script.LegacySpawn = true;

				SqServer.SetOption( SqServerOption.UseClasses, Handler.Handlers.Script.LegacySpawn );

				Handler.Handlers.Script.sendToClientToAll( 10, Handler.Handlers.Script.LegacySpawn.tostring() );

				SqCast.MsgAll( "EnableLegacySpawn", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Legacy Spawn", "Enable" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "jitterlimit", "g", [ "Value" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Value" ) )
        {
            SqCast.MsgPlr( player, "CurrentAllLimit", Handler.Handlers.Script.FPSLimit, Handler.Handlers.Script.PingLimit, Handler.Handlers.Script.JitterLimit );
        }

        else 
        {
            if( player.Authority > 3 )
            {
                if( IsNum( args.Value ) )
                {
                    if( args.Value.tointeger() > 4 && args.Value.tointeger() < 10000 )
                    {
						Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Change Jitter Limit", Handler.Handlers.Script.JitterLimit + " > " + args.Value.tointeger() );
                        
						Handler.Handlers.Script.JitterLimit = args.Value.tointeger();

						SqCast.MsgAll( "ChangeJitterSetting", player.Name, args.Value.tointeger() );

                        SqForeach.Player.Active( this, function( plr ) 
                        {
                            plr.Data.FPSWarning = 0;    
                        });
                    }
                    else SqCast.MsgPlr( player, "JitterLimitBetween" );
                }
                else SqCast.MsgPlr( player, "ValueNotNum" );
            }
            else SqCast.MsgPlr( player, "NotPermSetValue" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "readonly", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if ( Handler.Handlers.Script.ReadOnly == true )
			{
				Handler.Handlers.Script.ReadOnly = false;

				SqCast.MsgAll( "DisableReadOnly", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Read Only", "Disable" );
			}
			else
			{
				Handler.Handlers.Script.ReadOnly = true;

				SqCast.MsgAll( "EnableReadOnly", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Read Only", "Enable" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});

SqCommand.Create( "comment", "s|g", [ "Target", "Reason" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 2 )
        {
            if( args.rawin( "Target" ) )
            {
                local target = Handler.Handlers.Script.FindPlayer( args.Target );
                if( target )
                {
                    if( target.Data.Logged )
                    {
                        if( args.rawin( "Reason" ) )
                        {
							switch( args.Reason )
							{
								case "clear":
								target.Data.Comments = "no";

								SqCast.MsgAllAdmin( "RemoveComment", player.Name, target.Name );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Comment", "Clear" );
								break;

								default:
								target.Data.Comments = args.Reason;

								SqCast.MsgAllAdmin( "AddComment", player.Name, target.Name, args.Reason );

								Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, target.Data.ID, "Add Comment", args.Reason );
								break;
							}
                        }
                        else SqCast.MsgPlr( player, "KickSyntax" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "CommentSyntax" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "gpublicchat", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( player.Authority > 3 )
		{
			if ( Handler.Handlers.Script.AllowPublicChat == true )
			{
				Handler.Handlers.Script.AllowPublicChat = false;

				SqCast.MsgAll( "DisablePublicChat", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Public Chat", "Disable" );
			}
			else
			{
				Handler.Handlers.Script.AllowPublicChat = true;

				SqCast.MsgAll( "EnablePublicChat", player.Name );

				Handler.Handlers.PlayerUID.WriteToLog( player.Data.ID, player.Data.IP, 0, "Public Chat", "Enable" );
			}
		}
		else SqCast.MsgPlr( player, "ErrCmd" );
	}
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );
		
	return true;
});
