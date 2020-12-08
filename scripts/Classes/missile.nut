class CMissile
{
	function constructor() 
	{
		SqCore.On().PlayerAction.Connect( this, onPlayerActionChange );
		SqCore.On().ClientScriptData.Connect( this, onReceiveClientData );

		SqCore.On().ObjectTouched.Connect( this, onObjectBump );
	}

	function onPlayerActionChange( player, old, new )
	{
		if( new == 12 && ( player.Weapon == 127 ) )
		{
       	 	player.SetWeapon( 0,0 );
   	 	}
	}

	function onObjectBump( object, player )
	{
		missile.on_bump( object.ID, player.ID );
	}

	function onReceiveClientData( player, id, stream )
	{
		try 
		{
			switch( id )
			{
				case 6969:
				local from = Vector3( stream.ReadFloat(), stream.ReadFloat(), stream.ReadFloat() );
				local to = Vector3( stream.ReadFloat(), stream.ReadFloat(), stream.ReadFloat() );
				local angle = stream.ReadFloat();
				
				missile.new( from, to, angle, player.ID );
				break;

				case 6970:
				missile.error( stream.ReadInt(), player.ID );
				break;
			}
		}
		catch( e ) SqLog.Err( "Error on CMissile::onReceiveClientData, [%s]", e );
	}
}
