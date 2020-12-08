class CTextdraw extends CContext
{
	Textdraw = null;

	function constructor( Key )
	{
		base.constructor();

		this.Textdraw = {};

		this.Load();
	}

	function Add( type, text )
	{
		local element = GUILabel();
		
		element.Alpha = 255;
		element.Text = text;
		element.TextColour = Colour( 255, 255, 255 );
		element.FontSize = ( GUI.GetScreenSize().Y * 0.0138888888888889 );
		element.TextAlignment = GUI_ALIGN_LEFT;
		element.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;

		this.Textdraw.rawset( type, 
		{
			Element = element,
            Pos = Vector( 0,0,0 ),
		});
	}

	function Load() 
	{
        Add( "HealthRed", "" );
        Add( "HealthBlue", "" );
        Add( "ArmourRed", "" );
        Add( "ArmourBlue", "" );     
        Add( "AmmoRed", "" );
        Add( "AmmoBlue", "" );     
	}

	function onScriptProcess() 
	{
        local player = World.FindLocalPlayer();

	    if( this.Textdraw )
	    {
			foreach( index, value in this.Textdraw )
			{
				if( Distance( player.Position.X, player.Position.Y, player.Position.Z, value.Pos.X, value.Pos.Y, value.Pos.Z ) < 20 )
                {
                    local screenpos = GUI.WorldPosToScreen( value.Pos );
                    local alpha = 255;
                        
                    if( screenpos.Z > 1 ) alpha = 0;

                     value.Element.Alpha = alpha;

                    value.Element.Position = VectorScreen( screenpos.X - 20, screenpos.Y ); 
                }
                else value.Element.Alpha = 0;
			}
		}
    }

	function onServerData( type, str )
	{
		switch( type )
		{
			case 2700:
			local sp = split( str, ";" );

            this.Textdraw[ sp[0] ].Element.Text = sp[1];
            this.Textdraw[ sp[0] ].Pos = Vector( sp[2].tofloat(), sp[3].tofloat(), sp[4].tofloat() );          
			break;
		}
	}
}