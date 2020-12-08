SqCommand.Create( "stats", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            local ratio = ( typeof( player.Data.Stats.Kills.tofloat() / player.Data.Stats.Deaths.tofloat() ) != "float" ) ? 0.0 : player.Data.Stats.Kills.tofloat() / player.Data.Stats.Deaths.tofloat();

            SqCast.MsgPlr( player, "OwnStats" );
            SqCast.MsgPlr( player, "OwnStats1", player.Data.Stats.Kills, player.Data.Stats.Deaths, ratio, ( ( player.Data.Stats.TopSpree >= 5 ) ? player.Data.Stats.TopSpree : 0 ) );
            SqCast.MsgPlr( player, "OwnStats2", player.Data.Stats.RoundPlayed, player.Data.Stats.AttWon, player.Data.Stats.DefWon, player.Data.Stats.MVP, player.Data.Stats.Stealed );
            SqCast.MsgPlr( player, "OwnStats3", ( player.Data.AllTimeMinPing == 10000000 ) ? 0 : player.Data.AllTimeMinPing, ( player.Data.AllTimeMaxFPS == -1 ) ? 0 : player.Data.AllTimeMaxFPS, ( player.Data.AllTimeMinFPS == 10000000 ) ? 0 : player.Data.AllTimeMinFPS, ( player.Data.AllTimeMaxPing == -1 ) ? 0 : player.Data.AllTimeMaxPing );
        }

        else 
        {
            local target = Handler.Handlers.Script.FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                        if( Handler.Handlers.Gameplay.IsPrivate( target.Data.ShowStats, player.Authority ) ) 
                        {
                            local ratio = ( typeof( target.Data.Stats.Kills.tofloat() / target.Data.Stats.Deaths.tofloat() ) != "float" ) ? 0.0 : target.Data.Stats.Kills.tofloat() / target.Data.Stats.Deaths.tofloat();

                            SqCast.MsgPlr( player, "TargetStats", SqCast.GetPlayerColor( target ) );
                            SqCast.MsgPlr( player, "OwnStats1", target.Data.Stats.Kills, target.Data.Stats.Deaths, ratio, ( ( target.Data.Stats.TopSpree >= 5 ) ? target.Data.Stats.TopSpree : 0 ) );
                            SqCast.MsgPlr( player, "OwnStats2", target.Data.Stats.RoundPlayed, target.Data.Stats.AttWon, target.Data.Stats.DefWon, target.Data.Stats.MVP, target.Data.Stats.Stealed );
                            SqCast.MsgPlr( player, "OwnStats3", ( target.Data.AllTimeMinPing == 10000000 ) ? 0 : target.Data.AllTimeMinPing, ( target.Data.AllTimeMaxFPS == -1 ) ? 0 : target.Data.AllTimeMaxFPS, ( target.Data.AllTimeMinFPS == 10000000 ) ? 0 : target.Data.AllTimeMinFPS, ( target.Data.AllTimeMaxPing == -1 ) ? 0 : target.Data.AllTimeMaxPing );
                        }
                        else SqCast.MsgPlr( player, "TargetDisStats" );
                    }

                    else 
                    {
                        local ratio = ( typeof( player.Data.Stats.Kills.tofloat() / player.Data.Stats.Deaths.tofloat() ) != "float" ) ? 0.0 : player.Data.Stats.Kills.tofloat() / player.Data.Stats.Deaths.tofloat();

                        SqCast.MsgPlr( player, "OwnStats" );
                        SqCast.MsgPlr( player, "OwnStats1", player.Data.Stats.Kills, player.Data.Stats.Deaths, ratio, ( ( player.Data.Stats.TopSpree >= 5 ) ? player.Data.Stats.TopSpree : 0 ) );
                        SqCast.MsgPlr( player, "OwnStats2", player.Data.Stats.RoundPlayed, player.Data.Stats.AttWon, player.Data.Stats.DefWon, player.Data.Stats.MVP, player.Data.Stats.Stealed );
                        SqCast.MsgPlr( player, "OwnStats3", ( player.Data.AllTimeMinPing == 10000000 ) ? 0 : player.Data.AllTimeMinPing, ( player.Data.AllTimeMaxFPS == -1 ) ? 0 : player.Data.AllTimeMaxFPS, ( player.Data.AllTimeMinFPS == 10000000 ) ? 0 : player.Data.AllTimeMinFPS, ( player.Data.AllTimeMaxPing == -1 ) ? 0 : player.Data.AllTimeMaxPing );
                    }
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "hp", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            SqCast.MsgPlr( player, "ShowHPSelf", player.Health+player.Armour );
        }
        else 
        {
            local target = FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                        SqCast.MsgPlr( player, "ShowHP", SqCast.GetPlayerColor( target ), target.Health+target.Armour );
                    }
                    else SqCast.MsgPlr( player, "ShowHPSelf", player.Health+player.Armour );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "report", "s|g", [ "Target", "Reason" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
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
                        SqCast.MsgAllAdmin( "ReportAdmin", player.Name, target.Name, args.Reason );
                        SqCast.MsgPlr( player, "ReportSubmit");
                        SqCast.MsgPlr( player, "ReportSubmit1");
                    }
					else SqCast.MsgPlr( player, "CantReportSelf" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline");
			}
			else SqCast.MsgPlr( player, "ReportSyntax");
		}
        else SqCast.MsgPlr( player, "ReportSyntax");
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "fps", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            local calavgp = 0;
            local calavgf = 0;
            local totalp = 0;
            local totalf = 0;
        
            foreach( index, value in player.Data.LastPing ) { totalp += value; };
            foreach( index, value in player.Data.LastFPS ) { totalf += value; };

            calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
            calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );
           
            SqCast.MsgPlr( player, "ShowFPSPingSelf", player.Ping, player.Data.MaxPing, player.Data.MinPing, calavgp, player.FPS, player.Data.MaxFPS, player.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( player.Data.LastPing ) ) );
        }
        else 
        {
            local target = Handler.Handlers.Script.FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                        local calavgp = 0;
                        local calavgf = 0;
                        local totalp = 0;
                        local totalf = 0;

                        foreach( index, value in target.Data.LastPing ) { totalp += value; };
                        foreach( index, value in target.Data.LastFPS ) { totalf += value; };

                        calavgp = ( totalp/IsZero( target.Data.LastPing.len() ) );
                        calavgf = ( totalf/IsZero( target.Data.LastFPS.len() ) );
                                            
                        SqCast.MsgPlr( player, "ShowFPSPing", SqCast.GetPlayerColor( target ), target.Ping, target.Data.MaxPing, calavgp, target.Data.MinPing, target.FPS, target.Data.MaxFPS, target.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( target.Data.LastPing ) ) );
                    }
                    else 
                    {
                        local calavgp = 0;
                        local calavgf = 0;
                        local totalp = 0;
                        local totalf = 0;

                        foreach( index, value in player.Data.LastPing ) { totalp += value; };
                        foreach( index, value in player.Data.LastFPS ) { totalf += value; };

                        calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
                        calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );
                    
                        SqCast.MsgPlr( player, "ShowFPSPingSelf", player.Ping, player.Data.MaxPing, player.Data.MinPing, calavgp, player.FPS, player.Data.MaxFPS, player.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( player.Data.LastPing ) ) );
                    }
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ping", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            local calavgp = 0;
            local calavgf = 0;
            local totalp = 0;
            local totalf = 0;

            foreach( index, value in player.Data.LastPing ) { totalp += value; };
            foreach( index, value in player.Data.LastFPS ) { totalf += value; };

            calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
            calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );
           
            SqCast.MsgPlr( player, "ShowFPSPingSelf", player.Ping, player.Data.MaxPing, player.Data.MinPing, calavgp, player.FPS, player.Data.MaxFPS, player.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( player.Data.LastPing ) ) );
        }

        else 
        {
            local target = Handler.Handlers.Script.FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                        local calavgp = 0;
                        local calavgf = 0;
                        local totalp = 0;
                        local totalf = 0;

                        foreach( index, value in target.Data.LastPing ) { totalp += value; };
                        foreach( index, value in target.Data.LastFPS ) { totalf += value; };

                        calavgp = ( totalp/IsZero( target.Data.LastPing.len() ) );
                        calavgf = ( totalf/IsZero( target.Data.LastFPS.len() ) );

                        SqCast.MsgPlr( player, "ShowFPSPing", SqCast.GetPlayerColor( target ), target.Ping, target.Data.MaxPing, calavgp, target.Data.MinPing, target.FPS, target.Data.MaxFPS, target.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( target.Data.LastPing ) ) );
                    }
                    else 
                    {
                        local calavgp = 0;
                        local calavgf = 0;
                        local totalp = 0;
                        local totalf = 0;

                        foreach( index, value in player.Data.LastPing ) { totalp += value; };
                        foreach( index, value in player.Data.LastFPS ) { totalf += value; };

                        calavgp = ( totalp/IsZero( player.Data.LastPing.len() ) );
                        calavgf = ( totalf/IsZero( player.Data.LastFPS.len() ) );
                    
                        SqCast.MsgPlr( player, "ShowFPSPingSelf", player.Ping, player.Data.MaxPing, player.Data.MinPing, calavgp, player.FPS, player.Data.MaxFPS, player.Data.MinFPS, calavgf, Handler.Handlers.Gameplay.verifyJitter( CalculateJitter( player.Data.LastPing ) ) );
                    }
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "changepass", "s|s", [ "OldPass", "NewPass" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( args.rawin( "OldPass" ) )
        {
            if( args.rawin( "NewPass" ) )
            {
                if( player.Data.Password == SqHash.GetSHA256( args.OldPass ) )
                {
                    if( args.NewPass.len() > 4 )
                    {
                        if( args.OldPass.tolower() != args.NewPass.tolower() )
                        {
                            player.Data.Password = SqHash.GetSHA256( args.NewPass );

                            SqCast.MsgPlr( player, "Changepass" );
                        }
                        else SqCast.MsgPlr( player, "ChangepassOldSameNew" );
                    }
                    else SqCast.MsgPlr( player, "ChangepassNewPassNotEnough" );
                }
                else SqCast.MsgPlr( player, "ChangepassOldPass" );
            }
            else SqCast.MsgPlr( player, "ChangepassSyntax" );
        }
        else SqCast.MsgPlr( player, "ChangepassSyntax" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "country", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            SqCast.MsgPlr( player, "SelfCountry", GeoIP.GetDIsplayInfo( player.IP ) );
        }

        else 
        {
            local target = Handler.Handlers.Script.FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                        if( Handler.Handlers.Gameplay.IsPrivate( target.Data.ShowCountry, player.Authority ) ) 
                        {
                            SqCast.MsgPlr( player, "TargetCountry", SqCast.GetPlayerColor( target ), GeoIP.GetDIsplayInfo( target.IP ) );
                        }
                        else SqCast.MsgPlr( player, "TargerDisCountry" );
                    }
                    else SqCast.MsgPlr( player, "SelfCountry", GeoIP.GetDIsplayInfo( player.IP ) );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "admins", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
/*	local adminlist=GetAdminList();
    if( player.Data.Logged )
    {	
		if ( adminlist == "" ) SqCast.MsgPlr( player, "NoAdmins" );
		else SqCast.MsgPlr( player, "Admins", adminlist );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;*/

    if( player.Data.Logged )
    {
        local owner = [], man = [], admin = [], mod = [];

        SqForeach.Player.Active( this, function( plr ) 
        {
            if( plr.Data.Logged )
            {
                switch( plr.Authority )
                {
                    case 3:
                    mod.push( { "Name": plr.Name, "Status": Handler.Handlers.PlayerUID.GetPlayerStatus( plr ) } );
                    break;

                    case 4:
                    admin.push( { "Name": plr.Name, "Status": Handler.Handlers.PlayerUID.GetPlayerStatus( plr ) } );
                    break;

                    case 5:
                    man.push( { "Name": plr.Name, "Status": Handler.Handlers.PlayerUID.GetPlayerStatus( plr ) } );
                    break;
                    
                    default:
                    if( plr.Authority > 5 ) owner.push( { "Name": plr.Name, "Status": Handler.Handlers.PlayerUID.GetPlayerStatus( plr ) } );
                    break;
                }
            }
        });

        foreach( index, value in owner ) { SqCast.MsgPlr( player, "OwnerOnline", value.Name, value.Status ); }
        foreach( index, value in man ) { SqCast.MsgPlr( player, "ManagerOnline", value.Name, value.Status ); }
        foreach( index, value in admin ) { SqCast.MsgPlr( player, "AdminOnline", value.Name, value.Status ); }
        foreach( index, value in mod ) { SqCast.MsgPlr( player, "ModOnline", value.Name, value.Status ); }

        if( owner.len() == 0 && man.len() == 0 && admin.len() == 0 && mod.len() == 0 ) SqCast.MsgPlr( player, "NoAdmins" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
 
});

/*SqCommand.Create( "jingles", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
		if ( player.Data.Jingles == 0 ) 
		{
			player.Data.Jingles=1;
			player.Message("Jingles have been enabled.");
			Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Jingles = 1 WHERE Name = '%s';", player.Name );
			PlayJingles( player );
		}
		else
		{
		player.Data.Jingles = 0;
		player.Message("Jingles have been disabled, alt-tab out and in back to game to stop the jingles playing already.");
		Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Jingles = 0 WHERE Name = '%s';", player.Name );
		}
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});*/

SqCommand.Create( "rules", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        SqCast.MsgPlr( player, "ListRules1" );
        SqCast.MsgPlr( player, "ListRules2" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "help", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        SqCast.MsgPlr( player, "HelpMsg" );
        SqCast.MsgPlr( player, "HelpMsg1" );
        SqCast.MsgPlr( player, "HelpMsg2" );
        SqCast.MsgPlr( player, "HelpMsg3" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "sounds", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
		if ( player.Data.Sounds == 0 ) 
		{
			player.Data.Sounds = 1;

            SqCast.MsgPlr( player, "SoundsEnable" );

			PlayJingles( player );
		}
		else
		{
            player.Data.Sounds = 0;

            SqCast.MsgPlr( player, "SoundsDisable" );
		}
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "players", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		local attackers = 0, defenders = 0, spectators = 0, defcolor = "", attcolor = "";
		local reds, blues;
		reds = Handler.Handlers.Gameplay.getPlayerTeamCount( 1 );
		blues = Handler.Handlers.Gameplay.getPlayerTeamCount( 2 );
		if ( Handler.Handlers.Gameplay.Defender != 1 )
		{
			attackers = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 );
			attcolor = "Red Team";
			defenders = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 ); 
			defcolor = "Blue Team";
		}
		else
		{
			defenders = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 1 );
			attcolor = "Red Team";
			attackers = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 2 );
			defcolor = "Blue Team";
		}
		spectators = Handler.Handlers.Gameplay.getPlayerTeamCountV3( 7 );

		SqCast.MsgPlr( player, "GetPlayers", GetPlayers(), reds, blues, spectators );
        if( Handler.Handlers.Gameplay.Status > 2 ) SqCast.MsgPlr( player, "RoundActiveGetPlr", attcolor, attackers.tointeger(), defcolor, defenders.tointeger(), spectators );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "world", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( !args.rawin( "Target" ) )
        {
            SqCast.MsgPlr( player, "OwnWorld", player.World );
        }
        else 
        {
            local target = Handler.Handlers.Script.FindPlayer( args.Target );
            if( target )
            {
                if( target.Data.Logged )
                {
                    if( target.ID != player.ID )
                    {
                       SqCast.MsgPlr( player, "TargetWorld", target.Name, target.World );
                    }
                    else SqCast.MsgPlr( player, "OwnWorld", player.World );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "doodle", "g", [ "Text" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( ( time() - player.Data.DoodleCD ) >= 30 )
        {
            if( ( Handler.Handlers.PlayerUID.CheckMute( player ) ) )
            {
                if( args.rawin( "Text" ) )
                {
                    local isExist = null;
                    local id = Handler.Handlers.Script.DoddleBoardPos;

                    print( Handler.Handlers.Script.DoddleBoardPos );

                    foreach( index, value in Handler.Handlers.Script.DoddleBoard )
                    {
                        if( value.AuthorID == player.Data.ID ) 
                        {
                            isExist = index;
                        }
                    }

                    if( isExist ) id = isExist;                    

                    Handler.Handlers.Script.DoddleBoard[ id ].Text = StripCol( args.Text );
                    Handler.Handlers.Script.DoddleBoard[ id ].Author = player.Name;
                    Handler.Handlers.Script.DoddleBoard[ id ].AuthorID = player.Data.ID;

                    Handler.Handlers.Script.sendToClientToAll( 2201, id + "`" + StripCol( args.Text ) + "`" + player.Name );

                    if( !isExist ) Handler.Handlers.Script.DoddleBoardPos ++;

                    SqCast.MsgPlr( player, "DoodleScs" );

                    if( !Handler.Handlers.Script.ReadOnly ) Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_doodle SET Text = '%s', Author = '%d' WHERE ID = '%d'", Handler.Handlers.Script.Database.EscapeString( args.Text ), player.Data.ID, Handler.Handlers.Script.DoddleBoardPos );

                    if( Handler.Handlers.Script.DoddleBoardPos >= 21 ) Handler.Handlers.Script.DoddleBoardPos = 1;
                }
                else SqCast.MsgPlr( player, "DoodleSyntax" );
            }
            else SqCast.MsgPlr( player, "CantTalkMuted" );
        }
        else SqCast.MsgPlr( player, "CmdOnCD", GetTiming( ( 30 - ( time() - player.Data.DoodleCD ) ) ) );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "carcol", "s|s", [ "Col1", "Col2" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( args.rawin( "Col1" ) &&  args.rawin( "Col2" ) )
        {
            if( IsNum( args.Col1 ) && IsNum( args.Col2 ) )
            {
                player.Data.OperationVehColor1 = args.Col1.tointeger();
                player.Data.OperationVehColor2 = args.Col2.tointeger();

                SqCast.MsgPlr( player, "CarcolUpdated" );
            }
            else SqCast.MsgPlr( player, "CarcolNotNum" );
        }
        else SqCast.MsgPlr( player, "CarcolSyntax" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "changemvpsound", "s", [ "Text" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        if( args.rawin( "Text" ) )
        {
            switch( args.Text )
            {
                case "1":
                player.Data.MVPSound = 50043;

                SqCast.MsgPlr( player, "MVpChange", "Dancing" );

                playsound( player, player.Data.MVPSound );
                break;

                case "2":
                player.Data.MVPSound = 50044;

                SqCast.MsgPlr( player, "MVpChange", "EZ KATKA" );

                playsound( player, player.Data.MVPSound );
                break;
                
                case "3":
                player.Data.MVPSound = 50045;

                SqCast.MsgPlr( player, "MVpChange", "WOAH" );
                
                playsound( player, player.Data.MVPSound );
                break;
                
                case "4":
                player.Data.MVPSound = 50047;

                SqCast.MsgPlr( player, "MVpChange", "EZ4ENCE" );
                
                playsound( player, player.Data.MVPSound );
                break;
                
                case "5":
                player.Data.MVPSound = 50046;

                SqCast.MsgPlr( player, "MVpChange", "Nico Nico Nii" );
                
                playsound( player, player.Data.MVPSound );
                break;

                case "6":
                player.Data.MVPSound = 50048;

                SqCast.MsgPlr( player, "MVpChange", "SA Mission Passed" );
                
                playsound( player, player.Data.MVPSound );
                break;

                case "7":
                player.Data.MVPSound = 50049;

                SqCast.MsgPlr( player, "MVpChange", "SOSAT BLYAT" );
                
                playsound( player, player.Data.MVPSound );
                break;

                case "8":
                player.Data.MVPSound = 50050;

                SqCast.MsgPlr( player, "MVpChange", "Flawless Victory" );
                
                playsound( player, player.Data.MVPSound );
                break;

                case "9":
                player.Data.MVPSound = 50051;

                SqCast.MsgPlr( player, "MVpChange", "GJ VCPD" );
                
                playsound( player, player.Data.MVPSound );
                break;

                case "10":
                player.Data.MVPSound = 50052;

                SqCast.MsgPlr( player, "MVpChange", "Vi sitter i Ventrilo och Spelar DotA" );
                
                playsound( player, player.Data.MVPSound );
                break;

                default:
                SqCast.MsgPlr( player, "MVPSyntax" );
                SqCast.MsgPlr( player, "MVPSyntax1" );
            }
        }
        else 
        {
            SqCast.MsgPlr( player, "MVPSyntax" );
            SqCast.MsgPlr( player, "MVPSyntax1" );
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "playsound", "g", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
	if( args.rawin( "ID" ) )
	{
		try
		{
			playsound( player, args.ID.tointeger() );

			SqCast.MsgPlr( player, "PlaySoundX", args.ID.tointeger() );
		}
		catch( e ) SqCast.MsgPlr( player, "ErrPlaySound", e );
	}
	else SqCast.MsgPlr( player, "PlaySoundSyntax1" );

    return true;
});

SqCommand.Create( "login", "s", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
	if( args.rawin( "ID" ) )
	{
		if( player.Data.Registered )
		{
			if( !player.Data.Logged )
			{
				if( player.Data.Password == SqHash.GetSHA256( args.ID ) )
				{
					player.Data.Login( player );

					Handler.Handlers.Script.sendToClient( player, 601 );
				}
				else SqCast.MsgPlr( player, "LoginXPassword" );
            }
            else SqCast.MsgPlr( player, "AlreadyLogged" );
        }
        else SqCast.MsgPlr( player, "NotReg" );
    }
    else SqCast.MsgPlr( player, "LoginSyntax" );

    return true;
});

SqCommand.Create( "disablemvp", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.NoMVP )
        {
            case true:
            player.Data.NoMVP = false;
            SqCast.MsgPlr( player, "EnableMVP" );
            break;

            case false:
            player.Data.NoMVP = true;
            SqCast.MsgPlr( player, "DisableMVP" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "showcountry", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.ShowCountry )
        {
            case true:
            player.Data.ShowCountry = false;
            SqCast.MsgPlr( player, "ShowCountryOff" );
            break;

            case false:
            player.Data.ShowCountry = true;
            SqCast.MsgPlr( player, "ShowCountryOn" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "showstats", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.ShowStats )
        {
            case true:
            player.Data.ShowStats = false;
            SqCast.MsgPlr( player, "ShowStatsOff" );
            break;

            case false:
            player.Data.ShowStats = true;
            SqCast.MsgPlr( player, "ShowStatsOn" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "allowpm", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.AllowPM )
        {
            case true:
            player.Data.AllowPM = false;
            SqCast.MsgPlr( player, "AllowPMOff" );
            break;

            case false:
            player.Data.AllowPM = true;
            SqCast.MsgPlr( player, "AllowPMOn" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ignore", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
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
                        if( !player.Data.Ignore.rawin( target.Data.ID.tostring() ) ) 
                        {
                            player.Data.Ignore.rawset( target.Data.ID.tostring(), null );

                            SqCast.MsgPlr( player, "TargetIgnored", SqCast.GetPlayerColor( target ) );
                        }
                        else SqCast.MsgPlr( player, "TargetAlreadyIgnore" );
                    }
                    else SqCast.MsgPlr( player, "CantIgnoreSelf" );
                }
                else SqCast.MsgPlr( player, "TargetXOnline" );
            }
            else SqCast.MsgPlr( player, "TargetXOnline" );
        }
        else SqCast.MsgPlr( player, "IgnoreSyntax" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "unignore", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( args.rawin( "Target" ) )
        {
            if( IsNum( args.Target ) )
            {
                if( player.Data.Ignore.rawin( args.Target.tostring() ) ) 
                {
                    player.Data.Ignore.rawdelete( args.Target.tostring() );

                    SqCast.MsgPlr( player, "TargetUnIgnored", Handler.Handlers.PlayerAccount.GetAccountNameFromID( args.Target.tointeger() ) );
                }
                else SqCast.MsgPlr( player, "UnignoreInvalidIndex" );
            }
            else SqCast.MsgPlr( player, "UnignoreNotNum" );
        }
        else SqCast.MsgPlr( player, "UnIgnoreSyntax" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "ignorelist", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        local data = null;
        foreach( index, value in player.Data.Ignore )
        {
            if( data ) data = data + ", " + "[" + index + "] " + Handler.Handlers.PlayerAccount.GetAccountNameFromID( index.tointeger() );
            else data = "[" + index + "] " + Handler.Handlers.PlayerAccount.GetAccountNameFromID( index.tointeger() );
        }

        if( data ) SqCast.MsgPlr( player, "IgnoreList", data );
        else SqCast.MsgPlr( player, "NoIgnoreList" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "pm", "s|g", [ "Target", "Text" ], 0, 2, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( Handler.Handlers.PlayerUID.CheckMute( player ) )
        {
            if( args.rawin( "Target" ) )
            {
                if( args.rawin( "Text" ) )
                {
                    local target = Handler.Handlers.Script.FindPlayer( args.Target );
                    if( target )
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
                                            SqCast.MsgPlr( player, "onPlayerPMSender", target.Name, target.ID, args.Text );

                                            if( player.Data.aduty ) SqCast.MsgPlr( target, "onPlayerPMReceiverA", player.Name, player.ID, args.Text );
                                            else SqCast.MsgPlr( target, "onPlayerPMReceiver", player.Name, player.ID, args.Text );

                                            if( !Handler.Handlers.Script.PrivateMode ) 
                                            {
                                                Handler.Handlers.Discord.SendToPrivate( format( "**%s** to **%s**: %s", player.Name, target.Name, args.Text ), "pm" );
                                                SqCast.MsgAllMan( "onPlayerPM", player.Name, target.Name, args.Text );
                                            }
                                        }
                                        else SqCast.MsgPlr( player, "CantPMTargetIgnored" );
                                    }
                                    else SqCast.MsgPlr( player, "CantPMIgoreTarget" );
                                }
                                else SqCast.MsgPlr( player, "CantPMTargetDisallowPM" );
                            }
                            else SqCast.MsgPlr( player, "CantPMSelf", player.Name, GeoIP.GetIPCountry( player.ID ) );
                        }
                        else SqCast.MsgPlr( player, "TargetXOnline" );
                    }
                    else SqCast.MsgPlr( player, "TargetXOnline" );
                }
                else SqCast.MsgPlr( player, "PMSyntax" );
            }
            else SqCast.MsgPlr( player, "PMSyntax" );
        }
        else SqCast.MsgPlr( player, "CantTalkMuted" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "publicchat", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.PublicChat )
        {
            case true:
            player.Data.PublicChat = false;
            SqCast.MsgPlr( player, "DisablePChat" );
            break;

            case false:
            player.Data.PublicChat = true;
            SqCast.MsgPlr( player, "EnablePChat" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "showtaunt", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {	
        switch( player.Data.ShowTaunt )
        {
            case true:
            player.Data.ShowTaunt = false;
            SqCast.MsgPlr( player, "DisableTaunt1" );
            break;

            case false:
            player.Data.ShowTaunt = true;
            SqCast.MsgPlr( player, "EnableTaunt" );
            break;
        }
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "taunttext", "g", [ "Text" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( args.rawin( "Text" ) )
        {
            switch( args.Text )
            {
                case "disable":
                player.Data.TauntText = "no";

                SqCast.MsgPlr( player, "DisableTaunt" );
                break;

                default:
                player.Data.TauntText = args.Text;

                SqCast.MsgPlr( player, "TauntUpdate", args.Text );
                break;
            }
        }
        else SqCast.MsgPlr( player, "TauntSyntax" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});
