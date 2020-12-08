class SqCast
{
	function MsgAll( element, ... )
	{		
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Data.Logged ) player.Msg1( st );
		});
	}

	function MsgAll2( element, ... )
	{		
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Data.Logged && player.Data.PublicChat ) player.Msg( st );
		});
	}

	function MsgAll3( element, ... )
	{		
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Data.Logged ) player.Msg( st );
		});
	}

	function MsgTeam( team, element, ... )
	{		
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Team == team && player.Data.Logged && player.Spawned ) player.Msg1( st );
		});
	}

	function MsgAllExp( plr, element, ... )
	{	
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( plr.ID != player.ID && player.Data.Logged ) player.Msg1( st );
		});
	}

	function MsgAllAdmin( element, ... )
	{			
		local dsent = 0;
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( "[#ff3300][ADMIN] " + Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Authority > 1 ) player.Msg1( st );
		/*	local st2 = format.acall( st ).slice(0,8) + format.acall( st ).slice(17);
			if ( Handler.Handlers.Script.AC == 0 && dsent == 0 ) Handler.Handlers.Discord.ToDiscord( 0, "```" + st2 + "```" ), dsent = 1;*/
		});	
		Handler.Handlers.Script.AC = 0;
	}

	function MsgAllMan( element, ... )
	{			
		local dsent = 0;
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( "[#ff3300][ADMIN] " + Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}
			
			if( player.Authority > 5 ) player.Msg1( st );
		});	
	}

	function MsgPlr( plr, element, ... )
	{
		local st = [];
		st.push( Language[ plr.Data.Language ][ element ] );

		foreach( a in vargv )
		{
			if( a != null ) st.push( a );
		}

		plr.Msg2( st );
	}

	function parseStr( player, element, ... )
	{
		local st = [];
		st.push( Language[ player.Data.Language ][ element ] );

		foreach( a in vargv )
		{
			if( a != null ) st.push( a );
		}

		st.insert( 0, this );

		return format.acall( st );
	}		

	function GetTeamName( team, hascolor = true )
    {
    	local name = "", color = "";

    	switch( team )
    	{
    		case 1:
    		name = Handler.Handlers.Gameplay.RedTeamName;
		//	color = ( hascolor ) ? "[#ff3300]" : "";
    		break;

    		case 2:
    		name = Handler.Handlers.Gameplay.BlueTeamName;
		//	color = ( hascolor ) ? "[#3366ff]" : "";
    		break;
    	}

    	return color + name;

		return name;
    }

	function GetTeamColorOnly( team )
    {
    	local color = "";

    	switch( team )
    	{
    		case 1:
			color = "[#ff3300]";
    		break;

    		case 2:
			color = "[#3366ff]";
    		break;

			default:
			color = "[#ffff33]";
			break;
    	}

    	return color;

		return color;
    }

    function sendAlertToAll( element, ... )
    {
		SqForeach.Player.Active( this, function( player ) 
		{
			local st = [];
			st.push( Language[ player.Data.Language ][ element ] );

			foreach( a in vargv )
			{
				if( a != null ) st.push( a );
			}

			st.insert( 0, this );
			
    		if( player.Data.Logged ) Handler.Handlers.Script.sendToClient( player, 200, format.acall( st ) );
    	});
    }
	
	function sendAlert( plr, element, ... )
	{
		local st = [];
		st.push( Language[ plr.Data.Language ][ element ] );

		foreach( a in vargv )
		{
			if( a != null ) st.push( a );
		}

		st.insert( 0, this );
		
   		Handler.Handlers.Script.sendToClient( plr, 200, format.acall( st ) );
	}

	function PartReason( id )
	{
		switch( id )
		{
			case 1: return "PartReasonLeft";
			case 0: return "PartReasonTimeout";
			case 2: return "PartReasonKicked";
			case 3: return "PartReasonCrash";
		}
	}
	
	/*function GetPlayerColor( player, type = false )
	{
	    local getResult = "";

	    print( typeof player );
	    if( type )
	    {
	    	SqForeach.Player.Active( this, function( plr ) 
			{
				if( player == plr.Data.ID ) player = plr;
			});

			if( typeof player == "integer" ) player = Handler.Handlers.PlayerAccount.GetAccountNameFromID( player );
	    }
	    if( typeof player == "integer" ) player = Handler.Handlers.PlayerAccount.GetAccountNameFromID( player );

	    if( typeof player == "string" )
	    {
	    	if( Handler.Handlers.Script.FindPlayer( player ) == null ) return getResult = "[#ffffff]" + player;
	    	else 
	    	{
	    		local plr = Handler.Handlers.Script.FindPlayer( player );
	    		switch( plr.Team )
			    {
			        case 1:
			        if( plr.Spawned ) getResult = "[#ff0000]" + plr.Name;
			        else getResult = "[#ff9999]" + plr.Name;
			        break;

			        case 2:
			        if( player.Spawned ) getResult = "[#3333cc]" + plr.Name;
			        else getResult = "[#c1c1f0]" + plr.Name;
			        break;

			        default:
			        getResult = "[#8c8c8c]" + plr.Name;
			        break;
			    }
	    	}
	    }

	    else
	    {
	    	print( "2" );
		    switch( player.Team )
		    {
		        case 1:
		        if( player.Spawned ) getResult = "[#ff0000]" + player.Name;
		        else getResult = "[#ff9999]" + player.Name;
		        break;

		        case 2:
		        if( player.Spawned ) getResult = "[#3333cc]" + player.Name;
		        else getResult = "[#c1c1f0]" + player.Name;
		        break;

		        default:
		        getResult = "[#8c8c8c]" + player.Name;
		        break;
		    }
		}
	    return getResult;
	}*/

	function GetPlayerColor( player, type = false )
	{
		local getResult = "";

		switch( typeof player )
		{
			case "string":
		    getResult = player;
	    	break;

	    	case "integer":
			local plr = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( player );

		    if( !plr ) return getResult = "[#ffffff]" + Handler.Handlers.PlayerAccount.GetAccountNameFromID( player );
	    	else 
	    	{
	    		switch( plr.Team )
			    {
			        case 1:
			        if( plr.Spawned ) getResult = /* "[#ff3300]" + */ plr.Name;
			        else getResult = /* "[#ff9999]" + */ plr.Name;
			        break;

			        case 2:
			        if( plr.Spawned ) getResult = /* "[#3366ff]" +  */plr.Name;
			        else getResult = /* "[#c1c1f0]" + */ plr.Name;
			        break;

			        default:
					if ( plr.Authority > 1 ) getResult = /* "[#ffea00]" + */ plr.Name;
			        else getResult = /* "[#8c8c8c]" + */ plr.Name;
			        break;
			    }
	    	}
	    	break;

	    	case "SqPlayer":
		    switch( player.Team )
		    {
		        case 1:
		        if( player.Spawned ) getResult = /* "[#ff3300]" +*/ player.Name;
		        else getResult = /* "[#ff9999]" + */ player.Name;
		        break;

		        case 2:
		        if( player.Spawned ) getResult = /* "[#3366ff]" + */ player.Name;
		        else getResult = /* "[#c1c1f0]" + */ player.Name;
		        break;

		        default:
				if ( player.Authority > 1 ) getResult = /* "[#ffea00]" + */ player.Name;
			    else getResult = /* "[#8c8c8c]" + */ player.Name;
		        break;
		    }
		    break;
		}

		return getResult;
	}

	function GetPlayerColor2( player, type = false )
	{
		local getResult = "";

		switch( typeof player )
		{
			case "string":
			local plr = Handler.Handlers.Script.FindPlayer( player );

		    if( !plr ) return getResult = "[#ffffff]" + player;
	    	else 
	    	{
	    		switch( plr.Team )
			    {
			        case 1:
			        if( plr.Spawned ) getResult = "[#ff3300]" + plr.Name;
			        else getResult = "[#ff9999]" + plr.Name;
			        break;

			        case 2:
			        if( plr.Spawned ) getResult = "[#5C7EDA]" + plr.Name;
			        else getResult = "[#c1c1f0]" + plr.Name;
			        break;

			        default:
					if ( plr.Authority > 1 ) getResult = "[#ffea00]" + plr.Name;
			        else getResult = "[#8c8c8c]" + plr.Name;
			        break;
			    }
	    	}
	    	break;

	    	case "integer":
			local plr = Handler.Handlers.PlayerAccount.GetOnlineFromAccountID( player );

		    if( !plr ) return getResult = "[#ffffff]" + Handler.Handlers.PlayerAccount.GetAccountNameFromID( player );
	    	else 
	    	{
	    		switch( plr.Team )
			    {
			        case 1:
			        if( plr.Spawned ) getResult = "[#ff3300]" + plr.Name;
			        else getResult = "[#ff9999]" + plr.Name;
			        break;

			        case 2:
			        if( plr.Spawned ) getResult = "[#3366ff]" + plr.Name;
			        else getResult = "[#c1c1f0]" + plr.Name;
			        break;

			        default:
					if ( plr.Authority > 1 ) getResult = "[#ffea00]" + plr.Name;
			        else getResult = "[#8c8c8c]" + plr.Name;
			        break;
			    }
	    	}
	    	break;

	    	case "SqPlayer":
		    switch( player.Team )
		    {
		        case 1:
		        if( player.Spawned ) getResult = "[#ff3300]" + player.Name;
		        else getResult = "[#ff3333]" + player.Name;
		        break;

		        case 2:
		        if( player.Spawned ) getResult = "[#3366ff]" + player.Name;
		        else getResult = "[#5b5bd7]" + player.Name;
		        break;

		        default:
				if ( player.Authority > 1 ) getResult = "[#66ff33]" + player.Name;
			    else getResult = "[#8c8c8c]" + player.Name;
		        break;
		    }
		    break;
		}

		return getResult;
	}

}

