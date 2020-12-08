srand(accurate_seed());
SqMySQL <- MySQL;

Handler.Create( "Script", CScript( "Script" ) );
Handler.Create( "PlayerUID", CPlayerUID() );
Handler.Create( "Gameplay", CGameplay() );
Handler.Create( "Bases", CBases() );
Handler.Create( "PlayerAccount", CPlayerAccount() );
Handler.Create( "PlayerEvents", CPlayerEvents() );
Handler.Create( "Missile", CMissile() );
Handler.Create( "Matchlogger", CMatchLogger() );
Handler.Create( "Discord", CDiscord() );
Handler.Create( "Panel", CPanel() );
Handler.Create( "Operation", OperationWeek1() );
Handler.Create( "OperationW2", COperationWeek2() );
Handler.Create( "OperationW3", COperationWeek3() );
Handler.Create( "OperationW4", COperationWeek4() );
Handler.Create( "OperationW56", COperationWeek56() );
Handler.Create( "Objects", CObject() );