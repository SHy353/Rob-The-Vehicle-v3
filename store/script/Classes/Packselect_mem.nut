class CPackSelect extends CContext
{
	Background = null;

	Titlebar = null;
	Titletext = null;

	Body = null;

	PackSlot1 = null;
	PackSlot2 = null;
	PackSlot3 = null;
	PackSlot4 = null;
	PackSlot5 = null;
	PackSlot6 = null;
	PackSlot7 = null;

	PackSlotImg1 = null;
	PackSlotImg2 = null;
	PackSlotImg3 = null;
	PackSlotImg4 = null;
	PackSlotImg5 = null;
	PackSlotImg6 = null;
	PackSlotImg7 = null;

	PackInfo = null;
	PackWarning = null;
	PackClose = null;

	PackInfoText = null;
	PackWarningText = null;
	PackCloseText = null;

	isOpen = false;

	PackCloseKey = null;

	Background2 = null;
	Textline = null;

	function constructor( Key )
	{
		base.constructor();

		this.PackCloseKey = KeyBind( 0x42 );

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
		this.Body.SetTexture( "packbg.png" );
		this.Body.Colour = Colour( 255, 255, 255, 255 );
		this.center( this.Body );

	
	/*	this.Titletext = GUILabel();
		this.Titletext.TextColour = Colour( 255, 255, 255 );
		this.Titletext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Titletext.TextAlignment = GUI_ALIGN_CENTER;
		this.Titletext.FontFlags = GUI_FFLAG_BOLD;		
		this.Titletext.Text = "Select Pack";
		this.Titletext.FontSize = ( rel.X * 0.0109809663250366 );
		this.center( this.Titletext, this.Titlebar );

		this.Body = GUICanvas();
		this.Body.Pos = VectorScreen( rel.X * 0.2862371888726208, rel.Y *0.1744791666666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.5794270833333333 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );*/

		this.PackSlot1 = GUISprite();
		this.PackSlot1.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.2916666666666667 );
		this.PackSlot1.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot1.SetTexture( "packs/1.png" );
		this.PackSlot1.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlot2 = GUISprite();
		this.PackSlot2.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.36328125 );
		this.PackSlot2.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot2.SetTexture( "packs/2.png" );
		this.PackSlot2.Colour = Colour( 255, 255, 255, 255 );

		this.PackSlot3 = GUISprite();
		this.PackSlot3.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.4283854166666667 );
		this.PackSlot3.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot3.SetTexture( "packs/3.png" );
		this.PackSlot3.Colour = Colour( 255, 255, 255, 255 );

		this.PackSlot4 = GUISprite();
		this.PackSlot4.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.4934895833333333 );
		this.PackSlot4.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot4.SetTexture( "packs/4.png" );
		this.PackSlot4.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlot5 = GUISprite();
		this.PackSlot5.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.55859375 );
		this.PackSlot5.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot5.SetTexture( "packs/5.png" );
		this.PackSlot5.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlot6 = GUISprite();
		this.PackSlot6.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.6236979166666667 );
		this.PackSlot6.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot6.SetTexture( "packs/6.png" );
		this.PackSlot6.Colour = Colour( 255, 255, 255, 255 );

		this.PackSlot7 = GUISprite();
		this.PackSlot7.Pos = VectorScreen( rel.X * 0.3887262079062958, rel.Y * 0.6888020833333333 );
		this.PackSlot7.Size = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0651041666666667 );
		this.PackSlot7.SetTexture( "packs/7.png" );
		this.PackSlot7.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlotImg1 = GUISprite();
		this.PackSlotImg1.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.28125 );
		this.PackSlotImg1.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg1.SetTexture( "weps/python.png" );
		this.PackSlotImg1.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlotImg2 = GUISprite();
		this.PackSlotImg2.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.3463541666666667 );
		this.PackSlotImg2.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg2.SetTexture( "weps/ingrams.png" );
		this.PackSlotImg2.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlotImg3 = GUISprite();
		this.PackSlotImg3.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.42578125 );
		this.PackSlotImg3.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg3.SetTexture( "weps/mp5.png" );
		this.PackSlotImg3.Colour = Colour( 255, 255, 255, 255 );	

		this.PackSlotImg4 = GUISprite();
		this.PackSlotImg4.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.5026041666666667 );
		this.PackSlotImg4.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg4.SetTexture( "weps/colt.png" );
		this.PackSlotImg4.Colour = Colour( 255, 255, 255, 255 );
		
		this.PackSlotImg5 = GUISprite();
		this.PackSlotImg5.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.58203125 );
		this.PackSlotImg5.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg5.SetTexture( "weps/uzi.png" );
		this.PackSlotImg5.Colour = Colour( 255, 255, 255, 255 );		

		this.PackSlotImg6 = GUISprite();
		this.PackSlotImg6.Pos = VectorScreen( rel.X * 0.226207906295754, rel.Y * 0.6484375 );
		this.PackSlotImg6.Size = VectorScreen( rel.X * 0.1288433382137628, rel.Y * 0.1041666666666667 );
		this.PackSlotImg6.SetTexture( "weps/tec-9.png" );
		this.PackSlotImg6.Colour = Colour( 255, 255, 255, 255 );

		this.Background2 = GUISprite();
		this.Background2.SetTexture( "alert-bg.png" );
		this.Background2.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.8333333333333333 );
		this.Background2.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.1302083333333333 ); 
		this.Background2.Colour = Colour( 0, 0, 0, 255 );

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos = VectorScreen( 0, rel.Y * 0.0494791666666667 );		
	//	this.Textline.FontFlags = GUI_FFLAG_BOLD;
		this.Textline.Text = "Press [B] to close this menu.";
		this.Textline.FontName = "Bahnschrift";
		this.Textline.FontSize = ( rel.Y * 0.0175925925925926 );
		this.Background2.AddChild( this.Textline );
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.Background2.Size.X = this.getTextWidth( this.Textline ) * 2;
		this.centerX( this.Background2 );
		this.centerinchildX( this.Background2, this.Textline );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );

		this.PackSlot1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot6.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot7.RemoveFlags( GUI_FLAG_VISIBLE );

		this.PackSlotImg1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg6.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show()
	{
		this.Background.AddFlags( GUI_FLAG_VISIBLE );

	/*	this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );*/

		this.Body.AddFlags( GUI_FLAG_VISIBLE );

		this.PackSlot1.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot2.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot3.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot4.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot5.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot6.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlot7.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );

		this.PackSlotImg1.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlotImg2.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlotImg3.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlotImg4.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlotImg5.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );
		this.PackSlotImg6.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL );

		this.Background2.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

		this.isOpen = true;

		Hud.RemoveFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

		GUI.SetMouseEnabled( true );
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );

		this.PackSlot1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot6.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlot7.RemoveFlags( GUI_FLAG_VISIBLE );

		this.PackSlotImg1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg5.RemoveFlags( GUI_FLAG_VISIBLE );
		this.PackSlotImg6.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );

		this.isOpen = false;

		Hud.AddFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

		GUI.SetMouseEnabled( false );
	}

	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.PackSlot1:
			this.PackSlot1.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot2:
			this.PackSlot2.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot3:
			this.PackSlot3.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot4:
			this.PackSlot4.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot5:
			this.PackSlot5.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot6:
			this.PackSlot6.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlot7:
			this.PackSlot7.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlotImg1:
			this.PackSlotImg1.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlotImg2:
			this.PackSlotImg2.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlotImg3:
			this.PackSlotImg3.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;
			
			case this.PackSlotImg4:
			this.PackSlotImg4.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlotImg5:
			this.PackSlotImg5.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;

			case this.PackSlotImg6:
			this.PackSlotImg6.Colour = Colour( 255, 255, 26, 255 );

			Handler.Handlers.Player.playHoverSound();
			break;
		}
	}		


	function onElementHoverOut( element )
	{
		switch( element )
		{
			case this.PackSlot1:
			this.PackSlot1.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot2:
			this.PackSlot2.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot3:
			this.PackSlot3.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot4:
			this.PackSlot4.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot5:
			this.PackSlot5.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot6:
			this.PackSlot6.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlot7:
			this.PackSlot7.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlotImg1:
			this.PackSlotImg1.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlotImg2:
			this.PackSlotImg2.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlotImg3:
			this.PackSlotImg3.Colour = Colour( 255, 255, 255, 255 );
			break;
			case this.PackSlotImg4:
			this.PackSlotImg4.Colour = Colour( 255, 255, 255, 255 );
			break;
			case this.PackSlotImg5:
			this.PackSlotImg5.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.PackSlotImg6:
			this.PackSlotImg6.Colour = Colour( 255, 255, 255, 255 );
			break;
		}
	}		

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.PackSlot1:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "1" );
			Server.SendData( data );
			break;

			case this.PackSlot2:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "2" );
			Server.SendData( data );
			break;

			case this.PackSlot3:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "3" );
			Server.SendData( data );
			break;

			case this.PackSlot4:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "4" );
			Server.SendData( data );
			break;

			case this.PackSlot5:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "5" );
			Server.SendData( data );
			break;

			case this.PackSlot6:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "6" );
			Server.SendData( data );
			break;

			case this.PackSlot7:
			local data = Stream();
			data.WriteInt( 500 );
			data.WriteString( "7" );
			Server.SendData( data );
			break;

			case this.PackSlotImg1:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "18" );
			Server.SendData( data );
			break;

			case this.PackSlotImg2:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "24" );
			Server.SendData( data );
			break;

			case this.PackSlotImg3:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "25" );
			Server.SendData( data );
			break;

			case this.PackSlotImg4:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "17" );
			Server.SendData( data );
			break;

			case this.PackSlotImg5:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "23" );
			Server.SendData( data );
			break;

			case this.PackSlotImg6:
			local data = Stream();
			data.WriteInt( 900 );
			data.WriteString( "22" );
			Server.SendData( data );
			break;			
		}
	}		

	function onServerData( type, str )
	{
		switch( type )
		{
			case 500:
			this.Show();
			break;

			case 501:
			this.Hide();
			break;

			case 502:
			Handler.Handlers.Warning.Show( str );
			break;
		}
	}

	function onKeyBindDown( key )
	{
		switch( key )
		{
			case this.PackCloseKey:
			if( this.isOpen ) return this.Hide();
			else 
			{
				local data = Stream();
				data.WriteInt( 800 );
				Server.SendData( data );		

				return;
			}
			break;
		}
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