SqPlayer.newmember( "Msg", function( array )
{
	array.insert( 0, this );
	
	switch( this.Data.ChatType )
	{
		case "old":
		this.Message( format.acall( array ) );
		break;

		case "new":
		Handler.Handlers.Script.sendToClient( this, 2600, format.acall( array ) );
		break;
	}
});

SqPlayer.newmember( "Msg1", function( array )
{
	array.insert( 0, this );
	
	switch( this.Data.ChatType )
	{
		case "old":
		this.Message( format.acall( array ) );
		break;

		case "new":
		Handler.Handlers.Script.sendToClient( this, 2600, format.acall( array ) );
		break;
	}
	
});

SqPlayer.newmember( "Msg2", function( array )
{
	array.insert( 0, this );
	
	switch( this.Data.ChatType )
	{
		case "old":
		this.Message( format.acall( array ) );
		break;

		case "new":
		Handler.Handlers.Script.sendToClient( this, 2600, format.acall( array ) );
		break;
	}
});

SqPlayer.newmember( "Msg3", function( ... )
{
	vargv.insert( 0, this );
	
	switch( this.Data.ChatType )
	{
		case "old":
		this.Message( format.acall( vargv ) );
		break;

		case "new":
		Handler.Handlers.Script.sendToClient( this, 2600, format.acall( vargv ) );
		break;
	}
});

