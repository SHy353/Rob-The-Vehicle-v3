class CGameplay
{
 	Status = 0;

 	Bases = 0;

 	Defender = 1;

 	Autostart = true;

 	Replaybase = 0;

 	Lastbase = null;
 	LastDefender = null;

 	RoundTime = 400;
    originRoundTime = 400;

 	VoteBase1 = 0;
 	VoteBase2 = 0;
 	VoteBase3 = 0;
 	VoteBase4 = 0;
 	VoteBase5 = 0;

 	VoteBase1ID = null;
 	VoteBase2ID = null;
 	VoteBase3ID = null;
 	VoteBase4ID = null;
 	VoteBase5ID = null;

 	VehicleMarker = SqBlip.NullInst();
 	DefenderMarker = SqBlip.NullInst();
 	AttackerMarker = SqBlip.NullInst();

 	TargetVehicle = SqVehicle.NullInst();
    vehicleMarker = SqCheckpoint.NullInst();

 	deliverTimer = null;
    DriverName = 0;

    isTimeIncreased = 0;

    voteBase = {};

	RedTeamScore = [];
	BlueTeamScore = [];

	StartTimer = null;

	TryingToEnter = false;

	getScoreMVP = 0
	getScoreMVPName = null;
	
	TVBurning = false;

	HealthPickup = {};
	ArmourPickup = {};
	AmmoPickup = {};

	isEnding = false;

	BlueTeamName = "Blue Team";
	RedTeamName = "Red Team";

	RedTeamScore2 = 0;
	BlueTeamScore2 = 0;

	Mine = {};

	TimeInc = 0;

	function constructor()
	{
		SqCore.On().PlayerDestroyed.Connect( this, onPlayerDisconnect ); 
	/*	SqCore.On().PlayerRequestSpawn.Connect( this, onPlayerRequestSpawn );
		SqCore.On().PlayerRequestClass.Connect( this, onPlayerRequestClass );*/
		SqCore.On().PlayerSpawn.Connect( this, onPlayerSpawn );
		SqCore.On().PlayerKilled.Connect( this, onPlayerKill );
		SqCore.On().PlayerWasted.Connect( this, onPlayerDeath );
		SqCore.On().PlayerKeyPress.Connect( this, onPlayerKeyDown );

		SqCore.On().PlayerEmbarking.Connect( this, onPlayerAttemptEnterVehicle );
		SqCore.On().PlayerEmbarked.Connect( this, onPlayerEnterVehicle );
		SqCore.On().PlayerDisembark.Connect( this, onPlayerExitVehicle );
		SqCore.On().VehicleRespawn.Connect( this, onVehicleRespawn );
	//	SqCore.On().VehicleExplode.Connect( this, onVehicleExplode );
		SqCore.On().VehicleHealth.Connect( this, onVehicleHealth );

		SqCore.On().CheckpointEntered.Connect( this, onCheckpointEntered );
		SqCore.On().CheckpointExited.Connect( this, onCheckpointExited );
		SqCore.On().ObjectShot.Connect( this, onObjectShot );
		SqCore.On().VehicleDamageData.Connect( this, onVehicleDamage );
		SqCore.On().PlayerWeapon.Connect( this, onPlayerWeaponChange );

		for( local i = 0; i < 6; ++i )
		{
		    this.voteBase.rawset( i, 
		    {
		    	ID = 0,
		    	Count = 0,
		    });
		}

		HealthPickup.rawset( 1,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

		HealthPickup.rawset( 2,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

		ArmourPickup.rawset( 1,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

		ArmourPickup.rawset( 2,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

		AmmoPickup.rawset( 1,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

		AmmoPickup.rawset( 2,
		{
			Cooldown = 0,
			Instance = null,
			Radar = SqBlip.NullInst(),
		});

	}

	function onPlayerSpawn( player )
	{
    	//try 
    	//{
			Handler.Handlers.Script.sendToClient( player, 403 );
			player.Data.LastPing = [];
			if( !Handler.Handlers.Script.LegacySpawn ) player.Pos = Vector3( -966.268921,-252.156738,369.886597 );

		//	PlayJingles( player );
			
			switch( player.Team )
			{
				case 1:
				player.Colour = Color3( 255, 51, 0 );
				if ( this.Status >= 3 ) player.Data.Round = true;
				Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:51:0:" + player.Team );
				Handler.Handlers.Script.sendToClient( player, 2503, player.Team );

				if( !Handler.Handlers.Script.LegacySpawn )
				{
					local teamid = "Attacker";
					local teamid2 = "Attacker";

					if( Handler.Handlers.Gameplay.Defender == 1 ) teamid = "Defender";
					if( Handler.Handlers.Gameplay.Defender == 2 ) teamid2 = "Defender";

					if ( Handler.Handlers.Gameplay.Status > 2 ) 
					{
						Handler.Handlers.Script.sendToClientToAll( 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 ) );
						Handler.Handlers.Script.sendToClientToAll( 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ) );
					}				
					else 
					{
						Handler.Handlers.Script.sendToClientToAll( 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) );
						Handler.Handlers.Script.sendToClientToAll( 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) );
					}
				}
				break;

				case 2:
				player.Colour = Color3( 51, 102, 255 );
				if ( this.Status >= 3 ) player.Data.Round = true;
				Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":51:102:255:" + player.Team );
				Handler.Handlers.Script.sendToClient( player, 2503, player.Team );

				if( !Handler.Handlers.Script.LegacySpawn )
				{
					local teamid = "Attacker";
					local teamid2 = "Attacker";

					if( Handler.Handlers.Gameplay.Defender == 1 ) teamid = "Defender";
					if( Handler.Handlers.Gameplay.Defender == 2 ) teamid2 = "Defender";

					if ( Handler.Handlers.Gameplay.Status > 2 ) 
					{
						Handler.Handlers.Script.sendToClientToAll( 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 ) );
						Handler.Handlers.Script.sendToClientToAll( 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ) );
					}				
					else 
					{
						Handler.Handlers.Script.sendToClientToAll( 4300, SqCast.GetTeamColorOnly( 1 ) + SqCast.GetTeamName( 1 ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) );
						Handler.Handlers.Script.sendToClientToAll( 4400, SqCast.GetTeamColorOnly( 2 ) + SqCast.GetTeamName( 2 ) + " - " + teamid2 + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) );
					}
				}
				break;
			}
			
			switch( this.Status )
			{
				case 0:
				if( this.getPlayerTeamCountV2( 1 ) > 0 && getPlayerTeamCountV2( 2 ) > 0 && Handler.Handlers.Script.Autostart ) this.PrepRound();

				if( player.Data.wepSet == 4 )
				{
					if( this.checkSameRPGOwner( player, this.GetRPGSetInTeam( player.Team ) ) )
					{
						player.Data.wepSet = 1;
					}
				}
				break;

				case 1:
				if( player.Data.wepSet == 4 )
				{
					if( this.checkSameRPGOwner( player, this.GetRPGSetInTeam( player.Team ) ) )
					{
						player.Data.wepSet = 1;
					}
				}
				
				if( this.Replaybase == 0 && Handler.Handlers.Script.Autostart )
				{
					if( player.Team == 1 || player.Team == 2 )
					{
						if( !Handler.Handlers.PlayerUID.checkVote( player.UID, player.UID2 ) )
						{
							local getBase1Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 0 ].ID == 0 ) ? 1 : this.voteBase[ 0 ].ID ].Name;
							local getBase2Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 1 ].ID == 0 ) ? 1 : this.voteBase[ 1 ].ID ].Name;
							local getBase3Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 2 ].ID == 0 ) ? 1 : this.voteBase[ 2 ].ID ].Name;
							local getBase4Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 3 ].ID == 0 ) ? 1 : this.voteBase[ 3 ].ID ].Name;
							local getBase5Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 4 ].ID == 0 ) ? 1 : this.voteBase[ 4 ].ID ].Name;
							local getBase6Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 5 ].ID == 0 ) ? 1 : this.voteBase[ 5 ].ID ].Name;

							local getBase1Vote = this.voteBase[ 0 ].Count; 
							local getBase2Vote = this.voteBase[ 1 ].Count; 
							local getBase3Vote = this.voteBase[ 2 ].Count; 
							local getBase4Vote = this.voteBase[ 3 ].Count; 
							local getBase5Vote = this.voteBase[ 4 ].Count; 
							local getBase6Vote = this.voteBase[ 5 ].Count; 

							Handler.Handlers.Script.sendToClient( player, 301, getBase1Name + "," + getBase2Name + "," + getBase3Name + "," + getBase4Name + "," + getBase5Name + "," + getBase6Name );
							Handler.Handlers.Script.sendToClient( player, 300, getBase1Vote + "," + getBase2Vote + "," + getBase3Vote + "," + getBase4Vote + "," + getBase5Vote + "," + getBase4Vote );
							Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "VoteBaseNotice" ) );
						}
					}
				}
		    	break;

				case 3:
				local defpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team1Pos;
				local attpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team2Pos;
				
			/*	if( player.Data.wepSet == 4 )
				{
					if( this.checkSameRPGOwner( player, this.GetRPGSetInTeam( player.Team ) ) )
					{
						SqCast.MsgPlr( player, "PackChangeSameRPG", this.GetRPGSetInTeam( player.Team ).Name );

						player.Data.wepSet = 1;
					}
				}
			*/
				if ( player.Data.SpawnBan ) SpawnBanCheck( player );
				else
				{
					switch( player.Team )
					{
						case 1:
						if( this.Defender == 1 ) 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = defpos;
							}, 500, 1 );

							Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Defender" );
						}

						else 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = attpos;
							}, 500, 1 );

							Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Attacker" );
						}

						player.SetOption( SqPlayerOption.Controllable, false );
						Handler.Handlers.Script.sendToClient( player, 500 );

						SqCast.MsgPlr( player, "PressBCloseMenu" );

						player.Data.WasInRound = true;
						break;

						case 2:
						if( this.Defender == 2 ) 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = defpos;
							}, 500, 1 );

							Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Defender" );
						}

						else 
						{                 		
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = attpos;
							}, 500, 1 );

							Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Attacker" );
						}

						player.SetOption( SqPlayerOption.Controllable, false );
						Handler.Handlers.Script.sendToClient( player, 500 );

						SqCast.MsgPlr( player, "PressBCloseMenu" );

						player.Data.WasInRound = true;
						break;
					}
				}

				case 4:
				case 5:
				local defpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team1Pos;
				local attpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team2Pos;

			/*	if( player.Data.wepSet == 4 )
				{
					if( this.checkSameRPGOwner( player, this.GetRPGSetInTeam( player.Team ) ) )
					{
						SqCast.MsgPlr( player, "PackChangeSameRPG", this.GetRPGSetInTeam( player.Team ).Name );

						player.Data.wepSet = 1;
					}
				}
			*/	
				if ( player.Data.SpawnBan ) SpawnBanCheck( player );
				else
				{
					local oldtext = "Rob The Vehicle";

					switch( player.Team )
					{
						case 1:
						if( this.Defender == 1 ) 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = defpos;
							}, 500, 1 );

							oldtext = player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Defender";
						}

						else 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = attpos;
							}, 500, 1 );

							oldtext = player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Attacker";
						}

						this.giveSetWeapon( player );

						player.SetWeapon( player.Data.SMGSlot1, 9999 );
						player.SetWeapon( player.Data.SMGSlot2, 9999 );

						player.World = player.UniqueWorld;
						player.Data.setCount = 0;
						player.Data.WasInRound = true;

						this.setPlayerSpawnProtect( player, oldtext );
						break;

						case 2:
						if( this.Defender == 2 ) 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = defpos;
							}, 500, 1 );

							oldtext = "128$159$255$-Playing as Defender";
						}

						else 
						{
							player.MakeTask( function() 
							{
								if( Handler.Handlers.Gameplay.Status > 2 ) player.Pos = attpos;
							}, 500, 1 );

							oldtext = "128$159$255$-Playing as Attacker";
						}

						this.giveSetWeapon( player );

						player.SetWeapon( player.Data.SMGSlot1, 9999 );
						player.SetWeapon( player.Data.SMGSlot2, 9999 );

						player.World = player.UniqueWorld;
						player.Data.setCount = 0;
						player.Data.WasInRound = true;

						this.setPlayerSpawnProtect( player, oldtext );
						break;
					}	
				}
			}

			if( player.Data.aduty )
			{
				player.Immunity = 31;

				player.Colour = Color3( 0, 255, 0 );
			}

		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onPlayerSpawn, [%s]", e );
	}
	
	function onObjectShot( player, object, weapon )
	{
		if( object.Tag.find( "Mine" ) >= 0 ) 
		{
			this.Mine.rawdelete( object.ID );
			object.Destroy();

			SqCast.MsgPlr( player, "DestroyMine" );
		}
	}

	function setPlayerSpawnProtect( player, oldtext )
	{
		Handler.Handlers.Script.sendToClient( player, 401, "255$153$51$-Spawn Protection: 3" );

		local tcountdown = 0;
	    local tim = SqRoutine( this, function()
   		{
			tcountdown ++;
    		switch( tcountdown )
	    	{
	    		case 1:
	    	 	if ( player.Spawned ) Handler.Handlers.Script.sendToClient( player, 401, "255$153$51$-Spawn Protection: 2" );
	    		break;

    			case 2:
    			if ( player.Spawned ) Handler.Handlers.Script.sendToClient( player, 401, "255$153$51$-Spawn Protection: 1" );
    			break;

    			case 3:
				{
					if ( player.Spawned )
					{
						Handler.Handlers.Script.sendToClient( player, 401, "255$153$51$-Spawned!" );
						player.SetOption( SqPlayerOption.CanAttack, true );
						player.World = 0;
						player.Alpha = 255;
						for( local i=0; i<GetPlayers() + 10; i ++ )
						{
							local plr = FindPlayer( i );
							if ( plr ) if ( plr.Data.SpectateTarget == player && !plr.Data.InRound( plr ) ) plr.Spectate( player );
						}
					}
					break;
				}
				case 4:
				if ( player ) Handler.Handlers.Script.sendToClient( player, 401, oldtext );
				break;
			}
		}, 1000, 4 )
		
		tim.SetTag( "SpawnProtect" );
		tim.Quiet = false;
		/*	if( lastpos.tostring() == player.Pos.tostring() )
			{
				if ( ++this.Data >= 5 )
				{
					player.SetOption( SqPlayerOption.CanAttack, true );
					player.Immunity = 0;

					this.Terminate();
					return;
				}
			 }

			else 
			{
				player.SetOption( SqPlayerOption.CanAttack, true );
				player.Immunity = 0;

				this.Terminate();
				return;
			}*/
        //}, 500, 10, player.Pos );	
    }

	function InitCoundownUI( player )
	{
    	//try 
    	//{
			if( this.Status > 1 ) 
			{
				Handler.Handlers.Script.sendToClient( player, 400, this.RoundTime );
				Handler.Handlers.Script.sendToClient( 415, this.TargetVehicle.tostring() );
			}

			if( this.Status == 5 )
			{
				Handler.Handlers.Script.sendToClient( player, 400, "pause" );
			//	Handler.Handlers.Script.sendToClient( 415, 40000 );
			}
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::InitCoundownUI, [%s]", e );		
	}

	function getPlayerTeamCount( team )
	{
    	//try 
    	//{
			local count = 0;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( player.Team == team ) count ++;
			});

			return count;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getPlayerTeamCount, [%s]", e );
	}

	function PrepRound()
	{
    	if( !this.isEnding )
    	{
				local getTimer4 = Handler.Handlers.Script.findRoutine( "EndRound2" );

    			if( getTimer4 ) getTimer4.Terminate();

				if( this.Replaybase > 0 && this.Lastbase != null )
		    	{
		    		SqCast.sendAlertToAll( "Replaybase", 30 );

		    		this.Status = 1;

		    	//	print( "Replaybase :: " );

	    			local tcountdown = 0;
								 
		    		local tim = SqRoutine( this, function()
		    		{
		    		//	print( "Replaybase :: " + tcountdown + " :: " + this.getPlayerTeamCount( 1 ) + " ::: " + this.getPlayerTeamCount( 2 ) );

		    			tcountdown ++;
		    			if( this.getPlayerTeamCount( 1 ) >= 1 && this.getPlayerTeamCount( 2 ) >= 1 )
			    		{
			    			switch( tcountdown )
				    		{
				    			case 5:
								SqServer.SetGameSpeed( 1 );
				    			SqCast.sendAlertToAll( "Replaybase", 25 );
				    			break;

				    			case 10:
				    			SqCast.sendAlertToAll( "Replaybase", 20 );
				    			break;

				    			case 15:
				    			SqCast.sendAlertToAll( "Replaybase", 15 );
				    			break;
								
				    			case 20:
				    			SqCast.sendAlertToAll( "Replaybase", 10 );
				    			break;

								case 25:
				    			SqCast.sendAlertToAll( "Replaybase", 5 );
				    			break;

								case 30:
				    			this.StartBase( this.Lastbase );
								playsoundforall( 170 );
				    			break;
				    		}
			    		}

		                else 
		                {
			    		//	print( "Replaybase terminated :: " + tcountdown + " :: " + this.getPlayerTeamCount( 1 ) + " ::: " + this.getPlayerTeamCount( 2 ) );
		                	this.EndVote();
		                //	this.Terminate();
		                }
		    		}, 1000, 32 )
					
					tim.SetTag( "PrepRound" );
					tim.Quiet = false;
		    	}

		    	else 
		    	{
		    	//	print( "VoteBase :: " );
		    		this.voteBase = {};

		    		for( local i = 0; i < 6; ++i )
		    		{
		    			this.voteBase.rawset( i, 
		    			{
		    				ID = Handler.Handlers.Bases.chooseBase(),
		    				Count = 0,
		    			});
		    		}

		    		local getBase1Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 0 ].ID == 0 ) ? 1 : this.voteBase[ 0 ].ID ].Name;
		    		local getBase2Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 1 ].ID == 0 ) ? 1 : this.voteBase[ 1 ].ID ].Name;
		    		local getBase3Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 2 ].ID == 0 ) ? 1 : this.voteBase[ 2 ].ID ].Name;
		    		local getBase4Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 3 ].ID == 0 ) ? 1 : this.voteBase[ 3 ].ID ].Name;
		    		local getBase5Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 4 ].ID == 0 ) ? 1 : this.voteBase[ 4 ].ID ].Name;
		    		local getBase6Name = Handler.Handlers.Bases.Bases[ ( this.voteBase[ 5 ].ID == 0 ) ? 1 : this.voteBase[ 5 ].ID ].Name;

		    		this.Status = 1;

					SqServer.SetGameSpeed( 1 );

					Handler.Handlers.PlayerUID.ResetVote();

					SqForeach.Player.Active( this, function( player ) 
					{			
						this.UpdateBasevote( player );
			
						if( ( player.Team == 1 ) || ( player.Team == 2 ) && ( player.Spawned ) )
						{
							if( player.Spawned )
							{
								Handler.Handlers.Script.sendToClient( player, 301, getBase1Name + "," + getBase2Name + "," + getBase3Name + "," + getBase4Name + "," + getBase5Name + "," + getBase6Name );
							
								Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "VoteBaseNotice" ) );
							}
						}
					});


	    			local tcountdown = 0;
		    		local tim = SqRoutine( this, function()
		    		{
		    			if( this.getPlayerTeamCount( 1 ) >= 1 && this.getPlayerTeamCount( 2 ) >= 1 )
			    		{
			    		//	print( "VoteBase :: " + tcountdown );
			    			
			    			tcountdown ++;
			    			if( tcountdown == 20 )
			    			{
								SqForeach.Player.Active( this, function( player ) 
								{
				    			 	player.Data.voteBase = null;

									Handler.Handlers.Script.sendToClient( player, 302 );
			                    });

								Status = 2;
			                    SelectBase();
			                }
		                }

		                else 
		                {
		                	this.EndVote();
		                //	this.Terminate();
		                }
		    		}, 1000, 32 );

					tim.SetTag( "PrepRound" );
					tim.Quiet = false;
		    	}
		}
	}

	function SelectBase()
	{
	//	try 
	//	{	
		//	print( "SelectBase :: " );		

			local count = 0, finalBase = 0;
			foreach( index, value in this.voteBase )
			{
				if( value.Count > count ) 
				{
					count = value.Count;
					finalBase = value.ID;
				}
			}

			if( count == 0 ) finalBase = this.voteBase[ ( rand() % this.voteBase.len() ) ].ID;

			this.Bases = finalBase;

			if( finalBase == 0 ) this.Bases = 1;

			this.StartBase( this.Bases );

		    for( local i = 0; i < 6; ++i )
		    {
		    	this.voteBase.rawset( i, 
				{
					ID = finalBase,
					Count = count,
				});
		    }

			SqForeach.Player.Active( this, function( player ) 
			{
				this.UpdateBasevote( player );
			});
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::SelectBase, [%s]", e );
	}

	function StartBase( bases ) 
	{
    	//try 
    	//{
		//	print( "StartBase :: " + bases );			
			
			local defpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team1Pos;
			local attpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team2Pos;
			local getbasename = ( SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetAccountNameFromID( Handler.Handlers.Bases.Bases[ this.Bases ].Author ) ) ) == "[#ffffff]Undefined" ? "RTV" : SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetAccountNameFromID( Handler.Handlers.Bases.Bases[ this.Bases ].Author ) );
            local getmvp = ( SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetAccountNameFromID( Handler.Handlers.Bases.Bases[ this.Bases ].TopPlayer ) ) ) == "[#ffffff]Undefined" ? "None" : SqCast.GetPlayerColor( Handler.Handlers.PlayerAccount.GetAccountNameFromID( Handler.Handlers.Bases.Bases[ this.Bases ].TopPlayer ) );
			local getOldReadableTime = format( "%02d:%02d", date( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ).min, date( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ).sec );
		
			this.TargetVehicle = SqVehicle.Create( Handler.Handlers.Bases.Bases[ this.Bases ].VehicleModel, 0, Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos, Handler.Handlers.Bases.Bases[ this.Bases ].VehicleAngle, this.getDefVehicleColor(), this.getDefVehicleColor() );
			this.VehicleMarker = SqBlip.Create( 0, Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos, 2, Color4( 255, 255, 255, 255 ), this.getSpriteIDBySide() );
			this.DefenderMarker = SqBlip.Create( 0, Handler.Handlers.Bases.Bases[ this.Bases ].SpherePos, 2, Color4( 255, 255, 255, 255 ), 101 );
			this.vehicleMarker =  SqCheckpoint.Create( 0, true, Handler.Handlers.Bases.Bases[ this.Bases ].SpherePos, this.getAttSphereColor(), 5 );
				
			if ( this.Replaybase != 2 ) this.Replaybase ++;
			this.Status = 3;
			this.Lastbase = this.Bases;
	       	this.LastDefender = this.Defender;
	       	this.TargetVehicle.Immunity = 31;
	        this.RoundTime = 10;

			Handler.Handlers.Bases.Bases[ this.Bases ].Selected = true;

			Handler.Handlers.Bases.resetVoteHistory();

			Handler.Handlers.Script.sendToClientToAll( 3101 );
			Handler.Handlers.Script.sendToClientToAll( 415, this.TargetVehicle.tostring() );

	       	SqCast.MsgAll( "PrepRound", Handler.Handlers.Bases.Bases[ this.Bases ].Name, SqCast.GetTeamName( this.Defender ) );
	       	SqCast.MsgAll( "BaseInfo", getbasename, getmvp, getOldReadableTime );

			SqForeach.Player.Active( this, function( player ) 
			{
				if( player.Data.InRound( player ) )
				{
					player.Data.Round = true;
					switch( player.Team )
					{
						case 1:
						player.Data.AssignedTeam = 1;
						if( this.Defender == 1 ) 
						{
							Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Defender" );
							player.Pos = defpos;
						}
	                   	else
	                   	{
							Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Playing as Attacker" );
	                   		player.Pos = attpos;
	                   	}

						player.SetOption( SqPlayerOption.Controllable, false );
						Handler.Handlers.Script.sendToClient( player, 500 );

                		SqCast.MsgPlr( player, "PressBCloseMenu" );
						SqCast.MsgPlr( player, "SurrenderS" );
						break;

						case 2:
						player.Data.AssignedTeam = 2;
						if( this.Defender == 2 ) 
						{
							Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Defender" );
							player.Pos = defpos;
						}
	                   	else
	                   	{
							Handler.Handlers.Script.sendToClient( player, 401, "128$159$255$-Playing as Attacker" );
	                   		player.Pos = attpos;
	                   	}

						player.SetOption( SqPlayerOption.Controllable, false );
						Handler.Handlers.Script.sendToClient( player, 500 );
						
						SqCast.MsgPlr( player, "PressBCloseMenu" );
						SqCast.MsgPlr( player, "SurrenderS" );
						break;
					}

					player.Health = 100;
					player.Armour = 0;
					player.Score = 0;
					player.Data.CurrentStats.RoundKills = 0;
					player.Data.CurrentStats.RoundDeaths = 0;
					player.Data.CurrentStats.RoundAssist = 0;
					player.Data.CurrentStats.RoundSpree = 0;
					player.Data.CurrentStats.Score = 0;

					if( player.Data.aduty ) Handler.Handlers.Script.sendToClient( player, 401, player.Color.R + "$" + player.Color.G + "$" + player.Color.B + "$-Admin Duty" );
				}
				Handler.Handlers.Script.sendToClient( player, 400, "10" );
			});

			local tcountdown = 0;
		    local tim = SqRoutine( this, function()
		    {
		    	tcountdown ++;
		    	if( this.getPlayerTeamCount( 1 ) >= 1 && this.getPlayerTeamCount( 2 ) >= 1 )
			   	{		
					switch ( tcountdown )
					{
						case 1: playsoundforall( random( 50008, 50015 ) ); break;
						case 5: playsoundforall( random( 50007, 50014 ) ); break;
						case 10: this.StartRound(), playsoundforall( 369 ), playsoundforall( 367 ); break;
					}
			    }

			    else 
			    {
			    	this.EndPrep();
			//    	this.Terminate();
			    }
		    }, 1000, 10 );
			
			tim.SetTag( "StartBase" );
			tim.Quiet = false;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::StartBase, [%s]", e );			
	}

	function StartRound()
	{
    	try 
    	{
			this.Status = 4;
			this.RoundTime = this.originRoundTime;
			this.StartTimer = time();
			this.isTimeIncreased = 0;
			Handler.Handlers.Script.RoundActive = true;

	        SqCast.MsgAll( "RoundStart", Handler.Handlers.Bases.Bases[ this.Bases ].Name, SqCast.GetTeamName( this.Defender ) );
			Handler.Handlers.Discord.ToDiscord( 1, "**-> Round started: Base ``%s`` Defender ``%s``**", Handler.Handlers.Bases.Bases[ this.Bases ].Name, SqCast.GetTeamName( this.Defender ) );			

			Handler.Handlers.Matchlogger.BeginRecord( this.Bases, Handler.Handlers.Bases.Bases[ this.Bases ].Name, this.Defender );

			Handler.Handlers.Gameplay.HealthPickup[ 1 ].Radar = SqBlip.NullInst();
			Handler.Handlers.Gameplay.HealthPickup[ 2 ].Radar = SqBlip.NullInst();
			Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Radar = SqBlip.NullInst();
			Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Radar = SqBlip.NullInst();
			Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Radar = SqBlip.NullInst();
			Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Radar = SqBlip.NullInst();

			SqPickup.Create( 411, 0, 1, Vector3( -966.268921,-252.156738,370.886597 ), 255, false ).SetTag( "ToRound" );

			SqForeach.Player.Active( this, function( player ) 
			{
				player.Data.WasInRound = false;

				if( player.Data.InRound( player ) )
				{
					player.SetOption( SqPlayerOption.Controllable, true );

					player.Health = 100;
					player.Armour = 0;

					Handler.Handlers.Script.sendToClient( player, 501 );

					player.Data.setCount = 0;
					player.Data.FPSWarning = 0;
					player.Data.PingWarning = 0;
					player.Data.AFKCount = 0;

					player.Data.WasInRound = true;

					this.giveSetWeapon( player );
					player.SetWeapon( player.Data.SMGSlot1, 9999 );
					player.SetWeapon( player.Data.SMGSlot2, 9999 );
				}
				Handler.Handlers.Script.sendToClient( player, 400, this.RoundTime );

				player.Health = 100;
				player.Armour = 0;
				player.Score = 0;
				player.Data.CurrentStats.RoundKills = 0;
				player.Data.CurrentStats.RoundDeaths = 0;
				player.Data.CurrentStats.RoundAssist = 0;
				player.Data.CurrentStats.RoundSpree = 0;
				player.Data.CurrentStats.Score = 0;
			});

			local tim = SqRoutine( this, function()
	    	{
	    		this.RoundTime --;

				this.CheckVehicleHealth();
				this.CheckVehicleOriginPos();

				if( this.RoundTime % 15 == 0 )
				{
					Handler.Handlers.Script.sendToClientToAll( 400, this.RoundTime );
				}

				if( this.RoundTime == 30 ) 
				{
					if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "30 seconds remaining." );
				}

				if( this.RoundTime == 20 ) 
				{
					if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "20 seconds remaining." );
				}

				if( this.RoundTime == 10 ) 
				{
					if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "10 seconds remaining." );
				}

	    		if( this.RoundTime <= 0 )
	    		{
	    			this.EndRound( 0 );
	    		}
	    	}, 1000, 0 );

			tim.SetTag( "StartRound" );
			tim.Quiet = false;

			local counter = 0;
	    	local tim2 = SqRoutine( this, function()
	    	{
				counter ++;

	    		if( this.getPlayerTeamCount( 1 ) <= 0 || this.getPlayerTeamCount( 2 ) <= 0 ) this.EndRound( 2, true, ( this.getPlayerTeamCount( 2 ) < 0 ) ? 2 : 1 );

	    		if( this.TargetVehicle != null ) 
	    		{
					if( this.TargetVehicle.ID != -1 )
					{
						if ( this.TargetVehicle.Health < 250 && this.TVBurning == false ) playsoundforall( 50029 ), SqCast.MsgAll( "TargetVehOnFire" ), this.TVBurning = true;		
						if( ( this.TargetVehicle.ID != -1 ) && this.TargetVehicle.Pos.DistanceTo( Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos ) > 2500 ) 
						{
							this.TargetVehicle.Respawn();
							playsoundforall( 50020 );

							SqCast.sendAlertToAll( "TargetExeededLimitRespawnVehicle" );
						}
					}
	    		}

				SqForeach.Player.Active( this, function( player ) 
				{
					SqForeach.Player.Active( this, function( plr ) 
					{
						if( player.Spec.ID == plr.ID )
						{
							local ratio = ( typeof( plr.Data.CurrentStats.RoundKills.tofloat() / plr.Data.CurrentStats.RoundDeaths.tofloat() ) != "float" ) ? 0.00 : plr.Data.CurrentStats.RoundKills.tofloat() / plr.Data.CurrentStats.RoundDeaths.tofloat();

							Handler.Handlers.Script.sendToClient( player, 2800, " ;" + plr.Name + ";" + plr.Data.CurrentStats.RoundKills + ";" + plr.Data.CurrentStats.RoundDeaths + ";" + format( "%.2f", ratio ) + ";" + plr.Score );
						}
					});
				});

				if( counter % 5 == 0 )
				{
					this.CheckPlayerAFK();
				}

				if( counter % 15 == 0 )
				{
					if( Handler.Handlers.Script.KickLagger )
					{
						this.CheckPlayerFPS2();
						this.CheckPlayerPing2();

						if( counter % 25 == 0 ) this.CheckPlayerJitter2();
					}

					else 
					{
						this.CheckPlayerFPS();
						this.CheckPlayerPing();

						if( counter % 25 == 0 ) this.CheckPlayerJitter();
					}
				}
				this.CheckMine();


	    	}, 1000, 0 );
			
			tim2.SetTag( "DuringRound" );
			tim2.Quiet = false;
		}
		catch( e ) SqLog.Err( "Error on CGameplay::StartRound, [%s]", e );			
	}

	function EndRound( type, issurrender = false, team = null )
	{
    	//try 
    	//{
			Handler.Handlers.Script.RoundActive = false;
			
			AnnounceAll( "", 5 );
						
			local getTimer = Handler.Handlers.Script.findRoutine( "StartRound" );
			local getTImer2 = Handler.Handlers.Script.findRoutine( "DuringRound" );
			local getTImer3 = Handler.Handlers.Script.findRoutine( "RespawnVehicle" );
    		local getTimer4 = Handler.Handlers.Script.findRoutine( "MarkerFollowVehicle" );

    		if( getTimer ) getTimer.Terminate();
    		if( getTImer2 ) getTImer2.Terminate();
    		if( getTImer3 ) getTImer3.Terminate();
    		if( getTimer4 ) getTimer4.Terminate();

    		if( this.TargetVehicle.ID != -1 ) this.TargetVehicle.Destroy();
			if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();
			if( this.DefenderMarker.ID != -1 ) this.DefenderMarker.Destroy();
			if( this.vehicleMarker.ID != -1 ) this.vehicleMarker.Destroy();
			
			this.Status = 0;
			this.Lastbase = this.Bases;
        	this.LastDefender = this.Defender;
			this.TryingToEnter = false;
			this.RemovePickup();

			if( !issurrender )
			{ 
				this.GetWinType( type );

				if( this.Replaybase == 2 ) this.Replaybase = 0;
				this.SwitchDefender();
			}
			else
			{
				SqCast.MsgAll( "TeamSurrender", SqCast.GetTeamName( team ), HexColour.Yellow );
				Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` has forfeited the round.**", SqCast.GetTeamName( team ) );
			}

			Handler.Handlers.Script.sendToClientToAll( 400, "end" );
			Handler.Handlers.Script.sendToClientToAll( 501, "end" );
            Handler.Handlers.Script.sendToClientToAll( 401, "255$255$255$-Rob The Vehicle" );
			Handler.Handlers.Script.sendToClientToAll( 2801 );

			if( issurrender ) this.TeleportToLobbySurrender();

			this.GetRedScore();
			this.GetBlueScore();

			local getoutput = Handler.Handlers.Matchlogger.EndRound( type );

			if( Handler.Handlers.Script.MatchLogging ) 
			{
				SqCast.MsgAll( "GetRoundStatsOutput", getoutput );
				Handler.Handlers.Discord.ToDiscord( 1, "***-> You can view this round's statistics on %s***", getoutput );
			}
			
			Handler.Handlers.Script.first_damage = false;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::EndRound, [%s]", e );			
	}

	function onReceiveClientData( player, id, stream )
	{
    	//try 
    	//{
			switch( id )
			{
				case 200:
				local text = stream.ReadClientString();

				if( this.Replaybase == 0 )
				{
					if( player.Spawned && ( player.Team == 1 || player.Team == 2 ) )
					{
						player.Data.voteBase = true;

						Handler.Handlers.PlayerUID.SetVote( player.UID, player.UID2, true );

						this.voteBase[ text.tointeger() ].Count ++;

						Handler.Handlers.Script.sendToClientToAll( 300, this.voteBase[ 0 ].Count + "," + this.voteBase[ 1 ].Count + "," + this.voteBase[ 2 ].Count + "," + this.voteBase[ 3 ].Count + "," + this.voteBase[ 4 ].Count + "," + this.voteBase[ 5 ].Count );				
					}
				}
				break;

				case 500:
				if( this.Status > 1 )
				{
					local text = stream.ReadClientString();

					if( this.Status >= 3 )
					{
						if( text.tointeger() != player.Data.wepSet )
						{				
							local packid = text.tointeger();
							local Script = Handler.Handlers.Script;
							
						//	if( text.tointeger() == 4 && Script.PackLim[ 4 ].tointeger() == 1 && this.GetRPGSetInTeam( player.Team ) ) Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "CantTakeRPG", this.GetRPGSetInTeam( player.Team ).Name ) );
							if( text.tointeger() == 4 && !Handler.Handlers.PlayerUID.CheckRPGBan( player ) ) 
							{
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "CantTakeRPGBanned" ) ); 

								::playsound( player, 50061 );
							}

						/*	else if ( player.Team == 1 && Script.RedPackLim[ packid ].tointeger() >= Script.PackLim[ packid ].tointeger() ) Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "SetLimitReached" ) );
							else if ( player.Team == 2 && Script.BluePackLim[ packid ].tointeger() >= Script.PackLim[ packid ].tointeger() ) Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "SetLimitReached" ) );
							
							else if ( this.Status > 3 && Script.EventMode )
							{
								if ( player.Team == 1 && Script.RedPackLim[ player.Data.wepSet.tointeger() ].tointeger() > 0 ) 
								{
									local oldpack = Script.RedPackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.RedPackLim[ packid ].tointeger();

									Handler.Handlers.Script.RedPackLim[ player.Data.wepSet ] = ( oldpack - 1 );
									Handler.Handlers.Script.RedPackLim[ packid ] = ( newpack + 1 );
								}
								if ( player.Team == 2 && Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger() > 0 ) 
								{
									local oldpack = Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.BluePackLim[ packid ].tointeger();

									Handler.Handlers.Script.BluePackLim[ player.Data.wepSet.tointeger() ] = ( oldpack - 1 );
									Handler.Handlers.Script.BluePackLim[ packid ] = ( newpack + 1 );
								}
								player.Data.wepSet = text.tointeger();							
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "ChangePackNextSpawn" ) );
							}
							else if ( player.Data.setCount > 0 && this.Status > 3 )
							{
								if ( player.Team == 1 && Script.RedPackLim[ player.Data.wepSet ].tointeger() > 0 ) 
								{
									local oldpack = Script.RedPackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.RedPackLim[ packid ].tointeger();

									Handler.Handlers.Script.RedPackLim[ player.Data.wepSet ] = ( oldpack - 1 );
									Handler.Handlers.Script.RedPackLim[ packid ] = ( newpack + 1 );
								}

								if ( player.Team == 2 && Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger() > 0 ) 
								{
									local oldpack = Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.BluePackLim[ packid ].tointeger();

									Handler.Handlers.Script.BluePackLim[ player.Data.wepSet.tointeger() ] = ( oldpack - 1 );
									Handler.Handlers.Script.BluePackLim[ packid ] = ( newpack + 1 );
								}

								player.Data.wepSet = text.tointeger();				
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "ChangePackNextSpawn" ) );
							}
							else
							{
								player.Data.setCount ++;
								if ( player.Team == 1 && Script.RedPackLim[ player.Data.wepSet ].tointeger() > 0 ) 
								{
									local oldpack = Script.RedPackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.RedPackLim[ packid ].tointeger();

									Handler.Handlers.Script.RedPackLim[ player.Data.wepSet.tointeger() ] = ( oldpack - 1 );
									Handler.Handlers.Script.RedPackLim[ packid ] = ( newpack + 1 );
								}

								if ( player.Team == 2 && Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger() > 0 ) 
								{
									local oldpack = Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.BluePackLim[ packid ].tointeger();

									Handler.Handlers.Script.BluePackLim[ player.Data.wepSet.tointeger() ] = ( oldpack - 1 );
									Handler.Handlers.Script.BluePackLim[ packid ] = ( newpack + 1 );
								}

								print( Handler.Handlers.Script.RedPackLim[ player.Data.wepSet.tointeger() ] + " " + Handler.Handlers.Script.RedPackLim[ packid ] );
								player.Data.wepSet = text.tointeger();	

								this.giveSetWeapon( player );
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "TookSet", text ) );
							}
							player.SetWeapon( player.Data.SMGSlot1, 9999 );
							player.SetWeapon( player.Data.SMGSlot2, 9999 );/getTeamPackCount */

							else if( this.getTeamPackCount( player.Team, packid ) >= Script.PackLim[ packid ].tointeger() ) 
							{
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "SetLimitReached" ) );

								::playsound( player, 50061 );

								return;
							}
						//	else if ( player.Team == 2 && this.getTeamPackCount( player.Team, packid ) >= Script.PackLim[ packid ].tointeger() ) Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "SetLimitReached" ) );
							
						/*	else if ( this.Status > 3 && Script.EventMode )
							{
								if ( player.Team == 1 && this.getTeamPackCount( player.Team, packid ) ) 
								{
									local oldpack = Script.RedPackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.RedPackLim[ packid ].tointeger();

									Handler.Handlers.Script.RedPackLim[ player.Data.wepSet ] = ( oldpack - 1 );
									Handler.Handlers.Script.RedPackLim[ packid ] = ( newpack + 1 );
								}
								if ( player.Team == 2 && Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger() > 0 ) 
								{
									local oldpack = Script.BluePackLim[ player.Data.wepSet.tointeger() ].tointeger(); 
									local newpack = Script.BluePackLim[ packid ].tointeger();

									Handler.Handlers.Script.BluePackLim[ player.Data.wepSet.tointeger() ] = ( oldpack - 1 );
									Handler.Handlers.Script.BluePackLim[ packid ] = ( newpack + 1 );
								}
								player.Data.wepSet = text.tointeger();							
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "ChangePackNextSpawn" ) );
							}*/
							else if ( player.Data.setCount > 0 && this.Status > 3 )
							{
								player.Data.wepSet = text.tointeger();				

								if( Handler.Handlers.Script.PackLoggin ) SqCast.MsgAllAdmin( "PackSelectAdmin", SqCast.GetTeamName( player.Team ), player.Name, text.tointeger(), this.getTeamPackCount( player.Team, text.tointeger() ), Script.PackLim[ packid ].tointeger() );

								SqCast.MsgTeam( player.Team, "PackSelectTeam", SqCast.GetPlayerColor2( player ), text.tointeger() );

								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "ChangePackNextSpawn" ) );
							}
							else
							{
								player.Data.setCount ++;
								player.Data.wepSet = text.tointeger();	

								this.giveSetWeapon( player );
								Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "TookSet", text ) );

								SqCast.MsgTeam( player.Team, "PackSelectTeam", SqCast.GetPlayerColor2( player ), text.tointeger() );

								if( Handler.Handlers.Script.PackLoggin ) SqCast.MsgAllAdmin( "PackSelectAdmin", SqCast.GetTeamName( player.Team ), player.Name, text.tointeger(), this.getTeamPackCount( player.Team, text.tointeger() ), Script.PackLim[ packid ].tointeger() );
							}
							player.SetWeapon( player.Data.SMGSlot1, 9999 );
							player.SetWeapon( player.Data.SMGSlot2, 9999 );


						}
						else 
						{
							Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( player, "AlreadyTookSameSet" ) );

							::playsound( player, 50061 );
						}

					}
				}
				break;

				case 800:
				if( this.Status > 1 )
				{
					if( player.Data.InRound( player ) )
					{
					//	if( this.IsNearSpawn( player, 10 ) )
					//	{
							Handler.Handlers.Script.sendToClient( player, 500 );
					//	}
					//	else SqCast.MsgPlr( player, "CantChangePackTooFar" );

                	//	SqCast.MsgPlr( player, "PressBCloseMenu" );
					}
				}
			//	else Handler.Handlers.Script.sendToClient( player, 502, SqCast.parseStr( "ChangePackLimitExeeded" ) );
				break;

				case 900:
				local id = stream.ReadClientString();

				player.SetWeapon( id.tointeger(), 9999 );
				switch( id.tointeger() )
				{
					case 18:
					case 17:
					player.Data.SMGSlot1 = id.tointeger();
					break;

					default:
					player.Data.SMGSlot2 = id.tointeger();
					break;
				}
				break;

				case 3200:
				local id = stream.ReadClientString();
				local team = split( id, ":" )[0].tointeger();
				local skin = split( id, ":" )[1].tointeger();
				
				if( !player.Data.Registered ) return SqCast.MsgPlr( player, "CantSpawnNotReq" );

				if( player.Data.Registered && !player.Data.Logged ) return SqCast.MsgPlr( player, "CantSpawnNotLog" );
				
			/*	if ( Handler.Handlers.Script.EventMode && ( team == 1 || team == 2 )  )
				{
					player.AnnounceEx( 0, "There is a event going on, you can only spawn as a spectator." );
					return;
				}
				*/

				if ( Handler.Handlers.Script.TeamBalancer )
				{
					if ( GetPlayers() > 0 )
					{
						local inreds = Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 );
						local inblues = Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 );
						if ( team == 1  && inreds > inblues && !player.Data.Round ) return SqCast.sendAlert( player, "CmdError", "There are more players in this team, please choose the other team." ), SqCore.SetState( 0 );
						else if ( team == 2 && inblues > inreds && !player.Data.Round ) return SqCast.sendAlert( player, "CmdError", "There are more players in this team, please choose the other team." ), SqCore.SetState( 0 );
					}
				}

				if( team == 1 || team == 2 )
				{
					if( player.Ping > Handler.Handlers.Script.PingLimit )
					{
						SqCast.MsgPlr( player, "WarningPing1", Handler.Handlers.Script.PingLimit );
						
						return;
					}

					if( Handler.Handlers.Script.FPSLimit > player.FPS )
					{
						SqCast.MsgPlr( player, "FPSLimit1", Handler.Handlers.Script.FPSLimit );

						return;
					}
				}
				
					player.Skin = skin;
					player.Team = team;

					player.Spawn();
					player.RestoreCamera();

					Handler.Handlers.Script.sendToClient( player, 4100 );
					return;
				break;
			}
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onReceiveClientData, [%s]", e );
	}

	function getDefVehicleColor()
	{
    	//try 
    	//{
			local colour = null;
			
			switch( this.Defender )
			{
				case 1:
				colour = 12;
				break;
				
				case 2:
				colour = 57;
				break;
			}
			
			return colour;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getDefVehicleColor, [%s]", e );
	}

	function getAttSphereColor()
    {
    	//try 
    	//{
	        local colour = null;
	        
	        switch( this.Defender )
	        {
	            case 1:
	            colour = Color4( 51, 153, 255, 255 );
	            break;
	            
	            case 2:
	            colour = Color4( 255, 51, 0, 255 );
	            break;
	        }
	        
	        return colour;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getAttSphereColor, [%s]", e );
    } 

   function getSpriteIDBySide( def = false )
    {
    	//try 
    	//{
	       switch( def )
	        {
	            case true:
	            if( this.Defender == 1 ) return 103;
				else return 102;
	            break;

	            case false:
	            if( this.Defender == 1 ) return 102;
				else return 103;
	            break;
	        }
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getSpriteIDBySide, [%s]", e );
 	}   	

    function giveSetWeapon( player )
    {
    	//try 
    	//{
    		player.StripWeapons();

	        switch( player.Data.wepSet )
	        {
	            case 1:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 26, 9999 );
	            break;

	            case 2:
	            player.SetWeapon( 19, 9999 );
	            player.SetWeapon( 32, 9999 );
	            break;

	            case 3:
	            player.SetWeapon( 20, 9999 );
	            player.SetWeapon( 27, 9999 );
	            break;

	            case 4:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 30, 15 );
	            break;

	            case 5:
	            player.SetWeapon( 15, 15 );
	            player.SetWeapon( 19, 9999 );
	            player.SetWeapon( 28, 96 );
	            break;

	            case 6:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 29, 9999 );
	            player.SetWeapon( 12, 15 );
	            break;

	            case 7:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 31, 9999 );
	            player.SetWeapon( 11, 1 );
	            break;
	        }
			
			playsound( player, 80 );
	    //}
		//catch( e ) SqLog.Err( "Error on CGameplay::giveSetWeapon, [%s]", e );
    }	

	function RestockSetWep( player )
    {
    	//try 
    	//{
			player.StripWeapons();

	        switch( player.Data.wepSet )
	        {
	            case 1:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 26, 9999 );
	            break;

	            case 2:
	            player.SetWeapon( 19, 9999 );
	            player.SetWeapon( 32, 9999 );
	            break;

	            case 3:
	            player.SetWeapon( 20, 9999 );
	            player.SetWeapon( 27, 9999 );
	            break;

	            case 4:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 30, 10 );
	            break;

	            case 5:
	            player.SetWeapon( 15, 15 );
	            player.SetWeapon( 19, 9999 );
	            player.SetWeapon( 28, 500 );
	            break;

	            case 6:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 29, 9999 );
	            player.SetWeapon( 12, 15 );
	            break;

	            case 7:
	            player.SetWeapon( 21, 9999 );
	            player.SetWeapon( 31, 500 );
	            player.SetWeapon( 11, 1 );
	            break;
	        }

			player.SetWeapon( player.Data.SMGSlot1, 9999 );
			player.SetWeapon( player.Data.SMGSlot2, 9999 );			
			playsound( player, 78 );
	    //}
		//catch( e ) SqLog.Err( "Error on CGameplay::RestockSetWep, [%s]", e );
    }	


    function SwitchDefender()
    {
    	//try 
    	//{
	    	switch( this.Defender )
	    	{
	    		case 1:
	    		this.Defender = 2;
	    		break;

	    		case 2:
	    		this.Defender = 1;
	    		break;
	    	}
	   	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::SwitchDefender, [%s]", e );
    }    

    function GetWinType( type )
    {
    	//try 
    	//{
	    	this.getScoreMVP = 0
			this.getScoreMVPName = null;

	    	switch( type )
	    	{
	    		case 0:
				local getmvpsound = 0;
	    		SqCast.MsgAll( "RoundWinMoreScore", SqCast.GetTeamName( this.Defender ) );
				Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` have successfully defended the vehicle.**", SqCast.GetTeamName( this.Defender ) );

				this.getScoreMVPName = this.GetTopScorer( this.Defender );

	           /* if( getScoreMVP > Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ) 
	            {
	            	getScoreMVPName.Data.Stats.MVP ++;

	            	SqCast.MsgAll( "MVPMakeNewRecord", SqCast.GetPlayerColor( getScoreMVPName ) );

	            	Handler.Handlers.Bases.updateBase( this.Bases, getScoreMVPName.Data.ID, getScoreMVP );
	            }

	            else 
	            {
	                if( getScoreMVPName )
	                {
	                	getScoreMVPName.Data.Stats.MVP ++;

	                	SqCast.MsgAll( "MVPKiller", SqCast.GetPlayerColor( getScoreMVPName ) );
	                }
	            }*/

	    		SqForeach.Player.Active( this, function( player ) 
				{
					if( player.Team == this.Defender )
					{
						player.Data.Stats.DefWon ++;
						player.Data.WinStreak ++;
					}
					else player.Data.WinStreak = 0;
				});

				if( this.getScoreMVPName != null )
	            {
					local player = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( this.getScoreMVPName );
	                
					if( player != null )
					{
						player.Data.Stats.MVP ++;

						getmvpsound = player.Data.MVPSound;

	                	SqCast.MsgAll( "MVPKiller", SqCast.GetPlayerColor( player ) );
						Handler.Handlers.Discord.ToDiscord( 1, "**-> MVP: ``%s`` for making most kills.**", player.Name );
						Handler.Handlers.Script.sendToClientToAll( 3100, SqCast.GetTeamName( this.Defender ) + " has won the round.?MVP: " + player.Name + " for making most kills.?Now Playing " + player.Name + "'s MVP Track: " + this.getMVPTrackName( getmvpsound ) + "?" + this.Defender );
					}
	            }

				this.PlayMVP( getmvpsound );
				this.TeleportToLobby();
				Handler.Handlers.Matchlogger.WritelogToKill( SqCast.GetTeamName( this.Defender ) + " have successfully defended the vehicle." );

				if( Handler.Handlers.Script.EnableScore )
				{
					if( this.Defender == 1 ) this.RedTeamScore2 ++;
					else this.BlueTeamScore2 ++;
					
					SqCast.MsgAll( "AnnScore", this.RedTeamName, this.RedTeamScore2, this.BlueTeamScore2, this.BlueTeamName );
					Handler.Handlers.Discord.ToDiscord( 1, "**->** Score: ``%s`` **%d** - **%d** ``%s``", this.RedTeamName, this.RedTeamScore2, this.BlueTeamScore2, this.BlueTeamName );				
				}
	    		break;

	    		case 1:
				local getmvpsound = 0;
	    		local getAtt = ( this.Defender == 1 ) ? 2 : 1;

	    		SqForeach.Player.Active( this, function( player ) 
				{
					if( player.Team == getAtt )
					{
						player.Data.Stats.AttWon ++;
						player.Data.WinStreak ++;
						
						if( player.Score > this.getScoreMVP )
						{
							this.getScoreMVP = player.Score;
							this.getScoreMVPName = player.Data.ID;
						}
					}
					else player.Data.WinStreak = 0;
				});

	    		SqCast.MsgAll( "RoundWinVehicleDelivered", SqCast.GetTeamName( getAtt ) );

				Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` has robbed the vehicle.**", SqCast.GetTeamName( getAtt ) );
		    /*    if( getScoreMVP > Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ) 
		        {
		        	getScoreMVPName.Data.Stats.MVP ++;

		            SqCast.MsgAll( "MVPMakeNewRecord", SqCast.GetPlayerColor( getScoreMVPName ) );

		            Handler.Handlers.Bases.updateBase( this.Bases, getScoreMVPName.Data.ID, getScoreMVP );
		        }
			*/
				local getTime = ( time() - this.StartTimer );
				local allowcate = false;
				if( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore == 0 )
				{
					allowcate = true;
				}

				if( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore > getTime )
				{
					allowcate = true;
				}

				if( allowcate )
				{
					local getOldReadableTime = ( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore == 0 ) ? "" : format( "%02d:%02d", date( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ).min, date( Handler.Handlers.Bases.Bases[ this.Bases ].TopScore ).sec );
		        	local getNewReadableTime = format( "%02d:%02d", date( getTime ).min, date( getTime ).sec );
					
					this.DriverName.Data.Stats.MVP ++;

					getmvpsound = this.DriverName.Data.MVPSound;

					this.getScoreMVPName = this.DriverName.Data.ID;
					if( getOldReadableTime == "" )
					{
						SqCast.MsgAll( "MVPMakeNewRecordDriver1", SqCast.GetPlayerColor( this.DriverName ), getNewReadableTime );
						Handler.Handlers.Discord.ToDiscord( 1, "**-> MVP: ``%s`` for making new RTV record with ``%s``**", this.DriverName.Name, getNewReadableTime );
					}
		            else
					{
						SqCast.MsgAll( "MVPMakeNewRecordDriver", SqCast.GetPlayerColor( this.DriverName ), getNewReadableTime, getOldReadableTime );	
						Handler.Handlers.Discord.ToDiscord( 1, "**-> MVP: ``%s`` for breaking RTV record with ``%s`` [ Past Record: ``%s`` ]**", this.DriverName.Name, getNewReadableTime, getOldReadableTime );
					}

		            Handler.Handlers.Bases.updateBase( this.Bases, getScoreMVPName, getTime );
				}

	            else 
	            {
					local player = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( this.DriverName.Data.ID );
	            	
					if( player != null )
					{
						player.Data.Stats.MVP ++;

						getmvpsound = player.Data.MVPSound;

	               		SqCast.MsgAll( "MVPDriver", SqCast.GetPlayerColor( player ) );
						Handler.Handlers.Discord.ToDiscord( 1, "**-> MVP: ``%s`` for delivering the target vehicle.**", player.Name );
						Handler.Handlers.Script.sendToClientToAll( 3100, SqCast.GetTeamName( getAtt ) + " has won the round.?MVP: " + player.Name + " for delivering the target vehicle.?Now Playing " + player.Name + "'s MVP Track: " + this.getMVPTrackName( getmvpsound ) + "?" + getAtt );
					}
	        	}

				this.PlayMVP( getmvpsound );
				this.TeleportToLobby();

				if( Handler.Handlers.Script.EnableScore )
				{
					if( this.Defender == 1 ) this.BlueTeamScore2 ++;
					else this.RedTeamScore2 ++;

					SqCast.MsgAll( "AnnScore", this.RedTeamName, this.RedTeamScore2, this.BlueTeamScore2, this.BlueTeamName );
					Handler.Handlers.Discord.ToDiscord( 1, "**->** Score: ``%s`` **%d** - **%d** ``%s``", this.RedTeamName, this.RedTeamScore2, this.BlueTeamScore2, this.BlueTeamName );				
				}				
				break;
	    	}
	   	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::GetWinType, [%s]", e );
    }

    function onPlayerAttemptEnterVehicle( player, vehicle, slot )
    {
    	try 
    	{
    		if( vehicle == this.TargetVehicle )
    		{
				this.TargetVehicle.Fix();
    			if( slot == 0 )
    			{
		    		if( player.Team != this.Defender )
		    		{
		    			if( player.Data.InRound( player ) ) 
		    			{
							this.TryingToEnter = true;

							SqCast.MsgTeam( player.Team, "TeamChatEnteringVeh", SqCast.GetPlayerColor2( player ) );

		    				return SqCore.SetState( 1 );
		    			}
		    			else SqCore.SetState( 0 );
		    		}
		    		else return SqCore.SetState( 0 );
		    	}
		    	else return SqCore.SetState( 0 );
	    	}
	    	else return SqCore.SetState( 1 );
	   	}
		catch( e ) SqLog.Err( "Error on CGameplay::onPlayerAttemptEnterVehicle, [%s]", e );
    }

    function onPlayerEnterVehicle( player, vehicle, slot )
    {
    	try 
    	{
    		if( vehicle == this.TargetVehicle )
    		{
    			local getTimer = Handler.Handlers.Script.findRoutine( "StartRound" );

    			if( getTimer ) getTimer.Terminate();

    			SqCast.sendAlertToAll( "AttEnterVehicle", player.Name );

				if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** has entered the target vehicle.", SqCast.GetTeamName( player.Team ), player.Name );
				
				playsoundforall( random( 50032, 27 ) );
    			Handler.Handlers.Script.sendToClientToAll( 400, "pause" );
			//	Handler.Handlers.Script.sendToClientToAll( 415, "40000" );

			/*	if( this.isTimeIncreased != 4 ) 
				{
					this.isTimeIncreased ++;
					this.RoundTime += 60;

					Handler.Handlers.Script.sendToClientToAll( 400, this.RoundTime );
				}*/

    			this.VehicleMarker.Destroy();
    			this.TargetVehicle.Immunity = 0;
    			this.Status = 4;

			//	this.MarkerFollowVehicle();
    		}
  	   	}
		catch( e ) SqLog.Err( "Error on CGameplay::onPlayerEnterVehicle, [%s]", e );
    }

    function onPlayerExitVehicle( player, vehicle )
    {
    	//try 
    	//{
    		if( vehicle == this.TargetVehicle )
    		{
				this.TryingToEnter = false;

    			local getTimer = Handler.Handlers.Script.findRoutine( "MarkerFollowVehicle" );
				local getTimer1 = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

				if( getTimer1 ) getTimer1.Terminate(), AnnounceAll( "", 5 );
    			if( getTimer ) getTimer.Terminate();
				
    			if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();

				SqCast.sendAlertToAll( "AttExitVehicle", player.Name );

				if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** ejected from the target vehicle, respawning vehicle in 10 seconds.", SqCast.GetTeamName( player.Team ), player.Name );

    			Handler.Handlers.Script.sendToClientToAll( 400, this.RoundTime );

				this.VehicleMarker = SqBlip.Create( 0, vehicle.Pos, 2, Color4( 255, 255, 255, 255 ), this.getSpriteIDBySide() );
    		//	vehicle.Immunity = 31;
    			this.Status = 4;

				this.TargetVehicle.Destroy();
				this.TargetVehicle.NullInst();

				local tim = SqRoutine( this, this.RespawnVehicle, 10000, 1 );

				tim.SetTag( "RespawnVehicle" );
				tim.Quiet = false;

    		//	SqCast.sendAlertToAll( "TargetVehicleXplode" );


				local tim = SqRoutine( this, function()
		    	{
		    		this.RoundTime --;
					
					this.CheckVehicleHealth();
					this.CheckVehicleOriginPos();

					if( this.RoundTime % 15 == 0 )
					{
						Handler.Handlers.Script.sendToClientToAll( 400, this.RoundTime );

					//	this.CheckPlayerFPS();
					//	this.CheckPlayerPing();
					}

		    		if( this.RoundTime <= 0 )
		    		{
		    			this.EndRound( 0 );

		    		//	this.Terminate();
		    		}
		    	}, 1000, 0 );
				
				tim.SetTag( "StartRound" );
				tim.Quiet = false;
    		}
  	   	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onPlayerExitVehicle, [%s]", e );
    }

    function onVehicleRespawn( vehicle )
    {
    	//try 
    	//{
    		/*if( vehicle == this.TargetVehicle )
    		{
    			if( this.VehicleMarker ) this.VehicleMarker.Destroy();

    			this.VehicleMarker = SqBlip.Create( 0, this.TargetVehicle.Pos, 2, Color4( 255, 255, 255, 255 ), this.getSpriteIDBySide() );

    			this.TargetVehicle.Immunity = 31;
				
				Handler.Handlers.Script.first_damage = false;

    			SqCast.sendAlertToAll( "TargetVehicleRespawn" );
    	   	}*/
			if ( vehicle != this.TargetVehicle || this.Status < 3 ) vehicle.Destroy();
       	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onVehicleRespawn, [%s]", e );
    }

    function onCheckpointEntered( player, checkpoint )
    {
    	//try 
    	//{
    		if( checkpoint.ID == this.vehicleMarker.ID )
    		{
	    		if( player.Data.InRound( player ) && player.Team != this.Defender )
	    		{
	    			if( player.Vehicle )
	    			{
	    				if( player.Vehicle.ID == this.TargetVehicle.ID )
	    				{
		    				local delay = this.GetDelayByVehicleDamage( this.TargetVehicle.Health );
		    				local delay1 = delay;

		    				Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "DeliveringNotice", delay ) );
							if ( delay == 6 ) Handler.Handlers.Script.sendToClientToAll( 6300, "Delivering...:6");
							else Handler.Handlers.Script.sendToClientToAll( 6300, "Delivering...:5");
							local tim = SqRoutine( this, function()
					    	{
					    		delay --;
								
								switch ( delay )
								{
									case 5:
								//	AnnounceAll( "~h~5", 5 );
									break;
									
									case 4:
								//	AnnounceAll( "~h~4", 5 );
									break;
									
									case 3:
								//	AnnounceAll( "~h~3", 5 );
									break;
									
									case 2:
								//	AnnounceAll( "~h~2", 5 );
									break;
									
									case 1:
								//	AnnounceAll( "~h~1", 5 );
									break;
									
									case 0:
								//	AnnounceAll( "~h~0", 5 );
									break;
								}
								
					    		if( delay == 0 )
					    		{
									if( this.TargetVehicle != null && this.TargetVehicle.Occupant( 0 ) == -1 && this.TargetVehicle.ID != -1 )
									{
										local getTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

									    if( getTimer ) getTimer.Terminate();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

										SqCast.sendAlertToAll( "DeliverFailedODriverLeft", player.Name );

										return;
									}

									else if( this.TargetVehicle != null && this.TargetVehicle.Health < 250 && this.TargetVehicle.ID != -1 ) 
									{
										local getTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

									    if( getTimer ) getTimer.Terminate();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

										SqCast.sendAlertToAll( "DeliverFailedODriverLeft", player.Name );

										return;
									}

									else if( this.TargetVehicle != null && this.TargetVehicle.ID != -1 && player.Away ) 
									{
									//	Handler.Handlers.Discord.SendToPrivate( format( "**%s** alt tabbed while capturing checkpoint.", player.Name ), "pm" );
										SqCast.MsgAllMan( "AFKCheckpoint", player.Name );

										return;
									}

									else
									{
										player.Data.CurrentStats.Score += 20;
										player.Score += 20;
										player.Data.Stats.Stealed ++;

										DriverName = player;

										Handler.Handlers.Matchlogger.WritelogToKill( player.Name + " has delivered the vehicle." );
										Handler.Handlers.Matchlogger.AddScore( player.Name, player.Team, 20 );

									//	FreezeAll();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

									/*	player.MakeTask( function()
										{
											player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
											AnnounceAll( " ", 5 );
										}, 1500, 1 );*/

										EndRound( 1 );	
										return;
									}
					    		}

								if( this.TargetVehicle.ID != -1 )
								{
									if( this.TargetVehicle.Occupant( 0 ) == -1 )
									{
										local getTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

									    if( getTimer ) getTimer.Terminate();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

										SqCast.sendAlertToAll( "DeliverFailedODriverLeft", player.Name );

										return;
									}

									else if( this.TargetVehicle.Health < 250 ) 
									{
										local getTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

									    if( getTimer ) getTimer.Terminate();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

										SqCast.sendAlertToAll( "DeliverFailedODriverLeft", player.Name );

										return;
									}

									else if( player.Health < 2 ) 
									{
										local getTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

									    if( getTimer ) getTimer.Terminate();

										Handler.Handlers.Script.sendToClientToAll( 6310 );

										SqCast.sendAlertToAll( "DeliverFailedODriverLeft", player.Name );

										return;
									}
								}
					    	}, 1000, delay1 );
							
							tim.SetTag( "onCheckpointEntered" );
							tim.Quiet = false;
	    				}
	    				else Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "TakeDefVehicleNotice", SqCast.GetTeamName( this.Defender, false ) ) );
	    			}
	    			else Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "TakeDefVehicleNotice", SqCast.GetTeamName( this.Defender, false ) ) );
	    		}
	    	}
    	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onCheckpointEntered, [%s]", e );
    }  

    function GetDelayByVehicleDamage( hp )
    {
    	//try 
    	//{
	        local getCd = 4;

	    	if ( hp < 500 ) getCd = 6;
			
	        return getCd;
    	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::GetDelayByVehicleDamage, [%s]", e );	        
    }

    function FreezeAll()
    {
    	//try 
    	//{
	    	SqForeach.Player.Active( this, function( player ) 
			{
				if( player.Vehicle ) 
				{
					player.Vehicle.Pos = Vector3( -966.268921,-252.156738,379.886597 );
				//	player.Disembark();
				//	player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
				}
				player.SetOption( SqPlayerOption.Controllable, true );			
			});
	    //}
		//catch( e ) SqLog.Err( "Error on CGameplay::FreezeAll, [%s]", e );
    }

    function onCheckpointExited( player, checkpoint )
    {
    	//try 
    	//{
    		if( checkpoint.ID == this.vehicleMarker.ID )
    		{
	    		if( player.Data.InRound( player ) && player.Team != this.Defender )
	    		{
	    			if( player.Vehicle )
	    			{
	    				if( player.Vehicle.ID == this.TargetVehicle.ID )
	    				{
	    					local findTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

	    					if( findTimer ) findTimer.Terminate();
							
							Handler.Handlers.Script.sendToClientToAll( 6310 );
							
	    					Handler.Handlers.Script.sendToClient( player, 200, SqCast.parseStr( player, "DeliverFailVehicleOutCP" ) );
	    				}
	    			}
	    		}
	    	}
    	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onCheckpointExited, [%s]", e );
    }  

    function onVehicleExplode( vehicle )
    {
    	//try 
    	//{
    		if( vehicle == this.TargetVehicle )
    		{
    			if( this.VehicleMarker.tostring() == "0" ) this.VehicleMarker.Destroy();

				this.TargetVehicle.Destroy();
				this.TargetVehicle.NullInst();
				
				local getTimer = FindRoutine
				
	    		local findTimer = Handler.Handlers.Script.findRoutine( "onCheckpointEntered" );

	    		if( findTimer ) findTimer.Terminate(), AnnounceAll( "", 5 );
				
				Handler.Handlers.Script.first_damage = false;

				local tim = SqRoutine( this, this.RespawnVehicle, 10000, 1 );

				tim.SetTag( "RespawnVehicle" );
				tim.Quiet = false;

    			SqCast.sendAlertToAll( "TargetVehicleXplode" );

				if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "Target vehicle destroyed. Respawning vehicle in 10 seconds.." );
    	   	}
       	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onVehicleExplode, [%s]", e );
    }

    function onPlayerDisconnect( player, reason, payload )
    {
    	//try 
    	//{
       	//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onPlayerDisconnect, [%s]", e )//
    }

	function getPlayerTeamCountDis( team )
	{
    	//try 
    	//{
			local count = 0;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( ( player.Team == team)  && ( player.Spawned ) ) count ++;
			});

			return ( count - 1 );
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getPlayerTeamCountDis, [%s]", e );
	}

	function getTeamPackCount( team, pack )
	{
    	//try 
    	//{
			local count = 0;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( ( player.Team == team )  && ( player.Data.WasInRound ) && player.Data.wepSet == pack ) count ++;
			});

			return ( count );
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getPlayerTeamCountDis, [%s]", e );
	}

	function getPlayerTeamCountV2( team )
	{
    	//try 
    	//{
			local count = 0;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( ( player.Team == team )  && ( player.Spawned ) ) count ++;
			});

			return count;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getPlayerTeamCountDis, [%s]", e );
	}
	
	function getPlayerTeamCountV3( team )
	{
    	//try 
    	//{
			local count = 0;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( ( player.Team == team )  && ( player.Spawned ) )
				{
					if ( player.Data.Round ) count ++;
					else if ( team == 7 ) count ++;
				}
			});

			return count;
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::getPlayerTeamCountDis, [%s]", e );
	}	

	function EndVote()
	{
    	//try 
    	//{
			if( this.getPlayerTeamCountV2( 1 ) <= 0 && this.getPlayerTeamCountV2( 2 ) <= 0 )
			{
				local getTimer = Handler.Handlers.Script.findRoutine( "PrepRound" );

				if( getTimer ) getTimer.Terminate();

				if( this.Replaybase == 0 ) SqCast.sendAlertToAll( "StopVoteBcsNoPlayer" );

				this.Status = 0;

				SqForeach.Player.Active( this, function( player ) 
				{
					Handler.Handlers.Script.sendToClient( player, 302 );
				});    
			}    		    	
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::EndVote, [%s]", e );
	}

	function EndPrep()
	{
    	//try 
    	//{
			local getTimer = Handler.Handlers.Script.findRoutine( "StartBase" );

	    	if( getTimer ) getTimer.Terminate();

	    	SqCast.sendAlertToAll( "StopPrepBcsNoPlayer" );

			SqLog.Wrn("Prepare ended. Red %d Blue %s", this.getPlayerTeamCount( 1 ), this.getPlayerTeamCount( 2 ) );

    		this.TargetVehicle.Destroy();
			if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();
			this.DefenderMarker.Destroy();
			this.vehicleMarker.Destroy();
			
			this.Status = 0;
			this.Lastbase = this.Bases;
        	this.LastDefender = this.Defender;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( player.Data.InRound( player ) )
				{
					player.StripWeapons();
					player.Health = 100;

					if( player.Vehicle ) 
					{
						player.Vehicle.Pos = Vector3( -966.268921,-252.156738,379.886597 );
					//	player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						player.Disembark();
					}
					
					else player.Pos = Vector3( -966.268921,-252.156738,379.886597 );

					Handler.Handlers.Script.sendToClient( player, 400, "end" );
					Handler.Handlers.Script.sendToClient( player, 501, "end" );
                   	Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
				}

				player.SetOption( SqPlayerOption.Controllable, true );
			});        	
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::EndVote, [%s]", e );
	}

	function onPlayerKill( victim, killer, reason, bodypart, isteamkill )
	{
    	//try 
    	//{
		//	if( victim.Team != 1 || victim.Team != 2 ) return;

			local isRPG = GetWeaponName( reason );
    	//	if( this.getPlayerTeamCountDis( victim.Team ) <= 0 && this.Status == 1 ) this.EndVote();
    		if( this.getPlayerTeamCountDis( victim.Team ) <= 0 && this.Status == 3 ) this.EndPrep();
			if( killer.Data.wepSet == 4 && reason == 41 ) isRPG = "RPG";

			victim.Data.OldTeam = victim.Team;
			Handler.Handlers.Script.sendToClient( victim, 2503, "255" );
			Handler.Handlers.Script.sendToClientToAll( 2502, victim.ID + ":255:255:255:-1");
			
			if( this.Status >= 4 )
			{
				if( victim.Team == 1 || victim.Team == 2 && killer.Team == 1 || killer.Team == 2 )
				{
					Handler.Handlers.Script.sendToClient( victim, 401, "255$255$255$-Rob The Vehicle" );

					local allowcate = false;
				/*	if( victim.Data.Assist.HitBy )
					{
						local killer2 = Handler.Handlers.Script.FindPlayer( victim.Data.Assist.HitBy );
						if( killer2 )
						{
							if( killer.ID != killer2.ID && killer2.Team == killer.Team )
							{
								if( ( time() - victim.Data.Assist.HitTime ) > 0 )
								{
									allowcate = true;

									SqCast.MsgAll( "KillReason2", SqCast.GetPlayerColor( killer ), SqCast.GetPlayerColor( killer2 ), SqCast.GetPlayerColor( victim ), GetWeaponName( reason ), Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ) );

									killer2.Data.Stats.Assist ++;
									killer2.Data.CurrentStats.RoundAssist ++;
									killer2.Score ++;

									Handler.Handlers.Matchlogger.AddKillsAssist( killer.Name, killer.Team, killer2.Name, killer2.Team, victim.Name, victim.Team, GetWeaponName( reason ) );
								}
							}
						}
					}
				*/
					if( !isteamkill )
					{
						killer.Data.Stats.Kills ++;
						killer.Data.CurrentStats.RoundKills ++;
						killer.Data.CurrentStats.RoundSpree ++;
						killer.Data.CurrentStats.Score += 2;
						killer.Score += 2;

						victim.Data.Stats.Deaths ++;
						victim.Data.CurrentStats.RoundDeaths ++;
						victim.Data.FragileMission = 0;

						local calavgp = 0;
						local calavgf = 0;
						local totalp = 0;
						local totalf = 0;
					
						foreach( index, value in killer.Data.LastPing ) { totalp += value; };
						foreach( index, value in killer.Data.LastFPS ) { totalf += value; };

						calavgp = ( totalp/IsZero( killer.Data.LastPing.len() ) );
						calavgf = ( totalf/IsZero( killer.Data.LastFPS.len() ) );

						if ( victim.Data.CurrentStats.RoundSpree < 5 ) victim.Data.CurrentStats.RoundSpree = 0;

						if( killer.Data.TauntText != "no" && victim.Data.ShowTaunt ) SqCast.sendAlert( victim, "ShowTaunt2", killer.Name, killer.Data.TauntText );
						
						if ( victim.Team == 1 && killer.Team == 2 ) SqCast.MsgAll( "KillReasonRed", killer.Name, victim.Name, isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ), calavgp, calavgf );						
						else if ( victim.Team == 2 && killer.Team == 1 ) SqCast.MsgAll( "KillReasonBlue", killer.Name, victim.Name, isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ), calavgp, calavgf );	

						else SqCast.MsgAll( "KillReason", SqCast.GetPlayerColor2( killer ), SqCast.GetPlayerColor2( victim ), isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ), calavgp, calavgf );

						if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** killed ``%s`` **%s**  ``[%s] [%s] [%.4fm] [%d Ping] [%.2f FPS]``", SqCast.GetTeamName( killer.Team ), killer.Name, SqCast.GetTeamName( victim.Team ), victim.Name, isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ), calavgp, calavgf );
						
						if ( killer.Pos.DistanceTo( victim.Pos ) <= 19 && ( killer.Data.wepSet == 4 && reason == 41 ) )
						{			
							//Handler.Handlers.Discord.ToDiscord( 8, "**RPG RANGE ALERT!** Killer: [ %s ] Victim: [ %s ] Distance: [ %.4fm ].", killer.Name, victim.Name, killer.Pos.DistanceTo( victim.Pos ) );
							/*Handler.Handlers.Discord.ToDiscord( 8, "**RPG RANGE ALERT!**" );
							Handler.Handlers.Discord.ToDiscord( 1, "```css" );
							Handler.Handlers.Discord.ToDiscord( 1, "-> Killer: [ %s ] Victim: [ %s ] Distance: [ %.4fm ].```", killer.Name, victim.Name, killer.Pos.DistanceTo( victim.Pos ) );*/
							SqCast.MsgAllAdmin( "RPGCloseLimit", killer.Name, killer.Pos.DistanceTo( victim.Pos ) );
						}
						
						//SqCast.MsgAll( "KillReason", SqCast.GetPlayerColor( killer ), SqCast.GetPlayerColor( victim ), isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ) );	
						
						if ( bodypart == 6 ) playsound( killer, random( 50011, 50016 ) ), SqCast.sendAlert( killer, "CmdError", "Headshot!" );
						::HPAddon( killer );
						
						if( ( killer.Team == 1 || killer.Team == 2 ) && ( victim.Team == 1 || victim.Team == 2 ) ) Handler.Handlers.Matchlogger.AddKills( killer.Name, killer.Team, victim.Name, victim.Team, GetWeaponName( reason ) );
					
						if( killer.Data.CurrentStats.RoundSpree > 4 && killer.Data.CurrentStats.RoundSpree % 5 == 0 ) 
						{
							killer.Data.CurrentStats.Score += 5;
							killer.Score += 5;

							SqCast.MsgAll( "KillingSpree", SqCast.GetPlayerColor( killer ), killer.Data.CurrentStats.RoundSpree );
							Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` is on a killing spree of ``%d``!**", killer.Name, killer.Data.CurrentStats.RoundSpree );
							
							if ( killer.Data.CurrentStats.RoundSpree == 5 ) playsound( killer, random( 50012, 50034 ) ), SqCast.sendAlert( killer, "CmdError", "Killing Spree!" );
							else if ( killer.Data.CurrentStats.RoundSpree == 10 ) playsound( killer, 50035 ), SqCast.sendAlert( killer, "CmdError", "Rampage!" );
							else if ( killer.Data.CurrentStats.RoundSpree == 15 ) playsound( killer, 50036 ), SqCast.sendAlert( killer, "CmdError", "Unstoppable!" );
							else if ( killer.Data.CurrentStats.RoundSpree == 20 ) playsound( killer, 50037 ), SqCast.sendAlert( killer, "CmdError", "Dominating!" );
							else if ( killer.Data.CurrentStats.RoundSpree == 25 ) playsound( killer, 50038 ), SqCast.sendAlert( killer, "CmdError", "Godlike!" );
							else if ( killer.Data.CurrentStats.RoundSpree == 30 ) playsound( killer, 50039 ), SqCast.sendAlert( killer, "CmdError", "Legendary!" );
							
							if( Handler.Handlers.Script.AllowHealthRegen )
							{
								SqCast.MsgPlr( killer, "SpreeBonus" );

								RestockSetWep( killer );
						
								killer.Health += 15;
							}
							Handler.Handlers.Matchlogger.AddScore( killer.Name, killer.Team, 15 );
						}
					}
					else 
					{
						killer.Data.CurrentStats.Score -= 10;
						killer.Score -= 10;

						Handler.Handlers.Matchlogger.DecScore( killer.Name, killer.Team, 10 );

						SqCast.MsgAll( "KillReasonT", SqCast.GetPlayerColor2( killer ), SqCast.GetPlayerColor2( victim ), isRPG, Handler.Handlers.Script.GetBodyPartName( bodypart ), killer.Pos.DistanceTo( victim.Pos ) );
					}
					
					if( victim.Data.CurrentStats.RoundSpree > 4 )
					{
						SqCast.MsgAll( "EndKillingSpree", SqCast.GetPlayerColor( victim ), victim.Data.CurrentStats.RoundSpree, SqCast.GetPlayerColor( killer ) );
						Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s``'s killing spree of ``%d`` has been ended by ``%s``!**", victim.Name, victim.Data.CurrentStats.RoundSpree, killer.Name );
						victim.Data.CurrentStats.RoundSpree = 0;
					}				

					if( killer.Data.CurrentStats.RoundSpree > killer.Data.Stats.TopSpree ) killer.Data.Stats.TopSpree = killer.Data.CurrentStats.RoundSpree;

					if( killer.Data.CurrentStats.RoundSpree >= 5 )
					{
						if( killer.Data.CurrentStats.RoundSpree >= killer.Data.Stats.TopSpree ) killer.Data.Stats.TopSpree = killer.Data.CurrentStats.RoundSpree;
					}
				}		
			}
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onPlayerKill, [%s]", e );
	}

	function onPlayerDeath( player, reason )
	{
    	//try 
    	//{
    		if( this.getPlayerTeamCountDis( player.Team ) <= 0 && this.Status == 1 ) this.EndVote();
    		if( this.getPlayerTeamCountDis( player.Team ) <= 0 && this.Status == 3 ) this.EndPrep();

			player.Data.OldTeam = player.Team;

			Handler.Handlers.Script.sendToClient( player, 2503, "255" );
			Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:-1");

			if( this.Status >= 4 )
			{
				if( player.Team == 1 || player.Team == 2 )
				{				
					Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );

					player.Data.Stats.Deaths ++;
					player.Data.CurrentStats.RoundDeaths ++;
					player.Data.FragileMission = 0;
					if ( player.Data.CurrentStats.RoundSpree < 5 ) player.Data.CurrentStats.RoundSpree = 0;
					if ( player.Data.CurrentStats.RoundSpree > 4 )
					{
						SqCast.MsgAll( "EndKillingSpreeOwn", SqCast.GetPlayerColor( player ) );
						Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` has ended their own killing spree!**", player.Name );
						player.Data.CurrentStats.RoundSpree = 0;
					}
					player.Score --;
					player.Data.CurrentStats.Score --;
					Handler.Handlers.Matchlogger.DecScore( player.Name, player.Team, 1 );

					if( player.Team == 1 ) Handler.Handlers.Script.Reds--;
					else if( player.Team == 2 ) Handler.Handlers.Script.Blues--;
					
					local allowcate = false;
				/*	if( player.Data.Assist.HitBy )
					{
						local killer2 = Handler.Handlers.Script.FindPlayer( player.Data.Assist.HitBy );
						if( killer2 )
						{
							if( killer2.Team != player.Team )
							{
								if( ( time() - player.Data.Assist.HitTime ) > 0 )
								{
									allowcate = true;

									SqCast.MsgAll( "KillReason2", SqCast.GetPlayerColor( killer2 ), SqCast.GetPlayerColor( killer2 ), SqCast.GetPlayerColor( player ), GetWeaponName( reason ), "None", 0 );

									killer2.Data.Stats.Assist ++;
									killer2.Data.CurrentStats.RoundAssist ++;
									killer2.Score ++;

									Handler.Handlers.Matchlogger.AddKillsAssist( player.Name, player.Team, killer2.Name, killer2.Team, player.Name, player.Team, GetWeaponName( reason ) );
								}
							}
						}
					}
				*/
					if( !allowcate )
					{
						switch( reason )
						{
							case 70:
							SqCast.MsgAll( "DeathReasonSuicide", SqCast.GetPlayerColor2( player ) );

							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** commited suicide.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 39:
							SqCast.MsgAll( "DeathReasonCarCrash", SqCast.GetPlayerColor2( player ) );

							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** died in a car crash.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 31:
							SqCast.MsgAll( "DeathReasonBurn", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** burnt to death.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 14:
							SqCast.MsgAll( "DeathReasonChoke", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** choked to death.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 43:
							SqCast.MsgAll( "DeathReasonDrown", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** drowned.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 41:
							case 51:
							SqCast.MsgAll( "DeathReasonExplode", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** exploded.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							case 44:
							SqCast.MsgAll( "DeathReasonFell", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** fell to death.", SqCast.GetTeamName( player.Team ), player.Name );
							break;

							default:
							SqCast.MsgAll( "DeathReason", SqCast.GetPlayerColor2( player ) );
							
							if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** died.", SqCast.GetTeamName( player.Team ), player.Name );
							break;
						}

						if( player.Team == 1 || player.Team == 2 ) Handler.Handlers.Matchlogger.AddDeath( player.Name, player.Team, reason );
					}
				}
			}
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::onPlayerDeath, [%s]", e );
	}

	function GetRedScore()
	{
		this.RedTeamScore = [];

		local getMembers = {};
		local t, ta , taa, tta, tat, j , k = 0, i = 0, getStr = null;

		getMembers.rawset( i++, 
		{
			Name	= 0,
			Kills 	= 0,
			Deaths  = 0,
			Assist  = 0,
			Score   = -5000,
		});

	    foreach( index, value in Handler.Handlers.Matchlogger.red_temp )
		{
			getMembers.rawset( i, 
			{
				Name	= this.isMVP( index ),
				Kills 	= value.kills,
				Deaths  = value.deaths,
				Assist  = value.assist,
				Score   = value.score,
			});

			k++;
			i++;		
		}
								
		for( j = 0; j < getMembers.len(); j++ )
		{
			for( local i = 0 ; i<getMembers.len()-1-j; i++ )
			{
				if( ( getMembers.rawin( i ) ) && ( getMembers.rawin( i + 1 ) ) )
				{
					
					if( getMembers[ i ].Score <= getMembers[ i + 1 ].Score )
					{
						
						t = getMembers[ i + 1 ].Name;
						ta = getMembers[ i + 1 ].Score;
						taa = getMembers[ i + 1 ].Kills;
						tta = getMembers[ i + 1 ].Assist;
						tat =  getMembers[ i + 1 ].Deaths;

						getMembers[ i + 1 ].Name <- getMembers[ i ].Name;
						getMembers[ i + 1 ].Kills <- getMembers[ i ].Kills;
						getMembers[ i + 1 ].Deaths <- getMembers[ i ].Deaths;
						getMembers[ i + 1 ].Assist <- getMembers[ i ].Assist;
						getMembers[ i + 1 ].Score <- getMembers[ i ].Score;

						getMembers[ i ].Name <- t;
						getMembers[ i ].Kills <- taa;
						getMembers[ i ].Deaths <- tat;
						getMembers[ i ].Assist <- tta;
						getMembers[ i ].Score <- ta;
					}
				}
			}
		}

		for( local i = 0, j = 1; i < k ; i++, j++ )
		{
			if( ( i+1 ) <= 10 )
			{
				this.RedTeamScore.append( getMembers[ i ].Name + "~" + getMembers[ i ].Kills + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Score + "~" + ( i+1 ) );
			}
		}
	}

	function GetBlueScore()
	{
		this.BlueTeamScore = [];

		local getMembers = {};
		local t, ta , taa, tta, tat, j , k = 0, i = 0, getStr = null;

		getMembers.rawset( i++, 
		{
			Name	= 0,
			Kills 	= 0,
			Deaths  = 0,
			Assist  = 0,
			Score   = -5000,
		});

	    foreach( index, value in Handler.Handlers.Matchlogger.blue_temp )
		{
			getMembers.rawset( i, 
			{
				Name	= this.isMVP( index ),
				Kills 	= value.kills,
				Deaths  = value.deaths,
				Assist  = value.assist,
				Score   = value.score,
			});

			k++;
			i++;		
		}
								
		for( j = 0; j < getMembers.len(); j++ )
		{
			for( local i = 0 ; i<getMembers.len()-1-j; i++ )
			{
				if( ( getMembers.rawin( i ) ) && ( getMembers.rawin( i + 1 ) ) )
				{
					
					if( getMembers[ i ].Score <= getMembers[ i + 1 ].Score )
					{
						
						t = getMembers[ i + 1 ].Name;
						ta = getMembers[ i + 1 ].Score;
						taa = getMembers[ i + 1 ].Kills;
						tta = getMembers[ i + 1 ].Assist;
						tat =  getMembers[ i + 1 ].Deaths;

						getMembers[ i + 1 ].Name <- getMembers[ i ].Name;
						getMembers[ i + 1 ].Kills <- getMembers[ i ].Kills;
						getMembers[ i + 1 ].Deaths <- getMembers[ i ].Deaths;
						getMembers[ i + 1 ].Assist <- getMembers[ i ].Assist;
						getMembers[ i + 1 ].Score <- getMembers[ i ].Score;

						getMembers[ i ].Name <- t;
						getMembers[ i ].Kills <- taa;
						getMembers[ i ].Deaths <- tat;
						getMembers[ i ].Assist <- tta;
						getMembers[ i ].Score <- ta;
					}
				}
			}
		}

		for( local i = 0, j = 1; i < k ; i++, j++ )
		{
			if( ( i+1 ) <= 10 )
			{
				this.BlueTeamScore.append( getMembers[ i ].Name + "~" + getMembers[ i ].Kills + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Score + "~" + ( i+1 ) );
			}
		}

		this.UpdateScoreBoard();
	}

	function isMVP( name )
	{
		try 
		{
			local player = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( this.getScoreMVPName );

			if( player )
			{
				if( name == player.Name )
				{
					return name + " *";
				}
			}

			return name;
		}
		catch( _ ) _;
	}

	function UpdateScoreBoard()
	{
		Handler.Handlers.Script.sendToClientToAll( 1023 );
		Handler.Handlers.Script.sendToClientToAll( 1021 );

		if( this.RedTeamScore.len() > 0 )
		{
			foreach( index in this.RedTeamScore )
			{
				Handler.Handlers.Script.sendToClientToAll( 1020, index );
			}
		}

		if( this.BlueTeamScore.len() > 0 )
		{
			foreach( index in this.BlueTeamScore )
			{
				Handler.Handlers.Script.sendToClientToAll( 1022, index );
			}
		}
	}

	function UpdateScoreBoardForPlayer( player )
	{
		if( this.RedTeamScore.len() > 0 )
		{
			foreach( index in this.RedTeamScore )
			{
				Handler.Handlers.Script.sendToClient( player, 1020, index );
			}
		}

		if( this.BlueTeamScore.len() > 0 )
		{
			foreach( index in this.BlueTeamScore )
			{
				Handler.Handlers.Script.sendToClient( player, 1022, index );
			}
		}
	}

	function UpdateBasevote( player )
	{
		local getBase1Name = ( this.voteBase[ 0 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 0 ].ID ].Name;
		local getBase2Name = ( this.voteBase[ 1 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 1 ].ID ].Name;
		local getBase3Name = ( this.voteBase[ 2 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 2 ].ID ].Name;
		local getBase4Name = ( this.voteBase[ 3 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 3 ].ID ].Name;
		local getBase5Name = ( this.voteBase[ 4 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 4 ].ID ].Name;
		local getBase6Name = ( this.voteBase[ 5 ].ID == 0 ) ? "None" : Handler.Handlers.Bases.Bases[ this.voteBase[ 5 ].ID ].Name;

		local getBase1Vote = this.voteBase[ 0 ].Count; 
		local getBase2Vote = this.voteBase[ 1 ].Count; 
		local getBase3Vote = this.voteBase[ 2 ].Count; 
		local getBase4Vote = this.voteBase[ 3 ].Count; 
		local getBase5Vote = this.voteBase[ 4 ].Count; 
		local getBase6Vote = this.voteBase[ 5 ].Count; 

		Handler.Handlers.Script.sendToClient( player, 303, getBase1Name + "," + getBase2Name + "," + getBase3Name + "," + getBase4Name + "," + getBase5Name + "," + getBase6Name );
		Handler.Handlers.Script.sendToClient( player, 300, getBase1Vote + "," + getBase2Vote + "," + getBase3Vote + "," + getBase4Vote + "," + getBase5Vote + "," + getBase4Vote );
	}

	function onVehicleHealth( vehicle, old, new )
	{
		//print( vehicle.ID + " " + old + " " + new );
	}
	
	function onVehicleDamage( vehicle, old, new )
	{
		//print( "Damage Data :: " + vehicle.ID + ": " + old + " >> " + new );
	}	

	function RespawnVehicle()
	{
		if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();
		
		this.TargetVehicle = SqVehicle.Create( Handler.Handlers.Bases.Bases[ this.Bases ].VehicleModel, 0, Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos, Handler.Handlers.Bases.Bases[ this.Bases ].VehicleAngle, this.getDefVehicleColor(), this.getDefVehicleColor() );
		this.TargetVehicle.Immunity = 31;

    	this.VehicleMarker = SqBlip.Create( 0, this.TargetVehicle.Pos, 2, Color4( 255, 255, 255, 255 ), this.getSpriteIDBySide() );

    	SqCast.sendAlertToAll( "TargetVehicleRespawn" );

		if( Handler.Handlers.Script.ExtraEcho ) Handler.Handlers.Discord.ToDiscord( 1, "Target vehicle respawned." );

		Handler.Handlers.Script.sendToClientToAll( 415, this.TargetVehicle.tostring() );
		
		AnnounceAll( "", 5 );
		
		this.TVBurning = false;
		playsoundforall( 50027 );
	}

	function CheckVehicleHealth()
	{
		if( this.TargetVehicle.ID != -1 )
		{
			if( this.TargetVehicle.Health <= 20 )
			{
    			if( this.VehicleMarker.tostring() == "0" ) this.VehicleMarker.Destroy();

				this.TargetVehicle.Destroy();
				this.TargetVehicle.NullInst();

				local tim = SqRoutine( this, this.RespawnVehicle, 10000, 1 );

				tim.SetTag( "RespawnVehicle" );
				tim.Quiet = false;

    			SqCast.sendAlertToAll( "TargetVehicleXplode" );
			}			
		}
	}

	function CheckVehicleOriginPos()
	{
		if( this.TargetVehicle.ID != -1 )
		{
			if( !this.TryingToEnter )
			{
				if( this.TargetVehicle.HasOccupant( 0 ) )
				{
					local vPos = Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos;

					if( ( this.TargetVehicle.Pos.x != vPos.x ) || ( this.TargetVehicle.Pos.y != vPos.y ) )
					{
						if( this.TargetVehicle.Health >= 500 )
						{
							if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();

							this.VehicleMarker = SqBlip.Create( 0, this.TargetVehicle.Pos, 2, Color4( 255, 255, 255, 255 ), this.getSpriteIDBySide() );
								
						//	this.TargetVehicle.Respawn();
							this.TargetVehicle.Fix();

							this.TargetVehicle.PosX = Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos.x;
							this.TargetVehicle.PosY = Handler.Handlers.Bases.Bases[ this.Bases ].VehiclePos.y;
		
							this.TargetVehicle.EulerRotation = this.TargetVehicle.SpawnEulerRotation;
						}
					}
				}
				else this.TryingToEnter = false;
			}
		}
	}

	function MarkerFollowVehicle()
	{
		local tim = SqRoutine( this, function()
		{
			local vehicle = this.TargetVehicle;

			if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();

			this.VehicleMarker = SqBlip.Create( 0, vehicle.Pos, 2, Color4( 255, 255, 255, 255 ), 100 );
		}, 500, 0 );

		tim.Quiet = false;
		tim.SetTag( "MarkerFollowVehicle" );
	}

	function onPlayerKeyDown( player, key )
	{
		if( player.Data.Logged )
		{
			if( this.Status == 1 )
			{
				if( !Handler.Handlers.PlayerUID.checkVote( player.UID, player.UID2 ) )
				{
					if( this.Replaybase == 0 )
					{
						local indx = 0;

						switch( key.Tag )
						{
							case "Key1":
							indx = 0;
							break;

							case "Key2":
							indx = 1;
							break;

							case "Key3":
							indx = 2;
							break;

							case "Key4":
							indx = 3;
							break;

							case "Key5":
							indx = 4;
							break;

							case "Key6":
							indx = 5;
							break;
						}

						//local basenum = indx.tointeger()+1;		
						local basename = ( this.voteBase[ indx ].ID == 0 ) ? "Unknown" : Handler.Handlers.Bases.Bases[ this.voteBase[ indx ].ID ].Name;
						
						player.Data.voteBase = true;
						Handler.Handlers.PlayerUID.SetVote( player.UID, player.UID2, true );
						
						playsound( player, 50030 );
						
						//PMessage( player, "You have voted for the [ " + basenum + " ] base."  );
						SqCast.MsgAll( "VoteCastAll", player.Name, basename );

						this.voteBase[ indx ].Count ++;

						Handler.Handlers.Script.sendToClient( player, 302 );
						Handler.Handlers.Script.sendToClientToAll( 300, this.voteBase[ 0 ].Count + "," + this.voteBase[ 1 ].Count + "," + this.voteBase[ 2 ].Count + "," + this.voteBase[ 3 ].Count + "," + this.voteBase[ 4 ].Count + "," + this.voteBase[ 5 ].Count );
					}
				}
			}

			if( key.Tag == "F4" )
			{
				if( player.Data.AutoRespawn )
				{
					player.Data.AutoRespawn = 0;
					
					SqCast.MsgPlr( player, "AutoSpawnDisable" );
				}
				else
				{
					player.Data.AutoRespawn = 1;

					SqCast.MsgPlr( player, "AutoSpawnEnable" );
				}
			}

			if( this.Status > 1 )
			{
				if( ( time() - player.Data.RadioCD ) >= 2 )
				{
					if( player.Data.InRound( player ) )
					{
						switch( key.Tag )
						{
							case "Key1":
							SqCast.MsgTeam( player.Team, "TeamChatBackup", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key2":
							SqCast.MsgTeam( player.Team, "TeamChatRush", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key3":
							SqCast.MsgTeam( player.Team, "TeamChatFallBack", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key4":
							SqCast.MsgTeam( player.Team, "TeamChatEnemySpotted", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key5":
							SqCast.MsgTeam( player.Team, "TeamChatAgree", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key6":
							SqCast.MsgTeam( player.Team, "TeamChatDisagree", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key7":
							SqCast.MsgTeam( player.Team, "TeamChatClearArea", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;

							case "Key8":
							SqCast.MsgTeam( player.Team, "TeamChatCamp", SqCast.GetPlayerColor2( player ) );

							player.Data.RadioCD = time();
							break;
						}
					}
				}
			}
		}
	}

	function GetTopScorer( team )
	{
		this.BlueTeamScore = [];

		local getMembers = {};
		local t, ta , taa, tta, tat, j , k = 0, i = 0, getStr = null;

		getMembers.rawset( i++, 
		{
			Name	= 0,
			Score   = -5000,
		});

	    SqForeach.Player.Active( this, function( player ) 
		{
			if( team == player.Team )
			{
				getMembers.rawset( i, 
				{
					Name	= player.Data.ID,
					Score   = player.Data.CurrentStats.RoundKills,
				});

				k++;
				i++;
			}
		});
								
		for( j = 0; j < getMembers.len(); j++ )
		{
			for( local i = 0 ; i<getMembers.len()-1-j; i++ )
			{
				if( ( getMembers.rawin( i ) ) && ( getMembers.rawin( i + 1 ) ) )
				{
					
					if( getMembers[ i ].Score <= getMembers[ i + 1 ].Score )
					{
						
						t = getMembers[ i + 1 ].Name;
						ta = getMembers[ i + 1 ].Score;

						getMembers[ i + 1 ].Name <- getMembers[ i ].Name;
						getMembers[ i + 1 ].Score <- getMembers[ i ].Score;

						getMembers[ i ].Name <- t;
						getMembers[ i ].Score <- ta;
					}
				}
			}
		}

		for( local i = 0, j = 1; i < k ; i++, j++ )
		{
			//this.BlueTeamScore.append( getMembers[ i ].Name + "~" + getMembers[ i ].Kills + "~" + getMembers[ i ].Assist + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Score );
			return getMembers[ i ].Name;
		}

	}

	function CheckPlayerFPS()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				local calavgf = 0;
				local totalf = 0;
			
				foreach( index, value in player.Data.LastFPS ) { totalf += value; };

				calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );

				if( Handler.Handlers.Script.FPSLimit > calavgf )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningFPS", Handler.Handlers.Script.FPSLimit, player.Data.FPSWarning );
					
					SqCast.MsgAllAdmin( "FPSWarning", player.Name, calavgf, Handler.Handlers.Script.FPSLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						player.Data.Round = false;
						player.Team = 7;
						player.Skin = 173;
						player.Immunity = 31;
						player.Health = 100;
						player.StripWeapons();
						player.Disembark();
						player.Colour = Color3( 140, 140, 140 );
						player.SetOption( SqPlayerOption.CanAttack, false );

						player.MakeTask( function()
						{
							player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						}, 1500, 1 );

						player.Data.FPSWarning = 0;
						player.Data.PingWarning = 0;
						player.Data.AFKCount = 0;

						Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );

						SqCast.MsgAll( "FPSRemoved", SqCast.GetPlayerColor( player ), calavgf, Handler.Handlers.Script.FPSLimit );

						Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
						Handler.Handlers.Script.sendToClient( player, 2500 );

						Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:7" );
					}
				}
			}
		});
	}

	function CheckPlayerPing()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				local calavgp = 0;
				local totalp = 0;
			
				foreach( index, value in player.Data.LastPing ) { totalp += value; };

				calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );

				if( calavgp > Handler.Handlers.Script.PingLimit )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningPing", Handler.Handlers.Script.PingLimit, player.Data.FPSWarning );

					SqCast.MsgAllAdmin( "PingWarning", player.Name, calavgp, Handler.Handlers.Script.PingLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						player.Data.Round = false;
						player.Team = 7;
						player.Skin = 173;
						player.Immunity = 31;
						player.Health = 100;
						player.StripWeapons();
						player.Disembark();
						player.Colour = Color3( 140, 140, 140 );
						player.SetOption( SqPlayerOption.CanAttack, false );

						player.MakeTask( function()
						{
							player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						}, 1500, 1 );

						player.Data.FPSWarning = 0;
						player.Data.PingWarning = 0;
						player.Data.AFKCount = 0;

						Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );

						SqCast.MsgAll( "PingRemoved", SqCast.GetPlayerColor( player ), calavgp, Handler.Handlers.Script.PingLimit );

						Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
						Handler.Handlers.Script.sendToClient( player, 2500 );

						Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:7" );
					}
				}
			}
		});
	}

	function CheckPlayerJitter()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				if( this.verifyJitter( ::CalculateJitter( player.Data.LastPing ) ) > Handler.Handlers.Script.JitterLimit )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningJitter", Handler.Handlers.Script.JitterLimit, player.Data.FPSWarning );
					SqCast.MsgAllAdmin( "JittlerWarning", player.Name, ::CalculateJitter( player.Data.LastPing ), Handler.Handlers.Script.JitterLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						player.Data.Round = false;
						player.Team = 7;
						player.Skin = 173;
						player.Immunity = 31;
						player.Health = 100;
						player.StripWeapons();
						player.Disembark();
						player.Colour = Color3( 140, 140, 140 );
						player.SetOption( SqPlayerOption.CanAttack, false );

						player.MakeTask( function()
						{
							player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						}, 1500, 1 );

						player.Data.FPSWarning = 0;
						player.Data.PingWarning = 0;

						Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );

						SqCast.MsgAll( "JitterRemoved", SqCast.GetPlayerColor( player ), ::CalculateJitter( player.Data.LastPing ), Handler.Handlers.Script.JitterLimit );

						Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
						Handler.Handlers.Script.sendToClient( player, 2500 );

						Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:7" );
					}
				}
			}
		});
	}

	function CheckPlayerAFK()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				if( player.Data.AFKPos.tostring() == player.Pos.tostring() && player.State != 2 && this.IsNearSpawn( player ) )
				{
					player.Data.AFKCount ++;

					if( player.Data.AFKCount == 5 ) 
					{
						player.Data.Round = false;
						player.Team = 7;
						player.Skin = 173;
						player.Immunity = 31;
						player.Health = 100;
						player.StripWeapons();
						player.Disembark();
						player.Colour = Color3( 140, 140, 140 );
						player.SetOption( SqPlayerOption.CanAttack, false );

						player.MakeTask( function()
						{
							player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						}, 1500, 1 );

						player.Data.FPSWarning = 0;
						player.Data.PingWarning = 0;
						player.Data.AFKCount = 0;

						Handler.Handlers.Script.sendToClient( player, 404, "Type /spec [player] to spectate player, /exitspec to exit specting mode." );

						SqCast.MsgAll( "AFKRemoved", SqCast.GetPlayerColor( player ) );

						Handler.Handlers.Script.sendToClient( player, 401, "255$255$255$-Rob The Vehicle" );
						Handler.Handlers.Script.sendToClient( player, 2500 );

						Handler.Handlers.Script.sendToClientToAll( 2502, player.ID + ":255:255:255:7" );
					}
				}
				else 
				{
					player.Data.AFKPos = player.Pos;
					player.Data.AFKCount = 0;
				}
			}
		});
	}

	function verifyJitter( value )
	{
		try 
		{
			if( value.tointeger() > 0 ) return value;
			else return 0;
		}
		catch( e ) return 0;
	}

	function GetRPGSetInTeam( team )
	{
		local result = null;

		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Team == team && player.Data.wepSet == 4 ) result = player;
		});

		return result;
	}

	function checkSameRPGOwner( req, owner )
	{
		if( owner == null ) return false;

		if( req.ID == owner.ID && req.Data.OldTeam == req.Team ) return false;

		else return owner;
	}

	function onPlayerWeaponChange( player, old, new )
	{
		if( !Handler.Handlers.PlayerUID.CheckRPGBan( player ) )
		{
			if( new == 30 )
			{
				SqCast.MsgPlr( player, "DisarmRPGBan" );

				player.Data.wepSet = 1;

				this.giveSetWeapon( player );
			}
		}
	}

	function RequestPlayerColour( plr )
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			switch( player.Team )
			{
				case 1:
				Handler.Handlers.Script.sendToClient( plr, 2502, player.ID + ":255:51:0:" + player.Team );
				break;

				case 2:
				Handler.Handlers.Script.sendToClient( plr, 2502, player.ID + ":51:102:255:" + player.Team );
				break;
			}
		});
	}

	function Surrender( team )
	{
    	//try 
    	//{
			Handler.Handlers.Script.RoundActive = false;
			
			AnnounceAll( "", 5 );
			
			Handler.Handlers.Script.BluePackLim = [000,0,0,0,0,0,0,0];
			Handler.Handlers.Script.RedPackLim = [000,0,0,0,0,0,0,0];
			
			local getTimer = Handler.Handlers.Script.findRoutine( "StartRound" );
			local getTImer2 = Handler.Handlers.Script.findRoutine( "DuringRound" );
			local getTImer3 = Handler.Handlers.Script.findRoutine( "RespawnVehicle" );
    		local getTimer4 = Handler.Handlers.Script.findRoutine( "MarkerFollowVehicle" );

    		if( getTimer ) getTimer.Terminate();
    		if( getTImer2 ) getTImer2.Terminate();
    		if( getTImer3 ) getTImer3.Terminate();
    		if( getTimer4 ) getTimer4.Terminate();

    		if( this.TargetVehicle.ID != -1 ) this.TargetVehicle.Destroy();
			if( this.VehicleMarker.ID != -1 ) this.VehicleMarker.Destroy();
			if( this.DefenderMarker.ID != -1 ) this.DefenderMarker.Destroy();
			if( this.vehicleMarker.ID != -1 ) this.vehicleMarker.Destroy();
			
			this.Status = 0;
			this.Lastbase = this.Bases;
        	this.LastDefender = this.Defender;
			this.TryingToEnter = false;

			this.RemovePickup();

			if( this.Replaybase == 2 ) this.Replaybase = 0;
			this.SwitchDefender();

			SqCast.MsgAll( "TeamSurrender1", SqCast.GetTeamName( team ), HexColour.Yellow );
			Handler.Handlers.Discord.ToDiscord( 1, "**-> ``%s`` has surrender.**", SqCast.GetTeamName( team ) );

			SqForeach.Player.Active( this, function( player ) 
			{
				player.Data.Assist.HitBy = "";
				player.Data.Round = false;

				if( player.Data.InRound( player ) )
				{
					if( player.Vehicle ) 
					{
						player.Vehicle.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						player.Disembark();
					}
					else player.Pos = Vector3( -966.268921,-252.156738,379.886597 );

					player.StripWeapons();
					player.Health = 100;
					if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
					player.Data.Stats.RoundPlayed ++;

					if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
				}

				Handler.Handlers.Script.sendToClientToAll( 400, "end" );
				Handler.Handlers.Script.sendToClientToAll( 501, "end" );
                Handler.Handlers.Script.sendToClientToAll( 401, "255$255$255$-Rob The Vehicle" );


				if( player.Team == 1 || player.Team == 2 )
				{
					SqCast.MsgPlr( player, "RoundStats" );
					SqCast.MsgPlr( player, "RoundStats1", player.Data.CurrentStats.RoundKills, player.Data.CurrentStats.RoundDeaths, ( ( player.Data.CurrentStats.RoundSpree >= 5 ) ? player.Data.CurrentStats.RoundSpree : 0 ) );
				}
				player.SetOption( SqPlayerOption.Controllable, true );
			});

			this.GetRedScore();
			this.GetBlueScore();
			Handler.Handlers.Matchlogger.WritelogToKill( SqCast.GetTeamName( team ) + " has surrender." );

			local getoutput = Handler.Handlers.Matchlogger.EndRound( type );

			SqCast.MsgAll( "GetRoundStatsOutput", getoutput );
			Handler.Handlers.Discord.ToDiscord( 1, "***-> You can view this round's statistics on %s***", getoutput );
			
			Handler.Handlers.Script.first_damage = false;

			if ( Handler.Handlers.Script.Autostart )
			{
				if( this.getPlayerTeamCountV2( 1 ) > 0 && getPlayerTeamCountV2( 2 ) > 0 ) this.PrepRound();
			}
		//}
		//catch( e ) SqLog.Err( "Error on CGameplay::EndRound, [%s]", e );			
	}

	function RemovePickup() 
	{
		SqForeach.Pickup.Active(this, function( pickup )
		{
			if( pickup.Tag == "ToRound" || ( pickup.Tag.find( "Health" ) >= 0 ) || ( pickup.Tag.find( "Armour" ) >= 0 ) || ( pickup.Tag.find( "Ammo" ) >= 0 ) ) 
			{
				pickup.Destroy();
			}
		});

		if( Handler.Handlers.Gameplay.HealthPickup[ 1 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.HealthPickup[ 1 ].Radar.Destroy();
		if( Handler.Handlers.Gameplay.HealthPickup[ 2 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.HealthPickup[ 2 ].Radar.Destroy();
		
		Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance = null;
		Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance = null;

		if( Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Radar.Destroy();
		if( Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Radar.Destroy();
		
		Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance = null;
		Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance = null;

		if( Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Radar.Destroy();
		if( Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Radar.ID != -1 ) Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Radar.Destroy();

		Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance = null;
		Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance = null;

		Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Cooldown = 0;
		Handler.Handlers.Gameplay.HealthPickup[ 1 ].Cooldown = 0;
		Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Cooldown = 0;

		Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Cooldown = 0;
		Handler.Handlers.Gameplay.HealthPickup[ 2 ].Cooldown = 0;
		Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Cooldown = 0;

		Handler.Handlers.Script.sendToClientToAll( 2700, "HealthRed; ;0;0;0" );
        Handler.Handlers.Script.sendToClientToAll( 2700, "HealthBlue; ;0;0;0" );
        Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourRed; ;0;0;0" );
        Handler.Handlers.Script.sendToClientToAll( 2700, "ArmourBlue; ;0;0;0" );
        Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoRed; ;0;0;0" );
        Handler.Handlers.Script.sendToClientToAll( 2700, "AmmoBlue; ;0;0;0" );

	}

	function CreateTextdraw( player )
	{
		if( Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "HealthRed;Health Pickup Quatitiy: " + Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.HealthPickup[ 1 ].Instance.Pos.z );
		if( Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "HealthBlue;Health Pickup Quatitiy: " + Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.HealthPickup[ 2 ].Instance.Pos.z );

		if( Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "ArmourRed;Armour Pickup Quatitiy: " + Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 1 ].Instance.Pos.z );
		if( Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "ArmourBlue;Armour Pickup Quatitiy: " + Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.ArmourPickup[ 2 ].Instance.Pos.z );

		if( Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "AmmoRed;Ammo Pickup Quatitiy: " + Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 1 ].Instance.Pos.z );
		if( Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance ) Handler.Handlers.Script.sendToClient( player, 2700, "AmmoBlue;Ammo Pickup Quatitiy: " + Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance.Data.Count + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance.Pos.x + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance.Pos.y + ";" + Handler.Handlers.Gameplay.AmmoPickup[ 2 ].Instance.Pos.z );
	}

	function PlayMVP( id ) 
	{
		local tim = SqRoutine( this, function()
   		{
			SqForeach.Player.Active( this, function( player ) 
			{
				if( !player.Data.NoMVP )
				{
					player.PlaySound( id );
					player.PlaySound( id );
					player.PlaySound( id );
					player.PlaySound( id );
					player.PlaySound( id );
				}
			});
		}, 1200, 1 );

		tim.Quiet = false;
	}

	function TeleportToLobby()
	{
		this.isEnding = true;
		SqServer.SetGameSpeed( 0.08 );

		local cd = 0;
		local tim = SqRoutine( this, function()
   		{
			cd ++;

			if( cd == 7 )
			{
				SqServer.SetGameSpeed( 1 );
				SqForeach.Player.Active( this, function( player ) 
				{
					player.Data.Assist.HitBy = "";
					player.Data.Round = false;
					player.Data.WasInRound = false;

					if( player.Data.InRound( player ) )
					{
						if( player.Vehicle ) 
						{
							player.Vehicle.Pos = Vector3( -966.268921,-252.156738,379.886597 );
							player.Disembark();
						}
						else player.Pos = Vector3( -966.268921,-252.156738,379.886597 );

						player.StripWeapons();
						player.Health = 100;
						if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
						player.Data.Stats.RoundPlayed ++;

						if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
					}

						if( Handler.Handlers.Matchlogger.IsParticipate( player.Name ) )
						{
							local st = Handler.Handlers.Matchlogger.GetRoundData( player.Name );

							SqCast.MsgPlr( player, "RoundStats" );
							SqCast.MsgPlr( player, "RoundStats1", st.kills, st.deaths, ( ( player.Data.CurrentStats.RoundSpree >= 5 ) ? player.Data.CurrentStats.RoundSpree : 0 ) );
						}
					player.SetOption( SqPlayerOption.Controllable, true );
				});
			}

			if( cd == 8 )
			{
				Handler.Handlers.Gameplay.isEnding = false;
				if ( Handler.Handlers.Script.Autostart )
				{
					if( Handler.Handlers.Gameplay.getPlayerTeamCountV2( 1 ) > 0 && Handler.Handlers.Gameplay.getPlayerTeamCountV2( 2 ) > 0 ) Handler.Handlers.Gameplay.PrepRound();
				}
			}
		}, 1000, 10 );

		tim.SetTag( "EndRound2" );
		tim.Quiet = false;
	}

	function TeleportToLobbySurrender()
	{
		SqServer.SetGameSpeed( 1 );
		SqForeach.Player.Active( this, function( player ) 
		{
			player.Data.Assist.HitBy = "";
			player.Data.Round = false;

			if( player.Data.InRound( player ) )
			{
				if( player.Vehicle ) 
				{
					player.Vehicle.Pos = Vector3( -966.268921,-252.156738,379.886597 );
					player.Disembark();
				}
				else player.Pos = Vector3( -966.268921,-252.156738,379.886597 );

				player.StripWeapons();
				player.Health = 100;
				if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
				player.Data.Stats.RoundPlayed ++;

				if( player.Spawned ) player.Pos = Vector3( -966.268921,-252.156738,379.886597 );
			}

			if( Handler.Handlers.Matchlogger.IsParticipate( player.Name ) )
			{
				SqCast.MsgPlr( player, "RoundStats" );
				SqCast.MsgPlr( player, "RoundStats1", player.Data.CurrentStats.RoundKills, player.Data.CurrentStats.RoundDeaths, ( ( player.Data.CurrentStats.RoundSpree >= 5 ) ? player.Data.CurrentStats.RoundSpree : 0 ) );
			}
			player.SetOption( SqPlayerOption.Controllable, true );
		});
	}

	function CheckMine()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				foreach( index, value in this.Mine )
				{
					if( player.Team != value.Team )
					{
						if( player.Pos.DistanceTo( value.Pos ) < 2.5 )
						{
							SqServer.CreateExplosion( 0, 7,  value.Pos, SqPlayer.NullInst(), false );

							this.Mine.rawdelete( index );

							if( SqFind.Object.WithID( index ) ) SqFind.Object.WithID( index ).Destroy();
						}
					}
				}
			}
		});
	}

	function GetMineCountInTeam( id )
	{
		local count = 0;
		foreach( index, value in this.Mine )
		{
			if( value.Team == id ) count ++;
		}

		return count;
	}

	function getMVPTrackName( id )
	{
		switch( id )
		{
			case 50043: return "Default RTV MVP Track";
			case 50044: return "EZ KATKA";
			case 50045: return "WOAH";
			case 50046: return "Nico Nico Nii";
			case 50047: return "EZ4ENCE";
			case 50048: return "SA Mission Pass";
			case 50049: return "SOSAT BLYAT";
			case 50050: return "Flawless Victory";
			case 50051: return "GJ VCPD";
			case 50052: return "Vi sitter i Ventrilo och Spelar DotA";
		}
	}

	function IsNearSpawn( player, maxradius = 6 )
	{
		if( player.Data.InRound( player ) )
		{
			if( player.Team == 1 || player.Team == 2 )
			{
				local defpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team1Pos;
				local attpos = Handler.Handlers.Bases.Bases[ this.Bases ].Team2Pos;
				
				switch( player.Team )
				{
					case 1:
					if( this.Defender == 1 ) 
					{
						if( defpos.DistanceTo( player.Pos ) < maxradius ) return true;
					}

					else 
					{
						if( attpos.DistanceTo( player.Pos ) < maxradius ) return true;
					}
					break;

					case 2:
					if( this.Defender == 2 ) 
					{
						if( defpos.DistanceTo( player.Pos ) < maxradius ) return true;
					}
					
					else 
					{
						if( attpos.DistanceTo( player.Pos ) < maxradius ) return true;
					}
					break;
				}
			}
		}
	}

	function IsPrivate( option, level )
	{
		if( option == false ) return true;
		if( option == true && level > 1 ) return true;
		if( option == true && level < 2 ) return false;
	}

	function VerifyDefenderMaxResourceSpawn( player )
	{
		if( player.Team == this.Defender )
		{
			if( this.IsNearSpawn( player, 15 ) ) return true;
		}
		else return true;
	}


	function CheckPlayerFPS2()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				local calavgf = 0;
				local totalf = 0;
			
				foreach( index, value in player.Data.LastFPS ) { totalf += value; };

				calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );

				if( Handler.Handlers.Script.FPSLimit > calavgf )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningFPS", Handler.Handlers.Script.FPSLimit, player.Data.FPSWarning );
					
					SqCast.MsgAllAdmin( "FPSWarning", player.Name, calavgf, Handler.Handlers.Script.FPSLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						SqCast.MsgAll( "FPSRemoved2", SqCast.GetPlayerColor( player ), calavgf, Handler.Handlers.Script.FPSLimit );

						Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** has been kicked from the server due to low fps. ``[%f/%d]``", SqCast.GetTeamName( player.Team ), player.Name, calavgf, Handler.Handlers.Script.FPSLimit );
						
						player.Kick();
					}
				}
			}
		});
	}

	function CheckPlayerPing2()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				local calavgp = 0;
				local totalp = 0;
			
				foreach( index, value in player.Data.LastPing ) { totalp += value; };

				calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );

				if( calavgp > Handler.Handlers.Script.PingLimit )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningPing", Handler.Handlers.Script.PingLimit, player.Data.FPSWarning );

					SqCast.MsgAllAdmin( "PingWarning", player.Name, calavgp, Handler.Handlers.Script.PingLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						SqCast.MsgAll( "PingRemoved2", SqCast.GetPlayerColor( player ), calavgp, Handler.Handlers.Script.PingLimit );
						
						Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** has been kicked from the server due to high ping. ``[%d/%d]``", SqCast.GetTeamName( player.Team ), player.Name, calavgp, Handler.Handlers.Script.PingLimit );

						player.Kick();
					}
				}
			}
		});
	}

	function CheckPlayerJitter2()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.InRound( player ) )
			{
				if( this.verifyJitter( ::CalculateJitter( player.Data.LastPing ) ) > Handler.Handlers.Script.JitterLimit )
				{
					player.Data.FPSWarning ++;

					SqCast.MsgPlr( player, "WarningJitter", Handler.Handlers.Script.JitterLimit, player.Data.FPSWarning );
					SqCast.MsgAllAdmin( "JittlerWarning", player.Name, ::CalculateJitter( player.Data.LastPing ), Handler.Handlers.Script.JitterLimit, player.Data.FPSWarning );

					if( player.Data.FPSWarning == 4 ) 
					{
						SqCast.MsgAll( "JitterRemoved2", SqCast.GetPlayerColor( player ), ::CalculateJitter( player.Data.LastPing ), Handler.Handlers.Script.JitterLimit );

						Handler.Handlers.Discord.ToDiscord( 1, "``%s`` **%s** kicked from the server due to high jitter. ``[%d/%d]``", SqCast.GetTeamName( player.Team ), player.Name, ::CalculateJitter( player.Data.LastPing ), Handler.Handlers.Script.JitterLimit );

						player.Kick();
					}
				}
			}
		});
	}


}
