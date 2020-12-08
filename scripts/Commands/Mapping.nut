SqCommand.Create( "addobject", "g", [ "Model" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( player.Data.aduty )
            {
                if( Handler.Handlers.Gameplay.Status > 2 )
                {
                    if( player.Data.IsEditing == "" )
					{
                        if( args.rawin( "Model" ) )
                        {
                            if( IsNum( args.Model ) )
                            {
                                try 
                                {
                                    local

                                    getPos = " " + ( player.PosX + 2 ) + " ," + ( player.PosY + 2 ) + ", " + ( player.PosZ + 1 ),
                                    object = Handler.Handlers.Objects.Create( player.Data.ID, args.Model.tointeger(), Vector3.FromStr( getPos ), Handler.Handlers.Gameplay.Bases );
                                                
                                    object.ShotReport  	= true;
                                    object.Alpha 		= 150;

                                    Handler.Handlers.Objects.Objects[ object.Tag ].IsEditing = true;
                                                
                                    player.Data.IsEditing = object.Tag;

                                    SqCast.MsgPlr( player, "ObjAdded", object.ID );
                                }
                                catch( e )  SqCast.MsgPlr( player, "ObjCreateErr", e );
                            }
                            else SqCast.MsgPlr( player, "ModelNotNum" );
                        }
                        else SqCast.MsgPlr( player, "AddObjectSyntax" );
                    }
                    else SqCast.MsgPlr( player, "CurrentInEditMode" );
                }
                else SqCast.MsgPlr( player, "BaseNotLoad" );
            }
            else SqCast.MsgPlr( player, "NotInAdminDuty" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "editobject", "g", [ "ID" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( player.Data.aduty )
            {
                if( Handler.Handlers.Gameplay.Status > 2 )
                {
                    if( player.Data.IsEditing == "" )
					{
                        if( args.rawin( "ID" ) )
                        {
                            if( IsNum( args.ID ) )
                            {
								if( Handler.Handlers.Objects.GetObjectMaxID( args.ID.tointeger() ) )
								{
									if( SqFind.Object.WithID( args.ID.tointeger() ).tostring() != "-1" )
									{
										local object = SqFind.Object.WithID( args.ID.tointeger() );
											
                                        if( Handler.Handlers.Objects.Objects.rawin( object.Tag ) )
										{
											if( !Handler.Handlers.Objects.Objects[ object.Tag ].IsEditing )
											{
												player.Data.IsEditing = object.Tag;

												Handler.Handlers.Objects.Objects[ object.Tag ].IsEditing = true;

                                                SqCast.MsgPlr( player, "EditingObject", object.Model, args.ID.tointeger() );

												object.Alpha = 150;
											}
											else SqCast.MsgPlr( player, "SomeoneEditing", Handler.Handlers.Objects.GetEditorName( object.Tag ) );
										}
										else SqCast.MsgPlr( player, "ObjectIDNotFound" );
									}
									else SqCast.MsgPlr( player, "ObjectIDNotFound" );
								}
								else SqCast.MsgPlr( player, "ObjectIDNotFound" );
                            }
                            else SqCast.MsgPlr( player, "ModelIDNotNum" );
                        }
                        else SqCast.MsgPlr( player, "EditObjectSyntax" );
                    }
                    else SqCast.MsgPlr( player, "CurrentInEditMode" );
                }
                else SqCast.MsgPlr( player, "BaseNotLoad" );
            }
            else SqCast.MsgPlr( player, "NotInAdminDuty" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});

SqCommand.Create( "findobject", "g", [ "Radius" ], 0, 1, -1, true, true ).BindExec( this, function( player, args )
{
    if( player.Data.Logged )
    {
        if( player.Authority > 1 )
        {
            if( player.Data.aduty )
            {
                if( Handler.Handlers.Gameplay.Status > 2 )
                {
                    if( player.Data.IsEditing == "" )
					{
                        if( args.rawin( "Radius" ) )
                        {
                            if( IsFloat( args.Radius ) )
                            {
                                local result = null;
                                SqForeach.Object.Active( this, function( Object )
                                {
                                    if( Object.Pos.DistanceTo( player.Pos ) < args.Radius.tofloat() )
                                    {
                                        if( result ) result = result +", Model [" + Object.Model + "] ID [ " + Object.ID + " ]"; 
                                        else result = "Model [" + Object.Model + "] ID [ " + Object.ID + " ]"; 
                                    }
                                });
                                    
                                if( result ) SqCast.MsgPlr( player, "ObjNearestFound", result );
                                else SqCast.MsgPlr( player, "ObjNotFound" );
                            }
                            else SqCast.MsgPlr( player, "RadiusNotFloat" );
                        }
                        else SqCast.MsgPlr( player, "FindObjSyntax" );
                    }
                    else SqCast.MsgPlr( player, "CurrentInEditMode" );
                }
                else SqCast.MsgPlr( player, "BaseNotLoad" );
            }
            else SqCast.MsgPlr( player, "NotInAdminDuty" );
        }
        else SqCast.MsgPlr( player, "ErrCmdNoPerm" );
    }
    else SqCast.MsgPlr( player, "ErrCmdNoLog" );

    return true;
});