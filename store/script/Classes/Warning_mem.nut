class CWarning extends CContext
{
	Background = null;

	Title = null;

	Textline = null;
	Textline2 = null;

	IsHidden = true;

	Timeout = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUISprite();
		this.Background.SetTexture( "alert-bg.png" );
		this.Background.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.45 );
		this.Background.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.2981481481481481 ); 
		this.Background.Colour = Colour( 0, 0, 0, 255 );

		this.Title = GUISprite();
		this.Title.SetTexture( "warn-logo.png" );
		this.Title.Pos = VectorScreen( 0, rel.Y * 0.1111111111111111 );
		this.Title.Size = VectorScreen( rel.X * 0.0416666666666667, rel.Y * 0.037037037037037 ); 
		this.Title.Colour = Colour( 255, 0, 0, 255 );
		this.Background.AddChild( this.Title );
		this.centerinchildX( this.Background, this.Title );

		this.Title.Size = VectorScreen( rel.X * 0.0416666666666667, rel.Y * 0.037037037037037 ); 

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos =  VectorScreen( 0, rel.Y * 0.1432291666666667 );		
		this.Textline.FontFlags = GUI_FFLAG_BOLD;
		this.Textline.Text = "";
		this.Textline.FontName = "Bahnschrift";
		this.Textline.FontSize = ( rel.Y * 0.025 );
		this.Background.AddChild( this.Textline );
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.centerinchildX( this.Background, this.Textline );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show( text )
	{
		local rel = GUI.GetScreenSize();

		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_TEXT_TAGS );

		this.Textline.Size.X = 0;

		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );

		this.Textline.Text = text;

		this.Background.Size.X = this.getTextWidth( this.Textline ) * 1.5;

		this.IsHidden = false;
		this.Timeout = System.GetTimestamp();

		this.Background.Alpha = 255;

		this.centerX( this.Background );

		this.centerinchildX( this.Background, this.Title );
		this.centerinchildX( this.Background, this.Textline );

		this.Background.SendToTop();

		this.Textline.TextColour = Colour( 255, 255, 255 );
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Timeout = 0;
		this.IsHidden = true;
	}

	function onScriptProcess() 
	{
		local rel = GUI.GetScreenSize();

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) > 5 )
		{
			this.Background.Alpha -= 5;

			if( this.Background.Alpha < 1 )
			{
				this.Hide();
			}
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 200:
			this.Show( str );
			break;

			case 201:
			this.Hide();
			break;
		}
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