function RGBToHex( color )
{
	return format( "[#%06X]", color.RGB );
}

function StripCol( text )
{
	try
	{
		if ( !text ) return text;
		local coltrig, output = "";
		foreach( idx, chr in text )
		{
			switch (chr)
			{
				case '[':
				if ( text[idx + 1] == '#' )
				{
					coltrig = true;
					break;
				}

				case ']':
				if ( coltrig )
				{
					coltrig = false;
					break;
				}

				default:
				if ( !coltrig ) output += chr.tochar();
			}
		}
		return output;
	}
	catch(e) return text;
}

Colour <- {
	Red 	= 	Color3(244,67,54),
	LPink	=	Color3(238,130,239),
	Pink 	= 	Color3(255,128,171),
	DPink 	= 	Color3(233,30,99),
	Purple 	= 	Color3(170,0,255),
	DPurple = 	Color3(124,77,255),
	Indigo 	= 	Color3(140,158,255),
	SBlue	= 	Color3(147,201,244),
	IBlue	= 	Color3(75,170,255),
	Blue 	= 	Color3(33,150,243),
	LBlue 	= 	Color3(3,169,244),
	Cyan 	= 	Color3(0,229,255),
	Aqua 	= 	Color3(0,188,212),
	GBlue	= 	Color3(131,186,179),
	Teal 	= 	Color3(0,191,165),
	DTeal	=	Color3(0,137,123),
	Green 	= 	Color3(76,175,80),
	LGreen 	= 	Color3(139,195,74),
	PGreen	=	Color3(0,200,83),
	Lime 	= 	Color3(205,220,57),
	Cream	= 	Color3(255,209,128),
	Yellow	=	Color3(255,214,0),
	LYellow = 	Color3(255,235,59),
	Amber 	= 	Color3(255,193,7),
	LOrange = 	Color3(255,152,0),
	Orange  =   Color3(245,124,0),
	DOrange = 	Color3(255,87,34),
	Brown 	=	Color3(182,96,11),
	LGrey 	= 	Color3(220,220,220),
	Grey 	= 	Color3(180,180,180),
	DGrey	= 	Color3(140,140,140),
	BGrey 	= 	Color3(144,164,174),
	White 	= 	Color3(255,255,255),
	Black	= 	Color3(0,0,0)
}

