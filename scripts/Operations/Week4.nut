class COperationWeek4 {

    /* 
        Missions 

        24 - Get 500 kills with M4 - 200
        25 - Get 15 MVP - 200
        26 - Get total 15 hours playtime - 200
        27 - Kill player below 5 meteres 250 times - 200

        28 - 15 players or above in server bonus - 100 
        29 - Play at least 2 hours  - 50
        30 - Kill any staff member 50 times - 50
        31 - Kill FrailyV 5 times without dying - 50
    */

    function Mission24(player, weapon) {
        if (player.Data.Operation["Mission24"].DateComplete == 0) {
            if (weapon == SqWep.M4) {
                if (player.Data.Operation["Mission24"].Progress.tointeger() <= 500) {
                    local value = player.Data.Operation["Mission24"].Progress.tointeger();

                    player.Data.Operation["Mission24"].Progress = (player.Data.Operation["Mission24"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission24"].Progress.tointeger() >= 500) {
                        player.Data.Operation["Mission24"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 500 kills with M4", 200);
                    }
                }
            }
        }
    }

    function Mission25(player) {
        if (player.Data.Operation["Mission25"].DateComplete == 0) {
            if (player.Data.Operation["Mission25"].Progress.tointeger() <= 15) {
                local value = player.Data.Operation["Mission25"].Progress.tointeger();

                player.Data.Operation["Mission25"].Progress = (player.Data.Operation["Mission25"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission25"].Progress.tointeger() >= 15) {
                    player.Data.Operation["Mission25"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Get 15 MVP", 200);
                }
            }
        }
    }

    function Mission26(player, totaltime) {
        if (player.Data.Operation["Mission26"].DateComplete == 0) {
            if (player.Data.Operation["Mission26"].Progress.tointeger() <= 54000) {
                local value = player.Data.Operation["Mission26"].Progress.tointeger();

                player.Data.Operation["Mission26"].Progress = (player.Data.Operation["Mission26"].Progress.tointeger() + totaltime);

                if (player.Data.Operation["Mission26"].Progress.tointeger() >= 54000) {
                    player.Data.Operation["Mission26"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Get total 15 hours playtime", 200);
                }
            }
        }
    }

    function Mission27(player, dis) {
        if (player.Data.Operation["Mission27"].DateComplete == 0) {
            if (dis <= 5) {
                if (player.Data.Operation["Mission27"].Progress.tointeger() <= 250) {
                    local value = player.Data.Operation["Mission27"].Progress.tointeger();

                    player.Data.Operation["Mission27"].Progress = (player.Data.Operation["Mission27"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission27"].Progress.tointeger() >= 250) {
                        player.Data.Operation["Mission27"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Kill player below 5 meteres 250 times", 200);
                    }
                }
            }
        }
    }

    function Mission28(player) {
        if (player.Data.Operation["Mission28"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission28"].Progress.tointeger();

            player.Data.Operation["Mission28"].Progress = 1;

            player.Data.Operation["Mission28"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 100);

            SqCast.MsgPlr(player, "OperationMissionComplete", "15 players or above in server bonus", 100);
        }
    }

    function Mission29(player) {
        if (player.Data.Operation["Mission29"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission29"].Progress.tointeger();

            player.Data.Operation["Mission29"].Progress = 1;

            player.Data.Operation["Mission29"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Play at least 2 hours", 50);
        }
    }

    function Mission30(player, victim) {
        if (player.Data.Operation["Mission30"].DateComplete == 0) {
            if (victim.Authority > 1) {
                if (player.Data.Operation["Mission30"].Progress.tointeger() <= 50) {
                    local value = player.Data.Operation["Mission30"].Progress.tointeger();

                    player.Data.Operation["Mission30"].Progress = (player.Data.Operation["Mission30"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission30"].Progress.tointeger() >= 50) {
                        player.Data.Operation["Mission30"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 50);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Kill any staff member 50 times", 50);
                    }
                }
            }
        }
    }

    function Mission31(player, victim) {
        if (player.Data.Operation["Mission31"].DateComplete == 0) {
            if (victim.Data.ID == 616) {
                player.Data.FragileMission++;
                if (player.Data.FragileMission >= 5) {
                    local value = player.Data.Operation["Mission31"].Progress.tointeger();

                    player.Data.Operation["Mission31"].Progress = 1;

                    player.Data.Operation["Mission31"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 50);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Kill " + Handler.Handlers.PlayerAccount.GetAccountNameFromID( 616 ) + " 5 times without dying", 50);
                }
            }

            if (player.Data.ID == 616) {
                local value = player.Data.Operation["Mission31"].Progress.tointeger();

                player.Data.Operation["Mission31"].Progress = 1;

                player.Data.Operation["Mission31"].DateComplete = time();
                Handler.Handlers.Operation.AddXP(player, 50);

                SqCast.MsgPlr(player, "OperationMissionComplete", "Kill " + Handler.Handlers.PlayerAccount.GetAccountNameFromID( 616 ) + " 5 times without dying", 50);
            }
        }
    }
}