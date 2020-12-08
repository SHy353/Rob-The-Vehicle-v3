class CPlayerEvents
{
	function constructor() 
	{
		SqCore.On().PlayerDestroyed.Connect( this, onPlayerDisconnect ); 
		SqCore.On().PlayerRequestSpawn.Connect( this, onPlayerRequestSpawn );
		SqCore.On().PlayerRequestClass.Connect( this, onPlayerRequestClass );
		SqCore.On().PlayerCommand.Connect( this, onPlayerCommand );
		SqCore.On().ClientScriptData.Connect( this, onReceiveClientData );
		SqCore.On().PlayerMessage.Connect( this, onPlayerChat );
		SqCore.On().PlayerSpawn.Connect( this, onPlayerSpawn );
		SqCore.On().PlayerKilled.Connect( this, onPlayerKill );
		SqCore.On().PlayerWasted.Connect( this, onPlayerDeath );
		SqCore.On().PlayerUnspectate.Connect( this, onPlayerUnspec );
		SqCore.On().PlayerPrivateMessage.Connect( this, onPlayerPM );
		SqCore.On().PickupCollected.Connect( this, onPlayerPickedPickup );
		SqCore.On().PlayerWorld.Connect( this, onPlayerWorldChange );
		SqCore.On().PlayerTeam.Connect( this, onPlayerTeamChange );
		SqCore.On().PlayerAction.Connect( this, onPlayerActionChange );
		SqCore.On().PlayerStartTyping.Connect( this, onPlayerTyping );
		SqCore.On().PlayerStopTyping.Connect( this, onPlayerStopTyping );
		SqCore.On().PlayerKeyPress.Connect( this, onPlayerKeyDown );
		SqCore.On().PlayerModuleList.Connect( this, GetPlayerModuleList );
		SqCore.On().PlayerHealth.Connect( this, onPlayerHealthChange );
	}
	
	function onPlayerActionChange( player, oldAction, newAction ) 
	{
		local wep = player.Weapon;
		if ( newAction == 12 && ( wep == 26 || wep == 27 || wep == 32 ) ) 
		{
			player.SetWeapon( 0,0 );
		}
	}
	
	function onPlayerTeamChange( player, oldteam, newteam )
	{
		if ( Handler.Handlers.Gameplay.Status >= 3 ) player.Data.AssignedTeam = newteam;
	}
	
	function onPlayerWorldChange( player, oldworld, newworld, secondary )
	{
		for( local i=0; i<GetPlayers() + 10; i ++ )
		{
			local plr = FindPlayer( i );
			if ( plr && plr.Data.SpectateTarget == player ) plr.World = newworld, plr.Spectate( player );
		}
	}

	function onPlayerDisconnect( player, reason, payload )
	{
		Handler.Handlers.Discord.SendPlayerCount( true );
		Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:-1");
		try 
		{	
			if( player.Data.Logged ) 
			{
				SqCast.MsgAllExp( player, SqCast.PartReason( reason ), SqCast.GetPlayerColor( player.Name ) );

				Handler.Handlers.Discord.PartReason( player.Name, reason );

				Handler.Handlers.PlayerUID.Save( player.UID, player.UID2 );
				
				player.Data.Save( player );
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerEvents::onPlayerDisconnect [%s]", e );
		
		if( player.Team == 1 && player.Spawned ) Handler.Handlers.Script.Reds--;
		else if( player.Team == 2 && player.Spawned ) Handler.Handlers.Script.Blues--;
		
		if ( GetPlayers() < 2 )
		{
			if ( Handler.Handlers.Script.Autostart == 0 ) Handler.Handlers.Script.Autostart = 1; 
		}
		
		for( local i=0; i<GetPlayers() + 10; i ++ )
		{
			local plr = FindPlayer( i );
			if ( plr && plr.Data.SpectateTarget == player ) plr.Data.SpectateTarget = null;
		}
	}

	function onPlayerRequestSpawn( player )
	{
		try 
		{
			if( Handler.Handlers.Script.LegacySpawn )
			{
				if( !player.Data.Registered )
				{
					SqCast.MsgPlr( player, "CantSpawnNotReq" );

					SqCore.SetState( 0 );
				}

				if( player.Data.Registered && !player.Data.Logged )
				{
					SqCast.MsgPlr( player, "CantSpawnNotLog" );
					
					SqCore.SetState( 0 );
				}
				
				if( !player.Data.ReadNews )
				{
					SqCore.SetState( 0 );
				}

				if ( Handler.Handlers.Script.EventMode && ( player.Team == 1 || player.Team == 2 )  )
				{
					player.AnnounceEx( 0, "There is a event going on, you can only spawn as a spectator." );
					SqCore.SetState( 0 );		
				}
				
				if ( Handler.Handlers.Script.LimitTeamSpawn == 100 && Handler.Handlers.Script.TeamBalancer && !Handler.Handlers.Script.EventMode )
				{
					if ( GetPlayers() > 0 )
					{
						local inreds = Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 );
						local inblues = Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 );
						if ( player.Team == 1  && inreds > inblues && !player.Data.Round ) SqCast.sendAlert( player, "CmdError", "There are more players in this team, please choose the other team." ), SqCore.SetState( 0 );
						else if ( player.Team == 2 && inblues > inreds && !player.Data.Round ) SqCast.sendAlert( player, "CmdError", "There are more players in this team, please choose the other team." ), SqCore.SetState( 0 );
					}
				}

				if( player.Team != 7 && Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) > Handler.Handlers.Script.LimitTeamSpawn )
				{
					SqCast.MsgPlr( player, "CantSpawnNotLog" );
					
					SqCore.SetState( 0 );
				}		

				if( player.Team == 1 || player.Team == 2 )
				{
					if( player.Ping > Handler.Handlers.Script.PingLimit )
					{
						SqCast.MsgPlr( player, "WarningPing1", Handler.Handlers.Script.PingLimit );
						
						SqCore.SetState( 0 );
					}

					if( Handler.Handlers.Script.FPSLimit > player.FPS )
					{
						SqCast.MsgPlr( player, "FPSLimit1", Handler.Handlers.Script.FPSLimit );
						
						SqCore.SetState( 0 );
					}
				}

				if( player.Team == 7 && !Handler.Handlers.Script.AllowNonAdminSpawnAsRef && ( player.Authority < 2 ) )
				{
					SqCast.MsgPlr( player, "AllowNonAdminSpawnAsRef" );
						
					SqCore.SetState( 0 );
				}
			}
			else SqCore.SetState( 0 );
		}
		catch( e ) SqLog.Err( "Error on CPlayerEvents::CPlayerEvents [%s]", e );
	}

	function onPlayerRequestClass( player, highclass )
	{
		player.Angle = 0.0906024;
		/*if( !this.Registered )
		{
			SqCast.MsgPlr( player, "CantSpawnNotReq" );

			SqCore.SetState( 0 );
		}

		if( this.Registered && !this.Logged )
		{
			SqCast.MsgPlr( player, "CantSpawnNotLog" );
			
			SqCore.SetState( 0 );
		}*/

		if( Handler.Handlers.Script.LegacySpawn )
		{
			if( player.Data.Logged )
			{
				local teamid = "Defender";
				if( player.Team != Handler.Handlers.Gameplay.Defender ) teamid = "Attacker";
				if( player.Team == 7 ) teamid = "Spectator";

				if ( Handler.Handlers.Gameplay.Status > 2 ) Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( player.Team ) );
				else Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );
			}
			
			if ( player.Data.AutoRespawn ) 
			{
				if ( Handler.Handlers.Gameplay.Status > 2 && player.Team != 7 )
				{
					local inreds = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 );
					local inblues = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 );
					if ( player.Team == 1  && inreds > inblues ) SqCore.SetState( 0 );
					else if ( player.Team == 2 && inblues > inreds ) SqCore.SetState( 0 );
					else if( Handler.Handlers.Script.FPSLimit > player.FPS ) SqCore.SetState( 0 );
					else if( player.Ping > Handler.Handlers.Script.PingLimit ) SqCore.SetState( 0 );		
					else player.Spawn();
				}
			}
		}

		else 
		{
			if( player.Data.Logged )
			{
				local showui = true;
				if ( player.Data.AutoRespawn ) 
				{
					if( Handler.Handlers.Script.FPSLimit > player.FPS ) showui = true;
					else if( player.Ping > Handler.Handlers.Script.PingLimit ) showui = true;
					else 
					{
						player.Spawn();

						showui = false;

						SqCore.SetState( 0 );
					}
				}
				
				if( showui )
				{
					player.CameraPosition( Vector3( -482.285583,620.814087,12.381873+10 ),Vector3( -569.277649,670.066895,10.910061 ) );
					Handler.Handlers.Script.sendToClient( player, 4200 );

					local teamid = "Attacker";
					local teamid2 = "Attacker";

					if( Handler.Handlers.Gameplay.Defender == 1 ) teamid = "Defender";
					if( Handler.Handlers.Gameplay.Defender == 2 ) teamid2 = "Defender";

					if ( Handler.Handlers.Gameplay.Status > 2 ) 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ) );
					}				
					else 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) );
					}

					SqCore.SetState( 0 );
				}
			}
		}
	}

	function onReceiveClientData( player, id, stream )
	{
		try 
		{	
			switch( id )
			{
				case 1:
				local text = stream.ReadClientString();

				player.Data.LoadAccount( player, text );
				Handler.Handlers.Script.RequestDoddle( player );
				Handler.Handlers.Gameplay.RequestPlayerColour( player );
				Handler.Handlers.Gameplay.InitCoundownUI( player );
				Handler.Handlers.Gameplay.UpdateScoreBoardForPlayer( player );
				Handler.Handlers.Gameplay.UpdateBasevote( player );
				Handler.Handlers.Gameplay.CreateTextdraw( player );
				Handler.Handlers.Script.RequestTopPlayers( player );

				Handler.Handlers.Script.sendToClient( player, 10, Handler.Handlers.Script.LegacySpawn.tostring() );
				break;

				case 2:
				local text = stream.ReadClientString();
				local target = Handler.Handlers.Script.FindPlayer( text );

				if( target )
				{
					player.Data.Assist.HitBy = text;
					player.Data.Assist.HitTime = time();
				}
				break;

				case 3:
				SqCast.MsgAll( "TeamShooting", player.Name );
				break;

				case 700:
				local text = stream.ReadClientString();

				if( !player.Data.Registered )
				{
					player.Data.Register( player, text );					

					Handler.Handlers.Script.sendToClient( player, 701 );
				}
				else Handler.Handlers.Script.sendToClient( player, 702, SqCast.parseStr( player, "RegAlreadyRegistered" ) );
				break;

				case 600:
				local text = stream.ReadClientString();

				if( player.Data.Registered )
				{
					if( !player.Data.Logged )
					{
						if( player.Data.Password == SqHash.GetSHA256( text ) )
						{
							player.Data.Login( player );

							Handler.Handlers.Script.sendToClient( player, 601 );
						}
						else Handler.Handlers.Script.sendToClient( player, 602, SqCast.parseStr( player "LoginXPassword" ) );
					}
					else Handler.Handlers.Script.sendToClient( player, 602, SqCast.parseStr( player "LoginXPassword" ) );
				}
				else Handler.Handlers.Script.sendToClient( player, 602, SqCast.parseStr( player "NotReg" ) );
				break;
				
				case 2300:
				player.Data.ReadNews = "true";

			/*	if( player.Data.ReadNews )
				{
					Handler.Handlers.Script.sendToClient( player, 4200 );

					local teamid = "Attacker";
					local teamid2 = "Attacker";

					if( Handler.Handlers.Gameplay.Defender == 1 ) teamid = "Defender";
					if( Handler.Handlers.Gameplay.Defender == 2 ) teamid2 = "Defender";

					if ( Handler.Handlers.Gameplay.Status > 2 ) 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ) );
					}				
					else 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) );
					}
				}
				else Handler.Handlers.Script.sendToClient( player, 2300 );*/

				if( Handler.Handlers.Script.LegacySpawn )
				{
					local teamid = "Defender";
					if( player.Team != Handler.Handlers.Gameplay.Defender ) teamid = "Attacker";
					if( player.Team == 7 ) teamid = "Spectator";

					if ( Handler.Handlers.Gameplay.Status > 2 ) Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( player.Team ) );
					else Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );
				}

				else 
				{
					Handler.Handlers.Script.sendToClient( player, 4200 );

					local teamid = "Attacker";
					local teamid2 = "Attacker";

					if( Handler.Handlers.Gameplay.Defender == 1 ) teamid = "Defender";
					if( Handler.Handlers.Gameplay.Defender == 2 ) teamid2 = "Defender";

					if ( Handler.Handlers.Gameplay.Status > 2 ) 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ) );
					}				
					else 
					{
						Handler.Handlers.Script.sendToClient( player, 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) );
						Handler.Handlers.Script.sendToClient( player, 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) );
					}
				}
				break;

				case 2200:
			/*	local text = stream.ReadClientString();
				local sp = split( text, "`" );
				
				Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_doodle SET Text = '%s', Author = '%s' WHERE ID = '%d'", Handler.Handlers.Script.Database.EscapeString( sp[0] ), sp[1], sp[2].tointeger() );*/
				break;

				case 5000:
				local text = stream.ReadClientString();

				player.Data.Lticks = text;
				break;

				case 5001:
				local text = stream.ReadClientString();

				player.Data.Jticks = text;
				break;

				case 11:
				::playsound( player, 50060 );
				break;
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerEvents::onReceiveClientData, [%s]", e );
	}

	function onPlayerCommand( player, cmd )
	{
		SqCommand.Run( player, cmd );
	}	


	function onPlayerChat( player, message )
	{
		if( player.Data.Logged )
		{
			if ( message.slice( 0, 1 ) == "'" && player.Authority > 1 )
			{
				Handler.Handlers.Script.AC = 1;
				SqCast.MsgAllAdmin( "AdminChat", player.Name, message.slice( 1 ) );
				Handler.Handlers.Discord.sendToStaff( 0, "``[ADMIN CHAT]`` **%s**: %s", player.Name, ::StripCol( message.slice( 1 ) ) );
				
				SqCore.SetState( 0 );
			}
			
			else if( Handler.Handlers.PlayerUID.CheckMute( player ) )
			{
				if ( message.slice( 0, 1 ) == "\\" )
				{
					SqCast.MsgTeam( player.Team, "TeamChat", SqCast.GetPlayerColor2( player ), ::StripCol( message.slice( 1 ) ) );

					if( !Handler.Handlers.Script.PrivateMode ) 
					{
						Handler.Handlers.Discord.SendToPrivate( format( "**[%s]** ``%s``: %s", SqCast.GetTeamName( player.Team ), player.Name, ::StripCol( message.slice( 1 ) ) ), "tc" );
						SqCast.MsgAllMan( "onPlayerTeamChat", SqCast.GetTeamName( player.Team ), player.Name, ::StripCol( message.slice( 1 ) ) );
					}				

				/*	local getIgnorePlayer = player.Data.Ignore;
					for( local i = 0; i < GetPlayers(); i ++ )
					{
						local plr = FindPlayer( i );
						if ( plr )
						{
							local getIgnorePlr = plr.Data.Ignore;

							if( getIgnorePlr.rawin( player.Data.ID.tostring() ) ) continue;

							if( plr.Data.Logged && plr.Team == player.Team )
							{
								SqCast.MsgPlr( plr, "TeamChat", SqCast.GetPlayerColor2( player ), ::StripCol( message.slice( 1 ) ) );	
							}
						}
					}*/
					SqCore.SetState( 0 );
				}
				else 
				{
					if( Handler.Handlers.Script.AllowPublicChat )
					{
						if( player.Data.PublicChat )
						{
							Handler.Handlers.Discord.ToDiscord( 1, "**%s**: %s", player.Name, ::StripCol( message ) );

							if ( player.Data.aduty ) SqCast.MsgAll2( "asay", player.Name, message );	
							else SqCast.MsgAll3( "Chat", SqCast.GetPlayerColor2( player ), ::StripCol( message ) );						
							/*
							{
								local getIgnorePlayer = player.Data.Ignore;
								for( local i = 0; i < GetPlayers(); i ++ )
								{
									local plr = FindPlayer( i );
									if ( plr )
									{
									//	if( plr.ID == player.ID ) SqCast.MsgPlr( plr, "Chat", SqCast.GetPlayerColor2( player ), ::StripCol( message ) );

										local getIgnorePlr = plr.Data.Ignore;

										//	if( getIgnorePlayer.rawin( plr.ID ) ) continue;
										if( getIgnorePlr.rawin( player.Data.ID.tostring() ) ) continue;

										if( plr.Data.Logged )
										{
											SqCast.MsgPlr( plr, "Chat", SqCast.GetPlayerColor2( player ), ::StripCol( message ) );	
										}
									}
								}
								SqCore.SetState( 0 );
							}	*/
							SqCore.SetState( 0 );
						}

						else 
						{
							SqCast.MsgPlr( player, "CantTalkChatDisabled2" );

							SqCore.SetState( 0 );
						}
						
					}

					else 
					{
						if( player.Authority > 2 ) 
						{
							SqCast.MsgAll3( "Chat", SqCast.GetPlayerColor2( player ), ::StripCol( message ) );

							SqCore.SetState( 0 );
						}
						
						else 
						{
							SqCast.MsgPlr( player, "CantTalkChatDisabled" );

							SqCore.SetState( 0 );
						}
					}
				}
			}
			else 
			{
				SqCast.MsgPlr( player, "CantTalkMuted" );

				SqCore.SetState( 0 );
			}
		}
		else SqCore.SetState( 0 );
	}

	function onPlayerSpawn( player )
	{
		player.Immunity = 0;
		
		if( player.Team == 1 ) Handler.Handlers.Script.Reds++;
		else if( player.Team == 2 ) Handler.Handlers.Script.Blues++;
		else if( player.Team == 7 )
		{
		//	player.Skin = 173;
			player.Immunity = 31;
			player.SetOption( SqPlayerOption.CanAttack, false );
			player.Data.Round = false;
			if ( player.Authority > 1 ) player.Color = Color3( 255, 234, 0 );

			Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );
			Handler.Handlers.Script.sendToClient( player, 2500 );
		}

		for( local i=0; i<GetPlayers() + 10; i ++ )
		{
			local plr = FindPlayer( i );
			if ( plr ) if ( plr.Data.SpectateTarget == player ) plr.Spectate( player );
		}
		
		CheckFreeze( player );

		if( player.Data.aduty )
		{
			player.Immunity = 31;

			player.Colour = Color3( 0, 255, 0 );
		}
	}

	function onPlayerKill( player, killer, reason, bodypart, isteamkill )
	{
		player.Immunity = 0;
		player.Spec = player;
		player.SetOption( SqPlayerOption.CanAttack, true );

		Handler.Handlers.Script.sendToClient( player, 405 ); 
		Handler.Handlers.Script.sendToClient( player, 2501 );
		Handler.Handlers.Script.sendToClient( player, 2801 );
	}

	function onPlayerDeath( player, reason )
	{
		player.Immunity = 0;
		player.Spec = player;
		player.SetOption( SqPlayerOption.CanAttack, true );

		Handler.Handlers.Script.sendToClient( player, 405 ); 
		Handler.Handlers.Script.sendToClient( player, 2501 );
		Handler.Handlers.Script.sendToClient( player, 2801 );
	}

	function onPlayerUnspec( player )
	{			
		Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );

		player.Spec = player;
		Handler.Handlers.Script.sendToClient( player, 2801 );

		if( player.Authority > 1 && player.Team != 7 )
		{
			Handler.Handlers.Script.sendToClient( player, 405 ); 
		}
	}

	function onPlayerPM( player, target, message )
	{
    	if( player.Data.Logged )
		{
			if( Handler.Handlers.PlayerUID.CheckMute( player ) )
			{
				if( target.Data.Logged )
				{
					if( target.ID != player.ID )
					{
						if( target.Data.AllowPM )
						{
							if( !player.Data.Ignore.rawin( target.Data.ID.tostring() ) )
							{
								if( !target.Data.Ignore.rawin( player.Data.ID.tostring() ) )	
								{
									SqCast.MsgPlr( player, "onPlayerPMSender", target.Name, target.ID, message );

									if( player.Data.aduty ) SqCast.MsgPlr( target, "onPlayerPMReceiverA", player.Name, player.ID, message );
									else SqCast.MsgPlr( target, "onPlayerPMReceiver", player.Name, player.ID, message );

									if( !Handler.Handlers.Script.PrivateMode ) 
									{
										Handler.Handlers.Discord.SendToPrivate( format( "**%s** to **%s**: %s", player.Name, target.Name, message ), "pm" );
										SqCast.MsgAllMan( "onPlayerPM", player.Name, target.Name, message );
									}

									if( player.Data.ChatType == "new") player.Message( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" );
									SqCore.SetState( 0 );
								}

								else 
								{
									SqCast.MsgPlr( player, "CantPMTargetIgnored" );

									SqCore.SetState( 0 );
								}
							}

							else 
							{
								SqCast.MsgPlr( player, "CantPMIgoreTarget" );

								SqCore.SetState( 0 );
							}
						}

						else 
						{
							SqCast.MsgPlr( player, "CantPMTargetDisallowPM" );

							SqCore.SetState( 0 );
						}
					}

					else 
					{
						SqCast.MsgPlr( player, "CantPMSelf", player.Name, GeoIP.GetIPCountry( player.ID ) );

						SqCore.SetState( 0 );
					}
				}
				else 
				{
					SqCast.MsgPlr( player, "TargetXOnline" );

					SqCore.SetState( 0 );
				}
			}
			else 
			{
				SqCast.MsgPlr( player, "CantTalkMuted" );

				SqCore.SetState( 0 );
			}
		}
		else 
		{
			SqCast.MsgPlr( player, "CantPMNotLogged" );

			SqCore.SetState( 0 );
		}

		SqCore.SetState( 0 );
	}

	function onPlayerPickedPickup( player, pickup )
	{
		if( pickup.Tag.find( "ToRound" ) >= 0 ) 
		{
			switch( Handler.Handlers.Gameplay.Status )
			{
				case 3:
				local defpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team1Pos;
				local attpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team2Pos;
				
				if ( player.Data.SpawnBan ) SpawnBanCheck( player );
				else
				{
					switch( player.Team )
					{
						case 1:
						case 1:
						if( Handler.Handlers.Gameplay.Defender == 1 ) player.Pos = defpos;
						else player.Pos = attpos;
						break;

						case 2:
						if( Handler.Handlers.Gameplay.Defender == 2 ) player.Pos = defpos;
						else player.Pos = attpos;
						break;
					}
				}
				break;

				case 4:
				case 5:
				local defpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team1Pos;
				local attpos = Handler.Handlers.Bases.Bases[ Handler.Handlers.Gameplay.Bases ].Team2Pos;
				
				if ( player.Data.SpawnBan ) SpawnBanCheck( player );
				else
				{
					switch( player.Team )
					{
						case 1:
						if( Handler.Handlers.Gameplay.Defender == 1 ) player.Pos = defpos;
						else player.Pos = attpos;
						break;

						case 2:
						if( Handler.Handlers.Gameplay.Defender == 2 ) player.Pos = defpos;
						else player.Pos = attpos;
						break;
					}	
				}
				break;
			}
		}

		else if( pickup.Tag.find( "Health" ) >= 0 ) 
		{
			if( pickup.Data.Team == player.Team )
			{
				if( player.Health <= 49 )
				{
					if( ( time() - player.Data.GetHit ) >= 15 )
					{
						if( ( time() - player.Data.HealthPCooldown ) >= 45 )
						{
							pickup.Data.Count --;
							
							local addHPAlgorithm = 100 - player.Health;

							SqCast.MsgPlr( player, "HealthPickupPicked", addHPAlgorithm );

							player.Health += addHPAlgorithm;

							if( pickup.Data.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthRed;Health Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );
							if( pickup.Data.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthBlue;Health Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );

							if( pickup.Data.Count == 0 )
							{
								local getTeam = pickup.Data.Team;

								pickup.Destroy();

								Handler.Handlers.Gameplay.HealthPickup[ getTeam ].Instance = null;

								if( Handler.Handlers.Gameplay.HealthPickup[ getTeam ].Radar.ID != -1 ) Handler.Handlers.Gameplay.HealthPickup[ getTeam ].Radar.Destroy();

								if( getTeam == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthRed; ;0;0;0" );
								if( getTeam == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "HealthBlue; ;0;0;0" );
							}

							player.Data.HealthPCooldown = time();
						}
						else SqCast.MsgPlr( player, "PickupInCD", GetTiming( ( 45 - ( time() - player.Data.HealthPCooldown ) ) ) );
					}
					else SqCast.MsgPlr( player, "PickupGetHit", GetTiming( ( 15 - ( time() - player.Data.GetHit ) ) ) );
				}
				else SqCast.MsgPlr( player, "HealthPickupCantTakeLowerThan40" );
			}
			else SqCast.MsgPlr( player, "PickupCantUseEnemyPickup" );
		}

		else if( pickup.Tag.find( "Armour" ) >= 0 ) 
		{
			if( pickup.Data.Team == player.Team )
			{
				if( player.Armour <= 49 )
				{
					if( ( time() - player.Data.GetHit ) >= 15 )
					{
						if( ( time() - player.Data.ArmourPCooldown ) >= 45 )
						{
							pickup.Data.Count --;

							local addHPAlgorithm = 100 - player.Armour;

							SqCast.MsgPlr( player, "ArmourPickupPicked", addHPAlgorithm );

							player.Armour += addHPAlgorithm;

							if( pickup.Data.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourRed;Armour Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );
							if( pickup.Data.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourBlue;Armour Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );

							if( pickup.Data.Count == 0 )
							{
								local getTeam = pickup.Data.Team;

								pickup.Destroy();

								Handler.Handlers.Gameplay.ArmourPickup[ getTeam ].Instance = null;

								if( Handler.Handlers.Gameplay.ArmourPickup[ getTeam ].Radar.ID != -1 ) Handler.Handlers.Gameplay.ArmourPickup[ getTeam ].Radar.Destroy();
							
								if( getTeam == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourRed; ;0;0;0" );
								if( getTeam == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourBlue; ;0;0;0" );
							}

							player.Data.ArmourPCooldown = time();
						}
						else SqCast.MsgPlr( player, "PickupInCD", GetTiming( ( 45 - ( time() - player.Data.ArmourPCooldown ) ) ) );
					}
					else SqCast.MsgPlr( player, "PickupGetHit", GetTiming( ( 15 - ( time() - player.Data.GetHit ) ) ) );
				}
				else SqCast.MsgPlr( player, "ArmourPickupCantTakeLowerThan50" );
			}
			else SqCast.MsgPlr( player, "PickupCantUseEnemyPickup" );
		}
		
		else if( pickup.Tag.find( "Ammo" ) >= 0 ) 
		{
			if( pickup.Data.Team == player.Team ) 
			{
				if( player.Data.wepSet == 4 || player.Data.wepSet == 5 || player.Data.wepSet == 6 || player.Data.wepSet == 7 )
				{
					if( ( time() - player.Data.AmmoPCooldown ) >= 45 )
					{
						pickup.Data.Count --;

						SqCast.MsgPlr( player, "AmmoPickupPicked" );

						Handler.Handlers.Gameplay.giveSetWeapon( player );

						player.SetWeapon( player.Data.SMGSlot1, 9999 );
						player.SetWeapon( player.Data.SMGSlot2, 9999 );

						if( pickup.Data.Team == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoRed;Ammo Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );
						if( pickup.Data.Team == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoBlue;Ammo Pickup Quatitiy: " + pickup.Data.Count + ";" + pickup.Pos.x + ";" + pickup.Pos.y + ";" + pickup.Pos.z );

						if( pickup.Data.Count == 0 )
						{
							local getTeam = pickup.Data.Team;

							pickup.Destroy();

							Handler.Handlers.Gameplay.AmmoPickup[ getTeam ].Instance = null;

							if( Handler.Handlers.Gameplay.AmmoPickup[ getTeam ].Radar.ID != -1 ) Handler.Handlers.Gameplay.AmmoPickup[ getTeam ].Radar.Destroy();
						
							if( getTeam == 1 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoRed; ;0;0;0" );
							if( getTeam == 2 ) Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoBlue; ;0;0;0" );
						}

						player.Data.AmmoPCooldown = time();
					}
					else SqCast.MsgPlr( player, "PickupInCD", GetTiming( ( 45 - ( time() - player.Data.AmmoPCooldown ) ) ) );
				}
				else SqCast.MsgPlr( player, "AmmoPickupCantTake" );
			}
			else SqCast.MsgPlr( player, "PickupCantUseEnemyPickup" );
		}

		else 
		{
			if( !player.Vehicle ) player.Pos = Vector3.FromStr( pickup.Tag );
		}
	}

	function onPlayerTyping( player )
	{
		if( player.Data.ChatType == "new" ) Handler.Handlers.Script.sendToClient( player, 2601 );
	}

	function onPlayerStopTyping( player )
	{
		if( player.Data.ChatType == "new" ) Handler.Handlers.Script.sendToClient( player, 2602 );
	}

	function onPlayerKeyDown( player, key )
	{
		if( player.Data.Logged )
		{
			switch( key.Tag )
			{
				case "F2":
				switch( player.Data.ChatType )
				{
					case "old":
					player.Data.ChatType = "new";
					player.Message( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" );

					SqCast.MsgPlr( player, "ChatModeSwitch", "KikiUI" );
					break;

					case "new":
					player.Data.ChatType = "old";
					player.Message( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" );

					Handler.Handlers.Script.sendToClient( player, 2603 );
					SqCast.MsgPlr( player, "ChatModeSwitch", "Default" );
					break;
				}
				break;

				case "F3":
				switch( player.Data.TeamESP )
				{
					case true:
					player.Data.TeamESP = false;
					SqCast.MsgPlr( player, "TeamESPSwitchDis" );
					Handler.Handlers.Script.sendToClient( player, 2504, player.Data.TeamESP );
					break;

					case false:
					player.Data.TeamESP = true;
					SqCast.MsgPlr( player, "TeamESPSwitchEn" );
					Handler.Handlers.Script.sendToClient( player, 2504, player.Data.TeamESP );
					break;
				}
			}
		}
	}

	function GetPlayerModuleList( player, list )
	{
		this.WriteTextToFile( player.Data.ID + ".txt", list );
	}

    function WriteTextToFile( id, text )
    {
        local filename = Handler.Handlers.Script.PlayermodulePath + id;
        local fhnd = file(filename, "w");
        foreach(char in text) fhnd.writen(char, 'c'); 
        fhnd.writen('\n', 'c');
        fhnd.close();
        fhnd=null;
    }

	function onPlayerHealthChange(player, old, new )
	{
		if( old > new ) player.Data.GetHit = time();
	}

}