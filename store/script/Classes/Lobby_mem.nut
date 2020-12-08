class CLobby extends CContext
{
	RedSprite = null;
	BlueSprite = null;

	Warning = null;

	SpectateButton = null;
	SpectateText = null;

	Background = null;

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

		this.RedSprite = GUICanvas();
		this.RedSprite.Pos = VectorScreen( rel.X * 0.3, rel.Y * 0.2666666666666667 );
		this.RedSprite.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );
		this.RedSprite.Colour = Colour( 255, 0, 0, 255 );
		this.RedSprite.AddFlags( GUI_FLAG_MOUSECTRL );

		this.BlueSprite = GUICanvas();
		this.BlueSprite.Pos = VectorScreen( rel.X * 0.55, rel.Y * 0.2666666666666667 );
		this.BlueSprite.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );
		this.BlueSprite.Colour = Colour( 0, 0, 255, 255 );
		this.BlueSprite.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Warning = GUILabel();
		this.Warning.TextColour = Colour( 255, 255, 255 );
		this.Warning.Pos =  VectorScreen( rel.X * 0.4333333333333333, rel.Y * 0.7555555555555556 );		
		this.Warning.TextAlignment = GUI_ALIGN_CENTER;		
		this.Warning.Text = "Select your team.";
		this.Warning.FontSize = ( rel.Y * 0.0351851851851852 );

		this.SpectateButton = GUICanvas();
		this.SpectateButton.Pos = VectorScreen( rel.X * 0.7166666666666667, rel.Y * 0.8666666666666667 );
		this.SpectateButton.Size = VectorScreen( rel.X * 0.25, rel.Y * 0.0888888888888889 );
		this.SpectateButton.Colour = Colour( 42, 44, 49, 255 );
		this.SpectateButton.AddFlags( GUI_FLAG_MOUSECTRL );

		this.SpectateText = GUILabel();
		this.SpectateButton.AddChild( SpectateText );
		this.SpectateText.TextColour = Colour( 255, 255, 255 );
		this.SpectateText.Pos =  VectorScreen( rel.X * 0.075, rel.Y * 0.0222222222222222 );		
		this.SpectateText.TextAlignment = GUI_ALIGN_CENTER;		
		this.SpectateText.Text = "Spectate";
		this.SpectateText.FontSize = ( rel.Y * 0.0324074074074074 );
		this.SpectateText.AddFlags( GUI_FLAG_MOUSECTRL );

		this.RedSprite.RemoveFlags( GUI_FLAG_VISIBLE );
		this.BlueSprite.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Warning.RemoveFlags( GUI_FLAG_VISIBLE );
		this.SpectateButton.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show()
	{
		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.RedSprite.AddFlags( GUI_FLAG_VISIBLE );
		this.BlueSprite.AddFlags( GUI_FLAG_VISIBLE );
		this.Warning.AddFlags( GUI_FLAG_VISIBLE );
		this.SpectateButton.AddFlags( GUI_FLAG_VISIBLE );

		Hud.RemoveFlags( HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_HEALTH | HUD_FLAG_WANTED | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

		GUI.SetMouseEnabled( true );
	}

	function Hide()
	{
		this.RedSprite.RemoveFlags( GUI_FLAG_VISIBLE );
		this.BlueSprite.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Warning.RemoveFlags( GUI_FLAG_VISIBLE );
		this.SpectateButton.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );

		Hud.AddFlags( HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_HEALTH | HUD_FLAG_WANTED | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );

		GUI.SetMouseEnabled( false );
	}

	function onGameResize( w, h )
	{
		local rel = GUI.GetScreenSize();

		this.Background.Pos = VectorScreen( 0, 0 );
		this.Background.Size = VectorScreen( rel.X, rel.Y );

		this.RedSprite.Pos = VectorScreen( rel.X * 0.3, rel.Y * 0.2666666666666667 );
		this.RedSprite.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );

		this.BlueSprite.Pos = VectorScreen( rel.X * 0.55, rel.Y * 0.2666666666666667 );
		this.BlueSprite.Size = VectorScreen( rel.X * 0.1833333333333333, rel.Y * 0.4666666666666667 );

		this.Warning.Pos =  VectorScreen( rel.X * 0.4333333333333333, rel.Y * 0.7555555555555556 );		
		this.Warning.FontSize = ( rel.Y * 0.0351851851851852 );

		this.SpectateButton.Pos = VectorScreen( rel.X * 0.7166666666666667, rel.Y * 0.8666666666666667 );
		this.SpectateButton.Size = VectorScreen( rel.X * 0.25, rel.Y * 0.0888888888888889 );

		this.SpectateText.Pos =  VectorScreen( rel.X * 0.075, rel.Y * 0.0222222222222222 );		
		this.SpectateText.FontSize = ( rel.Y * 0.0324074074074074 );
	}

	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.RedSprite:
			this.RedSprite.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.BlueSprite:
			this.BlueSprite.Colour = Colour( 255, 255, 255, 255 );
			break;

			case this.SpectateButton:
			case this.SpectateText:
			this.SpectateButton.Colour = Colour( 255, 255, 255, 255 );
			this.SpectateText.TextColour = Colour( 42, 44, 49, 255 );
			break;
		}
	}

	function onElementHoverOut( element )
	{
		switch( element )
		{
			case this.RedSprite:
			this.RedSprite.Colour = Colour( 255, 0, 0, 255 );
			break;

			case this.BlueSprite:
			this.BlueSprite.Colour = Colour( 0, 0, 255, 255 );
			break;

			case this.SpectateButton:
			case this.SpectateText:
			this.SpectateButton.Colour = Colour( 42, 44, 49, 255 );
			this.SpectateText.TextColour = Colour( 255, 255, 255 );
			break;
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 100:
			this.Show();
			break;

			case 101:
			this.Hide();
			break;
		}
	}

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.RedSprite:
			local data = Stream();
			data.WriteInt( 100 );
			Server.SendData( data );
			break;

			case this.BlueSprite:
			local data = Stream();
			data.WriteInt( 101 );
			Server.SendData( data );
			break;

			case this.SpectateButton:
			case this.SpectateText:
		//	this.SpectateButton.Colour = Colour( 255, 255, 255, 255 );
		//	this.SpectateText.TextColour = Colour( 42, 44, 49, 255 );
			break;
		}
	}
}