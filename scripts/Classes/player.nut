class CPlayer
{
	player 			= 	null;
	Registered 	= 	false;
	Logged 			= 	false;
	IsActivated = 1;

	ID 					= 	-1;
	Name 				= 	null;
	OriginIP 			= 	null;
	Password 			= 	null;
	AutoLog			=	false;
	DateRegistered 	= null;
	LastActive			=	null;
	IP 					= "0.0.0.0";

	Stats 			= 	null;
	CurrentStats 	= null;

	TimeJoined	=	1;
	AdminLevel 	= 	0;
	ReadNews 	= 	false;

	Ban 			= 	null;
	Mute 		= 	null;
	RPGBan 	= 	null;
	Warns = 0;

	Language 	= 	"English";

	resultCache 	= 	null;
	voteBase 		= 	null;
	setCount 		= 	0;
	wepSet 		= 	1;
	Assist 			= 	null;
	Round 			= false;
	AssignedTeam = 0;

	SMGSlot1 	= 	0;
	SMGSlot2 	=  0;

	OldName 	=   null;

	FPSWarning 	= 0;
	PingWarning = 0;
	
	Jingles 	= 1;
	Sounds  = 1;
	AutoRespawn = 0;
	SpawnBan = 0;
	SpectateTarget = null;
	
	Freeze = false;
	
	aduty = 0;
	Stealth = 0;
	Mapper = 0;
	
	RobberCoins = 0;

	OldTeam = 0;
	
	Operation = null;
	OperationScore = 0;
	OperationDailyReward = 0;
	OperationVehColor1 = 0;
	OperationVehColor2 = 0;

	ChatType = "old";
	TeamESP = true;

	WinStreak = 0;
	FragileMission = 0;

	MVPSound = 50043;

	NoMVP = false;

	RadioCD = 0;
	
	IsParticipate = false;

	LastPing = null;
	LastFPS = null;

	GetHit = 0;

	MinPing = 1000000;
	MaxPing = 0;
	MinFPS = 1000;
	MaxFPS = 0;

	AllTimeMinPing = 10000000;
	AllTimeMaxPing = -1;
	AllTimeMaxFPS = -1;
	AllTimeMinFPS = 10000000;

	ShowCountry = true;
	ShowStats = true;
	AllowPM = true;

	AFKCount = 0;
	AFKPos = Vector3( 0,0,0 );

	Resolution = "";

	HealthPCooldown = 0;
	ArmourPCooldown = 0;
	AmmoPCooldown = 0;

	Ignore = null;

    Jticks = 0;
    Lticks = 0;

	CumCD = 0;
	DoodleCD = 0;

	WasInRound = false;

	PublicChat = true;
	ShowTaunt = true;
	TauntText = "no";
	Comments = "no";

	IsEditing = "";
	EditingMode = "XYZ";
	EditSens = 0.5

	function constructor( player )
	{
		player.Authority = 0;

		this.Stats =
		{
			Kills 	= 0,
			Deaths 	= 0,
			Assist = 0,
			Stealed = 0,
			TopSpree = 0,
			AttWon = 0,
			DefWon = 0,
			MVP = 0,
			XP = 0,
			XPLevel = 0,
			Playtime = 0,
			RoundPlayed = 0,
		}

		this.CurrentStats =
		{
			RoundKills = 0,
			RoundDeaths = 0,
			RoundAssist = 0,
			RoundSpree = 0,
			Playtime = 0,
			Score = 0,
		}

		this.Assist =
		{
			HitBy = null,
			HitTime = 0,
		}


		this.OldName = player.Name;
		player.Name = "RTV-" + player.ID;

	//	this.Operation = {};

	//	this.OperationInit();

		this.LastPing = [];
		this.LastFPS = [];
		
		this.Ignore = {};
	}

	function LoadAccount( player, res = "0x0" )
	{
		try 
		{
			local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_account INNER JOIN rtv3_pstats ON rtv3_account.ID = rtv3_pstats.ID WHERE Name LIKE '%s';", this.OldName );

			this.Resolution = res;

			if( result.Step() )
			{
				this.ID = result.GetInteger( "ID" );
				this.OriginIP = result.GetString( "OriginIP" );
				this.DateRegistered = result.GetInteger( "DateReg" );
				this.Password = result.GetString( "Password" );
				this.TimeJoined = result.GetInteger( "Joins" );
				this.Registered = true;
				this.resultCache = result;
				this.IP = player.IP;

				if( ( player.UID == result.GetString( "UID" ) ) && ( player.UID2 == result.GetString( "UID2" ) ) && ( this.IP == result.GetString( "IP" ) ) )
				{
					if( !this.verifyBan( player, result ) )
					{
						player.Name = this.OldName;

						this.checkMute( player, result );
						this.checkRPGBan( player, result );

						this.Logged = true;
						this.TimeJoined ++;
						this.LastActive = time();
						this.CurrentStats.Playtime = time();
						this.resultCache = null;

						this.Stats.Kills = result.GetInteger( "Kills" );
						this.Stats.Deaths = result.GetInteger( "Deaths" );
						this.Stats.Assist = result.GetInteger( "Assist" );
						this.Stats.Stealed = result.GetInteger( "Stolen" );
						this.Stats.TopSpree = result.GetInteger( "TopSpree" );
						this.Stats.AttWon = result.GetInteger( "AttWon" );
						this.Stats.DefWon = result.GetInteger( "DefWon" );
						this.Stats.MVP = result.GetInteger( "MVP" );
						this.Stats.RoundPlayed = result.GetInteger( "RoundPlayed" );
						this.Stats.XP = result.GetInteger( "XP" );
						this.Stats.XPLevel = result.GetInteger( "Level" );
						this.Stats.Playtime = result.GetInteger( "Playtime" );
						player.Authority = result.GetInteger( "AdminLevel" );
						this.Mapper = result.GetInteger( "Mapper" );
						this.ReadNews = SToB( result.GetString( "ReadNews" ) );
						this.Sounds = result.GetInteger( "Sounds" );
						this.Jingles = result.GetInteger( "Jingles" );
						this.AutoRespawn = result.GetInteger( "AutoRespawn" );
						this.SpawnBan = result.GetInteger( "SpawnBan" );
						this.RobberCoins = result.GetInteger( "RobberCoins" );
						this.IsActivated = result.GetInteger( "IsActivated" );
						this.Stealth = result.GetInteger( "Stealth" );
					//	this.Operation = 
						this.OperationVehColor1 = result.GetInteger( "Carcol1" );
						this.OperationVehColor2 = result.GetInteger( "Carcol2" );
						this.ChatType = result.GetString( "ChatMode" );
						this.TeamESP = SToB( result.GetString( "TeamESP" ) );
						this.MVPSound = result.GetInteger( "MVPSound" );
						this.NoMVP = SToB( result.GetString( "NoMVP" ) );
						this.ShowCountry = SToB( result.GetString( "ShowCountry" ) );
						this.ShowStats = SToB( result.GetString( "ShowStats" ) );
						this.AllowPM = SToB( result.GetString( "AllowPM" ) );
						this.AllTimeMinPing = result.GetInteger( "LowestAveragePing" );
						this.AllTimeMaxPing = result.GetInteger( "HighestAveragePing" );
						this.AllTimeMaxFPS = result.GetInteger( "HighestAverageFPS" );
						this.AllTimeMinFPS = result.GetInteger( "LowestAverageFPS" );
						this.Ignore = ( ::json_decode( result.GetString( "Ignore" ) ) == null ) ? {} : ::json_decode( result.GetString( "Ignore" ) );
						this.PublicChat = SToB( result.GetString( "PublicChat" ) );
						this.ShowTaunt = SToB( result.GetString( "ShowTaunt" ) );
						this.TauntText = result.GetString( "Taunt" );
						this.Comments = result.GetString( "Comments" );

						if ( player.Authority == 0 ) player.Authority = 1;

						if( this.ChatType == "new" ) player.Message( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" );

						Handler.Handlers.PlayerUID.AddAlias( player );

						Handler.Handlers.Script.sendToClient( player, 2504, this.TeamESP );

						if( this.ShowCountry )
						{
							SqCast.MsgAllExp( player, "AccJoined", SqCast.GetPlayerColor( player.Name ), GeoIP.GetDIsplayInfo( player.IP ) );
							Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server from **%s**.", player.Name, GeoIP.GetDIsplayInfo( player.IP ) );
						}
						else 
						{
							SqCast.MsgAllExp( player, "AccJoined2", SqCast.GetPlayerColor( player.Name ) );
							SqCast.MsgAllAdmin( "AccJoined4", SqCast.GetPlayerColor( player.Name ), GeoIP.GetDIsplayInfo( player.IP ) );
							Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server.", player.Name );
						}
						
						SqCast.MsgPlr( player, "AccAutoLogged" );
						playsound( player, 50028 ), SqCast.sendAlert( player, "CmdError", "Welcome to Rob The Vehicle!" );

						if( this.Comments != "no" ) SqCast.MsgAllAdmin( "ShowComments", SqCast.GetPlayerColor( player.Name ), this.Comments );

						if( !Handler.Handlers.Script.ReadOnly ) Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET IsOnline = '1' WHERE ID = '%d';", this.ID );
						if( Handler.Handlers.Script.ReadOnly ) SqCast.MsgPlr( player, "ReadOnlyAlert" );
						
						if( Handler.Handlers.Script.LegacySpawn )
						{
							local teamid = "Defender";
							if( player.Team != Handler.Handlers.Gameplay.Defender ) teamid = "Attacker";
							if( player.Team == 7 ) teamid = "Spectator";

							if ( Handler.Handlers.Gameplay.Status > 2 ) Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( player.Team ) );
							else Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );
						
							if( !this.ReadNews ) Handler.Handlers.Script.sendToClient( player, 2300 );
						}

						else 
						{
							player.CameraPosition( Vector3( -482.285583,620.814087,12.381873+10 ),Vector3( -569.277649,670.066895,10.910061 ) );

							if( this.ReadNews )
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
							else Handler.Handlers.Script.sendToClient( player, 2300 );
						}

						player.MakeTask( function() {
							local totalp = 0, totalf = 0, calavgp = 0, calavgf = 0;

							player.Data.LastPing.push( player.Ping );
							player.Data.LastFPS.push( player.FPS );

							if( player.Ping > player.Data.MaxPing ) player.Data.MaxPing = player.Ping;
							if( player.Ping < player.Data.MinPing ) player.Data.MinPing = player.Ping;

							if( player.FPS > player.Data.MaxFPS ) player.Data.MaxFPS = player.FPS;
							if( player.FPS < player.Data.MinFPS ) player.Data.MinFPS = player.FPS;

							foreach( index, value in player.Data.LastPing ) { totalp += value; };
							foreach( index, value in player.Data.LastFPS ) { totalf += value; };

							calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
            				calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );

							if( calavgp > player.Data.AllTimeMaxPing ) player.Data.AllTimeMaxPing = calavgp;
							if( calavgp < player.Data.AllTimeMinPing ) player.Data.AllTimeMinPing = calavgp;

							if( calavgf > player.Data.AllTimeMaxFPS ) player.Data.AllTimeMaxFPS = calavgf;
							if( calavgf < player.Data.AllTimeMinFPS ) player.Data.AllTimeMinFPS = calavgf;
						}, 500, 0 );

						player.GetModuleList();


						if( Handler.Handlers.Script.ReadOnly )
						{
							if( Handler.Handlers.PlayerAccount.PlayerTempAccount.rawin( player.Data.ID ) )
							{
								local getdata = Handler.Handlers.PlayerAccount.PlayerTempAccount.rawget( player.Data.ID );

								this.Stats.Kills = getdata.Kills;
								this.Stats.Deaths = getdata.Deaths;
								this.Stats.Stealed = getdata.Stolen;
								this.Stats.AttWon = getdata.AttWon;
								this.Stats.DefWon = getdata.DefWon;
								this.Stats.MVP = getdata.MVP;
								this.Stats.TopSpree = getdata.TopSpree;
								this.Stats.Playtime = getdata.Playtime;
								this.Stats.RoundPlayed = getdata.RoundPlayed;
								this.OperationVehColor1 = getdata.Carcol1;
								this.OperationVehColor2 = getdata.Calrol2;
								this.AllTimeMinPing = getdata.LowestAveragePing;
								this.AllTimeMaxPing = getdata.HighestAveragePing;
								this.AllTimeMaxFPS = getdata.LowestAverageFPS;
								this.AllTimeMinFPS = getdata.LowestAverageFPS;
								
								player.Authority = getdata.Level;
								this.NoMVP = getdata.NoMVP;
								this.MVPSound = getdata.MVPSound;
							}

							else 
							{
								this.Stats.Kills = 0;
								this.Stats.Deaths = 0;
								this.Stats.Stealed = 0;
								this.Stats.AttWon = 0;
								this.Stats.DefWon = 0;
								this.Stats.MVP = 0;
								this.Stats.TopSpree = 0;
								this.Stats.Playtime = 0;
								this.Stats.RoundPlayed = 0;
							}
						}
					}
				}
				else SqCast.MsgPlr( player, "LoginAlert" );
			}
			else Handler.Handlers.Script.sendToClient( player, 700 );
		}
		/*catch( e )
		{
			SqCast.MsgPlr( player, "AccError" );

			player.Kick();
		}*/

		catch( e ) SqLog.Err( "Error on CPlayer::Join [%s]", e );
	}

	function Save( player )
	{
		try 
		{
			if( this.Registered && this.Logged )
			{
				if( !Handler.Handlers.Script.ReadOnly )
				{
					local getTime = ( time() - this.CurrentStats.Playtime );
					local getTotalTime = ( this.Stats.Playtime + getTime );
					local ip = this.IP;
					local totalp = 0, totalf = 0, calavgp = 0, calavgf = 0;

					foreach( index, value in this.LastPing ) { totalp += value; };
					foreach( index, value in this.LastFPS ) { totalf += value; };

					calavgp = ( totalp/IsZero( this.LastPing.len() ) );
					calavgf = ( totalf/IsZero( this.LastFPS.len() ) );

					if( calavgp > this.AllTimeMaxPing ) this.AllTimeMaxPing = calavgp;
					if( calavgp < this.AllTimeMinPing ) this.AllTimeMinPing = calavgp;

					if( calavgf > this.AllTimeMaxFPS ) this.AllTimeMaxFPS = calavgf;
					if( calavgf < this.AllTimeMinFPS ) this.AllTimeMinFPS = calavgf;

					Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Joins = '%d', UID= '%s', UID2= '%s', IP = '%s', AdminLevel= '%d', Password = '%s', RPGBan = '%s', Mute = '%s', Ban = '%s', DateLog = '%d', RobberCoins = '%d', IsActivated = '%d', Stealth = '%d', AutoRespawn = '%d', Sounds = '%d', IsOnline = '0', ChatMode = '%s', TeamESP = '%s', Mapper = '%d', MVPSound = '%d', NoMVP = '%s', ShowCountry = '%s', ShowStats = '%s', AllowPM = '%s', PublicChat = '%s', ShowTaunt = '%s', Taunt = '%s', Comments = '%s' WHERE ID = '%d';", this.TimeJoined.tointeger(), player.UID, player.UID2, ip, player.Authority, this.Password, ::json_encode( this.RPGBan ), ::json_encode( this.Mute ), ::json_encode( this.Ban ), this.LastActive, this.RobberCoins, this.IsActivated, this.Stealth, this.AutoRespawn, this.Sounds, this.ChatType, this.TeamESP.tostring(), this.Mapper, this.MVPSound, this.NoMVP.tostring(), this.ShowCountry.tostring(), this.ShowStats.tostring(), this.AllowPM.tostring()/*, ::json_encode( this.Ignore )*/, this.PublicChat.tostring(), this.ShowTaunt.tostring(), Handler.Handlers.Script.Database.EscapeString( this.TauntText ), Handler.Handlers.Script.Database.EscapeString( this.Comments ), this.ID );
					Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_pstats SET Kills = '%d', Deaths = '%d', Stolen = '%d', AttWon = '%d', DefWon = '%d', MVP = '%d', TopSpree = '%d', XP = '%d', Level = '%d', Playtime = '%d', ReadNews = '%s', Assist = '%d', RoundPlayed = '%d', Carcol1 = '%d', Carcol2 = '%d', LowestAveragePing = '%d', HighestAveragePing = '%d', HighestAverageFPS = '%d', LowestAverageFPS = '%d', LastFPS = '%d', LastPing = '%d', LastRes = '%s' WHERE ID = '%d';", this.Stats.Kills, this.Stats.Deaths, this.Stats.Stealed, this.Stats.AttWon, this.Stats.DefWon, this.Stats.MVP, this.Stats.TopSpree, this.Stats.XP, this.Stats.XPLevel, getTotalTime, this.ReadNews.tostring(), this.Stats.Assist, this.Stats.RoundPlayed, this.OperationVehColor1, this.OperationVehColor2, this.AllTimeMinPing, this.AllTimeMaxPing, this.AllTimeMaxFPS, this.AllTimeMinFPS, calavgf, calavgp, this.Resolution.tostring(), this.ID );				
				}

				else 
				{
					local getTime = ( time() - this.CurrentStats.Playtime );
					local getTotalTime = ( this.Stats.Playtime + getTime );

					if( Handler.Handlers.PlayerAccount.PlayerTempAccount.rawin( player.Data.ID ) )
					{
						local getdata = Handler.Handlers.PlayerAccount.PlayerTempAccount.rawget( player.Data.ID );

						getdata.Kills = this.Stats.Kills;
						getdata.Deaths = this.Stats.Deaths;
						getdata.Stolen = this.Stats.Stealed;
						getdata.AttWon = this.Stats.AttWon;
						getdata.DefWon = this.Stats.DefWon;
						getdata.MVP = this.Stats.MVP;
						getdata.TopSpree = this.Stats.TopSpree;
						getdata.Playtime = getTotalTime;
						getdata.RoundPlayed = this.Stats.RoundPlayed;
						getdata.Carcol1 = this.OperationVehColor1;
						getdata.Calrol2 = this.OperationVehColor2;
						getdata.LowestAveragePing = this.AllTimeMinPing;
						getdata.HighestAveragePing = this.AllTimeMaxPing;
						getdata.LowestAverageFPS = this.AllTimeMaxFPS;
						getdata.LowestAverageFPS = this.AllTimeMinFPS;
					
						getdata.Level = player.Authority;
						getdata.NoMVP = this.NoMVP;
						getdata.MVPSound = this.MVPSound;
					}

					else 
					{
						Handler.Handlers.PlayerAccount.PlayerTempAccount.rawset( player.Data.ID, 
						{
							Kills = this.Stats.Kills,
							Deaths = this.Stats.Deaths,
							Stolen = this.Stats.Stealed,
							AttWon = this.Stats.AttWon,
							DefWon = this.Stats.DefWon,
							MVP = this.Stats.MVP,
							TopSpree = this.Stats.TopSpree,
							Playtime = getTotalTime,
							RoundPlayed = this.Stats.RoundPlayed,
							Carcol1 = this.OperationVehColor1,
							Calrol2 = this.OperationVehColor2,
							LowestAveragePing = this.AllTimeMinPing,
							HighestAveragePing = this.AllTimeMaxPing,
							LowestAverageFPS = this.AllTimeMaxFPS,
							LowestAverageFPS = this.AllTimeMinFPS,
							Level = player.Authority,
							NoMVP = this.NoMVP,
							MVPSound = this.MVPSound,
						})
					}
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayer::Save [%s]", e );
	}

	function Register( player, password )
	{
		try 
		{
			player.Name = this.OldName;

			this.OriginIP = player.IP;
			this.DateRegistered = time();
			this.Password = SqHash.GetSHA256( password );
			this.Registered = true;
			this.Logged = true;
			this.LastActive = time();
			this.CurrentStats.Playtime = time();		
			player.Authority = 1;

			this.ID = Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_account ( Name, Password, OriginIP, IP, UID, UID2, DateReg, DateLog ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s', '%d', '%d' )", player.Name, this.Password, this.OriginIP, this.OriginIP, player.UID, player.UID2, this.DateRegistered, this.LastActive ).tointeger();
			Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_pstats ( ID ) VALUES ( '%d' )", this.ID );

			Handler.Handlers.PlayerUID.AddAlias( player );
			
			SqCast.MsgAll( "AccJoined1",  SqCast.GetPlayerColor( player.Name ), GeoIP.GetDIsplayInfo( player.IP ) );
			
			SqCast.MsgPlr( player, "RegScs" );
			playsound( player, 50028 ), SqCast.sendAlert( player, "CmdError", "Welcome to Rob The Vehicles!" );
			
			Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server for the first time from **%s**.", player.Name, GeoIP.GetDIsplayInfo( player.IP ) );

			/* send news feed (newly registed) to player */

			local teamid = "Defender";
			if( player.Team != Handler.Handlers.Gameplay.Defender ) teamid = "Attacker";
			if( player.Team == 7 ) teamid = "Spectator";

			Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );

		}
		catch( e ) SqLog.Err( "Error on CPlayer::Register [%s]", e );
	}

	function Login( player )
	{
		try 
		{
			local result = this.resultCache;

			if( !this.verifyBan( player, result ) )
			{
				player.Name = this.OldName;
				
				this.checkMute( player, result );
				this.checkRPGBan( player, result );

				this.Logged = true;
				this.TimeJoined ++;
				this.LastActive = time();
				this.CurrentStats.Playtime = time();

				this.Stats.Kills = result.GetInteger( "Kills" );
				this.Stats.Deaths = result.GetInteger( "Deaths" );
				this.Stats.Assist = result.GetInteger( "Assist" );
				this.Stats.Stealed = result.GetInteger( "Stolen" );
				this.Stats.TopSpree = result.GetInteger( "TopSpree" );
				this.Stats.AttWon = result.GetInteger( "AttWon" );
				this.Stats.DefWon = result.GetInteger( "DefWon" );
				this.Stats.MVP = result.GetInteger( "MVP" );
				this.Stats.RoundPlayed = result.GetInteger( "RoundPlayed" );
				this.Stats.XP = result.GetInteger( "XP" );
				this.Stats.XPLevel = result.GetInteger( "Level" );
				this.Stats.Playtime = result.GetInteger( "Playtime" );
				player.Authority = result.GetInteger( "AdminLevel" );
				this.Mapper = result.GetInteger( "Mapper" );				
				this.ReadNews = SToB( result.GetString( "ReadNews" ) );
				this.Sounds = result.GetInteger( "Sounds" );
				this.Jingles = result.GetInteger( "Jingles" );
				this.AutoRespawn = result.GetInteger( "AutoRespawn" );
				this.SpawnBan = result.GetInteger( "SpawnBan" );
				this.RobberCoins = result.GetInteger( "RobberCoins" );
				this.IsActivated = result.GetInteger( "IsActivated" );
				this.Stealth = result.GetInteger( "Stealth" );
				this.OperationVehColor1 = result.GetInteger( "Carcol1" );
				this.OperationVehColor2 = result.GetInteger( "Carcol2" );
				this.ChatType = result.GetString( "ChatMode" );
				this.TeamESP = SToB( result.GetString( "TeamESP" ) );
				this.MVPSound = result.GetInteger( "MVPSound" );
				this.NoMVP = SToB( result.GetString( "NoMVP" ) );
				this.ShowCountry = SToB( result.GetString( "ShowCountry" ) );
				this.ShowStats = SToB( result.GetString( "ShowStats" ) );
				this.AllowPM = SToB( result.GetString( "AllowPM" ) );
				this.AllTimeMinPing = result.GetInteger( "LowestAveragePing" );
				this.AllTimeMaxPing = result.GetInteger( "HighestAveragePing" );
				this.AllTimeMaxFPS = result.GetInteger( "HighestAverageFPS" );
				this.AllTimeMinFPS = result.GetInteger( "LowestAverageFPS" );
				this.Ignore = ( ::json_decode( result.GetString( "Ignore" ) ) == null ) ? {} : ::json_decode( result.GetString( "Ignore" ) );
				this.PublicChat = SToB( result.GetString( "PublicChat" ) );
				this.ShowTaunt = SToB( result.GetString( "ShowTaunt" ) );
				this.TauntText = result.GetString( "Taunt" );
				this.Comments = result.GetString( "Comments" );
				
				if ( player.Authority == 0 ) player.Authority = 1;		
						
				Handler.Handlers.PlayerUID.AddAlias( player );

				Handler.Handlers.Script.sendToClient( player, 2504, this.TeamESP );

				if( this.ChatType == "new" ) player.Message( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" );

				if( this.ShowCountry )
				{
					SqCast.MsgAllExp( player, "AccJoined", SqCast.GetPlayerColor( player.Name ), GeoIP.GetDIsplayInfo( player.IP ) );
					Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server from **%s**.", player.Name, GeoIP.GetDIsplayInfo( player.IP ) );
				}
				else 
				{
					SqCast.MsgAllExp( player, "AccJoined2", SqCast.GetPlayerColor( player.Name ) );
					SqCast.MsgAllAdmin( "AccJoined4", SqCast.GetPlayerColor( player.Name ), GeoIP.GetDIsplayInfo( player.IP ) );
					Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server.", player.Name );
				}
				
				SqCast.MsgPlr( player, "LogScs" );
				playsound( player, 50028 ), SqCast.sendAlert( player, "CmdError", "Welcome to Rob The Vehicles!" );

				if( this.Comments != "no" ) SqCast.MsgAllAdmin( "ShowComments", SqCast.GetPlayerColor( player.Name ), this.Comments );
				
			//	Handler.Handlers.Discord.ToDiscord( 6, "**%s** joined the server from **%s**.", player.Name, GeoIP.GetDIsplayInfo( player.IP ) );
			
				
				if( !Handler.Handlers.Script.ReadOnly ) Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET IsOnline = '1' WHERE ID = '%d';", this.ID );
				if( Handler.Handlers.Script.ReadOnly ) SqCast.MsgPlr( player, "ReadOnlyAlert" );


				if( Handler.Handlers.Script.LegacySpawn )
				{
					local teamid = "Defender";
					if( player.Team != Handler.Handlers.Gameplay.Defender ) teamid = "Attacker";
					if( player.Team == 7 ) teamid = "Spectator";

					if ( Handler.Handlers.Gameplay.Status > 2 ) Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV3( player.Team ) );
					else Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );
				
					if( !this.ReadNews ) Handler.Handlers.Script.sendToClient( player, 2300 );
				}

				else 
				{
					player.CameraPosition( Vector3( -482.285583,620.814087,12.381873+10 ),Vector3( -569.277649,670.066895,10.910061 ) );

					if( this.ReadNews )
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
					else Handler.Handlers.Script.sendToClient( player, 2300 );
				}

			//	Handler.Handlers.Script.sendToClient( player, 402, SqCast.GetTeamColorOnly( player.Team ) + SqCast.GetTeamName( player.Team ) + " - " + teamid + " - Player(s)  " + Handler.Handlers.Gameplay.getPlayerTeamCountV2( player.Team ) );
			
			//	player.CameraPosition( Vector3( -482.285583,620.814087,12.381873+10 ),Vector3( -569.277649,670.066895,10.910061 ) );

				player.MakeTask( function() {
					local totalp = 0, totalf = 0, calavgp = 0, calavgf = 0;

					player.Data.LastPing.push( player.Ping );
					player.Data.LastFPS.push( player.FPS );

					if( player.Ping > player.Data.MaxPing ) player.Data.MaxPing = player.Ping;
					if( player.Ping < player.Data.MinPing ) player.Data.MinPing = player.Ping;

					if( player.FPS > player.Data.MaxFPS ) player.Data.MaxFPS = player.FPS;
					if( player.FPS < player.Data.MinFPS ) player.Data.MinFPS = player.FPS;

					foreach( index, value in player.Data.LastPing ) { totalp += value; };
					foreach( index, value in player.Data.LastFPS ) { totalf += value; };

					calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
            		calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );

					if( calavgp > player.Data.AllTimeMaxPing ) player.Data.AllTimeMaxPing = calavgp;
					if( calavgp < player.Data.AllTimeMinPing ) player.Data.AllTimeMinPing = calavgp;

					if( calavgf > player.Data.AllTimeMaxFPS ) player.Data.AllTimeMaxFPS = calavgf;
					if( calavgf < player.Data.AllTimeMinFPS ) player.Data.AllTimeMinFPS = calavgf;
				}, 500, 0 );

				player.GetModuleList();

				if( Handler.Handlers.Script.ReadOnly )
				{
					if( Handler.Handlers.PlayerAccount.PlayerTempAccount.rawin( player.Data.ID ) )
					{
						local getdata = Handler.Handlers.PlayerAccount.PlayerTempAccount.rawget( player.Data.ID );

						this.Stats.Kills = getdata.Kills;
						this.Stats.Deaths = getdata.Deaths;
						this.Stats.Stealed = getdata.Stolen;
						this.Stats.AttWon = getdata.AttWon;
						this.Stats.DefWon = getdata.DefWon;
						this.Stats.MVP = getdata.MVP;
						this.Stats.TopSpree = getdata.TopSpree;
						this.Stats.Playtime = getdata.Playtime;
						this.Stats.RoundPlayed = getdata.RoundPlayed;
						this.OperationVehColor1 = getdata.Carcol1;
						this.OperationVehColor2 = getdata.Calrol2;
						this.AllTimeMinPing = getdata.LowestAveragePing;
						this.AllTimeMaxPing = getdata.HighestAveragePing;
						this.AllTimeMaxFPS = getdata.LowestAverageFPS;
						this.AllTimeMinFPS = getdata.LowestAverageFPS;
								
						player.Authority = getdata.Level;
						this.NoMVP = getdata.NoMVP;
						this.MVPSound = getdata.MVPSound;
					}

					else 
					{
						this.Stats.Kills = 0;
						this.Stats.Deaths = 0;
						this.Stats.Stealed = 0;
						this.Stats.AttWon = 0;
						this.Stats.DefWon = 0;
						this.Stats.MVP = 0;
						this.Stats.TopSpree = 0;
						this.Stats.Playtime = 0;
						this.Stats.RoundPlayed = 0;
					}
				}
			}

			this.resultCache = null;
		}	

		catch( e ) SqLog.Err( "Error on CPlayer::Login [%s]", e );
	}

	function verifyBan( player, result )
	{
		try 
		{
			this.Ban = ::json_decode( result.GetString( "Ban" ) );
			if( this.Ban )
			{
	            if( this.Ban.Duration.tointeger() > ( time() - this.Ban.Time.tointeger() ) )
	            {
					SqCast.MsgPlr( player, "Kickban", SqCast.GetPlayerColor( this.Ban.Admin ), this.Ban.Reason, GetDate( this.Ban.Time.tointeger() ) );
					SqCast.MsgPlr( player, "KickbanTimered", GetTiming( ( this.Ban.Duration.tointeger() - ( time() - this.Ban.Time.tointeger() ) ) ) );

	                if( this.Ban.Duration.tointeger() > 604800 ) {}/* perma ban msg */

	                player.Kick();

	                return true;
	            }

				else 
				{
					this.Ban = null;
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayer::verifyBan [%s]", e );
	}

	function checkMute( player, result )
	{
		try 
		{
			if( !this.Mute )
			{
				this.Mute = ::json_decode( result.GetString( "Mute" ) );
				if( this.Mute )
				{
			        if( this.Mute.Duration.tointeger() > ( time() - this.Mute.Time.tointeger() ) )
			        {
		                player.MakeTask( function()
		                {  
		                    player.Data.Mute = null;
		                                                            
		                   	this.Terminate();

		                }, ( player.Data.Mute.Duration.tointeger() * 1500 ), 1 ).SetTag( "Mute" );


			           if( this.Mute.Duration.tointeger() > 604800 ) {}/* shun msg */
			        }

					else 
					{
		                this.Mute = null;
					}						
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayer::checkMute [%s]", e );
	}

	function checkRPGBan( player, result )
	{
		try 
		{
			if( !this.RPGBan )
			{
				this.RPGBan = ::json_decode( result.GetString( "RPGBan" ) );
				if( this.RPGBan )
				{
			        if( this.RPGBan.Duration.tointeger() > ( time() - this.RPGBan.Time.tointeger() ) )
			        {
		                player.MakeTask( function()
		                {  
		                    player.Data.Mute = null;
		                                                            
		                   	this.Terminate();

		                }, ( player.Data.RPGBan.Duration.tointeger() * 1500 ), 1 ).SetTag( "RPGBan" );


			           if( this.RPGBan.Duration.tointeger() > 604800 ) {}/* perma rpgban msg */
			        }

					else 				
					{
						this.RPGBan = null;
					}						
				}
			}
		}
		catch( e ) SqLog.Err( "Error on CPlayer::checkRPGBan [%s]", e );
	}

	function InRound( player )
	{
		try 
		{
			if( player.Team == 1 || player.Team == 2 && player.Spawned ) return player.Spawned;
		}
		catch( e ) SqLog.Err( "Error on CPlayer::InRound [%s]", e );

	}
}