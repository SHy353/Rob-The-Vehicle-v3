class CLobbyTop extends CContext
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
		this.Background.Pos3D = Vector(-947.669,-258.657,382.887);
		this.Background.Size3D = Vector( 8, 6, 0 );
		this.Background.Rotation3D = Vector(11.02, 0, 4.11);

		this.Background1 = GUISprite();
		this.Background.AddChild( this.Background1 );
		this.Background1.Pos = VectorScreen( -300, -146 );
		this.Background1.Size = VectorScreen( 1910, 900 );
		this.Background1.SetTexture( "top10ui.png" );

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
			this.AddList( "x", "kills", "ts" );
		}
	}

	function AddList( id, name1, tscore )
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
		name.Pos = VectorScreen( 625, ( 80 + ( 40 * this.Top5Killers.len() ) ) );
	//	this.centerX( name, this.Title );

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
			TScore = score3,
		});
	}

	function UpdateList( idx, name1, tscore )
	{
		this.Top5Killers[ idx.tointeger() ].Number.Text = idx.tointeger();
		this.Top5Killers[ idx.tointeger() ].Name.Text = name1;
		this.Top5Killers[ idx.tointeger() ].TScore.Text = tscore;

		this.centerX( this.Top5Killers[ idx.tointeger() ].Name, this.Top5Killers[0].Name );
		this.centerX( this.Top5Killers[ idx.tointeger() ].TScore, this.Top5Killers[0].TScore );
	}

	function StripLine( str )
	{
		local strip2 = split( str, "`" );

		UpdateList( strip2[0], strip2[1], strip2[2] );
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 3000:
			this.StripLine( str );
			break;

			case 3001:
			foreach( index, value in this.Top5Killers )
			{
				if( index != 0 )
				{
					value.Number.Text = "";
					value.Name.Text = "";
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
		name.Pos = VectorScreen( 625, ( 40 + ( 20 * this.Top5Killers.len() ) ) );

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