missile_client <- {
	"config" : {
		"missile_clientside_code_shoot" : 6969,
		"missile_clientside_code_error" : 6970,
		"missile_weapon_id" : 127,
	},
	"on_shoot" : function(player, weapon, hitEntity, hitPosition){
		if(weapon != missile_client.config.missile_weapon_id){return;}
		local p = ::World.FindLocalPlayer();
		if(null == p){return;}
		if(player.ID != p.ID){return;}
		local data = Stream();
		if(null == hitEntity){
			data.WriteInt(missile_client.config.missile_clientside_code_error);
			data.WriteInt(0);//no target found
			::Server.SendData(data);
			return;
		} else if(null == hitPosition){
			data.WriteInt(missile_client.config.missile_clientside_code_error);
			data.WriteInt(0);//no target found
			::Server.SendData(data);
			return;
		} else {
			local from = ::Vector(player.Position);
			local to = ::Vector(hitPosition);
			local angle = ::atan2(from.Y - to.Y, from.X - to.X);
			angle = ::atan2(::sin(angle), ::cos(angle));
			from = ::Vector(from.X - 2.5 * ::cos(angle), from.Y - 2.5 * ::sin(angle), from.Z + 0.5);
			angle = ::atan2(::sin(angle - 1.58), ::cos(angle - 1.58));
			data.WriteInt(missile_client.config.missile_clientside_code_shoot);
			data.WriteFloat(from.X);
			data.WriteFloat(from.Y);
			data.WriteFloat(from.Z);
			data.WriteFloat(to.X);
			data.WriteFloat(to.Y);
			data.WriteFloat(to.Z);
			data.WriteFloat(angle);
			::Server.SendData(data);
		}
	},
}
