class CPanel
{
    function constructor()
    {
        checkPanel();
    }

    function checkPanel()
    {
    /*    local tim = SqRoutine( this, function()
        {
            local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM panel_task" );

            while( result.Step() )
            {
                Callback( result.GetString( "Type" ), result.GetString( "Param" ), result.GetString( "Param2" ), result.GetString( "Param3" ), result.GetString( "Param4" ), result.GetString( "Param5" ) );

                Handler.Handlers.Script.Database.ExecuteF( "DELETE FROM panel_task WHERE ID = '%d'", result.GetInteger( "ID" ) );
            }
        }, 5000, 0 );

        tim.Quiet = false;*/
    }

    function Callback( type, param, param1, param2, param3, param4 )
    {
        switch( type )
        {
            case "changenamea":   
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );
         
            SqCast.MsgAllAdmin( "ChangeNameAdminPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), param2, param3 );

            if( target )
            {
                target.Name = param3;

                SqCast.MsgPlr( target, "ChangeNamePlrPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), param3 );
            }
            break;

            case "changeranka":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );

			SqCast.MsgAllAdmin( "SetLevelAdmin", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ), GetRank( param2.tointeger() ) );

            if( target )
            {
                local oldlevel = target.Authority;
				target.Authority = param2.tointeger();
								
				if( target.Authority > oldlevel ) SqCast.MsgPlr( target, "AdminPromote", GetRank( target.Authority ) );
				else SqCast.MsgPlr( target, "AdminDemoted", GetRank( target.Authority ) );
            }
            break;

            case "changepassa":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );

            SqCast.MsgAllAdmin( "ChangePasswordAdminPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ) );
        
            if( target )
            {
                target.Data.Password = SqHash.GetSHA256( param2 );

                SqCast.MsgPlr( target, "ResetPassword2Panel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), param2 );
            }
            break;

            case "banplr":            
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );

            if( param3 == "0" )
            {
			//	Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_account SET Ban = '%s' WHERE ID = '%d';", "N/A", param1.tointeger() );

                SqCast.MsgAll( "UnBanPlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ) );
            }

            else 
            {
                if( target )
                {
                    SqCast.MsgAll( "BanPlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), SqCast.GetPlayerColor( target ), param2, SecondToTime( ( param3.tointeger() * 86400 ) ) );

                    target.Kick();
                }

                else 
                {
                    SqCast.MsgAll( "BanPlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ), param2, SecondToTime( ( param3.tointeger() * 86400 ) ) );
                }
            }
            break;

            case "rpgbanplr":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );
            local duration = ( param3.tointeger() * 86400 );

            SqCast.MsgAll( "RPGBanPlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), SqCast.GetPlayerColor( target ), param2, SecondToTime( duration ) );

            if( target )
            {
                target.Data.RPGBan = {};

                target.Data.RPGBan.rawset( "Admin", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ) );
                target.Data.RPGBan.rawset( "Reason", param2 );
                target.Data.RPGBan.rawset( "Duration", duration.tostring() );
                target.Data.RPGBan.rawset( "Time", time().tostring() );
                
				target.Data.wepSet = 1;

				if( Handler.Handlers.Gameplay.Status > 1 )
				{
					SqCast.MsgPlr( target, "DisarmRPGBan" );

					Handler.Handlers.Gameplay.giveSetWeapon( target );
				}

                target.MakeTask( function()
                {  
					target.Data.RPGBan = null;

                    this.Terminate();
               }, ( duration * 1500 ), 1 ).SetTag( "RPGBan" );
            }
            break;

            case "unrpgban":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );

            SqCast.MsgAll( "UnRPGBanPlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ) );

            if( target )
            {
                target.Data.RPGBan = null;

                if( Handler.Handlers.PlayerUID.IsTimedRPGBan( target ) ) target.FindTask( "RPGBan" ).Terminate();
            }
            break;

            case "muteplr":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );
            local duration = ( param3.tointeger() * 86400 );

            SqCast.MsgAll( "MutePlayerPanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), SqCast.GetPlayerColor( target ), param2, SecondToTime( duration ) );

            if( target )
            {
                target.Data.Mute = {};

                target.Data.Mute.rawset( "Admin", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ) );
                target.Data.Mute.rawset( "Reason", param2 );
                target.Data.Mute.rawset( "Duration", duration.tostring() );
                target.Data.Mute.rawset( "Time", time().tostring() );

                target.MakeTask( function()
                {  
                    player.Data.Mute = null;
										                        
                    this.Terminate();
                }, ( duration * 1500 ), 1 ).SetTag( "Mute" );
            }
            break;

            case "unmuteplr":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param1 );

            SqCast.MsgAll( "UnMutePanel", Handler.Handlers.PlayerAccount.GetAccountNameFromID( param ), Handler.Handlers.PlayerAccount.GetAccountNameFromID( param1 ) );

            if( target )
            {
                target.Data.Mute = null;

                if( Handler.Handlers.PlayerUID.IsTimedMuted( target ) ) target.FindTask( "Mute" ).Terminate();
            }
            break;

            case "changename":   
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param );
         
            if( target )
            {
                target.Name = param2;
            }
            break;

            case "changepass":
            local target = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( param );
        
            if( target )
            {
                target.Data.Password = param1;
            }
            break;

        }
    }
}