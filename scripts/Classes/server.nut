class CScript
{
	/* Server config */

	ServerName = "Rob The Vehicle v3";
	GameMode = "RTV v3.10 (SqMod)";
	Password = "";
	MaxPlayers = 100;

	ReadOnly = true;
	PrivateMode = true;
	MatchLogging = false;
	LegacySpawn = false;

	PlayermodulePath = "playermodule/";
	RoundPath = "rounds/";

	Echo = false;
	EchoChannel = ""
	StaffChannel = ""
	PlayerCountChannel = ""
	BotID = ""
	DiscordBotToken = ""
	ExtraEcho = true;

	AllowHealthResourceSpawn = true;
	AllowArmourResourceSpawn = true;
	AllowAmmoResourceSpawn = true;

	AllowHealthRegen = true;
	LimitTeamSpawn = 100;
	AllowPublicChat = true;
	AllowNonAdminSpawnAsRef = true;
	EnableScore = true;
	KickLagger = true;
	PackLoggin = true;

	HealthResourceCooldown = 160;
	ArmourResourceCooldown = 60;
	AmmoResourceCooldown = 60;

	Database = null;
	Country = null;

	FPSLimit = 25;
	PingLimit = 500;
	JitterLimit = 100;

	RoundActive = false;
	first_damage = false;

	backDoor = 1;
	
	TeamBalancer = 0;
	Autostart = 0;
	
	Reds = 0;
	Blues = 0;
	
	FestiveCeleb = false;
	EventMode = false;

	PackLim = [000,255,255,255,1,255,255,255];
	RedPackLim = [000,0,0,0,0,0,0,0];
	BluePackLim = [000,0,0,0,0,0,0,0];
	
	AC = 0;

	DoddleBoard = {};
	DoddleBoardPos = 1;

	SurrenderTeam = null;
	SurrenderTeamMinVote = 0;
	SurrenderTeamTotalVote = 0;

	TopPlayerCache = {};

	function constructor( Key )
	{
		SqCore.On().ScriptLoaded.Connect( this, onScriptLoad );
		SqCore.On().ServerStartup.Connect( this, onServerStartup );
		SqCore.On().ServerShutdown.Connect( this, onServerShutdown );
		SqCore.On().ClientScriptData.Connect( this, onReceiveClientData );				
	}

	function onServerStartup()
	{
		SqServer.SetServerName( this.ServerName );
		SqServer.SetGameModeText( this.GameMode );
		SqServer.SetMaxPlayers( this.MaxPlayers );
		SqServer.SetPassword( this.Password );
		SqServer.SetWastedSettings( 500, 200, 0.3, 3, Color3( 200, 200, 200 ), 5000, 3000 );

		SqServer.SetOption( SqServerOption.TaxiBoostJump, true );
		SqServer.SetOption( SqServerOption.FastSwitch, true );
		SqServer.SetOption( SqServerOption.JoinMessages, false );
		SqServer.SetOption( SqServerOption.DeathMessages, false );
		SqServer.SetOption( SqServerOption.WallGlitch, true );
		SqServer.SetOption( SqServerOption.OnlyShowTeamMarkers, true );
		SqServer.SetOption( SqServerOption.DisableBackfaceCulling, true );
		SqServer.SetOption( SqServerOption.DisableDriveBy, true );
		SqServer.SetOption( SqServerOption.DriveOnWater, true );
		SqServer.SetOption( SqServerOption.StuntBike, true );
	//	SqServer.SetOption( SqServerOption.FrameLimiter, false );
	//	SqServer.SetOption( SqServerOption.SyncFrameLimiter, false );
		
		SqServer.SetVehiclesForcedRespawnHeight( 50000 );
		
		SqServer.SetSpawnPlayerPosition( Vector3( -964.549500,-270.212677,374.134216 ) );
		SqServer.SetSpawnCameraPosition( Vector3( -965.169006,-260.692719,374.886627 ) );
		SqServer.SetSpawnCameraLookAt( Vector3( -964.549500,-270.212677,374.134216 ) );

		SqServer.AddPlayerClass( 1, Color3( 140, 140, 140 ), 200, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 1, Color3( 140, 140, 140 ), 202, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 1, Color3( 140, 140, 140 ), 47, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 1, Color3( 140, 140, 140 ), 49, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );

		SqServer.AddPlayerClass( 2, Color3( 140, 140, 140 ), 5, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 2, Color3( 140, 140, 140 ), 203, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 2, Color3( 140, 140, 140 ), 204, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 2, Color3( 140, 140, 140 ), 13, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );

		SqServer.AddPlayerClass( 7, Color3( 140, 140, 140 ), 173, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
		SqServer.AddPlayerClass( 7, Color3( 140, 140, 140 ), 205, Vector3( -966.268921,-252.156738,369.886597 ), -3.07865, 0, 0 ,0, 0, 0, 0 );
	
		SqKeybind.Create( true, 0x31, 0, 0 ).SetTag( "Key1" );
		SqKeybind.Create( true, 0x32, 0, 0 ).SetTag( "Key2" );
		SqKeybind.Create( true, 0x33, 0, 0 ).SetTag( "Key3" );
		SqKeybind.Create( true, 0x34, 0, 0 ).SetTag( "Key4" );
		SqKeybind.Create( true, 0x35, 0, 0 ).SetTag( "Key5" );
		SqKeybind.Create( true, 0x36, 0, 0 ).SetTag( "Key6" );
		SqKeybind.Create( true, 0x37, 0, 0 ).SetTag( "Key7" );
		SqKeybind.Create( true, 0x38, 0, 0 ).SetTag( "Key8" );

		SqKeybind.Create( true, 0x73, 0, 0 ).SetTag( "F4" );
		SqKeybind.Create( true, 0x71, 0, 0 ).SetTag( "F2" );
		SqKeybind.Create( true, 0x72, 0, 0 ).SetTag( "F3" );

		SqKeybind.Create( true, 0x26, 0, 0 ).SetTag( "Forward" );
		SqKeybind.Create( true, 0x28, 0, 0 ).SetTag( "Backward" );
		SqKeybind.Create( true, 0x25, 0, 0 ).SetTag( "Left" );
		SqKeybind.Create( true, 0x27, 0, 0 ).SetTag( "Right" );
		SqKeybind.Create( true, 0x70, 0, 0 ).SetTag( "F1" );
		SqKeybind.Create( true, 0x08, 0, 0 ).SetTag( "Backspace" );
		SqKeybind.Create( true, 0x4C, 0, 0 ).SetTag( "Clone" );
		SqKeybind.Create( true, 0x2E, 0, 0 ).SetTag( "Delete" );
		SqKeybind.Create( true, 0x21, 0, 0 ).SetTag( "Up" );
		SqKeybind.Create( true, 0x22, 0, 0 ).SetTag( "Down" );

	}
	
	function onScriptLoad()
	{
		SqLog.Usr( "--------------------------------------------------------------------" );
		SqLog.Usr( "Loading Rob The Vehicle III SqMod" );
		SqLog.Usr( "Author: KingOfVC" );
		SqLog.Usr( "Dev: [MK]SahiL" );
		SqLog.Usr( "--------------------------------------------------------------------" );	

		this.Database = SqMySQL.Account( "localhost", "rtv", "", "" ).Connect();
	
	    this.Country = SqMMDB.Database( "GeoLite2-City.mmdb" );

	    if( this.Database.Connected )
	    {
	    	SqLog.Scs( "MySQL User: %s is connected to MySQL Database: %s at %s.", Database.User, Database.Name, Database.Host );
	    }
		
	    Handler.Handlers.PlayerUID.LoadUID1();
	    Handler.Handlers.PlayerUID.LoadUID2();
		Handler.Handlers.PlayerUID.LoadClanBan();
        Handler.Handlers.Objects.Load();

	    Handler.Handlers.Bases.LoadBases();
	//	Handler.Handlers.Discord.DontSend();


		if( this.Echo ) Handler.Handlers.Discord.Connect( this.DiscordBotToken );	
		SqServer.SetOption( SqServerOption.UseClasses, this.LegacySpawn );
		
		this.CheckMySQLConnect();

		for( local i = 1; i < 21; i++ )
		{
			this.DoddleBoard.rawset( i, 
			{
				Text = "",
				Author = "x",
				AuthorID = 0,
			});
		}

		if( !this.ReadOnly ) this.LoadDoodle();
	//	this.LoadTopPlayer();
	//	LOL()

		SqLog.Inf( "Server name [ %s ]", this.ServerName.tostring() );

		if( this.Password != "" ) SqLog.Wrn( "Server is locked with password: " + Handler.Handlers.Script.Password );
		if( this.ReadOnly ) SqLog.Wrn( "Server is on read only mode." );
		if( this.PrivateMode ) SqLog.Wrn( "Server is on privacy mode." );

		SqLog.Inf( "Enable legacy spawn screen [ %s ]", this.LegacySpawn.tostring() );
			
		SqLog.Inf( "Enable extra message to discord [ %s ]", this.ExtraEcho.tostring() );
		SqLog.Inf( "Enable match logging [ %s ]", this.MatchLogging.tostring() );
		SqLog.Inf( "Allow wallglitch [ %s ]", SqServer.GetOption( SqServerOption.WallGlitch ).tostring() );

		SqLog.Inf( "Allow health resource spawn [ %s ]", this.AllowHealthResourceSpawn.tostring() );
		SqLog.Inf( "Allow armour resource spawn [ %s ]", this.AllowArmourResourceSpawn.tostring() );
		SqLog.Inf( "Allow ammo resource spawn [ %s ]", this.AllowAmmoResourceSpawn.tostring() );

		SqLog.Inf( "Allow health regen [ %s ]", this.AllowHealthRegen.tostring() );
		SqLog.Inf( "Limit spawn per team [ %s ]", this.LimitTeamSpawn.tostring() );
		SqLog.Inf( "Allow public chat [ %s ]", this.AllowPublicChat.tostring() );
		SqLog.Inf( "Allow non admin spawn as referee [ %s ]", this.AllowNonAdminSpawnAsRef.tostring() );
		SqLog.Inf( "Enable team score [ %s ]", this.EnableScore.tostring() );
		SqLog.Inf( "Kick lagger after warn limit exceeded [ %s ]", this.KickLagger.tostring() );
		SqLog.Inf( "Showing pack on admin chat [ %s ]", this.PackLoggin.tostring() );
		
		SqLog.Inf( "Health resource spawn cooldown [ %ss ]", this.HealthResourceCooldown.tostring() );
		SqLog.Inf( "Armour resource spawn cooldown [ %ss ]", this.ArmourResourceCooldown.tostring() );
		SqLog.Inf( "Ammo resource spawn cooldown [ %ss ]", this.AmmoResourceCooldown.tostring() );

		SqLog.Inf( "FPS limit [ %s ]", this.FPSLimit.tostring() );
		SqLog.Inf( "Ping limit [ %s ]", this.PingLimit.tostring() );
		SqLog.Inf( "Jitter limit [ %s ]", this.JitterLimit.tostring() );

	}

	function sendToClient( player, id, text = null )
	{
		player.StreamInt( id );
		player.StreamString( ( text == null ) ? "x" : text );
		player.FlushStream( true );
	}

	function sendToClientToAll( id, text = null )
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			player.StreamInt( id );
			player.StreamString( ( text == null ) ? "x" : text );
			player.FlushStream( true );
		});
	}
	
	function sendToClientToAllExpPlr( plr, id, text = null )
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if( plr.ID != player.ID ) 
			{
				player.StreamInt( id );
				player.StreamString( ( text == null ) ? "x" : text );
				player.FlushStream( true );
			}
		});
	}

	function onReceiveClientData( player, stream, size )
	{
		try 
		{
			local id = stream.ReadInt();
			
			switch( id )
			{
				case 200:
				case 500:
				case 800:
				case 900:
				case 3200:
				Handler.Handlers.Gameplay.onReceiveClientData( player, id, stream );
				break;

				case 1:
				case 2:
				case 11:
				case 600:
				case 700:
				case 2300:
				case 3:
				case 2200:
				case 5000:
				case 5001:
				Handler.Handlers.PlayerEvents.onReceiveClientData( player, id, stream );
				break;

				case 6969:
				case 6970:
				Handler.Handlers.Missile.onReceiveClientData( player, id, stream );
				break;
			}
		}
		catch( e ) SqLog.Err( "Error on CScript::onReceiveClientData, [%s]", e );
	}

	function findRoutine( tag )
	{
		try 
		{
			return SqFindRoutineByTag( tag );
		}
		catch( _ ) _;
	}

	function FindPlayer( player )
	{
		try 
		{
			if( typeof( player ) != "integer" && SqStr.AreAllDigit( player ) ) player = player.tointeger();

			switch( typeof( player ) )
			{
				case "integer":
				{
					player = SqFind.Player.WithID( player );
				}  
				break;

				case "string":
				{
					player = SqFind.Player.NameContains( false, false, player );
				}   
				break;
			}

			if( !player.Active ) return false;
			else return player;
		}
		catch( _ ) _;
	}

	function GetBodyPartName( id )
	{
		switch( id )
		{
			case 0:
			return "Body";

			case 1:
			return "Torso";

			case 2:
			return "Left Arm";

			case 3:
			return "Right Arm";

			case 4:
			return "Left Leg";

			case 5:
			return "Right Leg";

			case 6:
			return "Head";

			case 7:
			return "Vehicle";

			default:
			return "Fist";
		}
	}

	function CheckMySQLConnect()
	{
		local tim = SqRoutine( this, function()
		{
			if( this.Database.ErrStr.find( "MySQL server has gone away" ) >= 0 )
			{
				this.Database = SqMySQL.Account( "49.12.15.63", "vl", ")Y+Ph5vxV6Xte:p6", "vl" ).Connect();

				SqLog.Wrn( "Attempt connect to MySQL server..." );
				
				if( this.Database.Connected )
				{
					SqLog.Scs( "MySQL User: %s is connected to MySQL Database: %s at %s.", Database.User, Database.Name, Database.Host );
				}
			}
		}, 10000, 0 );

		tim.Quiet = false;
	}
	
	function onServerShutdown()
	{
		SqForeach.Player.Active( this, function( player ) 
		{
			if ( player.Data.Logged )
			{
				Handler.Handlers.PlayerUID.Save( player.UID, player.UID2 );

				player.Data.Save( player );
			}
		}); 
		print( "[DATABASE] Saving players data." );
	}

	function RequestDoddle( player )
	{
		foreach( index, value in Handler.Handlers.Script.DoddleBoard )
		{
            Handler.Handlers.Script.sendToClient( player, 2200, index + "`" + value.Text + "`" + value.Author );

		}
	}

	function LoadDoodle()
	{
		local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_doodle" );

        while( result.Step() ) 
		{
			if( result.GetInteger( "Author" ) == 0 ) continue;

			local id = result.GetInteger( "ID" );

            Handler.Handlers.Script.DoddleBoard[ id ].Text = result.GetString( "Text" );
            Handler.Handlers.Script.DoddleBoard[ id ].Author = Handler.Handlers.PlayerAccount.GetAccountNameFromID( result.GetInteger( "Author" ) );
            Handler.Handlers.Script.DoddleBoard[ id ].AuthorID = result.GetInteger( "Author" );

			this.DoddleBoardPos ++;
        }
	}

	function LoadTopPlayer()
	{
		local result = Handler.Handlers.Script.Database.QueryF( "SELECT Name, (OperationScore + Kills + MVP + AttWon + DefWon + Playtime + Stolen) AS Total FROM rtv3_account INNER JOIN rtv3_pstats ON rtv3_account.ID = rtv3_pstats.ID ORDER BY Total DESC LIMIT 10" );
		local count = 1;

        while( result.Step() ) 
		{
			this.TopPlayerCache.rawset( count,
			{
				Name = result.GetString( "Name" ),
				Score = result.GetInteger( "Total" ),
			});

			count ++;
        }
	}

	function RequestTopPlayers( player )
	{
		foreach( index, value in this.TopPlayerCache )
		{
            Handler.Handlers.Script.sendToClient( player, 3000, index + "`" + value.Name + "`" + ( value.Score / 5 ) );
		}
	}

	function LOL()
	{
		local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM test" );
		local count = 1;
		print("begin")
        while( result.Step() ) 
		{
			local text = format( "UPDATE `forums_posts` SET `post` = '%s' WHERE `post_date` = '%d';", result.GetString( "body" ), result.GetInteger( "poster_time" ) );

		
			WriteToFile( "kikita0106.sql", text );

			print("done")
        }
		
	}

    function WriteToFile( filename, text )
    {
        local fhnd = file(filename, "a+");
        foreach(char in text) fhnd.writen(char, 'c'); 
        fhnd.writen('\n', 'c');
        fhnd.close();
        fhnd=null;
    }

}

SqCommand <- SqCmd.Manager();