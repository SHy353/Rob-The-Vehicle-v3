class COperationWeek2 {

    /* 
        Missions 

        9 - Get 50 kills with chainsaw - 200
        10 - Finish 5 matchs with 10 kills or above - 200
        11 - Get total 6 hours playtime - 200
        12 - Kill player from 50 meters or above 100 times - 200

        13 - Get 5 Win as defender - 50
        14 - Win a round with 0 dead - 50
        15 - Use any operation exclusive command 1 time - 50
        16 - Collect daily reward 5 times - 50 
    */

    function Mission9(player, weapon) {
        if (player.Data.Operation["Mission9"].DateComplete == 0) {
            if (weapon == SqWep.Chainsaw) {
                if (player.Data.Operation["Mission9"].Progress.tointeger() <= 50) {
                    local value = player.Data.Operation["Mission9"].Progress.tointeger();

                    player.Data.Operation["Mission9"].Progress = (player.Data.Operation["Mission9"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission9"].Progress.tointeger() >= 50) {
                        player.Data.Operation["Mission9"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 50 kills with Chainsaw", 200);
                    }
                }
            }
        }
    }

    function Mission10(player, kill) {
        if (player.Data.Operation["Mission10"].DateComplete == 0) {
            if (kill >= 10) {
                if (player.Data.Operation["Mission10"].Progress.tointeger() <= 5) {
                    local value = player.Data.Operation["Mission10"].Progress.tointeger();

                    player.Data.Operation["Mission10"].Progress = (player.Data.Operation["Mission10"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission10"].Progress.tointeger() >= 5) {
                        player.Data.Operation["Mission10"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Finish 5 matchs with 10 kills or above", 200);
                    }
                }
            }
        }
    }

    function Mission11(player, totaltime) {
        if (player.Data.Operation["Mission11"].DateComplete == 0) {
            if (player.Data.Operation["Mission11"].Progress.tointeger() <= 21600) {
                local value = player.Data.Operation["Mission11"].Progress.tointeger();

                player.Data.Operation["Mission11"].Progress = (player.Data.Operation["Mission11"].Progress.tointeger() + totaltime);

                if (player.Data.Operation["Mission11"].Progress.tointeger() >= 21600) {
                    player.Data.Operation["Mission11"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Get total 6 hours playtime", 200);
                }
            }
        }
    }

    function Mission12(player, dis) {
        if (player.Data.Operation["Mission12"].DateComplete == 0) {
            if (dis >= 50) {
                if (player.Data.Operation["Mission12"].Progress.tointeger() <= 100) {
                    local value = player.Data.Operation["Mission12"].Progress.tointeger();

                    player.Data.Operation["Mission12"].Progress = (player.Data.Operation["Mission12"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission12"].Progress.tointeger() >= 100) {
                        player.Data.Operation["Mission12"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Kill player from 50 meters or above 100 times", 200);
                    }
                }
            }
        }
    }

    function Mission13(player) {
        if (player.Data.Operation["Mission13"].DateComplete == 0) {
            if (player.Data.Operation["Mission13"].Progress.tointeger() <= 5) {
                local value = player.Data.Operation["Mission13"].Progress.tointeger();

                player.Data.Operation["Mission13"].Progress = (player.Data.Operation["Mission13"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission13"].Progress.tointeger() >= 5) {
                    player.Data.Operation["Mission13"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 50);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Get 5 win as Defender", 50);
                }
            }
        }
    }

    function Mission14(player, dead) {
        if (dead == 0) {
            if (player.Data.Operation["Mission14"].Progress.tointeger() != 1) {
                local value = player.Data.Operation["Mission14"].Progress.tointeger();

                player.Data.Operation["Mission14"].Progress = 1;

                player.Data.Operation["Mission14"].DateComplete = time();
                Handler.Handlers.Operation.AddXP(player, 50);

                SqCast.MsgPlr(player, "OperationMissionComplete", "Win a round with 0 dead", 50);
            }
        }
    }

    function Mission15(player) {
        if (player.Data.Operation["Mission15"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission15"].Progress.tointeger();

            player.Data.Operation["Mission15"].Progress = 1;

            player.Data.Operation["Mission15"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Use any operation exclusive command 1 time", 50);
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