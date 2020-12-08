class CPlayerHud extends CContext
{
	Background	= null;

	HealthIcon	= null;
	HealthBar	= null;
	HealthValue = null;

	ArmourIcon	= null;
	ArmourBar	= null;
	ArmourValue = null;

	Countdown	= null;
	CountdownText = null;

	VersionText	= null;

	LobbyLogo	= null;
	DonatorT	= null;
	Donor 		= null;

	LobbyText   = null;

	F3Key 		= null;
	IsHidden 	= false;

	a = null;
	b = null;
	c = null;
	d = null;
	d1 = null;
	d2 = null;
	d3 = null;
	text1 = null;
	tt = null;
	text2 = null;
	text3 = null;

	function constructor( Key )
	{
		base.constructor();

		this.LobbyText =
		{
			"Regular world":
			{
				"Element": "xxx",
				"Pos": Vector( 1375.76, 362.202, 27.9756 ),
			},

			"Use /spec to spectate player":
			{
				"Pos": Vector( 1392.466919,366.975861,27.975609 ),
				"Element": "xxx",
			},

			"Shop":
			{
				"Pos": Vector( 1383.369019,378.871368,27.975609 ),
				"Element": "xxx",				
			},

			"Use /buycoin to buy Vice Coin":
			{
				"Element": "xxx",
				"Pos": Vector( 1370.020020,377.135803,27.975609 ),				
			},

			"Cash world":
			{
				"Element": "xxx",
				"Pos": Vector( 1381.859131,363.038330,27.975609 ),				
			},

			"Staff Room":
			{
				"Element": "xxx",
				"Pos": Vector( 1384.330811,363.038330,27.975609 ),				
			}

			"Death match":
			{
				"Element": "xxx",
				"Pos": Vector( 1378.702881,363.178894,27.975609 ),				
			},

			"Hall of fame":
			{
				"Element": "xxx",
				"Pos": Vector( 1368.117798,362.119232,27.975609 ),				
			},
		}
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

	/*	this.a = GUICanvas();
		this.a.Pos = VectorScreen( rel.X * 0.3333333333333333, rel.Y * 0.4666666666666667 );
		this.a.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.1622222222222222 ); 
		this.a.Colour = Colour( 42, 44, 49, 255 );

		this.b = GUICanvas();
		this.a.AddChild( b );
		this.b.Pos = VectorScreen( rel.X * 0.0166666666666667, rel.Y * 0.0222222222222222 );
		this.b.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		this.b.Colour = Colour( 0, 255, 0, 255 );

		this.d = GUICanvas();
		this.a.AddChild( d );
		this.d.Pos = VectorScreen( rel.X * 0.1166666666666667, rel.Y * 0.0222222222222222 );
		this.d.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		this.d.Colour = Colour( 0, 255, 0, 255 );

		this.d1 = GUICanvas();
		this.a.AddChild( d1 );
		this.d1.Pos = VectorScreen( rel.X * 0.2166666666666667, rel.Y * 0.0222222222222222 );
		this.d1.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		this.d1.Colour = Colour( 0, 255, 0, 255 );

		this.d2 = GUICanvas();
		this.a.AddChild( d2 );
		this.d2.Pos = VectorScreen( rel.X * 0.3166666666666667, rel.Y * 0.0222222222222222 );
		this.d2.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		this.d2.Colour = Colour( 0, 255, 0, 255 );

		this.d3 = GUICanvas();
		this.a.AddChild( d3 );
		this.d3.Pos = VectorScreen( rel.X * 0.4166666666666667, rel.Y * 0.0222222222222222 );
		this.d3.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		this.d3.Colour = Colour( 0, 255, 0, 255 );

		this.c = GUICanvas();
		this.a.AddChild( c );
		this.c.Pos =  VectorScreen( 0, rel.Y * 0.1666666666666667 );
		this.c.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.0666666666666667 ); 
		this.c.Colour = Colour( 42, 44, 49, 255 );

		this.text1 = GUILabel();
		this.c.AddChild( text1 );
		this.text1.TextColour = Colour( 255, 0, 255 );
		this.text1.Pos =  VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0111111111111111 );		
		this.text1.TextAlignment = GUI_ALIGN_CENTER;		
		this.text1.Text = "i love xxcaraxx.";
		this.text1.FontSize = ( rel.X * 0.0166666666666667 );

		this.tt = GUICanvas();
		this.a.AddChild( tt );
		this.tt.Pos = VectorScreen( 0, rel.Y * -0.0755555555555556 );
		this.tt.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.0666666666666667 ); 
		this.tt.Colour = Colour( 42, 44, 49, 255 );

		this.text2 = GUILabel();
		this.tt.AddChild( text2 );
		this.text2.TextColour = Colour( 255, 0, 255 );
		this.text2.Pos =  VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0111111111111111 );		
		this.text2.TextAlignment = GUI_ALIGN_CENTER;		
		this.text2.Text = "Pack Selection";
		this.text2.FontSize = ( rel.X * 0.0166666666666667 );
*/


	/*	this.a = GUIWindow();
		this.a.Pos = VectorScreen( rel.X * 0.3666666666666667, rel.Y * 0.7333333333333333 );
		this.a.Size = VectorScreen( rel.X * 0.3333333333333333, rel.Y * 0.1777777777777778 ); 
		this.a.Colour = Colour( 42, 44, 49, 255 );
		this.a.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );

		this.text1 = GUILabel();
		this.a.AddChild( text1 );
		this.text1.TextColour = Colour( 255, 0, 0 );
		this.text1.Pos =  VectorScreen( rel.X * 0.1166666666666667, rel.Y * 0.0111111111111111 );		
		this.text1.TextAlignment = GUI_ALIGN_CENTER;		
		this.text1.Text = "Alert";
		this.text1.FontFlags = GUI_FFLAG_BOLD;
		this.text1.FontSize = ( rel.X * 0.025 );

		this.text2 = GUILabel();
		this.a.AddChild( text2 );
		this.text2.TextColour = Colour( 255, 255, 255 );
		this.text2.Pos =  VectorScreen( rel.X * 0.0333333333333333, rel.Y * 0.0666666666666667 );		
		this.text2.TextAlignment = GUI_ALIGN_CENTER;		
		this.text2.Text = "[SS]ELK has steal your panty,";
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );

		this.text3 = GUILabel();
		this.a.AddChild( text3 );
		this.text3.TextColour = Colour( 255, 255, 255 );
		this.text3.Pos =  VectorScreen( rel.X * 0.0333333333333333, rel.Y * 0.1111111111111111 );		
		this.text3.TextAlignment = GUI_ALIGN_CENTER;		
		this.text3.Text = "Get it back before it too late.";
		this.text3.FontSize = ( rel.X * 0.0183333333333333 );*/

	/*	this.a = GUICanvas();
		this.a.Pos = VectorScreen( rel.X * 0.05, rel.Y * 0.9333333333333333 );
		this.a.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0555555555555556 ); 
		this.a.Colour = Colour( 42, 44, 49, 255 );
	
		this.text1 = GUILabel();
		this.a.AddChild( text1 );
		this.text1.TextColour = Colour( 255, 255, 255 );
		this.text1.Pos =  VectorScreen( rel.X * 0.0166666666666667, rel.Y * 0.0066666666666667 );		
		this.text1.TextAlignment = GUI_ALIGN_LEFT;		
		this.text1.Text = "Time Left: ";
		this.text1.FontSize = ( rel.X * 0.0183333333333333 );

		this.text2 = GUILabel();
		this.a.AddChild( text2 );
		this.text2.TextColour = Colour( 255, 255, 255 );
		this.text2.Pos =  VectorScreen( rel.X * 0.1083333333333333, rel.Y * 0.0066666666666667 );		
		this.text2.TextAlignment = GUI_ALIGN_LEFT;		
		this.text2.Text = "50:00";
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );*/

		this.a = GUICanvas();
		this.a.Pos = VectorScreen( rel.X * 0.3, rel.Y * 0.2666666666666667 );
		this.a.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );
		this.a.Colour = Colour( 255, 0, 0, 255 );

		this.b = GUICanvas();
		this.b.Pos = VectorScreen( rel.X * 0.55, rel.Y * 0.2666666666666667 );
		this.b.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );
		this.b.Colour = Colour( 0, 0, 255, 255 );

		this.text1 = GUILabel();
		this.text1.TextColour = Colour( 255, 255, 255 );
		this.text1.Pos =  VectorScreen( rel.X * 0.4666666666666667, rel.Y * 0.7555555555555556 );		
		this.text1.TextAlignment = GUI_ALIGN_CENTER;		
		this.text1.Text = "Team is full.";
		this.text1.FontSize = ( rel.X * 0.02 );

		this.c = GUICanvas();
		this.c.Pos = VectorScreen( rel.X * 0.7166666666666667, rel.Y * 0.8666666666666667 );
		this.c.Size = VectorScreen( rel.X * 0.25, rel.Y * 0.0888888888888889 );
		this.c.Colour = Colour( 0, 255, 0, 255 );

		this.text2 = GUILabel();
		this.c.AddChild( text2 );
		this.text2.TextColour = Colour( 255, 255, 255 );
		this.text2.Pos =  VectorScreen( rel.X * 0.075, rel.Y * 0.0222222222222222 );		
		this.text2.TextAlignment = GUI_ALIGN_CENTER;		
		this.text2.Text = "Spectate";
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );

	}

	function onScriptProcess() 
	{
	}

	function LoadLobbyText( str )
	{
		foreach( index, value in this.LobbyText )
		{
			value.Element = GUILabel();
			value.Element.TextColour = Colour( 255, 0, 255 );
			value.Element.FontSize = 12;
			value.Element.TextAlignment = GUI_ALIGN_CENTER;
		//	value.Element.FontFlags = GUI_FFLAG_BOLD// | GUI_FFLAG_OUTLINE;
			value.Element.Text = index;

	//		if( index == "DMArena Entrance" ) value.Element.Text = "DM Arena: " + str;
		}
	}

	function RemoveLobbyText()
	{
		foreach( index, value in this.LobbyText )
		{
			value.Element = null;
			value.Element = "xxx";
		}
	}

	function onServerData( type, str )
	{

	}

	function onScriptLoad()
	{
		this.Load();
	
	   local data = Stream();

		data.WriteInt( 401 );
		data.WriteString( "" );
		Server.SendData( data );
	}

	function onKeyBindDown( key )
	{

	}

	function onPlayerShoot( player, weapon, hitEntity, hitPosition )
	{	
    	local p = World.FindLocalPlayer();
   		if ( p.ID == player.ID ) 
   		{
   			if( hitEntity && weapon == 109 && hitEntity.Type == OBJ_BUILDING ) Console.Print( format( "[#00BCD4]** Object model id[#ffffff] %d", hitEntity.ModelIndex ) );

   			if( hitEntity && hitEntity.Type == OBJ_PLAYER )
   			{
   				local data = Stream();

				data.WriteInt( 400 );
				data.WriteString( hitEntity.ID );
				Server.SendData( data );
			}
		}
	}

	function onGameResize(width, height) 
	{
		local rel = GUI.GetScreenSize();

	/*	this.a.Pos = VectorScreen( rel.X * 0.3333333333333333, rel.Y * 0.4666666666666667 );
		this.a.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.1622222222222222 ); 

		this.b.Pos = VectorScreen( rel.X * 0.0166666666666667, rel.Y * 0.0222222222222222 );
		this.b.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );

		this.c.Pos =  VectorScreen( 0, rel.Y * 0.1666666666666667 );
		this.c.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.0666666666666667 ); 

		this.text1.Pos =  VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0111111111111111 );	
		this.text1.FontSize = ( rel.X * 0.0166666666666667 );

		this.d.Pos = VectorScreen( rel.X * 0.1166666666666667, rel.Y * 0.0222222222222222 );
		this.d.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		
		this.d1.Pos = VectorScreen( rel.X * 0.2166666666666667, rel.Y * 0.0222222222222222 );
		this.d1.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		
		this.d2.Pos = VectorScreen( rel.X * 0.3166666666666667, rel.Y * 0.0222222222222222 );
		this.d2.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );
		
		this.d3.Pos = VectorScreen( rel.X * 0.4166666666666667, rel.Y * 0.0222222222222222 );
		this.d3.Size = VectorScreen( rel.X * 0.0833333333333333, rel.Y * 0.1111111111111111 );

		this.tt.Pos = VectorScreen( 0, rel.Y * -0.0755555555555556 );
		this.tt.Size = VectorScreen( rel.X * 0.5183333333333333, rel.Y * 0.0666666666666667 ); 

		this.text2.Pos =  VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0111111111111111 );	
		this.text2.FontSize = ( rel.X * 0.0166666666666667 );*/

	/*	this.a.Pos = VectorScreen( rel.X * 0.3666666666666667, rel.Y * 0.7333333333333333 );
		this.a.Size = VectorScreen( rel.X * 0.3333333333333333, rel.Y * 0.1777777777777778 ); 

		this.text1.Pos =  VectorScreen( rel.X * 0.1166666666666667, rel.Y * 0.0111111111111111 );		
		this.text1.FontSize = ( rel.X * 0.025 );

		this.text2.Pos =  VectorScreen( rel.X * 0.0333333333333333, rel.Y * 0.0666666666666667 );		
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );

		this.text3.Pos =  VectorScreen( rel.X * 0.0333333333333333, rel.Y * 0.1111111111111111 );		
		this.text3.FontSize = ( rel.X * 0.0183333333333333 );*/

	/*	this.a.Pos = VectorScreen( rel.X * 0.05, rel.Y * 0.9333333333333333 );
		this.a.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.0555555555555556 ); 
	
		this.text1.Pos =  VectorScreen( rel.X * 0.0166666666666667, 0.0066666666666667 );		
		this.text1.FontSize = ( rel.X * 0.0183333333333333 );

		this.text2.Pos =  VectorScreen( rel.X * 0.1083333333333333, 0.0066666666666667 );		
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );*/

		this.a.Pos = VectorScreen( rel.X * 0.3, rel.Y * 0.2666666666666667 );
		this.a.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );

		this.b.Pos = VectorScreen( rel.X * 0.55, rel.Y * 0.2666666666666667 );
		this.b.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );

		this.text1.Pos =  VectorScreen( rel.X * 0.4666666666666667, rel.Y * 0.7555555555555556 );		
		this.text1.FontSize = ( rel.X * 0.02 );

		this.c.Pos = VectorScreen( rel.X * 0.7166666666666667, rel.Y * 0.8666666666666667 );
		this.c.Size = VectorScreen( rel.X * 0.25, rel.Y * 0.0888888888888889 );
		this.c.Colour = Colour( 0, 255, 0, 255 );

		this.text2.Pos =  VectorScreen( rel.X * 0.075, rel.Y * 0.0222222222222222 );		
		this.text2.FontSize = ( rel.X * 0.0183333333333333 );


	 }
}