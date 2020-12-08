class CBasevote extends CContext
{

	Background = null;

	Titlebar = null;

	Box1 = null;
	Box1Text = null;
	Box1Text2 = null;
	Box1Count = null;

	Box2 = null;
	Box2Text = null;
	Box2Text2 = null;
	Box2Count = null;

	Box3 = null;
	Box3Text = null;
	Box3Text2 = null;
	Box3Count = null;

	Box4 = null;
	Box4Text = null;
	Box4Text2 = null;
	Box4Count = null;

	Box5 = null;
	Box5Text = null;
	Box5Count = null;

	Box6 = null;
	Box6Text = null;
	Box6Count = null;

	MouseEnabled = false;

	Background2 = null;
	Textline = null;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUICanvas();
		this.Background.Pos = VectorScreen( 0, 0 );
		this.Background.Size = VectorScreen( rel.X, rel.Y );
		this.Background.Colour = Colour( 0, 0, 0, 155 );

		this.Titlebar = GUISprite();
		this.Titlebar.SetTexture( "votebase_ui.png" );
		this.Titlebar.Size = VectorScreen( rel.X * 0.794289897510981, rel.Y * 0.7877604166666667 );
		this.center( this.Titlebar );

		this.Box1 = GUICanvas();
		this.Box1.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box1.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.2604166666666667 );
		this.Box1.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box1.Colour = Colour( 92, 66, 66, 0 );		

		this.Box1Text = GUILabel();
		this.Box1Text.TextColour = Colour( 246, 123, 78 );
		this.Box1Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box1Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box1Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box1Text.FontName = "Bahnschrift";	
		this.Box1Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box1Text.Text = "a";
		this.Box1.AddChild( this.Box1Text );

		this.Box1Count = GUILabel();
		this.Box1Count.TextColour = Colour( 0, 0, 0 );
		this.Box1Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.26953125 );		
		this.Box1Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box1Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box1Count.FontName = "Bahnschrift";	
		this.Box1Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box1Count.Text = "55";

		this.Box2 = GUICanvas();
		this.Box2.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box2.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.3385416666666667 );
		this.Box2.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box2.Colour = Colour( 92, 66, 66, 0 );		

		this.Box2Text = GUILabel();
		this.Box2Text.TextColour = Colour( 246, 123, 78 );
		this.Box2Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box2Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box2Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box2Text.FontName = "Bahnschrift";	
		this.Box2Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box2Text.Text = "xxxd";
		this.Box2.AddChild( this.Box2Text );

		this.Box2Count = GUILabel();
		this.Box2Count.TextColour = Colour( 0, 0, 0 );
		this.Box2Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.34765625 );		
		this.Box2Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box2Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box2Count.FontName = "Bahnschrift";	
		this.Box2Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box2Count.Text = "24";

		this.Box3 = GUICanvas();
		this.Box3.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box3.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.4166666666666667 );
		this.Box3.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box3.Colour = Colour( 92, 66, 66, 0 );		

		this.Box3Text = GUILabel();
		this.Box3Text.TextColour = Colour( 246, 123, 78 );
		this.Box3Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box3Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box3Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box3Text.FontName = "Bahnschrift";	
		this.Box3Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box3Text.Text = "aaaaa";
		this.Box3.AddChild( this.Box3Text );

		this.Box3Count = GUILabel();
		this.Box3Count.TextColour = Colour( 0, 0, 0 );
		this.Box3Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.4283854166666667 );		
		this.Box3Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box3Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box3Count.FontName = "Bahnschrift";	
		this.Box3Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box3Count.Text = "24";

		this.Box4 = GUICanvas();
		this.Box4.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box4.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.4947916666666667 );
		this.Box4.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box4.Colour = Colour( 92, 66, 66, 0 );		

		this.Box4Text = GUILabel();
		this.Box4Text.TextColour = Colour( 246, 123, 78 );
		this.Box4Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box4Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box4Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box4Text.FontName = "Bahnschrift";	
		this.Box4Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box4Text.Text = "aweaweaweawr";
		this.Box4.AddChild( this.Box4Text );

		this.Box4Count = GUILabel();
		this.Box4Count.TextColour = Colour( 0, 0, 0 );
		this.Box4Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.50390625 );		
		this.Box4Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box4Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box4Count.FontName = "Bahnschrift";	
		this.Box4Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box4Count.Text = "24";

		this.Box5 = GUICanvas();
		this.Box5.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box5.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.5729166666666667 );
		this.Box5.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box5.Colour = Colour( 92, 66, 66, 0 );		

		this.Box5Text = GUILabel();
		this.Box5Text.TextColour = Colour( 246, 123, 78 );
		this.Box5Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box5Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box5Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box5Text.FontName = "Bahnschrift";	
		this.Box5Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box5Text.Text = "gsdgsgsg";
		this.Box5.AddChild( this.Box5Text );

		this.Box5Count = GUILabel();
		this.Box5Count.TextColour = Colour( 0, 0, 0 );
		this.Box5Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.58203125 );		
		this.Box5Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box5Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box5Count.FontName = "Bahnschrift";	
		this.Box5Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box5Count.Text = "24";

		this.Box6 = GUICanvas();
		this.Box6.AddFlags( GUI_FLAG_MOUSECTRL );
		this.Box6.Pos = VectorScreen( rel.X * 0.314787701317716, rel.Y * 0.6510416666666667 );
		this.Box6.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.0520833333333333 );
		this.Box6.Colour = Colour( 92, 66, 66, 0 );		

		this.Box6Text = GUILabel();
		this.Box6Text.TextColour = Colour( 246, 123, 78 );
		this.Box6Text.Pos =  VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.2669270833333333 );		
		this.Box6Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box6Text.FontFlags = GUI_FFLAG_BOLD;	
		this.Box6Text.FontName = "Bahnschrift";	
		this.Box6Text.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box6Text.Text = "XXXXXXX";
		this.Box6.AddChild( this.Box6Text );

		this.Box6Count = GUILabel();
		this.Box6Count.TextColour = Colour( 0, 0, 0 );
		this.Box6Count.Pos =  VectorScreen( rel.X * 0.6881405563689605, rel.Y * 0.6640625 );		
		this.Box6Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box6Count.FontFlags = GUI_FFLAG_BOLD;	
		this.Box6Count.FontName = "Bahnschrift";	
		this.Box6Count.FontSize = ( rel.X * 0.0124450951683748 );
		this.Box6Count.Text = "24";

		this.Background2 = GUISprite();
		this.Background2.SetTexture( "alert-bg.png" );
		this.Background2.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.8333333333333333 );
		this.Background2.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.1302083333333333 ); 
		this.Background2.Colour = Colour( 0, 0, 0, 255 );

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos = VectorScreen( 0, rel.Y * 0.0494791666666667 );		
	//	this.Textline.FontFlags = GUI_FFLAG_BOLD;
		this.Textline.Text = "Use [1] [2] [3] [4] [5] [6] keys to vote.";
		this.Textline.FontName = "Bahnschrift";
		this.Textline.FontSize = ( rel.Y * 0.0175925925925926 );
		this.Background2.AddChild( this.Textline );
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.Background2.Size.X = this.getTextWidth( this.Textline ) * 2;
		this.centerX( this.Background2 );
		this.centerinchildX( this.Background2, this.Textline );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show( base1, base2, base3, base4, base5, base6 )
	{
	/*	this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Box1.AddFlags( GUI_FLAG_VISIBLE );
		this.Box1Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box1Count.AddFlags( GUI_FLAG_VISIBLE );
		this.Box2.AddFlags( GUI_FLAG_VISIBLE );
		this.Box2Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box2Count.AddFlags( GUI_FLAG_VISIBLE );
		this.Box3.AddFlags( GUI_FLAG_VISIBLE );
		this.Box3Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box3Count.AddFlags( GUI_FLAG_VISIBLE );
		this.Box4.AddFlags( GUI_FLAG_VISIBLE );
		this.Box4Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box4Count.AddFlags( GUI_FLAG_VISIBLE );
		this.Box5.AddFlags( GUI_FLAG_VISIBLE );
		this.Box5Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box5Count.AddFlags( GUI_FLAG_VISIBLE );
		this.Box6.AddFlags( GUI_FLAG_VISIBLE );
		this.Box6Text.AddFlags( GUI_FLAG_VISIBLE );
		this.Box6Count.AddFlags( GUI_FLAG_VISIBLE );*/
		this.Background2.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

	/*	this.Box1Text.Text = base1.toupper();
		this.Box2Text.Text = base2.toupper();
		this.Box3Text.Text = base3.toupper();
		this.Box4Text.Text = base4.toupper();
		this.Box5Text.Text = base5.toupper();
		this.Box6Text.Text = base6.toupper();

		this.Box1Count.Text = 0;
		this.Box2Count.Text = 0;
		this.Box3Count.Text = 0;
		this.Box4Count.Text = 0;
		this.Box5Count.Text = 0;
		this.Box6Count.Text = 0;

		Hud.RemoveFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

	//	GUI.SetMouseEnabled( true );
		this.MouseEnabled = true;

		this.centerinchild( this.Box1, this.Box1Text );
		this.centerinchild( this.Box2, this.Box2Text );
		this.centerinchild( this.Box3, this.Box3Text );
		this.centerinchild( this.Box4, this.Box4Text );
		this.centerinchild( this.Box5, this.Box5Text );
		this.centerinchild( this.Box6, this.Box6Text );*/
	}

	function Hide()
	{
		/*this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Count.RemoveFlags( GUI_FLAG_VISIBLE );*/
		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );

	/*	this.Box1Text.TextColour = Colour( 246, 123, 78 );
		this.Box2Text.TextColour = Colour( 246, 123, 78 );
		this.Box3Text.TextColour = Colour( 246, 123, 78 );
		this.Box4Text.TextColour = Colour( 246, 123, 78 );
		this.Box5Text.TextColour = Colour( 246, 123, 78 );
		this.Box6Text.TextColour = Colour( 246, 123, 78 );
		this.Box1Count.TextColour = Colour( 0, 0, 0 );
		this.Box2Count.TextColour = Colour( 0, 0, 0 );
		this.Box3Count.TextColour = Colour( 0, 0, 0 );
		this.Box4Count.TextColour = Colour( 0, 0, 0 );
		this.Box5Count.TextColour = Colour( 0, 0, 0 );
		this.Box6Count.TextColour = Colour( 0, 0, 0 );

		Hud.AddFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

	//	GUI.SetMouseEnabled( false );
		this.MouseEnabled = false;*/
	}

	function UpdateVote( base1, base2, base3, base4, base5, base6 )
	{
		this.Box1Count.Text = base1;
		this.Box2Count.Text = base2;
		this.Box3Count.Text = base3;
		this.Box4Count.Text = base4;
		this.Box5Count.Text = base5;
		this.Box6Count.Text = base6;
	}

