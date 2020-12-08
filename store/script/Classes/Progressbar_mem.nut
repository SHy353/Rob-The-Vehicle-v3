class CProgress extends CContext
{
	Background = null;

	Title = null;

	Textline = null;
	Textline2 = null;

	IsHidden = true;

	Timeout = 0;

	getHash = null;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUISprite();
		this.Background.SetTexture( "progressbar-ui.png" );
		this.Background.Pos = VectorScreen( rel.X * 0.7833089311859444, rel.Y * 0.8814814814814815 );
		this.Background.Size = VectorScreen( rel.X * 0.2196193265007321, rel.Y * 0.0651041666666667 ); 

		this.Textline = GUIProgressBar();
		this.Textline.Pos = VectorScreen( rel.X * 0.8308931185944363, rel.Y * 0.9009259259259259 );
		this.Textline.Size = VectorScreen( rel.X * 0.1537335285505124, rel.Y * 0.0260416666666667 ); 
		this.Textline.Colour = Colour( 255, 255, 255 )
		this.Textline.StartColour = Colour( 255, 0, 0 );
		this.Textline.EndColour = Colour( 40, 255, 40 );
		this.Textline.MaxValue = 1000;
		this.Textline.Value = 10;
		this.Textline.SendToBottom();

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show( title, cd )
	{
		local rel = GUI.GetScreenSize();

		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

		this.IsHidden = false;
		this.Timeout = System.GetTimestamp();

		Timer.Destroy( getHash );

		local cooldown = cd*9;

		this.Textline.MaxValue = cd*9;

		getHash = Timer.Create( this, function() 
		{
			cooldown --;
			this.Textline.Value +=1;

			if( cooldown < 0 ) this.Hide();
		}, 100, 0 );
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Timeout = 0;
		this.IsHidden = true;

		this.Textline.Value = 0;

		Timer.Destroy( getHash );
	}

	function onScriptProcess() 
	{
	/*	local rel = GUI.GetScreenSize();

		if( this.Background.Pos.Y != ( rel.Y * 0.5989583333333333 ) ) 
		{
			this.Background.Pos.Y -= 5;
		}
	

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) > 5 )
		{
			this.Background.Alpha -= 5;

			if( this.Background.Alpha < 1 )
			{
				this.Hide();
			}
		}

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) < 15 )
		{
			this.Textline.Value +=1
			Console.Print( this.Textline.Value );
		//	if( this.Textline.Value > 399 ) this.Hide();
		}		*/
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 6300:
			local se = split( str, ":" );
			if( this.IsHidden ) this.Show( se[0], se[1].tointeger() );
		/*	else 
			{
				this.Textline.Value += 10;

				if( this.Textline.Value > 99 ) this.Hide();
			}*/
			break;

			case 6310:
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