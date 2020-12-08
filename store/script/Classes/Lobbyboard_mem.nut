class CLobbyboard extends CContext
{
	Background = null;
	Background1 = null;

	Title = null;

	Top5Killers = null;

	function constructor( Key )
	{
		base.constructor();

		this.Top5Killers = [];

		this.Load();
	}

	function Load()
	{
		this.Background = GUICanvas();
		this.Background.Size = VectorScreen( 1360, 570 );
	//	this.Background.Pos = VectorScreen( 200, 300 );
		this.Background.Colour = Colour( 47, 49, 54, 255 );
		this.Background.AddFlags( GUI_FLAG_3D_ENTITY );
		this.Background.Pos3D = Vector( -947.51,-246.003,381.3 );
		this.Background.Size3D = Vector( 8, 6, 0 );
		this.Background.Rotation3D = Vector( 11, 0, -1.45 );

		this.Background1 = GUISprite();
		this.Background.AddChild( this.Background1 );
		this.Background1.Pos = VectorScreen( -300, -146 );
		this.Background1.Size = VectorScreen( 1910, 900 );
		this.Background1.SetTexture( "lobbybg.png" );

		this.Title = GUILabel();
		this.Title.TextColour = Colour( 255,0,0 );
		this.Title.FontName = "Bahnschrift";
		this.Title.FontFlags = GUI_FFLAG_BOLD;
		this.Title.Text = "";
		this.Title.TextAlignment = GUI_ALIGN_LEFT;
		this.Title.FontSize = 15;
		this.Title.Pos = VectorScreen( 0, 10 );
		this.Background.AddChild( this.Title );
		this.centerinchildX( this.Background, this.Title );

		Init();

		for( local i = 0; i < 10; i++ )
		{
			this.AddList( "", "", "", "", "" );
		}
	}

	function AddList( name1, kills, deaths, assign, tscore )
	{
		local number = GUILabel();
		local name = GUILabel();
		local score = GUILabel();
		local score1 = GUILabel();
	//	local score2 = GUILabel();
		local score3 = GUILabel();

		this.Background.AddChild( number );
		number.TextColour = Colour( 255,255,255 );
		number.FontSize = 30;
		number.FontName = "Bahnschrift";
		number.FontFlags = GUI_FFLAG_BOLD;
		number.Text = "";
		number.TextAlignment = GUI_ALIGN_CENTER;
		number.Pos = VectorScreen( 40, ( 80 + ( 40 * this.Top5Killers.len() ) ) );

		this.Background.AddChild( name );
		name.TextColour = Colour( 255, 0, 0 );
		name.FontSize = 30;
		name.FontName = "Bahnschrift";
		name.FontFlags = GUI_FFLAG_BOLD;
		name.Text = name1;
		name.TextAlignment = GUI_ALIGN_CENTER;
		name.Pos = VectorScreen( 175, ( 80 + ( 40 * this.Top5Killers.len() ) ) );
	//	this.centerX( name, this.Title );

		this.Background.AddChild( score );
		score.TextColour = Colour( 255,255,255 );
		score.FontSize = 30;
		score.FontName = "Bahnschrift";
		score.FontFlags = GUI_FFLAG_BOLD;
		score.Text = kills;
		score.TextAlignment = GUI_ALIGN_CENTER;
		score.Pos = VectorScreen( 710, ( 80 + ( 40 * this.Top5Killers.len() ) ) );

		this.Background.AddChild( score1 );
		score1.TextColour = Colour( 255,255,255 );
		score1.FontSize = 30;
		score1.FontName = "Bahnschrift";
		score1.FontFlags = GUI_FFLAG_BOLD;
		score1.Text = deaths;
		score1.TextAlignment = GUI_ALIGN_CENTER;
		score1.Pos = VectorScreen( 945, ( 80 + ( 40 * this.Top5Killers.len() ) ) );

	/*	this.Background.AddChild( score2 );
		score2.TextColour = Colour( 255,255,255 );
		score2.FontSize = 30;
		score2.FontName = "Bahnschrift";
		score2.FontFlags = GUI_FFLAG_BOLD;
		score2.Text = assign;
		score2.TextAlignment = GUI_ALIGN_CENTER;
		score2.Pos = VectorScreen( 945, ( 80 + ( 40 * this.Top5Killers.len() ) ) );*/

		this.Background.AddChild( score3 );
		score3.TextColour = Colour( 255,255,255 );
		score3.FontSize = 30;
		score3.FontName = "Bahnschrift";
		score3.FontFlags = GUI_FFLAG_BOLD;
		score3.Text = tscore;
		score3.TextAlignment = GUI_ALIGN_CENTER;
		score3.Pos = VectorScreen( 1185, ( 80 + ( 40 * this.Top5Killers.len() ) ) );

		this.Top5Killers.append(
		{
			Number = number,
			Name = name,
			Kills = score,
			Deaths = score1,
		//	Assign = score2,
			TScore = score3,
		});
	}

	function UpdateList( idx, name1, kills, deaths, assign, tscore )
	{
		this.Top5Killers[ idx.tointeger() ].Number.Text = idx.tointeger();
		this.Top5Killers[ idx.tointeger() ].Name.Text = name1;
		this.Top5Killers[ idx.tointeger() ].Kills.Text = kills;
		this.Top5Killers[ idx.tointeger() ].Deaths.Text = deaths;
	//	this.Top5Killers[ idx.tointeger() ].Assign.Text = assign;
		this.Top5Killers[ idx.tointeger() ].TScore.Text = tscore;

		this.centerX( this.Top5Killers[ idx.tointeger() ].Name, this.Top5Killers[0].Name );
		this.centerX( this.Top5Killers[ idx.tointeger() ].Kills, this.Top5Killers[0].Kills );
		this.centerX( this.Top5Killers[ idx.tointeger() ].Deaths, this.Top5Killers[0].Deaths );
	//	this.centerX( this.Top5Killers[ idx.tointeger() ].Assign, this.Top5Killers[0].Assign );
		this.centerX( this.Top5Killers[ idx.tointeger() ].TScore, this.Top5Killers[0].TScore );
	}

	function StripLine( str )
	{
		local strip = split( str, ":" );

		foreach( value in strip )
		{
			local strip2 = split( value, "~" );

			UpdateList( strip2[5], strip2[0], strip2[1], strip2[2], strip2[3], strip2[4] );
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 1020:
			this.StripLine( str );
			break;

			case 1021:
			foreach( index, value in this.Top5Killers )
			{
				if( index != 0 )
				{
					value.Number.Text = "";
					value.Name.Text = "";
					value.Kills.Text = "";
					value.Deaths.Text = "";
		//			value.Assign.Text = "";
					value.TScore.Text = "";
				}
			}
			break;
		}
	}

	function Init()
	{
		local number = GUILabel();
		local name = GUILabel();
		local score = GUILabel();
	//	local score1 = GUILabel();
		local score2 = GUILabel();
		local score3 = GUILabel();

		this.Background.AddChild( number );
		number.TextColour = Colour( 255,255,255 );
		number.FontSize = 30;
		number.FontName = "Bahnschrift";
		number.FontFlags = GUI_FFLAG_BOLD;
		number.TextAlignment = GUI_ALIGN_LEFT;
		number.Pos = VectorScreen( 40, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

		this.Background.AddChild( name );
		name.TextColour = Colour( 255,255,255 );
		name.FontSize = 30;
		name.FontName = "Bahnschrift";
		name.FontFlags = GUI_FFLAG_BOLD;
		name.Text = "Name";
		name.TextAlignment = GUI_ALIGN_LEFT;
		name.Pos = VectorScreen( 325, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

		this.Background.AddChild( score );
		score.TextColour = Colour( 255,255,255 );
		score.FontSize = 30;
		score.FontName = "Bahnschrift";
		score.FontFlags = GUI_FFLAG_BOLD;
		score.Text = "Kills";
		score.TextAlignment = GUI_ALIGN_LEFT;
		score.Pos = VectorScreen( 710, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

	/*	this.Background.AddChild( score1 );
		score1.TextColour = Colour( 255,255,255 );
		score1.FontSize = 30;
		score1.FontName = "Bahnschrift";
		score1.FontFlags = GUI_FFLAG_BOLD;
		score1.Text = "Assists";
		score1.TextAlignment = GUI_ALIGN_LEFT;
		score1.Pos = VectorScreen( 810, ( 40 + ( 20 * this.Top5Killers.len() ) ) );*/

		this.Background.AddChild( score2 );
		score2.TextColour = Colour( 255,255,255 );
		score2.FontSize = 30;
		score2.FontName = "Bahnschrift";
		score2.FontFlags = GUI_FFLAG_BOLD;
		score2.Text = "Deaths";
		score2.TextAlignment = GUI_ALIGN_LEFT;
		score2.Pos = VectorScreen( 945, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

		this.Background.AddChild( score3 );
		score3.TextColour = Colour( 255,255,255 );
		score3.FontSize = 30;
		score3.FontName = "Bahnschrift";
		score3.FontFlags = GUI_FFLAG_BOLD;
		score3.Text = "Scores";
		score3.TextAlignment = GUI_ALIGN_LEFT;
		score3.Pos = VectorScreen( 1180, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

		this.Top5Killers.append(
		{
			Number = number,
			Name = name,
			Kills = score,
			Deaths = score2,
		//	Assign = score2,
			TScore = score3,
		});
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

	function centerinchildX( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );

		child.Pos.X = x;
	}
}