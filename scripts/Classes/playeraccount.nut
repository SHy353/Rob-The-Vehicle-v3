class CPlayerAccount
{
	PlayerTempAccount = {};
	
	function constructor() 
	{
		
	}

	function GetAccountNameFromID( id )
	{
		local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_account WHERE ID = %d;", id.tointeger() );

	   	if( result.Step() )
		{
			return result.GetString( "Name" );
		}
		
		return "Undefined";
	}

	function GetOnlineFromAccountID( id )
	{
		if( typeof( id ) != "integer" ) return;
		try 
		{
			local plr = null;

			SqForeach.Player.Active( this, function( player ) 
			{
				if( typeof( player.Data.ID ) == "integer" )
				{
					if( player.Data.ID == id.tointeger() ) plr = player;
				}
			});

			return plr;
		}
		catch( _ ) _;
	}

	function GetOnlineFromAccountIDV2( id )
	{
		local plr = null;

		SqForeach.Player.Active( this, function( player ) 
		{
			if( player.Data.ID == id ) plr = player;
		});

		if( plr ) return plr;
		else return this.GetAccountNameFromID( id );
	}

}