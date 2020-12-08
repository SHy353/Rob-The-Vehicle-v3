class COperationWeek56 {
    /* 
    Missions 
    32 - Finish off 150 players with Colt45 or Python - 400
    33 - Kills 350 players with flamethrower/molotov - 400
    34 - Win 150 rounds - 400
    35 - Regen 15000 health with health pickup - 400
    
    
    36 - Vote on base 20 times - 200
    37 - Kills 25 players with RPG - 200
    38 - 20 players bonus - 200
    39 - Kill any staff members 200 times - 200 
    
    */


    function Mission32(player, weapon) {
        if (player.Data.Operation["Mission32"].DateComplete == 0) {
            if (weapon == SqWep.Colt45 || weapon == SqWep.Python) {
                if (player.Data.Operation["Mission32"].Progress.tointeger() <= 150) {
                    local value = player.Data.Operation["Mission32"].Progress.tointeger();

                    player.Data.Operation["Mission32"].Progress = (player.Data.Operation["Mission32"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission32"].Progress.tointeger() >= 150) {
                        player.Data.Operation["Mission32"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 400);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Finish off 150 players with Colt45 or Python", 400);
                    }
                }
            }
        }
    }

    function Mission33(player, weapon) {
        if (player.Data.Operation["Mission33"].DateComplete == 0) {
            if (weapon == 31) {
                if (player.Data.Operation["Mission33"].Progress.tointeger() <= 350) {
                    local value = player.Data.Operation["Mission33"].Progress.tointeger();

                    player.Data.Operation["Mission33"].Progress = (player.Data.Operation["Mission33"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission33"].Progress.tointeger() >= 350) {
                        player.Data.Operation["Mission33"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 400);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Kills 350 players with flamethrower/molotov", 400);
                    }
                }
            }
        }
    }

    function Mission34(player) {
        if (player.Data.Operation["Mission34"].DateComplete == 0) {
            if (player.Data.Operation["Mission34"].Progress.tointeger() <= 150) {
                local value = player.Data.Operation["Mission34"].Progress.tointeger();

                player.Data.Operation["Mission34"].Progress = (player.Data.Operation["Mission34"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission34"].Progress.tointeger() >= 150) {
                    player.Data.Operation["Mission34"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 400);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Win 150 rounds", 400);
                }
            }
        }
    }

    function Mission35(player,value) {
        if (player.Data.Operation["Mission35"].DateComplete == 0) {
            if (player.Data.Operation["Mission35"].Progress.tointeger() <= 15000) {
            //    local value = player.Data.Operation["Mission35"].Progress.tointeger();

                player.Data.Operation["Mission35"].Progress = (player.Data.Operation["Mission35"].Progress.tointeger() + value);

                if (player.Data.Operation["Mission35"].Progress.tointeger() >= 15000) {
                    player.Data.Operation["Mission35"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 400);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Regen 15000 health with health pickup", 400);
                }
            }
        }
    }

    function Mission36(player) {
        if (player.Data.Operation["Mission36"].DateComplete == 0) {
            if (player.Data.Operation["Mission36"].Progress.tointeger() <= 20) {
                local value = player.Data.Operation["Mission36"].Progress.tointeger();

                player.Data.Operation["Mission36"].Progress = (player.Data.Operation["Mission36"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission36"].Progress.tointeger() >= 20) {
                    player.Data.Operation["Mission36"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Vote on base 20 times", 200);
                }
            }
        }
    }

    function Mission37(player) {
        if (player.Data.Operation["Mission37"].DateComplete == 0) {
            if (player.Data.Operation["Mission37"].Progress.tointeger() <= 25) {
                local value = player.Data.Operation["Mission37"].Progress.tointeger();

                player.Data.Operation["Mission37"].Progress = (player.Data.Operation["Mission37"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission37"].Progress.tointeger() >= 25) {
                    player.Data.Operation["Mission37"].DateComplete = time();
                    Handler.Handlers.Operation.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Kills 25 players with RPG", 200);
                }
            }
        }
    }

    function Mission38(player) {
        if (player.Data.Operation["Mission38"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission38"].Progress.tointeger();

            player.Data.Operation["Mission38"].Progress = 1;

            player.Data.Operation["Mission38"].DateComplete = time();
            Handler.Handlers.Operation.AddXP(player, 200);

            SqCast.MsgPlr(player, "OperationMissionComplete", "20 players bonus", 200);
        }
    }

    function Mission39(player, victim) {
        if (player.Data.Operation["Mission39"].DateComplete == 0) {
            if (victim.Authority > 1) {
                if (player.Data.Operation["Mission39"].Progress.tointeger() <= 200) {
                    local value = player.Data.Operation["Mission39"].Progress.tointeger();

                    player.Data.Operation["Mission39"].Progress = (player.Data.Operation["Mission39"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission39"].Progress.tointeger() >= 200) {
                        player.Data.Operation["Mission39"].DateComplete = time();
                        Handler.Handlers.Operation.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Kill any staff members 200 times", 200);
                    }
                }
            }
        }
    }

}