/*	function onElementHoverOver( element )
	{
		if( this.MouseEnabled )
		{
			switch( element )
			{
				case this.Box1:
				case this.Box1Text:
				this.Box1Text.TextColour = Colour( 255, 255, 26 );
				break;

				case this.Box2:
				case this.Box2Text:
				this.Box2Text.TextColour = Colour( 255, 255, 26 );
				break;

				case this.Box3:
				case this.Box3Text:
				this.Box3Text.TextColour = Colour( 255, 255, 26 );
				break;

				case this.Box4:
				case this.Box4Text:
				this.Box4Text.TextColour = Colour( 255, 255, 26 );
				break;

				case this.Box5:
				case this.Box5Text:
				this.Box5Text.TextColour = Colour( 255, 255, 26 );
				break;

				case this.Box6:
				case this.Box6Text:
				this.Box6Text.TextColour = Colour( 255, 255, 26 );
				break;
			}
		}
	}

	function onElementHoverOut( element )
	{
		if( this.MouseEnabled )
		{
			switch( element )
			{
				case this.Box1:
				case this.Box1Text:
				this.Box1Text.TextColour = Colour( 246, 123, 78 );
				break;

				case this.Box2:
				case this.Box2Text:
				this.Box2Text.TextColour = Colour( 246, 123, 78 );
				break;

				case this.Box3:
				case this.Box3Text:
				this.Box3Text.TextColour = Colour( 246, 123, 78 );
				break;

				case this.Box4:
				case this.Box4Text:
				this.Box4Text.TextColour = Colour( 246, 123, 78 );
				break;

				case this.Box5:
				case this.Box5Text:
				this.Box5Text.TextColour = Colour( 246, 123, 78 );
				break;

				case this.Box6:
				case this.Box6Text:
				this.Box6Text.TextColour = Colour( 246, 123, 78 );
				break;
			}
		}
	}
*/
	function onServerData( type, str )
	{
		switch( type )
		{
			case 300:
			local getVote = split( str, "," );

			this.UpdateVote( getVote[0], getVote[1], getVote[2], getVote[3], getVote[4], getVote[5] );
			break;

			case 301:
			local getVote = split( str, "," );

			this.Show( getVote[0], getVote[1], getVote[2], getVote[3], getVote[4], getVote[5] );
			break;

			case 302:
			this.Hide();
			break;
		}
	}

