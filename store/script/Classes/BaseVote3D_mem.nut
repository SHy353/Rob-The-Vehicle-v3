class CBasevote3D extends CContext
{

	Background = null;

	Titlebar = null;

	Box1Text = null;
	Box1Count = null;

	Box2Text = null;
	Box2Count = null;

	Box3Text = null;
	Box3Count = null;

	Box4Text = null;
	Box4Count = null;

	Box5Text = null;
	Box5Count = null;

	Box6Text = null;
	Box6Count = null;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Titlebar = GUISprite();
		this.Titlebar.SetTexture( "votebase_ui.png" );
	//	this.Titlebar.Pos = VectorScreen( 200, 300 );
		this.Titlebar.Size = VectorScreen( 1085, 605 );
		this.Titlebar.AddFlags( GUI_FLAG_3D_ENTITY );
		this.Titlebar.Pos3D = Vector( -958.429,-269.828,385.134 );
		this.Titlebar.Size3D = Vector( 12, 10, 0 );
		this.Titlebar.Rotation3D = Vector( 11, 0, 3.23 );

		this.Box1Text = GUILabel();
		this.Titlebar.AddChild( this.Box1Text );
		this.Box1Text.TextColour = Colour( 246, 123, 78 );
		this.Box1Text.Pos =  VectorScreen( 0, 116 );		
		this.Box1Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box1Text.FontName = "Bahnschrift";	
		this.Box1Text.Text = "";
		this.Box1Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box1Text )

		this.Box1Count = GUILabel();
		this.Titlebar.AddChild( this.Box1Count );
		this.Box1Count.TextColour = Colour( 0, 0, 0 );
		this.Box1Count.Pos =  VectorScreen( 786, 115 );		
		this.Box1Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box1Count.FontName = "Bahnschrift";	
		this.Box1Count.Text = "55";
		this.Box1Count.FontSize = 29;

		this.Box2Text = GUILabel();
		this.Titlebar.AddChild( this.Box2Text );
		this.Box2Text.TextColour = Colour( 246, 123, 78 );
		this.Box2Text.Pos =  VectorScreen( 0, 176 );		
		this.Box2Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box2Text.FontName = "Bahnschrift";	
		this.Box2Text.Text = "";
		this.Box2Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box2Text )

		this.Box2Count = GUILabel();
		this.Titlebar.AddChild( this.Box2Count );
		this.Box2Count.TextColour = Colour( 0, 0, 0 );
		this.Box2Count.Pos =  VectorScreen( 786, 175 );		
		this.Box2Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box2Count.FontName = "Bahnschrift";	
		this.Box2Count.Text = "55";
		this.Box2Count.FontSize = 29;

		this.Box3Text = GUILabel();
		this.Titlebar.AddChild( this.Box3Text );
		this.Box3Text.TextColour = Colour( 246, 123, 78 );
		this.Box3Text.Pos =  VectorScreen( 0, 236 );		
		this.Box3Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box3Text.FontName = "Bahnschrift";	
		this.Box3Text.Text = "";
		this.Box3Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box3Text )

		this.Box3Count = GUILabel();
		this.Titlebar.AddChild( this.Box3Count );
		this.Box3Count.TextColour = Colour( 0, 0, 0 );
		this.Box3Count.Pos =  VectorScreen( 786, 237 );		
		this.Box3Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box3Count.FontName = "Bahnschrift";	
		this.Box3Count.Text = "55";
		this.Box3Count.FontSize = 29;

		this.Box4Text = GUILabel();
		this.Titlebar.AddChild( this.Box4Text );
		this.Box4Text.TextColour = Colour( 246, 123, 78 );
		this.Box4Text.Pos =  VectorScreen( 0, 296 );		
		this.Box4Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box4Text.FontName = "Bahnschrift";	
		this.Box4Text.Text = "";
		this.Box4Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box4Text )

		this.Box4Count = GUILabel();
		this.Titlebar.AddChild( this.Box4Count );
		this.Box4Count.TextColour = Colour( 0, 0, 0 );
		this.Box4Count.Pos =  VectorScreen( 786, 295 );		
		this.Box4Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box4Count.FontName = "Bahnschrift";	
		this.Box4Count.Text = "55";
		this.Box4Count.FontSize = 29;

		this.Box5Text = GUILabel();
		this.Titlebar.AddChild( this.Box5Text );
		this.Box5Text.TextColour = Colour( 246, 123, 78 );
		this.Box5Text.Pos =  VectorScreen( 0, 354 );		
		this.Box5Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box5Text.FontName = "Bahnschrift";	
		this.Box5Text.Text = "";
		this.Box5Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box5Text )

		this.Box5Count = GUILabel();
		this.Titlebar.AddChild( this.Box5Count );
		this.Box5Count.TextColour = Colour( 0, 0, 0 );
		this.Box5Count.Pos =  VectorScreen( 786, 356 );		
		this.Box5Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box5Count.FontName = "Bahnschrift";	
		this.Box5Count.Text = "55";
		this.Box5Count.FontSize = 29;

		this.Box6Text = GUILabel();
		this.Titlebar.AddChild( this.Box6Text );
		this.Box6Text.TextColour = Colour( 246, 123, 78 );
		this.Box6Text.Pos =  VectorScreen( 0, 413 );		
		this.Box6Text.TextAlignment = GUI_ALIGN_CENTER;
		this.Box6Text.FontName = "Bahnschrift";	
		this.Box6Text.Text = "";
		this.Box6Text.FontSize = 26;
        centerinchildX( this.Titlebar, this.Box6Text )

		this.Box6Count = GUILabel();
		this.Titlebar.AddChild( this.Box6Count );
		this.Box6Count.TextColour = Colour( 0, 0, 0 );
		this.Box6Count.Pos =  VectorScreen( 786, 417 );		
		this.Box6Count.TextAlignment = GUI_ALIGN_CENTER;
		this.Box6Count.FontName = "Bahnschrift";	
		this.Box6Count.Text = "55";
		this.Box6Count.FontSize = 29;

	/*	this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box1Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box2Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box3Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box4Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box5Count.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Text.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Box6Count.RemoveFlags( GUI_FLAG_VISIBLE );*/
	}

	function Update( base1, base2, base3, base4, base5, base6 )
	{
		this.Box1Text.TextColour = Colour( 246, 123, 78 );
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
        
		this.Box1Text.Text = base1.toupper();
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

		this.centerinchildX( this.Titlebar, this.Box1Text );
		this.centerinchildX( this.Titlebar, this.Box2Text );
		this.centerinchildX( this.Titlebar, this.Box3Text );
		this.centerinchildX( this.Titlebar, this.Box4Text );
		this.centerinchildX( this.Titlebar, this.Box5Text );
		this.centerinchildX( this.Titlebar, this.Box6Text );
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

			this.Update( getVote[0], getVote[1], getVote[2], getVote[3], getVote[4], getVote[5] );
			break;

			case 303:
			local getVote = split( str, "," );

			this.Update( getVote[0], getVote[1], getVote[2], getVote[3], getVote[4], getVote[5] );
			break;

			case 304:
			local getVote = split( str, "," );

			this.UpdateColor( getVote[0], getVote[1], getVote[2], getVote[3], getVote[4], getVote[5] );
			break;

		/*	case 302:
			this.Hide();
			break;*/
		}
	}

	function UpdateColor( base1, base2, base3, base4, base5, base6 )
	{
		if( base1 == "true") this.Box1Text.TextColour = Colour( 255, 0, 0 );
		if( base2 == "true") this.Box2Text.TextColour = Colour( 255, 0, 0 );
		if( base3 == "true") this.Box3Text.TextColour = Colour( 255, 0, 0 );
		if( base4 == "true") this.Box4Text.TextColour = Colour( 255, 0, 0 );
		if( base5 == "true") this.Box5Text.TextColour = Colour( 255, 0, 0 );
		if( base5 == "true") this.Box6Text.TextColour = Colour( 255, 0, 0 );
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