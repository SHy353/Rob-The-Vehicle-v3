GeoIP <-
{
	function GetIPInfo( ip )
	{
		local getInfo = [ this.GetIPCity( ip ), this.GetIPSubdivision( ip ), this.GetIPCountry( ip ), this.GetIPRegion( ip ) ], result = null;
				
		foreach( index, value in getInfo )
		{
			if( value != null )
			{
				if( result ) result = result + ", " + value;
				else result = value;
			}
		}
		
		if( result ) return result;
		else return "Unknown";
	}

	function GetDIsplayInfo( ip )
	{
		local getInfo = [ this.GetIPCountry( ip ), this.GetIPRegion( ip ) ], result = null;
				
		foreach( index, value in getInfo )
		{
			if( value != null )
			{
				if( result ) result = result + ", " + value;
				else result = value;
			}
		}
		
		if( result ) return result;
		else return "Unknown";
	}
	
	function GetIPRegion( ip )
	{
		local result = Handler.Handlers.Script.Country.LookupString( ip );
	
		if ( result.FoundEntry )
		{
			try
			{
				return result.GetValue( "continent", "names", "en" ).String;	
			}
			catch( _ ) _;
		}
		else return null;
	}

	function GetIPCountry( ip )
	{
		local result = Handler.Handlers.Script.Country.LookupString( ip );
	
		if ( result.FoundEntry )
		{
			try
			{
				switch( result.GetValue( "country", "names", "en" ).String )
				{
				//	case "Malaysia": return "Islamic State of Malaya";

					default: return result.GetValue( "country", "names", "en" ).String;
				}
				return ;	
			}
			catch( _ ) _;
		}
		else return "Unknown";
	}
	
	function GetIPCity( ip )
	{
		local result = Handler.Handlers.Script.Country.LookupString( ip );
	
		if ( result.FoundEntry )
		{
			try
			{
				return result.GetValue( "city", "names", "en" ).String;	
			}
			catch( _ ) _;
		}
		else return null;
	}
	
	function GetIPSubdivision( ip )
	{
		local result = Handler.Handlers.Script.Country.LookupString( ip );
	
		if ( result.FoundEntry )
		{
			try
			{
				if( GetIPCity( ip ) == result.GetValue( "subdivisions", 0, "names", "en" ).String ) return result.GetValue( "country", 0, "names", "en" ).String;
			}
			catch( _ ) _;
		}
		else return null;
	}
}