SqCommand.BindFail( this, function( type, msg, payload )
{
    local player = SqCommand.Invoker, cmd = SqCommand.Command;

	switch( type )
	{
		case SqCmdErr.EmptyCommand:
		case SqCmdErr.InvalidCommand:
		case SqCmdErr.UnknownCommand:
		SqCast.MsgPlr( player, "ErrCmd" );
		break;

		case SqCmdErr.MissingExecuter:
		case SqCmdErr.IncompleteArgs:
		case SqCmdErr.ExtraneousArgs:
		case SqCmdErr.UnsupportedArg:
		switch( cmd )
        {
            /* Player.nut */
            case "changepass":
            SqCast.MsgPlr( player, "ChangepassSyntax" );
            break;

            /* Admin.nut */
            case "e":
            SqCast.MsgPlr( player, "ExecSyntax" );
            break;

            case "cl":
            SqCast.MsgPlr( player, "ClSyntax" );
            break;

            case "kick":
            SqCast.MsgPlr( player, "KickSyntax" );
            break;

            case "ban":
            SqCast.MsgPlr( player, "BanSyntax" );
            break;

            case "mute":
            SqCast.MsgPlr( player, "MuteSyntax" );
            break;

            case "unmute":
            SqCast.MsgPlr( player, "UnMuteSyntax" );
            break;

            case "spec":
            SqCast.MsgPlr( player, "SpecSynrtax" );
            break;

            case "ac":
            SqCast.MsgPlr( player, "AChatSyntax" );
            break;
            
            case "rpgban":
            SqCast.MsgPlr( player, "RPGBanSyntax" );
            break;

            case "unrpgban":
            SqCast.MsgPlr( player, "UnRPGBanSyntax" );
            break;
          
        }
		
    }
});