HexColour <- {
	Red 	= 	"[#f44336]",
	LPink	=	"[#ee82ef]",
	Pink 	= 	"[#ff80ab]",
	DPink 	= 	"[#e91e63]",
	Purple 	= 	"[#aa00ff]",
	DPurple = 	"[#7c4dff]",
	Indigo 	= 	"[#8c9eff]",
	SBlue	= 	"[#93c9f4]",
	IBlue	= 	"[#4baaff]",
	Blue 	= 	"[#2196f3]",
	LBlue 	= 	"[#03a9f4]",
	Cyan 	= 	"[#00e5ff]",
	Aqua 	= 	"[#00bcd4]",
	GBlue	= 	"[#83bab3]",
	Teal 	= 	"[#00bfa5]",
	DTeal	=	"[#00897b]",
	Green 	= 	"[#4caf50]",
	LGreen 	= 	"[#8bc34a]",
	PGreen	=	"[#00c853]",
	Lime 	= 	"[#cddc39]",
	Cream	= 	"[#ffd180]",
	Yellow	=	"[#ffd600]",
	LYellow = 	"[#ffeb3b]",
	Amber 	= 	"[#ffc107]",
	LOrange = 	"[#ff9800]",
	Orange  =   "[#f57c00]",
	DOrange = 	"[#ff5722]",
	Brown 	=	"[#b6600b]",
	LGrey 	= 	"[#dcdcdc]",
	Grey 	= 	"[#b4b4b4]",
	DGrey	= 	"[#8c8c8c]",
	BGrey 	= 	"[#90a4ae]",
	White 	= 	"[#ffffff]",
	Black	= 	"[#000000]"
}

IrcColour <- {
	Red      	= 	"4",
	Orange   	= 	"7",
	Yellow   	= 	"8",
	LGreen   	= 	"9",
	Green   	= 	"3",
	Brown    	= 	"5",
	Pink     	= 	"13",
	Purple   	= 	"6",
	Cyan    	= 	"11",
	Aqua     	= 	"10",
	LBlue    	= 	"12",
	Blue 		= 	"2",
	LGrey   	= 	"15",
	Grey    	= 	"14",
	White    	= 	"0",
	Black    	= 	"1",
	End         = 	"",
	Bold     	= 	"",
	Italic		= 	"",
	Reset		= 	"",
	Underline	= 	"",
}

function SecondToTime( secs )
{
	try 
	{
		local ret	= "";
		local hr	= 0;
		local mn	= 0;
		local dy	= 0;
			
		mn = secs / 60;
		secs = secs - mn*60;
		hr = mn / 60;
		mn = mn - hr*60;
		dy = hr / 24;
		hr = hr - dy*24	
			
		if ( dy > 0 ) ret = dy + " Days ";
		if ( hr > 0 ) ret = ret + hr + " Hours ";
		if ( mn > 0 ) ret = ret + mn + " Minutes ";
		ret = ret + secs + " Seconds";
			
		return ret;
	}
	catch( e ) return "Unknown";
}

