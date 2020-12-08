class CPlayerUID
{
	UID = {};
	UID2 = {};
	ClanBan = {};
	DisallowMultiClient = true;

	function constructor() 
	{
	    SqCore.On().PlayerCreated.Connect( this, onPlayerJoin );
	}

	function LoadUID1()
	{
		try 
		{
			local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_uid1" );

			while( result.Step() )
			{
				this.UID.rawset( result.GetString( "UID" ),
				{
					Ban				= ::json_decode( result.GetString( "Ban" ) ),
					Mute 			= ::json_decode( result.GetString( "Mute" ) ),
					Alias 			= ::json_decode( result.GetString( "Alias" ) ),
					RPGBan			= ::json_decode( result.GetInteger( "RPGBan" ) ),
					Comment			= result.GetString( "Comment" ),
					VoteBase 		= false,
					VoteSur 		= false,
				});
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::LoadUID1 [%s]", e );
	}

	function LoadUID2()
	{
		try
		{
			local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_uid2" );

			while( result.Step() )
			{
				this.UID2.rawset( result.GetString( "UID" ),
				{
					Ban				= ::json_decode( result.GetString( "Ban" ) ),
					Mute 			= ::json_decode( result.GetString( "Mute" ) ),
					Alias 			= ::json_decode( result.GetString( "Alias" ) ),
					RPGBan			= ::json_decode( result.GetInteger( "RPGBan" ) ),
					Comment			= result.GetString( "Comment" ),
					VoteBase 		= false,
					VoteSur 		= false,
				});
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::LoadUID1 [%s]", e );
	}

	function LoadClanBan()
	{
		try
		{
			local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_clan_ban" );

			while( result.Step() )
			{
				this.ClanBan.rawset( result.GetString( "Name" ),
				{
					Tag				= ::json_decode( result.GetString( "Tag" ) ),
				});
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::LoadClanBan [%s]", e );
	}

	function onPlayerJoin( player, header, payload )
	{
		Handler.Handlers.Discord.SendPlayerCount();
		
		try
		{
			player.Data = CPlayer( player );

			SqCast.MsgAllAdmin( "JoinMessage2", player.Data.OldName, player.Name );

			if( !CheckTagIsBanned( player ) )
			{
				local result = Handler.Handlers.Script.Database.QueryF( "SELECT IsActivated FROM rtv3_account WHERE Name LIKE '%s';", player.Data.OldName );
				local result1 = Handler.Handlers.Script.Database.QueryF( "SELECT Name FROM rtv3_account WHERE Name LIKE '%s';", player.Data.OldName );
				
				if ( result.Step() ) 
				{
					player.Data.IsActivated = result.GetInteger( "IsActivated" );
					//else player.Data.IsActivated = 0;
				
					if( player.Data.IsActivated == 0 ) 
					{
						player.AnnounceEx( 0, "You have been kicked, press TAB for more information." );

						if ( result1.Step() )
						{
							SqCast.MsgPlr( player, "AccountNotActivated" );

							SqCast.MsgAllAdmin( "ActivatedBlocked", player.Data.OldName );
						}
						else SqCast.MsgPlr( player, "AccountNotReg" );
						
						SqCast.MsgPlr( player, "PortalLink" );
						SqCast.MsgPlr( player, "DiscordLink" );

						player.MakeTask( function()
						{
							player.Kick(); 
						}, 2000, 1 );
					}			
				}

				else 
				{
					player.AnnounceEx( 0, "You have been kicked, press TAB for more information." );

					SqCast.MsgPlr( player, "AccountNotReg" );
					SqCast.MsgPlr( player, "PortalLink" );
					SqCast.MsgPlr( player, "DiscordLink" );

					player.MakeTask( function()
					{
						player.Kick(); 
					}, 2000, 1 );
				}
				
				if( player.Data.IsActivated == 1 )
				{
					if( !this.verifyMultiClient( player ) || player.UID == "45dc56d324df443267f100463192902293e1f7fa" )
					{
	//					SqCast.MsgPlr( player, "WelcomeMessage", player.Data.OldName );
						
						if( this.UID.rawin( player.UID ) )
						{
							if( this.checkUIDBan( player ) ) return;
						}
						else this.RegisterUID( player );

						if( this.UID2.rawin( player.UID2 ) )
						{
							if( this.checkUID2Ban( player ) ) return;
						}
						else RegisterUID2( player );

						this.checkUIDMute( player );
						this.checkUID2Mute( player );

						this.checkUIDRPGBan( player );
						this.checkUID2RPGBan( player );
					}
				
					else 
					{			
						player.AnnounceEx( 3, "Multi-client is not allowed." )
						SqCast.MsgPlr( player, "DisallowMultiClient" ), player.Kick();
					}
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::onPlayerJoin [%s]", e );
	}

	function checkUIDBan( player )
	{
		try 
		{
			if( this.UID[ player.UID ].Ban != null )
			{
				if( this.UID[ player.UID ].Ban.Duration.tointeger() == 5000000 )
				{
					SqCast.MsgPlr( player, "Kickban", SqCast.GetPlayerColor( this.UID[ player.UID ].Ban.Admin ), this.UID[ player.UID ].Ban.Reason, GetDate( this.UID[ player.UID ].Ban.Time.tointeger() ) );
					SqCast.MsgPlr( player, "UnbanForum", "http://rtv-pl-community.com/" );

					player.Kick();

					return true;
				}

				else 
				{
					if( this.UID[ player.UID ].Ban.Duration.tointeger() > ( time() - this.UID[ player.UID ].Ban.Time.tointeger() ) )
					{
						SqCast.MsgPlr( player, "Kickban", SqCast.GetPlayerColor( this.UID[ player.UID ].Ban.Admin ), this.UID[ player.UID ].Ban.Reason, GetDate( this.UID[ player.UID ].Ban.Time.tointeger() ) );
						SqCast.MsgPlr( player, "KickbanTimered", GetTiming( ( this.UID[ player.UID ].Ban.Duration.tointeger() - ( time() - this.UID[ player.UID ].Ban.Time.tointeger() ) ) ) );

						player.Kick();

						return true;
					}

					else this.UID[ player.UID ].Ban = null;
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUIDBan [%s]", e );
	}

	function checkUIDMute( player )
	{
		try 
		{
			if( this.UID[ player.UID ].Mute != null )
			{
				if( this.UID[ player.UID ].Mute != null )
				{
					if( this.UID[ player.UID ].Mute.Duration.tointeger() == 5000000 )
					{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID[ player.UID ].Mute.Admin, TextColor.Error, this.UID[ player.UID ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID[ player.UID ].Mute.Time.tointeger() ) );
							
						//	player.Msg3( TextColor.Error, Lang.UnmuteForum[0], Server.Forum );

						player.Data.Mute = this.UID[ player.UID ].Mute;
					}

					else 
					{
						if( this.UID[ player.UID ].Mute.Duration.tointeger() > ( time() - this.UID[ player.UID ].Mute.Time.tointeger() ) )
						{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID[ player.UID ].Mute.Admin, TextColor.Error, this.UID[ player.UID ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID[ player.UID ].Mute.Time.tointeger() ) );

						//	player.Msg3( TextColor.Error, Lang.UnmuteDuration[0], SqInteger.SecondToTime( ( this.UID[ player.UID ].Mute.Duration.tointeger() - ( time() - this.UID[ player.UID ].Mute.Time.tointeger() ) ) ) );
									
							player.Data.Mute = this.UID[ player.UID ].Mute;
									
		                    player.MakeTask( function()
		                    {  
		                        Handler.Handlers.PlayerUID.UID[ player.UID ].Mute = null;

		                        player.Data.Mute = null;
		                                                            
		                        this.Terminate();

		                //    SqCast.MsgAll( TextColor.Admin, Lang.AUnmuteTimered, player.Name );
		                    }, ( Handler.Handlers.PlayerUID.UID[ player.UID ].Mute.Duration.tointeger() * 1500 ), 1 ).SetTag( "Mute" );
						}
						else this.UID[ player.UID ].Mute = null;						
					}
				}
			}	
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUIDMute [%s]", e );
	}

	function checkUIDRPGBan( player )
	{
		try 
		{
			if( this.UID[ player.UID ].RPGBan != null )
			{
				if( this.UID[ player.UID ].RPGBan != null )
				{
					if( this.UID[ player.UID ].RPGBan.Duration.tointeger() == 5000000 )
					{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID[ player.UID ].Mute.Admin, TextColor.Error, this.UID[ player.UID ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID[ player.UID ].Mute.Time.tointeger() ) );
							
						//	player.Msg3( TextColor.Error, Lang.UnmuteForum[0], Server.Forum );

						player.Data.RPGBan = this.UID[ player.UID ].RPGBan;
					}

					else 
					{
						if( this.UID[ player.UID ].RPGBan.Duration.tointeger() > ( time() - this.UID[ player.UID ].RPGBan.Time.tointeger() ) )
						{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID[ player.UID ].Mute.Admin, TextColor.Error, this.UID[ player.UID ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID[ player.UID ].Mute.Time.tointeger() ) );

						//	player.Msg3( TextColor.Error, Lang.UnmuteDuration[0], SqInteger.SecondToTime( ( this.UID[ player.UID ].Mute.Duration.tointeger() - ( time() - this.UID[ player.UID ].Mute.Time.tointeger() ) ) ) );
									
							player.Data.RPGBan = this.UID[ player.UID ].RPGBan;
									
		                    player.MakeTask( function()
		                    {  
		                        Handler.Handlers.PlayerUID.UID[ player.UID ].RPGBan = null;

		                        player.Data.RPGBan = null;
		                                                            
		                        this.Terminate();

		                //    SqCast.MsgAll( TextColor.Admin, Lang.AUnmuteTimered, player.Name );
		                    }, ( Handler.Handlers.PlayerUID.UID[ player.UID ].RPGBan.Duration.tointeger() * 1500 ), 1 ).SetTag( "RPGBan" );
						}
						else this.UID[ player.UID ].RPGBan = null;						
					}
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUIDRPGBan [%s]", e );
	}

	function RegisterUID( player )
	{
		try 
		{
			local oldname = player.Data.OldName;

			Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_uid1 ( UID, Ban, Mute, RPGBan, Alias, Comment ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s' );", player.UID, "N/A", "N/A", "N/A", "N/A", "N/A" );

			this.UID.rawset( player.UID,
			{
				Ban				= null,
				Mute 			= null,
				RPGBan			= null,
				Alias 			= {},
				Comment			= "N/A",
				VoteBase 		= false,
				VoteSur 		= false,
			});

			this.UID[ player.UID ].Alias.rawset( oldname, 
			{
				UsedTimes	= "1",
				LastUsed	= time().tostring(),
			});
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::RegisterUID [%s]", e );
	}

	function checkUID2Ban( player )
	{
		try 
		{
			if( this.UID2[ player.UID2 ].Ban != null )
			{
				if( this.UID2[ player.UID2 ].Ban.Duration.tointeger() == 5000000 )
				{
					SqCast.MsgPlr( player, "Kickban", SqCast.GetPlayerColor( this.UID2[ player.UID2 ].Ban.Admin ), this.UID2[ player.UID2 ].Ban.Reason, GetDate( this.UID2[ player.UID2 ].Ban.Time.tointeger() ) );
					SqCast.MsgPlr( player, "UnbanForum", "http://rtv-pl-community.com/" );
							
					player.Kick();

					return true;
				}

				else 
				{
					if( this.UID2[ player.UID2 ].Ban.Duration.tointeger() > ( time() - this.UID2[ player.UID2 ].Ban.Time.tointeger() ) )
					{
						SqCast.MsgPlr( player, "Kickban", SqCast.GetPlayerColor( this.UID2[ player.UID2 ].Ban.Admin ), this.UID2[ player.UID2 ].Ban.Reason, GetDate( this.UID2[ player.UID2 ].Ban.Time.tointeger() ) );
						SqCast.MsgPlr( player, "KickbanTimered", GetTiming( ( this.UID2[ player.UID2 ].Ban.Duration.tointeger() - ( time() - this.UID2[ player.UID2 ].Ban.Time.tointeger() ) ) ) );
								
						player.Kick();

						return true;
					}
					else this.UID2[ player.UID2 ].Ban = null;
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUID2Ban [%s]", e );
	}

	function checkUID2Mute( player )
	{
		try 
		{
			if( !player.Data.Mute )
			{
				if( this.UID2[ player.UID2 ].Mute )
				{
					if( this.UID2[ player.UID2 ].Mute.Duration.tointeger() == 5000000 )
					{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID2[ player.UID2 ].Mute.Admin, TextColor.Error, this.UID2[ player.UID2 ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID2[ player.UID2 ].Mute.Time.tointeger() ) );
								
						//	player.Msg3( TextColor.Error, Lang.UnmuteForum[0], Server.Forum );
					}

					else 
					{
						if( this.UID2[ player.UID2 ].Mute.Duration.tointeger() > ( time() - this.UID2[ player.UID2 ].Mute.Time.tointeger() ) )
						{
							//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID2[ player.UID2 ].Mute.Admin, TextColor.Error, this.UID2[ player.UID2 ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID2[ player.UID2 ].Mute.Time.tointeger() ) );

							//	player.Msg3( TextColor.Error, Lang.UnmuteDuration[0], SqInteger.SecondToTime( ( this.UID2[ player.UID2 ].Mute.Duration.tointeger() - ( time() - this.UID2[ player.UID2 ].Mute.Time.tointeger() ) ) ) );
										
			                player.MakeTask( function()
			                {  
			                    Handler.Handlers.PlayerUID.UID2[ player.UID2 ].Mute = null;
			                   
			                   	player.Data.Mute = null;

			                   	this.Terminate();

			                }, ( Handler.Handlers.PlayerUID.UID2[ player.UID2 ].Mute.Duration.tointeger() * 1500 ), 1 ).SetTag( "Mute" );
						}
						else this.UID2[ player.UID2 ].Mute = null;						
					}
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUID2Mute [%s]", e );
	}

	function checkUID2RPGBan( player )
	{
		try 
		{
			if( !player.Data.RPGBan )
			{
				if( this.UID2[ player.UID2 ].RPGBan )
				{
					if( this.UID2[ player.UID2 ].RPGBan.Duration.tointeger() == 5000000 )
					{
						//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID2[ player.UID2 ].Mute.Admin, TextColor.Error, this.UID2[ player.UID2 ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID2[ player.UID2 ].Mute.Time.tointeger() ) );
								
						//	player.Msg3( TextColor.Error, Lang.UnmuteForum[0], Server.Forum );
					}

					else 
					{
						if( this.UID2[ player.UID2 ].RPGBan.Duration.tointeger() > ( time() - this.UID2[ player.UID2 ].RPGBan.Time.tointeger() ) )
						{
							//	player.Msg3( TextColor.Error, Lang.MuteNotice[0], this.UID2[ player.UID2 ].Mute.Admin, TextColor.Error, this.UID2[ player.UID2 ].Mute.Reason, TextColor.Error, SqInteger.TimestampToDate( this.UID2[ player.UID2 ].Mute.Time.tointeger() ) );

							//	player.Msg3( TextColor.Error, Lang.UnmuteDuration[0], SqInteger.SecondToTime( ( this.UID2[ player.UID2 ].Mute.Duration.tointeger() - ( time() - this.UID2[ player.UID2 ].Mute.Time.tointeger() ) ) ) );
										
			                player.MakeTask( function()
			                {  
			                    Handler.Handlers.PlayerUID.UID2[ player.UID2 ].RPGBan = null;
			                   
			                   	player.Data.RPGBan = null;

			                   	this.Terminate();

			                }, ( Handler.Handlers.PlayerUID.UID2[ player.UID2 ].RPGBan.Duration.tointeger() * 1500 ), 1 ).SetTag( "RPGBan" );
						}
						else this.UID2[ player.UID2 ].RPGBan = null;						
					}
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::checkUID2RPGBan [%s]", e );
	}

	function RegisterUID2( player )
	{
		try 
		{
			local oldname = player.Data.OldName;

			Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_uid2 ( UID, Ban, Mute, RPGBan, Alias, Comment ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s' );", player.UID2, "N/A", "N/A", "N/A", "N/A", "N/A" );

			this.UID2.rawset( player.UID2,
			{
				Ban				= null,
				Mute 			= null,
				RPGBan			= null,
				Alias 			= {},
				Comment			= "N/A",
				VoteBase 		= false,
				VoteSur			= false,
			});

			this.UID2[ player.UID2 ].Alias.rawset( oldname, 
			{
				UsedTimes	= "1",
				LastUsed	= time().tostring(),
			});
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::RegisterUID2 [%s]", e );
	}

	function AddAlias( player )
	{
		try 
		{
			local findUID = false, findUID2 = false;

			if( this.UID[ player.UID ].Alias == null ) this.UID[ player.UID ].Alias = {};

			foreach( index, value in this.UID[ player.UID ].Alias )
			{
				if( index.tolower() == player.Name.tolower() )
				{
					value.UsedTimes	= ( value.UsedTimes.tointeger() + 1 );
					value.LastUsed	= time().tostring();
					findUID		= true;
				} 
			}

			if( !findUID )
			{
				this.UID[ player.UID ].Alias.rawset( player.Name, 
				{
					UsedTimes	= "1",
					LastUsed	= time().tostring(),
				});
			}

			if( this.UID2[ player.UID2 ].Alias == null ) this.UID2[ player.UID2 ].Alias = {};
			
			foreach( index, value in this.UID2[ player.UID2 ].Alias )
			{
				if( index.tolower() == player.Name.tolower() )
				{
					value.UsedTimes	= ( value.UsedTimes.tointeger() + 1 );
					value.LastUsed	= time().tostring();
					findUID2	= true;
				} 
			}

			if( !findUID2 )
			{
				this.UID2[ player.UID2 ].Alias.rawset( player.Name, 
				{
					UsedTimes	= "1",
					LastUsed	= time().tostring(),
				});
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::AddAlias [%s]", e );
	}

	function Save( uid1, uid2 )
	{
		try 
		{
			if( !Handler.Handlers.Script.ReadOnly )
			{
				local getUID1 = ( this.UID.rawin( uid1 ) ) ? this.UID[ uid1 ] : null;
				local getUID2 = ( this.UID2.rawin( uid2 ) ) ? this.UID2[ uid2 ] : null ;

				if( getUID1 ) Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_uid1 SET Ban = '%s', Mute = '%s', RPGBan = '%s', Alias = '%s', Comment = '%s' WHERE UID = '%s'", ::json_encode( getUID1.Ban ), ::json_encode( getUID1.Mute ), ::json_encode( getUID1.RPGBan ), ::json_encode( getUID1.Alias ), getUID1.Comment, uid1 );
				if( getUID2 ) Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_uid2 SET Ban = '%s', Mute = '%s', RPGBan = '%s', Alias = '%s', Comment = '%s' WHERE UID = '%s'", ::json_encode( getUID2.Ban ), ::json_encode( getUID2.Mute ), ::json_encode( getUID1.RPGBan ), ::json_encode( getUID2.Alias ), getUID2.Comment, uid2 );	
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::Save [%s]", e );
	}

	function AddMute( victim, admin, reason, duration )
	{
		try 
		{
		/*	this.UID[ victim.UID ].Mute = {};

			this.UID[ victim.UID ].Mute.rawset( "Admin", admin );
			this.UID[ victim.UID ].Mute.rawset( "Reason", reason );
			this.UID[ victim.UID ].Mute.rawset( "Duration", duration.tostring() );
			this.UID[ victim.UID ].Mute.rawset( "Time", time().tostring() );

			this.UID2[ victim.UID2 ].Mute = {};

			this.UID2[ victim.UID2 ].Mute.rawset( "Admin", admin );
			this.UID2[ victim.UID2 ].Mute.rawset( "Reason", reason );
			this.UID2[ victim.UID2 ].Mute.rawset( "Duration", duration.tostring() );
			this.UID2[ victim.UID2 ].Mute.rawset( "Time", time().tostring() );*/

			victim.Data.Mute = {};

			victim.Data.Mute.rawset( "Admin", admin );
			victim.Data.Mute.rawset( "Reason", reason );
			victim.Data.Mute.rawset( "Duration", duration.tostring() );
			victim.Data.Mute.rawset( "Time", time().tostring() );
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::AddMute [%s]", e );

	}

	function AddBan( victim, admin, reason, duration )
	{
		try 
		{
		/*	this.UID[ victim.UID ].Ban = {};

			this.UID[ victim.UID ].Ban.rawset( "Admin", admin );
			this.UID[ victim.UID ].Ban.rawset( "Reason", reason );
			this.UID[ victim.UID ].Ban.rawset( "Duration", duration.tostring() );
			this.UID[ victim.UID ].Ban.rawset( "Time", time().tostring() );

			this.UID2[ victim.UID2 ].Ban = {};

			this.UID2[ victim.UID2 ].Ban.rawset( "Admin", admin );
			this.UID2[ victim.UID2 ].Ban.rawset( "Reason", reason );
			this.UID2[ victim.UID2 ].Ban.rawset( "Duration", duration.tostring() );
			this.UID2[ victim.UID2 ].Ban.rawset( "Time", time().tostring() );*/

			victim.Data.Ban = {};

			victim.Data.Ban.rawset( "Admin", admin );
			victim.Data.Ban.rawset( "Reason", reason );
			victim.Data.Ban.rawset( "Duration", duration.tostring() );
			victim.Data.Ban.rawset( "Time", time().tostring() );
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::AddBan [%s]", e );
	}	

	function AddRPGBan( victim, admin, reason, duration )
	{
		try 
		{
		/*	this.UID[ victim.UID ].RPGBan = {};

			this.UID[ victim.UID ].RPGBan.rawset( "Admin", admin );
			this.UID[ victim.UID ].RPGBan.rawset( "Reason", reason );
			this.UID[ victim.UID ].RPGBan.rawset( "Duration", duration.tostring() );
			this.UID[ victim.UID ].RPGBan.rawset( "Time", time().tostring() );

			this.UID2[ victim.UID2 ].RPGBan = {};

			this.UID2[ victim.UID2 ].RPGBan.rawset( "Admin", admin );
			this.UID2[ victim.UID2 ].RPGBan.rawset( "Reason", reason );
			this.UID2[ victim.UID2 ].RPGBan.rawset( "Duration", duration.tostring() );
			this.UID2[ victim.UID2 ].RPGBan.rawset( "Time", time().tostring() );*/

			victim.Data.RPGBan = {};

			victim.Data.RPGBan.rawset( "Admin", admin );
			victim.Data.RPGBan.rawset( "Reason", reason );
			victim.Data.RPGBan.rawset( "Duration", duration.tostring() );
			victim.Data.RPGBan.rawset( "Time", time().tostring() );

		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::AddRPGBan [%s]", e );

	}

	function CheckMute( victim )
	{
		//if( this.UID[ victim.UID ].Mute == null ) return true;
		//if( this.UID2[ victim.UID2 ].Mute == null ) return true;

		if( victim.Data.Mute == null ) return true;
	}

	function CheckRPGBan( victim )
	{
		//if( this.UID[ victim.UID ].RPGBan == null ) return true;
		//if( this.UID2[ victim.UID2 ].RPGBan == null ) return true;

		if( victim.Data.RPGBan == null ) return true;
	}

	function IsTimedMuted( player )
	{
		try
		{
			return player.FindTask( "Mute" );
		}
		catch( _ ) _;
	
		return null;
	}

	function IsTimedRPGBan( player )
	{
		try
		{
			return player.FindTask( "RPGBan" );
		}
		catch( _ ) _;
	
		return null;
	}

	function onPlayerDisconnect( player, reason )
	{
		try 
		{
			this.Save( player.UID, player.UID2 );
		}
		catch( e ) SqLog.Err( "Error on CPlayerUID::onPlayerDisconnect [%s]", e );
	}

	function checkVote( uid1, uid2 )
	{
		if( this.UID[ uid1 ].VoteBase ) return true;
		if( this.UID2[ uid2 ].VoteBase ) return true;
	}

	function SetVote( uid1, uid2, bool )
	{
		this.UID[ uid1 ].VoteBase = bool;
		this.UID2[ uid2 ].VoteBase = bool;
	}

	function ResetVote()
	{
		foreach( index, value in this.UID )
		{
			value.VoteBase = false;
		}

		foreach( index, value in this.UID2 )
		{
			value.VoteBase = false;
		}
	}

	function checkSurVote( uid1, uid2 )
	{
		if( this.UID[ uid1 ].VoteSur ) return true;
		if( this.UID2[ uid2 ].VoteSur ) return true;
	}

	function SetSurVote( uid1, uid2, bool )
	{
		this.UID[ uid1 ].VoteSur = bool;
		this.UID2[ uid2 ].VoteSur = bool;
	}

	function ResetSurVote()
	{
		foreach( index, value in this.UID )
		{
			value.VoteSur = false;
		}

		foreach( index, value in this.UID2 )
		{
			value.VoteSur = false;
		}
	}

	function GetDuration( duration )
	{
		local ban_time = null, duration_type = null;
		
		try 
		{
			switch( duration.len() )
			{
				case 2:
				ban_time = duration.slice(0,1);
				duration_type = duration.slice(1,2);
				break;

				case 3:
				ban_time = duration.slice(0,2);
				duration_type = duration.slice(2,3);
				break;

				case 4:
				ban_time = duration.slice(0,3);
				duration_type = duration.slice(3,4);
				break;
			}
			 
			switch( duration_type )
			{
				case "d":
				ban_time = ban_time.tointeger() * 86400;
				break;

				case "w":
				ban_time = ban_time.tointeger() * 604800;
				break;

				case "y":
				ban_time = ban_time.tointeger() * 31536000;
				break;

				case "m":
				ban_time = ban_time.tointeger() * 60;
				break;

				case "h":
				ban_time = ban_time.tointeger() * 3600;
				break;

			//	default:
			//	return null;
			}
		}
		catch( _ ) _;

		if( typeof ban_time == "integer" ) return ban_time;

		return null;
	}

	function verifyMultiClient( player )
	{
		local result = false;
		
	/*	SqForeach.Player.Active( this, function( plr ) 
        {
			if( player.ID != plr.ID && DisallowMultiClient )
			{
				if( player.UID == plr.UID || plr.UID2 == player.UID2 )
				{
					result = true;
				}
			}
		});*/

		return result;
	}

	function CheckTagIsBanned( player )
	{
		local result = null, tag = "";
		foreach( index, value in this.ClanBan )
		{
			foreach( index1, value1 in value.Tag )
			{
				if( index1 == ::FindClan( player.Data.OldName ) ) 
				{
					result = index;
					tag = index1;
				}
			}
		}

		if( result )
		{
			SqCast.MsgPlr( player, "ClanBanNotice", result );
			SqCast.MsgPlr( player, "ClanBanNotice2", tag );

			player.MakeTask( function()
			{
				player.Kick(); 
			}, 2000, 1 );

			return true;
		}
	}

	function WriteToLog( admin, adminip, target, cmd, reason )
	{
		if( !Handler.Handlers.Script.PrivateMode )
		{
			Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_adminlog ( Date, Admin, AdminIP, Cmd, Target, Reason ) VALUES ( '%d', '%d', '%s', '%s', '%d', '%s' )", ::time(), admin, adminip, cmd, target, Handler.Handlers.Script.Database.EscapeString( reason ) );
		}
	}

	function GetModDur( level, dur )
	{
		if( level == 2 )
		{
			if( this.GetDuration( dur ) <= 86400 ) return true; 
		}
		else return true;
	}

	function GetPlayerStatus( plr )
	{
		if( plr.Data.aduty ) return "Administrating"
		if( plr.Data.InRound( plr ) ) return "Playing";
		if( plr.Away ) return "Away";
		else return "Idling";
	}
}

