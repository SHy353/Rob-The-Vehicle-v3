SqCommand.Create( "forum", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
	if( player.Data.Logged )
    {
		SqCast.MsgPlr( player, "ShowForum", "" );
    }
    else SqCast.MsgPlr( player, "ErrCmd" );

	return true;
});

SqCommand.Create( "discord", "", [ "" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
	if( player.Data.Logged )
    {
		SqCast.MsgPlr( player, "ShowDiscord" );
    }
    else SqCast.MsgPlr( player, "ErrCmd" );

	return true;
});

SqCommand.Create( "credits", "", [ "" ], 0, 0, -1, true ).BindExec( this, function( player, args )
{
	if( player.Data.Logged )
    {
		SqCast.MsgPlr( player, "ShowCreditsHeader" );
		SqCast.MsgPlr( player, "ShowCreditsMain" );
		SqCast.MsgPlr( player, "ShowCreditsDev" );
		SqCast.MsgPlr( player, "ShowCreditsUI" );
		SqCast.MsgPlr( player, "ShowCreditsSpecial" );
		SqCast.MsgPlr( player, "ShowCreditPanel" );
    }
    else SqCast.MsgPlr( player, "ErrCmd" );

	return true;
});

SqCommand.Create( "cmds", "g", [ "Text" ], 0, 0, -1, true, true ).BindExec( this, function( player, args )
{
	if( player.Data.Logged )
    {
		SqCast.MsgPlr( player, "ShowCmds" );
		SqCast.MsgPlr( player, "ShowKeyBinds" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

	return true;
});

SqCommand.Create( "cum", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( ( time() - player.Data.CumCD ) >= 15 )
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
							SqCast.MsgAll( "Cum2", player.Name, target.Name );

							player.Data.CumCD = time();
						}
						else SqCast.MsgPlr( player, "CumCantShootSelf" );
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}

        	else 
			{
				SqCast.MsgAll( "Cum", player.Name );

				player.Data.CumCD = time();
			}
		}
		else SqCast.MsgPlr( player, "CmdOnCD", GetTiming( ( 15 - ( time() - player.Data.CumCD ) ) ) );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "love", "g", [ "Target" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
		if( ( time() - player.Data.CumCD ) >= 15 )
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
							SqCast.MsgAll( "Love2", player.Name, target.Name );

							player.Data.CumCD = time();
						}
						else 
						{
							SqCast.MsgAll( "Love", player.Name );

							player.Data.CumCD = time();
						}
					}
					else SqCast.MsgPlr( player, "TargetXOnline" );
				}
				else SqCast.MsgPlr( player, "TargetXOnline" );
			}

        	else 
			{
				SqCast.MsgAll( "Love", player.Name );

				player.Data.CumCD = time();
			}
		}
		else SqCast.MsgPlr( player, "CmdOnCD", GetTiming( ( 15 - ( time() - player.Data.CumCD ) ) ) );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});
