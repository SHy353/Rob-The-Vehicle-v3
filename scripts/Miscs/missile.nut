missile <- {
	"list" : {},
	"index_by_object_id" : {},
	"config" : {
		"game_world_id" : 1,
		"missile_clientside_code_shoot" : 6969,
		"missile_clientside_code_error" : 6970,
		"missile_speed" : 50.0, // in real life its around 100.0 metres per second
		"min_distance" : 20.0,
		"max_distance" : 1600.0, // also limited by combination ::missile.config.missile_liftime and ::missile.config.missile_speed, a missile can not to fly longer than ::missile.config.missile_liftime (20 seconds max) due object.MoveTo limitations, so make missile's speed faster if longer distance needed
		"missile_basetimer" : 30, // base timer, used to explode missile when time to explode and to remove outdated missiles
		"missile_liftime" : 20.0, // max liftime of missile in seconds to remove outdated missiles, set 20.0 maximum because of object.MoveTo limitations or bugs will be.
		"missile_clientside_shoot_errors" : [
			"no target found",
			"target is too far",
			"target is too close to you"
		]
	},
	"explode" : function(missile_ID){
		if(::missile.list.rawin(missile_ID)){
			local missile = ::missile.list.rawget(missile_ID);
			local playerCaused = SqPlayer.NullInst();
			local shooter = Handler.Handlers.Script.FindPlayer( missile.shooter_id);
			if(shooter){
				playerCaused = shooter;
			}
			::CreateExplosion(::missile.config.game_world_id, 10, missile.to, playerCaused, false);
			::missile.remove(missile_ID);
		}
	},
	"explode_here" : function(missile_ID, pos){
		if(::missile.list.rawin(missile_ID)){
			local missile = ::missile.list.rawget(missile_ID);
			local playerCaused = -1;
			local shooter = Handler.Handlers.Script.FindPlayer( missile.shooter_id);
			if(shooter){
				playerCaused = shooter;
			}
			::CreateExplosion(::missile.config.game_world_id, 10, pos, playerCaused, false);
			::missile.remove(missile_ID);
		}
	}
	"basetimer" : function(){
		local current_clock = SqChrono.EpochMilli();
		foreach(missile_ID, missile in ::missile.list){
			if(missile.explode >= current_clock){
				::missile.explode(missile_ID);
			}
			else if(missile.die >= current_clock){
				::missile.remove(missile_ID);
			}
		}
	},
	"on_bump" : function(object_id, body_ID){
		if(::missile.index_by_object_id.rawin(object_id)){
			local o = SqFind.Object.WithID(object_id);
			if(o){
				::missile.explode_here(::missile.index_by_object_id.rawget(object_id), o.Pos);
			}
		}
	},
	"on_shoot" : function(object_id, shooter_ID){
		if(::missile.index_by_object_id.rawin(object_id)){
			local o = SqFind.Object.WithID(object_id);
			if(o){
				::missile.explode_here(::missile.index_by_object_id.rawget(object_id), o.Pos);
			}
		}
	},
	"error" : function(error_id, shooter_ID){
		local p = Handler.Handlers.Script.FindPlayer(shooter_ID);
		if(p){
			if(0 == error_id){
				//no target found
				Handler.Handlers.Script.sendToClient( p, 200, SqCast.parseStr( p, "missleTargetXFound" ) );
			//	::PlaySoundForPlayer(p, 178);
				p.PlaySound( 178 );
				p.GiveWeapon(127, 0);//at localhost it will return used bullet, not sure if it will work for people with high ping in the internet
			} else if(1 == error_id){
				//target is too far
				Handler.Handlers.Script.sendToClient( p, 200, SqCast.parseStr( p, "missleTargetTooFar" ) );
			//	::PlaySoundForPlayer(p, 178);
				p.PlaySound( 178 );
				p.GiveWeapon(127, 0);
			} else if(2 == error_id){
				//target is too close to you
				Handler.Handlers.Script.sendToClient( p, 200, SqCast.parseStr( p, "missleTargetTooClose" ) );
			//	::PlaySoundForPlayer(p, 178);
				p.PlaySound( 178 );
				p.GiveWeapon(127, 0);
			}
		}
	},
	"remove" : function(missile_ID){
		if(::missile.list.rawin(missile_ID)){
			local object_id = ::missile.list[ missile_ID ].object_id;
			local o = SqFind.Object.WithID(object_id);
			if(o){
				o.Destroy();
			}
			if(::missile.index_by_object_id.rawin(object_id)){
				::missile.index_by_object_id.rawdelete(object_id);
			}
			::missile.list.rawdelete(missile_ID);
		}
	},
	"new" : function(from, to, angle, shooter_ID){
		/*
		this is not including an anticheat for unlimited ammunition (alot of players using that for sniper/rpg/grenades/molotov)
		this is not including an anticheat for fast shooting/no-reload (to flood missiles)
		this is not including an anticheat for fake stream data (to be able to shoot even without having a rpg)
		*/
		for(local i = 0; true; i++){
			if(!::missile.list.rawin(i)){
				local current_clock = SqChrono.EpochMilli();
				local missile = {
					"id" : i,
					"created" : current_clock,
					"die" : current_clock + ::missile.config.missile_liftime,
					"explode" : -1,
					"from" : from,
					"to" : to,
					"shooter_id" : shooter_ID,
					"object_id" : -1,
				}
				local dist = to.DistanceTo(from);
				if(::missile.config.min_distance > dist){
					::missile.error(2,shooter_ID);
					return;
				} else if(::missile.config.max_distance < dist){
					::missile.error(1,shooter_ID);
					return;
				}
				local time_to_target = (dist/::missile.config.missile_speed);
				if(time_to_target > ::missile.config.missile_liftime){
					::missile.error(1,shooter_ID);
					return;
				}
				local missile_object = SqObject.Create(273, 1, from, 255)
				if(null != missile_object){
					missile_object.BumpReport = true;
					missile_object.ShotReport = true;
				//	missile_object.RotateToEuler(::Vector3(0,0,angle), 0);
					missile.explode = current_clock + time_to_target;
					local move_to_time = time_to_target * 1000;
					move_to_time = move_to_time.tointeger();
					missile_object.MoveTo(to, move_to_time);
					::PlaySound(::missile.config.game_world_id, 59, from);
					missile.object_id = missile_object.ID;
					::missile.list.rawset(i, missile);
					::missile.index_by_object_id.rawset(missile.object_id, i);
				}
				break;
			}
		}
	}
}


local tim = SqRoutine( missile, missile.basetimer, ::missile.config.missile_basetimer, 0 );
tim.Quiet = false;