class CNews extends CContext
{
	Background = null;

	Titlebar = null;
	Titletext = null;

	Body = null;

	PackInfo = null;
	PackWarning = null;
	PackClose = null;

	PackInfoText = null;
	PackWarningText = null;
	PackCloseText = null;

	isOpen = false;

	PackCloseKey = null;

	Membox = null;
	Scrollbar = null;

	Background2 = null;
	Textline = null;

	function constructor( Key )
	{
		base.constructor();

		this.PackCloseKey = KeyBind( 0x58 );

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUICanvas();
		this.Background.Pos = VectorScreen( 0, 0 );
		this.Background.Size = VectorScreen( rel.X, rel.Y );
		this.Background.Colour = Colour( 0, 0, 0, 155 );

		this.Body = GUISprite();
		this.Body.Pos = VectorScreen( rel.X * 0.2862371888726208, rel.Y *0.1744791666666667 );
		this.Body.Size = VectorScreen( rel.X * 0.794289897510981, rel.Y * 0.7877604166666667 );
		this.Body.SetTexture( "news-bg.png" );
		this.Body.Colour = Colour( 255, 255, 255, 255 );
		this.center( this.Body );

	
		this.Membox = GUIMemobox();
		this.Body.AddChild( Membox );
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.AddFlags( GUI_FLAG_MEMOBOX_TOPBOTTOM | GUI_FLAG_SCROLLABLE | GUI_FLAG_SCROLLBAR_HORIZ );
		this.Membox.RemoveFlags( GUI_FLAG_BORDER );
		this.Membox.FontName = "Bahnschrift";
		this.Membox.TextPaddingTop = 10;
		this.Membox.TextPaddingBottom = 4;
		this.Membox.TextPaddingLeft = 10;
		this.Membox.TextPaddingRight = 10;
		this.Membox.FontSize = ( rel.Y * 0.0222222222222222 );
		this.Membox.Pos = VectorScreen( rel.X * 0.1380208333333333, rel.Y * 0.1657407407407407 );
		this.Membox.Size = VectorScreen( rel.X * 0.5088541666666667, rel.Y * 0.4148148148148148 );
		this.Membox.Colour = Colour( 43, 38, 38, 255 );
		this.Membox.TextColour = Colour( 246, 123, 78, 255 );

		this.Scrollbar = GUIScrollbar();
		this.Scrollbar.Colour = Colour( 246, 123, 78, 255 );
		this.Scrollbar.Size = VectorScreen( rel.X * 0.0119791666666667, rel.Y * 0.4148148148148148 );
	//	this.Membox.AddChild( Scrollbar );
		this.Scrollbar.Pos = VectorScreen( rel.X * 0.7494791666666667, rel.Y * 0.2731481481481481 );

		this.Background2 = GUISprite();
		this.Background2.SetTexture( "alert-bg.png" );
		this.Background2.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.7685185185185185 );
		this.Background2.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.1302083333333333 ); 
		this.Background2.Colour = Colour( 0, 0, 0, 255 );

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos = VectorScreen( 0, rel.Y * 0.0494791666666667 );		
	//	this.Textline.FontFlags = GUI_FFLAG_BOLD;
		this.Textline.Text = "Press [X] to close this menu.";
		this.Textline.FontName = "Bahnschrift";
		this.Textline.FontSize = ( rel.Y * 0.0175925925925926 );
		this.Background2.AddChild( this.Textline );
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.Background2.Size.X = this.getTextWidth( this.Textline ) * 2;
		this.centerX( this.Background2 );
		this.centerinchildX( this.Background2, this.Textline );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show()
	{
		this.Background.AddFlags( GUI_FLAG_VISIBLE );

	/*	this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );*/

		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Background2.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );

	//	this.Body.SendToTop();
		this.Scrollbar.SendToTop();
		
		this.isOpen = true;

		Hud.RemoveFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );
		
		this.Membox.DisplayPos = 1;

		this.Body.SendToTop();
		this.Scrollbar.SendToTop();


		this.Membox.AddLine( "" );
		this.Membox.AddLine( " " );
		this.Membox.AddLine( @"
		
		Update 8/6/2020
		
		[New content]
		- Taunt
		-- killer taunt message will be show to victim when killed
		-- /showtaunt to toggle showing killer taunt message
		-- /taunttext to change taunt message, use 'disable' to disable taunt message
		- Added new mvp sound 'Vi sitter i Ventrilo och Spelar DotA' (/changemvpsound 10)

		[Gameplay]
		- Remove 3d arrow when player enter target vehicle
		- Team pack notice will shown when player taking/changing pack

		[Command]
		- Added /packcount 
		- Added /love
		- Added /publicchat, if disabled public chat will not show to player
		- Added /jitterlimit, admin+ can edit its value
		- /cum now have optional parameter
		- /changemvpsound now will play sound after selected mvp sound

		[Other] 
		- Readded new spawn screen
		- Added sound effect on some UIs
		- Extended doodle board to 20 lines, improved doodle code
		- Added referee skin into spawn class  (only in legacy spawn class)
		- Added some female skins into spawn class (only in legacy spawn class)
		- Fixed public/team chat sometimes not showing to some players
		- Changed admin action message color" );

				
		local getHash = Timer.Create( this, function() 
		{
			GUI.SetMouseEnabled( true );
		}, 1500, 1 );

	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

		this.isOpen = false;

		Hud.AddFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

		GUI.SetMouseEnabled( false );
	}

	function onElementHoverOver( element )
	{
		switch( element )
		{
		}
	}		


	function onElementHoverOut( element )
	{
		switch( element )
		{
		}
	}		

	function onElementRelease( element, x, y )
	{
		if( this.isOpen ) GUI.SetFocusedElement( this.Scrollbar );
	}		

	function onServerData( type, str )
	{
		switch( type )
		{
			case 2300:
			this.Show();
			break;

			case 2301:
			this.Hide();
			break;
		}
	}

	function onKeyBindDown( key )
	{
		switch( key )
		{
			case this.PackCloseKey:
			if( this.isOpen )
			{
			 	this.Hide();

				local data = Stream();
				data.WriteInt( 2300 );
				Server.SendData( data );		

				return;
			}
			break;
		}
	}

	function onScrollbarScroll( scrollbar, position, change )
	{
		if( scrollbar == this.Scrollbar ) this.Membox.DisplayPos = 1 - position;
	}

	function setText( text )
	{
		this.PackInfoText.Text = text;

		this.center( this.PackInfoText, this.PackInfo );	
	}

	function setWarning( text )
	{
		this.PackWarningText.Text = text;

		this.center( this.PackWarningText, this.PackWarning );	
	}

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

	function centerinchildX( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );

		child.Pos.X = x;
	}

	function getTextWidth( element ) 
	{
		local size = element.Size;
		return size.X;
	}

}