function RGBToHex( color )
{
	return format("[#%02X%02X%02X]", color.r, color.g, color.b );
}

function GetPlayer( player )
{
	if( player )
	{
		if( IsNum( player ) )
		{
			local n = FindPlayer( player.tointeger() );
			if ( n ) return n;
		}
		
		else 
		{      
			local b = FindPlayer( player ); 
			if ( b ) return b;
		}
	}
}

function ConvertToPos( str )
{
	local strip = split( str, "," );

	return Vector( strip[0].tofloat(), strip[1].tofloat(), strip[2].tofloat() );
}

function ConvertToStrPos( pos )
{
	return pos.x + ", " + pos.y + ", " + pos.z;
}

function EscapeJSONString( string )
{
	local getInvalidChar = [ "\"", "'", "\\", ":" ]

	if( !string ) return;

	foreach( index, value in getInvalidChar )
	{
		if( string.find( value ) >= 0 ) string = SearchAndReplace( string, value, " " );
	}

	return string;
}

function SearchAndReplace( str, search, replace ) 
{
    local li = 0, ci = str.find( search, li ), res = "";
    while( ci != null ) 
    {
        if( ci > 0 ) 
        {
            res += str.slice( li, ci );
            res += replace;
        }
        else res += replace;
        li = ci + search.len(), ci = str.find( search, li );
    }
    if ( str.len() > 0 ) res += str.slice( li );
    return res;
}

function IsFloat( num )
{
	try
	{
		local a = num.tofloat();
		if( typeof a == "float" ) return true;
	}
	catch( _ ) _;

	return false;
}

function GetTok( string, separator, n, ... )
{
	local m = vargv.len() > 0 ? vargv[0] : n,
	tokenized = split( string, separator ),
	text = "";

	if ( n > tokenized.len() || n < 1 ) return null;
	for( ; n <= m; n++ )
	{
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	}
	return text;
}

function NumTok( string, separator )
{
	local tokenized = split( string, separator );
	return tokenized.len();
}

function GetTiming( secs )
{
	local ret = "";
	local hr = 0;
	local mn = 0;
	local dy = 0;

	mn = secs / 60;
	secs = secs - mn*60;
	hr = mn / 60;
	mn = mn - hr*60;
	dy = hr / 24;
	hr = hr - dy*24

	if ( dy > 0 ) ret = dy + " Days ";
	if ( hr > 0 ) ret = ret + hr + " Hours ";
	if ( mn > 0 ) ret = ret + mn + " Minutes ";
	ret = ret + secs +" Seconds";

	return ret;
}

function GetDate( time )
{
	return date( time ).day + "/" + ( date( time ).month + 1 ) + "/" + date( time ).year + " " + format( "%02d", date( time ).hour ) + ":" + format( "%02d", date( time ).min );
}

function ConvertToRGBA( str )
{
	local strip = split( str, "," );

	return RGBA( strip[0].tointeger(), strip[1].tointeger(), strip[2].tointeger(), 255 );
}

function GetFrontPosition(position, angle, gap) return Vector(position.x - gap * sin(angle), position.y + gap * cos(angle), position.z); 

function IsFloat( num )
{
	try
	{
		if( typeof num.tofloat() == "float" ) return true;
	}
	catch( e ) return false;
}
	
function IsNum( num )
{
	try
	{
		num = num.tointeger();
		if( typeof num == "integer" ) return true;
	}
	catch( e ) return false;
}

function accurate_seed() {
    local uptime = split(clock().tostring(), ".");
    uptime = uptime.len() > 1 ? uptime[0] + uptime[1] : uptime[0];
    return uptime.tointeger();
}

function CalculateAvg(arr) {
    local sum = 0, count = 0;
    foreach(entry in arr) {
        sum += entry;
        count++;
    }

    return sum.tofloat() / count.tofloat();
}

function CalculateVariance(arr) {
    local avg = CalculateAvg(arr);
    local sum = 0, count = 0;

    foreach (entry in arr) {
        sum += pow(entry - avg, 2);
        count++;
    }

    return sum.tofloat() / count.tofloat();
}

function CalculateJitter(arr) {
	return sqrt(CalculateVariance(arr));
}

