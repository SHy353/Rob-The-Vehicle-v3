
dofile( "Miscs/Context.nut" );
dofile( "Miscs/ContextManager.nut" );
dofile( "Miscs/Handler.nut" );
dofile( "Miscs/Misc.nut" );
dofile( "Miscs/Execute.nut" );
dofile( "Miscs/Timer.nut" );

dofile( "Events/Events.nut" );

dofile( "Classes/PlayerHud.nut" );
dofile( "Classes/Lobby_mem.nut" );
dofile( "Classes/Warning_mem.nut" );
dofile( "Classes/Player_mem.nut" );
dofile( "Classes/BaseVote_mem.nut" );
dofile( "Classes/Packselect_mem.nut" );
dofile( "Classes/Spectate_mem.nut" );
dofile( "Classes/PlayerTitle_mem.nut" );
dofile( "Classes/Login_mem.nut" );
dofile( "Classes/news_mem.nut" );
dofile( "Classes/Register_mem.nut" );
dofile( "Classes/Lobbyboard_mem.nut" );
dofile( "Classes/Lobbyboardblue_mem.nut" );
dofile( "Classes/Missile_mem.nut" );
dofile( "Classes/BaseVote3D_mem.nut" );
dofile( "Classes/Progressbar_mem.nut" );
//dofile( "Classes/OperationMission_mem.nut" );
dofile( "Classes/DoddleBoard_mem.nut" );
dofile( "Classes/Console_mem.nut" );
dofile( "Classes/Textdraw_mem.nut" );
//dofile( "Classes/LobbyTop_mem.nut" );
dofile( "Classes/Roundend_mem.nut" );
dofile( "Classes/Spawnscreen_mem.nut" );
dofile( "Classes/Spiller_mem.nut" );

seterrorhandler( errorHandling );

ContextManager <- CContextManager();
Handler <- CHandler();

//Handler.Create( "PlayerHud", CPlayerHud( "PlayerHud" ) );
Handler.Create( "Excute", CExecute( "CExecute" ) );
//Handler.Create( "Lobby", CLobby( "Lobby" ) );
Handler.Create( "Warning", CWarning( "Warning" ) );
Handler.Create( "Player", CPlayer( "Player" ) );
Handler.Create( "Basevote", CBasevote( "Basevote" ) );
Handler.Create( "Pack", CPackSelect( "Pack" ) );
Handler.Create( "Spectate", CSpectate( "Spectate" ) );
Handler.Create( "PlayerTitle", CPTitle( "PlayerTitle" ) );
Handler.Create( "Login", CLogin( "Login" ) );
Handler.Create( "News", CNews( "News" ) );
Handler.Create( "Register", CRegister( "Register" ) );
Handler.Create( "Lobbyboard", CLobbyboard( "Lobbyboard" ) );
Handler.Create( "Lobbyboardblue", CLobbyboardB( "Lobbyboardblue" ) );
Handler.Create( "Basevote3d", CBasevote3D( "Basevote3d" ) );
Handler.Create( "Progressbar", CProgress( "Progressbar" ) );
//Handler.Create( "OPMission", COPMission( "OPMission" ) );
Handler.Create( "Doddle", CDoddle( "Doddle" ) );
Handler.Create( "ConsoleChat", CChatbox( "ConsoleChat" ) );
Handler.Create( "Textdraw", CTextdraw( "Textdraw" ) );
//Handler.Create( "LobbyTop", CLobbyTop( "LobbyTop" ) );
Handler.Create( "Roundend", CRoundEnd( "Roundend" ) );
Handler.Create( "Spawnscreen", CSpawnScreen( "Spawnscreen" ) );
Handler.Create( "Spiller", CSpiller( "Spiller" ) );