/*	function onElementRelease( element, x, y )
	{
		if( this.MouseEnabled )
		{
			switch( element )
			{
				case this.Box1:
				case this.Box1Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "0" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box1Text.TextColour = Colour( 255, 255, 26 );
				this.Box1Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box1Text.TextColour = Colour( 255, 255, 26 );
				this.Box1.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box1Text.RemoveFlags( GUI_FLAG_MOUSECTRL );

				break;

				case this.Box2:
				case this.Box2Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "1" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box2Text.TextColour = Colour( 255, 255, 26 );
				this.Box2Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box2Text.TextColour = Colour( 255, 255, 26 );
				this.Box2.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box2Text.RemoveFlags( GUI_FLAG_MOUSECTRL );			
				break;

				case this.Box3:
				case this.Box3Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "2" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box3Text.TextColour = Colour( 255, 255, 26 );
				this.Box3Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box3Text.TextColour = Colour( 255, 255, 26 );
				this.Box3.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box3Text.RemoveFlags( GUI_FLAG_MOUSECTRL );
				break;

				case this.Box4:
				case this.Box4Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "3" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box4Text.TextColour = Colour( 255, 255, 26 );
				this.Box4Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box4Text.TextColour = Colour( 255, 255, 26 );
				this.Box4.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box4Text.RemoveFlags( GUI_FLAG_MOUSECTRL );			
				break;

				case this.Box5:
				case this.Box5Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "4" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box5Text.TextColour = Colour( 255, 255, 26 );
				this.Box5Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box5Text.TextColour = Colour( 255, 255, 26 );
				this.Box5.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box5Text.RemoveFlags( GUI_FLAG_MOUSECTRL );			
				break;
				
				case this.Box6:
				case this.Box6Text:
				local data = Stream();
				data.WriteInt( 200 );
				data.WriteString( "5" );
				Server.SendData( data );

				GUI.SetMouseEnabled( false );
				this.Hide();

				this.Box6Text.TextColour = Colour( 255, 255, 26 );
				this.Box6Count.TextColour = Colour( 255, 255, 26 );
				Handler.Handlers.Basevote3d.Box6Text.TextColour = Colour( 255, 255, 26 );
				this.Box6.RemoveFlags( GUI_FLAG_MOUSECTRL );
				this.Box6Text.RemoveFlags( GUI_FLAG_MOUSECTRL );			
				break;
			}
		}
	}
*/
	function center( instance, instance2 = null )
	{
		if( !instance2 ) 
		{
			local size = instance.Size;
			local screen = ::GUI.GetScreenSize();
			local x = (screen.X/2)-(size.X/2);
			local y = (screen.Y/2)-(size.Y/2);
			
			instance.Position = ::VectorScreen(x, y);
		}

		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X)/2;
			instance.Position.Y = (position.Y + (position.Y + size.Y) - instance.Size.Y)/2;
		}
	}

	function centerX( instance, instance2 = null )
	{
		if( !instance2 ) 
		{
			local size = instance.Size;
			local screen = ::GUI.GetScreenSize();
			local x = (screen.X/2)-(size.X/2);
			
			instance.Position.X = x;
		} 

		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X)/2;
		}
	}

	function left( instance, instance2 = null ) 
	{
		if( !instance2 ) instance.Position.X = 0;
		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = position.X;
		}
	}

	function centerinchild( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );
		local y = ( parentElement.Y/2 )-( childElement.Y/2 );

		child.Pos = ::VectorScreen( x, y );
	}

	function getTextWidth( element ) 
	{
		local size = element.Size;
		return size.X;
	}

	function centerinchildX( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );

		child.Pos.X = x;
	}

}