function IsZero(id) {
	if( id == 0 ) return 1;
	else return id;
}

function FindClan( strPlayer )
{	
	try 
	{
		local
			 D_DELIM = regexp(@"([\[(=^<{]+\w+[\])=^>}]+)"),// Checking for double delimiter like [TX],{TX},(TX),=TX=,^TX^,<TX>
			 D_DELIM_SYM_2 = regexp(@"([\[(=^<{]+\w+[\.*-=]+\w+[\])=^>}]+)"),    // Checking the presence of symbolic clan tag with 2 alphanumeric values like [T-X]Azazel [ Double Delimiter ]
			 D_DELIM_SYM_3 = regexp(@"([\[(=^<{]+\w+[\.*-=]+\w+[\.*-=]+\w+[\])=^>}]+)"), // Checking the presence of symbolic clan tag with 3 alphanumeric values like [F.O.X]Sofia [ Double Delimiter ]
			 S_DELIM = regexp(@"(\w.+[.*=]+)"),               // Checking for single delimiter like VT. VT= VT*  

			 D_DELIM_res = D_DELIM.capture(strPlayer),// Capturing for the double delimiter expression in player.Name  [ will return some array blocks of clan as [TX] < WITH THE CLAN TAG SYMBOL INCLUDED>]
			 D_DELIM_SYM_2_res = D_DELIM_SYM_2.capture(strPlayer),  // Capturing for T-X / T.X / T*X Type
			 D_DELIM_SYM_3_res = D_DELIM_SYM_3.capture(strPlayer),  // Capturing for F-O-X / F.O.X / F*O*X Type 
			 S_DELIM_res = S_DELIM.capture(strPlayer);           // Capturing for the single delimiter expression in player.Name  [ will return some array blocks as VT. < WITH THE CLAN TAG SYMBOL INCLUDED>]

		if ( D_DELIM_res != null )      // Are captured expressions true ? Do they physically exist in memory?
		{
			return strPlayer.slice( D_DELIM_res[ 0 ].begin + 1, D_DELIM_res[ 0 ].end - 1 );   // Slicing [TX] into TX by moving 1 step forward from beginning & same step backward from the end  
		}
		else if ( D_DELIM_SYM_2_res != null )      
		{
			local tag_sym_2 = strPlayer.slice( D_DELIM_SYM_2_res[ 0 ].begin + 1, D_DELIM_SYM_2_res[ 0 ].end - 1 );   // Slicing [T-X] into T-X by moving 1 step forward from beginning & same step backward from the end  
			local amalgamate_2 = split(tag_sym_2, ".*-=");                      // Splitting T-X into 2 array blocks like a[0] = T, a[1] = X [ DEFINED BY SEPARATORS ]
			return (amalgamate_2[0]+amalgamate_2[1]);                         // Returning the Sum i.e. TX
		}
		else if ( D_DELIM_SYM_3_res != null )      // Are captured expressions true ? Do they physically exist in memory?
		{
			local tag_sym_3 = strPlayer.slice( D_DELIM_SYM_3_res[ 0 ].begin + 1, D_DELIM_SYM_3_res[ 0 ].end - 1 );   // Slicing [F.0.X] into F.O.X by moving 1 step forward from beginning & same step backward from the end  
			local amalgamate_3 = split(tag_sym_3, ".*-=");                      // Splitting F.O.X into 3 array blocks like a[0] = F, a[1] = 0, a[2] = X [ DEFINED BY SEPARATORS ]
			return (amalgamate_3[0]+amalgamate_3[1]+amalgamate_3[2]);           // Returning the Sum i.e. FOX
		
		}
		else if ( S_DELIM_res != null ) 
		{
			return strPlayer.slice( S_DELIM_res[ 0 ].begin, S_DELIM_res[ 0 ].end - 1 );	// Slicing VT. into VT by moving 1 step backward from the end
		}
			else return null;                            // No such expressions found? Probably player isn't in a clan. Let's return null !!!
	}
	catch( e ) return null;
}

function IsFloat( num )
{
	try
	{
		if( typeof num.tofloat() == "float" ) return true;
	}
	catch( e ) return false;
}
