class CCarhpbar extends CContext
{
    vehhpprog = null;
	vehedge = null;
	vehhpprogshown = false;
	tvid = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
			local rel = GUI.GetScreenSize();
	this.vehhpprog = GUIProgressBar( VectorScreen( rel.X * 0.038, rel.Y * 0.629 ), VectorScreen( rel.X * 0.16, rel.Y * 0.02 ), Colour( 255, 0, 0 ), Colour( 40, 255, 40 ), GUI_FLAG_NONE, 1000 );
	this.vehedge = GUISprite( "sprite_hpcar.png", VectorScreen( rel.X * 0.02, rel.Y * 0.591 ) );
	this.vehedge.Size = VectorScreen( rel.X * 0.19, rel.Y * 0.09 );
	this.vehedge.AddFlags( GUI_FLAG_VISIBLE );
    this.vehhpprog.AddFlags( GUI_FLAG_VISIBLE );
	//vehedge.AddChild( vehhpprog );
	this.vehedge.RemoveFlags( GUI_FLAG_VISIBLE );
	this.vehhpprog.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show()
	{
		    this.vehedge.AddFlags( GUI_FLAG_VISIBLE );
		    this.vehhpprog.AddFlags( GUI_FLAG_VISIBLE );
		    this.vehhpprogshown = true;

	}

	function Hide()
	{
	    this.vehedge.RemoveFlags( GUI_FLAG_VISIBLE );
	    this.vehhpprog.RemoveFlags( GUI_FLAG_VISIBLE );
		this.vehhpprogshown = false;
		tvid = 0;
	}

	function onGameResize( w, h )
	{
		local rel = GUI.GetScreenSize();

	this.vehedge.Position = VectorScreen( rel.X * 0.02, rel.Y * 0.591 );
	this.vehedge.Size = VectorScreen( rel.X * 0.19, rel.Y * 0.09 );
	this.vehhpprog.Position = VectorScreen( rel.X * 0.038, rel.Y * 0.629 );
	this.vehhpprog.Size = VectorScreen( rel.X * 0.16, rel.Y * 0.02 );
	}


	function onServerData( type, str )
	{
		switch( type )
		{
			case 944:
			local vehicleid = str;
		    tvid = vehicleid;
			this.Show();
			break;

			case 945:
			this.Hide();
			break;
		}
	}
	
	function onScriptProcess() 
	{

	}

}