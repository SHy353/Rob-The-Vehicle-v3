class CObject
{

	Objects		= {};

    function constructor() 
	{
        SqCore.On().ObjectShot.Connect( this, onPlayerShootOnObject );
        SqCore.On().PlayerKeyPress.Connect( this, onPlayerKeyDown );
        SqCore.On().PlayerKeyRelease.Connect( this, onPlayerKeyUp );
	}

	
	function Load()
	{		
		local result = Handler.Handlers.Script.Database.QueryF( "SELECT * FROM rtv3_objects" );

		while( result.Step() )
		{
			this.Objects.rawset( result.GetString( "UID" ).tolower(),
			{
				Model			= result.GetInteger( "Model" ),
				Pos				= Vector3.FromStr( result.GetString( "Pos" ) ),
				Rotation 		= Vector3.FromStr( result.GetString( "Euler" ) ),
				Bases			= result.GetInteger( "Bases" ),
				LastEdited		= result.GetInteger( "LastEdited" ),
				LastEditTime	= result.GetString( "LastEditTime" ),
				IsEditing		= false,
				instance     	= SqObject.NullInst(),
			});
		}

		SqLog.Scs( "Total objects loaded in table: %d", this.Objects.len() );
	}	
		
	
	function Create( creator, model, pos, bases )
	{
		local object = SqObject.Create( model, 1, pos, 255 ), getUID = "Object:" + SqHash.GetMD5( "" + time() );

		getUID.tolower();

		this.Objects.rawset( getUID,
		{
			Model			= model,
			Pos				= pos,
			Rotation 		= Vector3.FromStr( "0, 0, 0" ),
			Bases			= bases,
			LastEdited		= creator,
			LastEditTime	= time(),
			IsEditing		= false,
			instance     	= object,
		});

		this.Objects[ getUID ].instance.SetTag( getUID );

		Handler.Handlers.Script.Database.InsertF( "INSERT INTO `rtv3_objects` (`UID`, `Model`, `Pos`, `Euler`, `Bases`, `LastEdited`, `LastEditTime`)VALUES ( '%s', '%d', '%d', '%s', '%s', '%d', '%d' )", getUID, model, bases, pos.tostring(), Vector3.FromStr( "0,0,0" ).tostring(), creator, time() );
	
		return object;
	}	

	function Save( id )
	{
		local obj = this.Objects[ id ];

		obj.Pos 		= obj.instance.Pos;
		obj.Rotation 	= obj.instance.EulerRotation;

		Handler.Handlers.Script.Database.ExecuteF( "UPDATE rtv3_objects SET Pos = '%s', Euler = '%s', LastEdited = '%d', LastEditTime = '%d' WHERE UID = '%s'", obj.Pos.tostring(), obj.Rotation.tostring(), obj.LastEdited, time(), id );
	}

	function GetBaseObjectCount( bases )
	{
		local getCount = 0;
		
        foreach( index, value in this.Objects )
        {
            if( value.Bases == bases ) getCount++;
        }
		return getCount;
	}

	function RemoveAllObjectInBase( bases )
	{
        foreach( index, value in this.Objects )
        {
            if( value.Bases == bases )
            {
                value.instance.Destroy();

                value.instance = SqObject.NullInst();
            }
        }
	}
	
	function GetPlayerInsideWorld( world )
	{
		local getOldCount = 0;
		SqForeach.Player.Active(this, function(plr)
		{
			if( world == plr.World ) getOldCount ++;
		});
		return getOldCount
	}
	
	function CancelEditing( player )
	{
		local object = SqFind.Object.TagMatches( false, false, player.Data.IsEditing );

		if( object )
		{
			object.Alpha	= 255;

			this.Objects[ object.Tag ].IsEditing = false;
			this.Save( object.Tag );
				
			player.Data.IsEditing = "";
            SqCast.MsgPlr( player, "ObjSave" );
		}
	}

	function IsMoving( player )
	{
		try
		{
			return player.FindTask( "Editing" );
		}
		catch( _ ) _;
	
		return null;
	}

    function onPlayerShootOnObject( player, object, weapon )
    {
        if( player.Weapon == 109 )
        {
            if( player.Data.IsReg )
            {
                if( player.Data.Logged )
                {
                    if( player.Data.aduty )
                    {
                        if( player.Data.IsEditing == "" )
                        {
                            if( this.Objects.rawin( object.Tag ) )
                            {
                                if( !this.Objects[ object.Tag ].IsEditing )
                                {
                                    player.Data.IsEditing = object.Tag;

                                    this.Objects[ object.Tag ].IsEditing = true;

                                    player.Msg( TextColor.Sucess, Lang.ObjEditingWithModel[ player.Data.Language ], object.Model, TextColor.Sucess, object.ID );

                                    SqCast.MsgPlr( player, "ObjSave" );

                                    object.Alpha = 150;

                                    if( !SqWorld.GetPrivateWorld( player.World ) ) ::SendMessageToDiscord( format( "**%s** is editing object. **Model** %d **World** %d", player.Name, object.Model, player.World ), "mapping" );
                                }
                            }
                        }
                    }

                    else 
                    {
                        player.Msg( TextColor.InfoS, Lang.ObjGetModel[ player.Data.Language ], object.Model );
                    }
                }
            }
        }
    }

    function onPlayerKeyDown( player, key )
    {
        if( player.Data.IsEditing.find( ":" ) >= 0 )
        {	
            local stripType = split( player.Data.IsEditing, ":" );
            
            switch( stripType[0].tolower() )
            {
                case "object":
                local 
                object = SqFind.Object.TagMatches( false, false, player.Data.IsEditing );

                switch( key.Tag )
                {
                    case "Up":
                    case "Down":
                    case "Left":
                    case "Right":
                    case "Forward":
                    case "Backward":
                    player.MakeTask( function()
                    {
                        if( object.tostring() != "-1" )
                        {
                            switch( key.Tag )
                            {
                                case "Up":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    local origin = object.Pos;
                                    object.Pos = Vector3( origin.x, origin.y, origin.z + player.Data.EditSens );
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerZ = player.Data.EditSens;
                                    break;
                                }
                                break;
                                
                                case "Down":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    local origin = object.Pos;
                                    object.Pos = Vector3( origin.x, origin.y, origin.z - player.Data.EditSens );
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerZ = -player.Data.EditSens;
                                    break;
                                }
                                break;
                                
                                case "Left":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    object.PosX += player.Data.EditSens;
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerX = player.Data.EditSens;
                                    break;
                                }
                                break;
                                
                                case "Right":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    object.PosX -= player.Data.EditSens;
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerX = -player.Data.EditSens;
                                    break;
                                }
                                break;
                                
                                case "Forward":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    object.PosY += player.Data.EditSens;
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerY = player.Data.EditSens;
                                    break;
                                }
                                break;
                                
                                case "Backward":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    object.PosY -= player.Data.EditSens;
                                    break;
                                    
                                    case "Angle":
                                    object.RotateByEulerY = -player.Data.EditSens;
                                    break;
                                }
                                break;
                            }
                        }
                        else 
                        {
                            this.Terminate();
                            player.Data.IsEditing = "";
                        }
                    }, 100, 0 ).SetTag( "Editing" );
                    break;
                    
                    case "Delete":
                    if( !this.IsMoving( player ) )
                    {
                        Handler.Handlers.Script.Database.ExecuteF( "DELETE FROM rtv3_objects WHERE Lower(UID) = '%s'", object.Tag.tolower() );

                        this.Objects.rawdelete( object.Tag );
                                                    
                        object.Destroy();
                        
                        player.Data.IsEditing = "";

                        SqCast.MsgPlr( player, "ObjDeleted" );
                    }
                    break;
                        
                    case "Backspace":
                    if( !this.IsMoving( player ) )
                    {
                        object.Alpha          = 255;
                        this.Objects[ object.Tag ].IsEditing = false;
                        this.Save( object.Tag );
                            
                        player.Data.IsEditing = "";

                        SqCast.MsgPlr( player, "ObjSave" );
                    }
                    break;
                        
                    case "Clone":
                    if( !this.IsMoving( player ) )
                    {
                        try 
                        {
                            object.Alpha          = 255;
                            this.Objects[ object.Tag ].IsEditing = false;
                            this.Save( object.Tag );
                                
                            local object1 = this.Create( player.Data.ID, object.Model, object.Pos, Handler.Handlers.Gameplay.Bases );
                                            
                            object1.ShotReport  	= true;
                            object1.Alpha 			= 150;

                            object1.RotateByEuler( object.EulerRotation, 0 );
                                    
                            this.Objects[ object1.Tag ].IsEditing = true;
                                            
                            player.Data.IsEditing = object1.Tag;

                            SqCast.MsgPlr( player, "ObjClone", object1.ID );
                        }
                        catch( e ) SqCast.MsgPlr( player, "ObjCloneErr", e );
                    }
                    break;
                }
                break;
                    
            /*    case "pickup":
                local pickup = SqFind.Pickup.TagMatches( false, false, player.Data.IsEditing );

                switch( key.Tag )
                {
                    case "Up":
                    case "Down":
                    case "Left":
                    case "Right":
                    case "Forward":
                    case "Backward":
                    player.MakeTask( function()
                    {
                        if( pickup.tostring() != "-1" )
                        {
                            switch( key.Tag )
                            {
                                case "Up":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    local origin = pickup.Pos;
                                    pickup.Pos = Vector3( origin.x, origin.y, origin.z + player.Data.EditSens );
                                    break;
                                            
                                    case "Sens":
                                    player.Data.EditSens += 0.1;
                                    player.Msg( TextColor.InfoS, Lang.EditSensPlus[ player.Data.Language ], player.Data.EditSens );
                                    break;
                                }
                                break;
                                        
                                case "Down":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    local origin = pickup.Pos;
                                    pickup.Pos = Vector3( origin.x, origin.y, origin.z - player.Data.EditSens );
                                    break;
                                                                        
                                    case "Sens":
                                    player.Data.EditSens -= 0.1;
                                    player.Msg( TextColor.InfoS, Lang.EditSensMinus[ player.Data.Language ], player.Data.EditSens );
                                    break;
                                }
                                break;
                                        
                                case "Left":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    pickup.PosX += player.Data.EditSens;
                                    break;
                                }
                                break;
                                        
                                case "Right":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    pickup.PosX -= player.Data.EditSens;
                                    break;
                                }
                                break;
                                        
                                case "Forward":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    pickup.PosY += player.Data.EditSens;
                                    break;
                                }
                                break;
                                        
                                case "Backward":
                                switch( player.Data.EditingMode )
                                {
                                    case "XYZ":
                                    pickup.PosY -= player.Data.EditSens;
                                    break;
                                }
                                break;
                            }
                        }
                        else 
                        {
                            this.Terminate();
                            player.Data.IsEditing = "";
                        }
                    }, 100, 0 ).SetTag( "Editing" );
                    break; 
                
                    case "Delete":
                    if( !SqObj.IsMoving( player ) )
                    {
                        Handler.Handlers.Script.Database.Exec( format( "DELETE FROM Pickups WHERE Lower(UID)= '%s'", pickup.Tag.tolower() ) );

                        SqPick.Pickups.rawdelete( pickup.Tag );

                        pickup.Destroy();
                                
                        player.Data.IsEditing = "";
                        player.Msg( TextColor.InfoS, Lang.PickupDel[ player.Data.Language ] );
                    }
                    break;
                                
                    case "Backspace":
                    if( !SqObj.IsMoving( player ) )
                    {
                        pickup.Alpha          = 255;
                        SqPick.Pickups[ pickup.Tag ].IsEditing = false;

                        SqPick.Save( pickup.Tag );
                                    
                        player.Data.IsEditing = "";
                        player.Msg( TextColor.InfoS, Lang.PickSaved[ player.Data.Language ] );
                    }
                    break;
                }
                break;
            }*/
            }
        }
        
        switch( key.Tag )
        {
            case "F1":
            switch( player.Data.EditingMode )
            {
                case "XYZ":
                player.Data.EditingMode = "Angle";
                SqCast.MsgPlr( player, "EditTypeSwitch", "Angle" );
                break;
                        
                case "Angle":
                player.Data.EditingMode = "XYZ";
                SqCast.MsgPlr( player, "EditTypeSwitch", "XYZ" );
                break;
            }
            break;
        }
    }

    function onPlayerKeyUp( player, key )
    {
        switch( key.Tag )
        {
            case "Up":
            case "Down":
            case "Left":
            case "Right":
            case "Forward":
            case "Backward":
            try 
            {
                player.FindTask( "Editing" ).Terminate();
            } 
            catch(_) _;			
            break;
        }
    }
   
   	function GetObjectMaxID( value )
	{
		if( SqMath.IsLess( value, 3000 ) && SqMath.IsGreaterEqual( value, -1 ) ) return true;
		
		else return false;
	}

    function GetEditorName( tag )
    {
        local name = "None";

 		SqForeach.Player.Active( this, function( plr ) 
        {
            if( plr.Data.IsEditing == tag ) name = plr.Name;
		});
       
       return name;
    }
}