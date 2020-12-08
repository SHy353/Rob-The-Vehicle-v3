class COperationWeek3 {

    /* 
        Missions 

        17 - Get 500 kills with Ruger - 200
        18 - Win 100 as defender - 200
        19 - Get 300 headshots with any sniper rifles - 200
        20 - Get 5 win streaks in single session - 200

        21 - Pick health or armour pickup which spawned by player - 50
        22 - Get 5 kills with RPG - 50
        23 - Spawn as spectator - 50
    */

    function Mission17(player, weapon) {
        if (player.Data.Operation["Mission17"].DateComplete == 0) {
            if (weapon == SqWep.Ruger) {
                if (player.Data.Operation["Mission17"].Progress.tointeger() <= 500) {
                    local value = player.Data.Operation["Mission17"].Progress.tointeger();

                    player.Data.Operation["Mission17"].Progress = (player.Data.Operation["Mission17"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission17"].Progress.tointeger() >= 50) {
                        player.Data.Operation["Mission17"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 500 kills with Ruger", 200);
                    }
                }
            }
        }
    }

    function Mission18(player) {
        if (player.Data.Operation["Mission18"].DateComplete == 0) {
            if (player.Data.Operation["Mission18"].Progress.tointeger() <= 100) {
                local value = player.Data.Operation["Mission18"].Progress.tointeger();

                player.Data.Operation["Mission18"].Progress = (player.Data.Operation["Mission18"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission18"].Progress.tointeger() >= 100) {
                    player.Data.Operation["Mission18"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Win 100 as defender", 200);
                }
            }
        }
    }

    function Mission19(player, weapon, bodypart) {
        if (player.Data.Operation["Mission19"].DateComplete == 0) {
            if (weapon == SqWep.Sniper || weapon == SqWep.Laserscope && bodypart == SqBodyPart.Head) {
                if (player.Data.Operation["Mission19"].Progress.tointeger() <= 300) {
                    local value = player.Data.Operation["Mission19"].Progress.tointeger();

                    player.Data.Operation["Mission19"].Progress = (player.Data.Operation["Mission19"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission19"].Progress.tointeger() >= 300) {
                        player.Data.Operation["Mission19"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 300 headshots with any sniper rifles", 200);
                    }
                }
            }
        }
    }

    function Mission20(player) {
        if (player.Data.Operation["Mission20"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission20"].Progress.tointeger();

            player.Data.Operation["Mission20"].Progress = 1;

            player.Data.Operation["Mission20"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 200);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Get 5 win streaks in single session", 200);
        }
    }

    function Mission21(player) {
        if (player.Data.Operation["Mission21"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission21"].Progress.tointeger();

            player.Data.Operation["Mission21"].Progress = 1;

            player.Data.Operation["Mission21"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Pick health or armour pickup which spawned by player", 50);
        }
    }

    function Mission22(player) {
        if (player.Data.Operation["Mission22"].DateComplete == 0) {
            if (player.Data.Operation["Mission22"].Progress.tointeger() <= 5) {
                local value = player.Data.Operation["Mission22"].Progress.tointeger();

                player.Data.Operation["Mission22"].Progress = (player.Data.Operation["Mission22"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission22"].Progress.tointeger() >= 5) {
                    player.Data.Operation["Mission22"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 50);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Get 5 kills with RPG", 50);
                }
            }
        }
    }

    function Mission23(player) {
        if (player.Data.Operation["Mission23"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission23"].Progress.tointeger();

            player.Data.Operation["Mission23"].Progress = 1;

            player.Data.Operation["Mission23"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Spawn as spectator", 50);
        }
    }

    function Mission16(player) {
        if (player.Data.Operation["Mission16"].Progress.tointeger() <= 5) {
            local value = player.Data.Operation["Mission16"].Progress.tointeger();

            player.Data.Operation["Mission16"].Progress = (player.Data.Operation["Mission16"].Progress.tointeger() + 1);

            if (player.Data.Operation["Mission16"].Progress.tointeger() >= 5) {
                player.Data.Operation["Mission16"].DateComplete = time();
                Handler.Handlers.Operation.AddXP(player, 50);

                SqCast.MsgPlr(player, "OperationMissionComplete", "Collect daily reward 5 times", 50);
            }
        }
    }

}