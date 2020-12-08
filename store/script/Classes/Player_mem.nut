class CPlayer extends CContext
{
	InfoBackgound = null;
	InfoText = null;

	TimerBackgound = null;
	TimerText = null;

	Countdown = 20;
	getHash = null;
	
	VehicleArrow = null;
	TargetVehicleHP = 1;
	
	TargetVehicle = 1;

	TargetVehicleHPBg = null;
	TargetVehicleHPBar = null;
	
	Background2 = null;
	Textline = null;

	SpectatorBack = null;
	SpectatorText = null;

	ChampBanner = null;
	ChampBanner1 = null;

	HitWarn = 0;

	LegacySpawn = "false";

	function constructor( Key )
	{
		base.constructor();

		this.Load();

		Hud.RemoveFlags( HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_WANTED );
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

	/*
		this.InfoBackgound = GUISprite();
		this.InfoBackgound.SetTexture( "plr-hud.png" );
		this.InfoBackgound.Pos = VectorScreen( 0, 0 );
		this.InfoBackgound.Size = VectorScreen( rel.X * 0.2348958333333333, rel.Y * 0.1018518518518519 ); 
		this.centerX( this.InfoBackgound );	
	
		this.InfoText = GUILabel();
		this.InfoText.TextColour = Colour( 255, 255, 255 );
		this.InfoText.Pos =  VectorScreen( rel.X * 0.4597364568081991, rel.Y * -0.0013020833333333 );
		this.InfoText.Text = "Rob The Vehicle";
		this.InfoText.FontName = "Bahnschrift";
		this.InfoText.FontFlags = GUI_FFLAG_BOLD;
		this.InfoText.FontSize = ( rel.X * 0.0135416666666667 );
		this.centerX( this.InfoText, this.TimerText );

		this.TimerText = GUILabel();
		this.TimerText.TextColour = Colour( 255, 255, 255 );
		this.TimerText.Pos = VectorScreen( rel.X * 0.4597364568081991, rel.Y * 0.0509259259259259 );
		this.TimerText.Text = "--:--";
		this.TimerText.FontName = "Bahnschrift";
		this.TimerText.FontFlags = GUI_FFLAG_BOLD;
		this.TimerText.FontSize = ( rel.X * 0.0145833333333333 ); */

	/*	if( rel.X <= 1024 )
		{
			this.InfoBackgound = GUISprite();
			this.InfoBackgound.SetTexture( "plr-hud.png" );
			this.InfoBackgound.Pos = VectorScreen( 0, 0 );
			this.InfoBackgound.Size = VectorScreen( rel.X * 0.234375, rel.Y * 0.1015625 ); 
			this.centerX( this.InfoBackgound );

			this.InfoText = GUILabel();
			this.InfoText.FontSize = ( rel.X * 0.01953125 );
			this.InfoText.TextColour = Colour( 255, 255, 255 );
			this.InfoText.Text = "Rob The Vehicle";
			this.InfoText.FontName = "Bahnschrift";
			this.InfoText.FontFlags = GUI_FFLAG_BOLD;
			this.InfoText.Pos =  VectorScreen( rel.X * 0.4208984375, rel.Y * -0.0026041666666667 );
			this.centerX( this.InfoText, this.TimerText );

			this.TimerText = GUILabel();
			this.TimerText.TextColour = Colour( 255, 255, 255 );
			this.TimerText.FontSize = ( rel.X * 0.01953125 );
			this.TimerText.Text = "--:--";
			this.TimerText.FontName = "Bahnschrift";
			this.TimerText.FontFlags = GUI_FFLAG_BOLD;
			this.TimerText.Pos = VectorScreen( rel.X * 0.4677734375, rel.Y * 0.0494791666666667 );
		}
		else 
		{*/
		this.InfoBackgound = GUISprite();
		this.InfoBackgound.SetTexture( "plr-hud.png" );
		this.InfoBackgound.Pos = VectorScreen( 0, 0 );
		this.InfoBackgound.Size = VectorScreen( rel.X * 0.2348958333333333, rel.Y * 0.1018518518518519 ); 
		this.centerX( this.InfoBackgound );	
		
		this.InfoText = GUILabel();
		this.InfoText.TextColour = Colour( 255, 255, 255 );
		this.InfoText.Pos =  VectorScreen( rel.X * 0.4597364568081991, rel.Y * -0.0013020833333333 );
		this.InfoText.Text = "Playing as Defender";
		this.InfoText.FontName = "Bahnschrift";
		this.InfoText.FontFlags = GUI_FFLAG_BOLD;
		this.InfoText.FontSize = ( rel.Y * 0.025 );
		
		this.centerX( this.InfoText, this.TimerText );

		this.TimerText = GUILabel();
		this.TimerText.TextColour = Colour( 255, 255, 255 );
		this.TimerText.Pos = VectorScreen( rel.X * 0.4597364568081991, rel.Y * 0.0509259259259259 );
		this.TimerText.Text = "--:--";
		this.TimerText.FontName = "Bahnschrift";
		this.TimerText.FontFlags = GUI_FFLAG_BOLD;
		this.TimerText.FontSize = ( rel.Y * 0.025 );

		this.VehicleArrow = GUISprite( "arrow.png", VectorScreen( 0, rel.Y / 2 ) );
		this.VehicleArrow.Size = VectorScreen( rel.X * 0.054904831625183, rel.Y * 0.1171875 );
		this.centerX( this.TimerText );
		
		this.VehicleArrow.Alpha = 0;

		this.TargetVehicleHPBg = GUISprite();
		this.TargetVehicleHPBg.SetTexture( "vehhp.png" );
		this.TargetVehicleHPBg.Pos = VectorScreen( rel.X * 0.7833089311859444, rel.Y * 0.9375 );
		this.TargetVehicleHPBg.Size = VectorScreen( rel.X * 0.2196193265007321, rel.Y * 0.0651041666666667 ); 
		
		this.TargetVehicleHPBar = GUIProgressBar();
		this.TargetVehicleHPBar.Pos = VectorScreen( rel.X * 0.8308931185944363, rel.Y * 0.95703125 );
		this.TargetVehicleHPBar.Size = VectorScreen( rel.X * 0.1537335285505124, rel.Y * 0.0260416666666667 ); 
		this.TargetVehicleHPBar.Colour = Colour( 255, 255, 255 )
		this.TargetVehicleHPBar.StartColour = Colour( 255, 0, 0 );
		this.TargetVehicleHPBar.EndColour = Colour( 40, 255, 40 );
		this.TargetVehicleHPBar.MaxValue = 1000;
		this.TargetVehicleHPBar.Value = 10;
		this.TargetVehicleHPBar.SendToBottom();

		this.TargetVehicleHPBg.Alpha = 0;
		this.TargetVehicleHPBar.Alpha = 0;

		this.Background2 = GUISprite();
		this.Background2.SetTexture( "alert-bg.png" );
		this.Background2.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.8731481481481481 );
		this.Background2.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.1666666666666667 ); 
		this.Background2.Colour = Colour( 0, 0, 0, 255 );

    /*    this.ChampBanner = GUISprite();
		this.ChampBanner.SetTexture("champ-banner.png");
        this.ChampBanner.Size = VectorScreen(4120, 920);
        this.ChampBanner.AddFlags(GUI_FLAG_3D_ENTITY);
        this.ChampBanner.Pos3D = Vector(-947.669,-258.657,384.887);
        this.ChampBanner.Size3D = Vector(11, 10, 0);
        this.ChampBanner.Rotation3D = Vector(11.02, 0, 4.11);*/

        this.ChampBanner1 = GUISprite();
		this.ChampBanner1.SetTexture("lobbybg1.png");
        this.ChampBanner1.Size = VectorScreen(4120, 920);
        this.ChampBanner1.AddFlags(GUI_FLAG_3D_ENTITY);
        this.ChampBanner1.Pos3D = Vector(-975.099,-269.957,384.887);
        this.ChampBanner1.Size3D = Vector(11, 10, 0);
        this.ChampBanner1.Rotation3D = Vector(11.02, 0, 2.39);


		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function ShowTimer( countdown )
	{
		switch( countdown )
		{
			case "end":
			this.TimerText.Text = "--:--";
			this.TimerText.TextColour = Colour( 255, 255, 255 );
					
			this.centerX( this.TimerText );

			Timer.Destroy( getHash );
			break;

			case "pause":
			this.TimerText.Text = "||";
			this.TimerText.TextColour = Colour( 255, 255, 255 );
					
			this.centerX( this.TimerText );

			Timer.Destroy( getHash );
			break;			

			default:
			countdown = countdown.tointeger();

			Timer.Destroy( getHash );
			
			this.Countdown = countdown;
		
			getHash = Timer.Create( this, function() 
			{

				if( this.Countdown != -1 )
				{
					this.Countdown --;
					
					this.TimerText.TextColour = Colour( 255, 255, 255 );
					this.TimerText.Text = ::String_seconds_to_mmss( this.Countdown );
					this.centerX( this.TimerText );

					
					if( this.Countdown < 6 ) this.TimerText.TextColour = Colour( 255, 0, 0 );

					if( this.Countdown < 1 )
					{
						this.TimerText.Text = "--:--";
						this.TimerText.TextColour = Colour( 255, 255, 255 );
						this.centerX( this.TimerText );
						
						Timer.Destroy( getHash );
					}
				}
			}, 1000, 0 );
			break;
		}
	}

	function ShowTeamOnClass( text )
	{
		local rel = GUI.GetScreenSize();

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos = VectorScreen( 0, rel.Y * 0.062962962962963 );		
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.Textline.Text = text;
		this.Textline.FontName = "Bahnschrift";
		this.Textline.FontSize = ( rel.Y * 0.0240740740740741 );
		this.Background2.AddChild( this.Textline );

		this.Background2.Size.X = this.getTextWidth( this.Textline ) * 2;
		this.centerX( this.Background2 );
		this.centerinchildX( this.Background2, this.Textline );

		this.Background2.AddFlags( GUI_FLAG_VISIBLE );

		Hud.RemoveFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );
	}

	function RemoveTeamOnClass()
	{
		this.Background2.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Textline = null;

		Hud.AddFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR );
	}

	function onScriptProcess() 
	{
        local veh = World.FindVehicle( this.TargetVehicle );
	//	if( this.TargetVehicleHP == 4000 )  this.VehicleArrow.Alpha = 0;

        if ( veh )
        {			
			this.TargetVehicleHPBg.Alpha = 255;
			this.TargetVehicleHPBar.Alpha = 255;
			
			this.TargetVehicleHPBar.Value = veh.Health;

            local player = World.FindLocalPlayer(), ppos = player.Position, vehpos = veh.Position, z1 = Vector( 0, 0, 3.5 );
            if( Distance( ppos.X, ppos.Y, ppos.Z, vehpos.X, vehpos.Y, vehpos.Z ) < 35 )
            {
                local screenpos = GUI.WorldPosToScreen( vehpos + z1 );
				local alpha = 255;
				
				if(screenpos.Z > 1)
					alpha = 0;

                this.VehicleArrow.Alpha = alpha;

                this.VehicleArrow.Position = VectorScreen( screenpos.X - 20, screenpos.Y ); 
            }
            else this.VehicleArrow.Alpha = 0;
        }
        else 
		{
			this.VehicleArrow.Alpha = 0;
			
			this.TargetVehicleHPBg.Alpha = 0;
			this.TargetVehicleHPBar.Alpha = 0;
		}
    }
			
	function onScriptLoad()
	{
		local data = Stream();
		local rel = GUI.GetScreenSize();

		data.WriteInt( 1 );
		data.WriteString( rel.X + "x" + rel.Y );

		Server.SendData( data );
	}

	function onPlayerShoot( player, weapon, hitEntity, hitPosition )
	{	
    	local p = World.FindLocalPlayer();
   		if( p.ID == player.ID ) 
   		{
   			/*if( hitEntity && hitEntity.Type == OBJ_PLAYER )
   			{
   				local data = Stream();

				data.WriteInt( 2 );
				data.WriteString( hitEntity.ID );
				Server.SendData( data );
			}*/

			if( hitEntity && hitEntity.Type == OBJ_VEHICLE )
			{
				if( ( System.GetTimestamp() - this.HitWarn ) >= 5 )
				{
					this.HitWarn =  System.GetTimestamp();

					local data = Stream();
					data.WriteInt( 3 );
					data.WriteString( "");
					Server.SendData( data );
				}
			}
		}

		::missile_client.on_shoot(player, weapon, hitEntity, hitPosition);
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 10:
			this.LegacySpawn = str;
			break;
			
			case 400:
			this.ShowTimer( str );
			break;
			
			case 401:
			this.UpdateTitle( str );
			break;

			case 402:
			this.ShowTeamOnClass( str );
			break;
		
			case 403:
			this.RemoveTeamOnClass();
			break;

			case 415:
			this.TargetVehicle = str.tointeger();
			this.TargetVehicleHP = str.tointeger();
			break;
		}
	}
	
	function UpdateTitle( str )
	{
		local strip = split( str, "$" );
		local rel = GUI.GetScreenSize();
		
		this.InfoText.Text = str.slice( str.find( "-" ) + 1 );
		this.InfoText.TextColour = Colour( strip[0].tointeger(), strip[1].tointeger(), strip[2].tointeger() );
		this.centerX( this.InfoText, this.TimerText );
	//	this.InfoText.Pos.Y = ( rel.Y * -0.0013020833333333 );
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

	function playHoverSound()
	{
		local data = Stream();
		data.WriteInt( 11 );
		data.WriteString( "" );
		Server.SendData( data );
	}


}
