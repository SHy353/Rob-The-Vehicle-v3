class OperationWeek1 {
    /* Mission list 
        Get 500 Headshots Reward 200 points
        Deliver 50 Vehicles Reward 200 points
        Win 100 Round as attacker Reward 200 points
        Get 150 Kills with shotgun Reward 200 points
        Get 5 Spree in single round Reward 50 points
        Get 1 MVP Reward 50 points
        Win a round as defender Reward 50 points
        Play at least 1 hour Reward 50 points
    */

    function LoadData(player,str) {
        local json_data = {};
        if (::json_decode(str)) {
            json_data = ::json_decode(str);

            if (!json_data.rawin("Mission1")) {

                json_data.rawset("Mission1", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission2", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission3", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission4", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission5", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission6", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission7", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission8", {
                    Progress = 0,
                    DateComplete = 0,
                });
            }

            if (!json_data.rawin("Mission9")) {
                json_data.rawset("Mission9", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission10", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission11", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission12", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission13", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission14", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission15", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission16", {
                    Progress = 0,
                    DateComplete = 0,
                });

            }

            if (!json_data.rawin("Mission17")) {
                json_data.rawset("Mission17", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission18", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission19", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission20", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission21", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission22", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission23", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission24", {
                    Progress = 0,
                    DateComplete = 0,
                });

            }

            if (!json_data.rawin("Mission25")) {
                json_data.rawset("Mission25", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission26", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission27", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission28", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission29", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission30", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission31", {
                    Progress = 0,
                    DateComplete = 0,
                });
            }

            if (!json_data.rawin("Mission32")) {
                json_data.rawset("Mission32", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission33", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission34", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission35", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission36", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission37", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission38", {
                    Progress = 0,
                    DateComplete = 0,
                });

                json_data.rawset("Mission39", {
                    Progress = 0,
                    DateComplete = 0,
                });
            }

            player.Data.Operation = json_data;
        }

        SqCast.MsgPlr(player, "OperationIntro");
        SqCast.MsgPlr(player, "OperationScore", Handler.Handlers.Operation.getLevelAtExperience(player.Data.OperationScore), player.Data.OperationScore, Handler.Handlers.Operation.getExperienceAtLevel((Handler.Handlers.Operation.getLevelAtExperience(player.Data.OperationScore) + 1)));

    //    SqCast.MsgPlr(player, "OperationIntro1");
    }

    function getExperienceAtLevel(level) {
        local total = 0;
        for (local i = 1; i < level; ++i) {
            // total += floor((i + 100) * pow(2, i / 7.0));
            total += i + 100;
        }

        // return floor(total / 4);
        return total;
    }

    function getLevelAtExperience(experience) {
        local index;

        for (index = 0; index < 100; index++) {
            if (getExperienceAtLevel(index + 1) > experience)
                break;
        }

        return index;
    }

    function AddXP(player, xp) {
        local add_xp = (player.Data.OperationScore + xp);

        if (this.getLevelAtExperience(add_xp) > this.getLevelAtExperience(player.Data.OperationScore)) {
            for (local i = this.getLevelAtExperience(player.Data.OperationScore); i <= this.getLevelAtExperience(add_xp); i++) {
                if (this.getLevelAtExperience(player.Data.OperationScore) == i) continue;

                SqCast.MsgPlr(player, "OperationLevelUp", i);

                switch (i) {
                    case 5:
                        SqCast.MsgPlr(player, "OperationRewardUnlock", "Able to add text in lobby with /doodle");
                        break;
                    case 10:
                        SqCast.MsgPlr(player, "OperationRewardUnlock", "Change to cutomize color when entering vehicle (use /carcol to customize)");
                        break;

                    case 20:
                        SqCast.MsgPlr(player, "OperationRewardUnlock", "Ability to spawn health pickup (use /spawnhp)");
                        break;

                }
            }
        }

        player.Data.OperationScore = add_xp;
    }

    function Mission1(player, bodypart) {
        if (player.Data.Operation["Mission1"].DateComplete == 0) {
            if (bodypart == SqBodyPart.Head) {
                if (player.Data.Operation["Mission1"].Progress.tointeger() <= 500) {
                    local value = player.Data.Operation["Mission1"].Progress.tointeger();

                    player.Data.Operation["Mission1"].Progress = (player.Data.Operation["Mission1"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission1"].Progress.tointeger() >= 500) {
                        player.Data.Operation["Mission1"].DateComplete = time();
                        this.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 500 Headshots", 200);
                    }
                }
            }
        }
    }

    function Mission2(player) {
        if (player.Data.Operation["Mission2"].DateComplete == 0) {
            if (player.Data.Operation["Mission2"].Progress.tointeger() <= 50) {
                local value = player.Data.Operation["Mission2"].Progress.tointeger();

                player.Data.Operation["Mission2"].Progress = (player.Data.Operation["Mission2"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission2"].Progress.tointeger() >= 50) {
                    player.Data.Operation["Mission2"].DateComplete = time();
                    this.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Deliver 50 Vehicles", 200);
                }
            }
        }
    }

    function Mission3(player) {
        if (player.Data.Operation["Mission3"].DateComplete == 0) {
            if (player.Data.Operation["Mission3"].Progress.tointeger() <= 100) {
                local value = player.Data.Operation["Mission3"].Progress.tointeger();

                player.Data.Operation["Mission3"].Progress = (player.Data.Operation["Mission3"].Progress.tointeger() + 1);

                if (player.Data.Operation["Mission3"].Progress.tointeger() >= 100) {
                    player.Data.Operation["Mission3"].DateComplete = time();
                    this.AddXP(player, 200);

                    SqCast.MsgPlr(player, "OperationMissionComplete", "Win 100 Round as attacker", 200);
                }
            }
        }
    }

    function Mission4(player, weapon) {
        if (player.Data.Operation["Mission4"].DateComplete == 0) {
            if (weapon == SqWep.Shotgun || weapon == SqWep.Spas12 || weapon == SqWep.Stubby) {
                if (player.Data.Operation["Mission4"].Progress.tointeger() <= 150) {
                    local value = player.Data.Operation["Mission4"].Progress.tointeger();

                    player.Data.Operation["Mission4"].Progress = (player.Data.Operation["Mission4"].Progress.tointeger() + 1);

                    if (player.Data.Operation["Mission4"].Progress.tointeger() >= 150) {
                        player.Data.Operation["Mission4"].DateComplete = time();
                        this.AddXP(player, 200);

                        SqCast.MsgPlr(player, "OperationMissionComplete", "Get 150 Kills with shotgun", 200);
                    }
                }
            }
        }
    }

    function Mission5(player) {
        if (player.Data.Operation["Mission5"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission5"].Progress.tointeger();

            player.Data.Operation["Mission5"].Progress = 1;

            player.Data.Operation["Mission5"].DateComplete = time();
            this.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Get 5 Spree in single round", 50);
        }
    }

    function Mission6(player) {
        if (player.Data.Operation["Mission6"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission6"].Progress.tointeger();

            player.Data.Operation["Mission6"].Progress = 1;

            player.Data.Operation["Mission6"].DateComplete = time();
            this.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Get 1 MVP", 50);
        }
    }

    function Mission7(player) {
        if (player.Data.Operation["Mission7"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission7"].Progress.tointeger();

            player.Data.Operation["Mission7"].Progress = 1;

            player.Data.Operation["Mission7"].DateComplete = time();
            this.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Win a round as defender", 50);
        }
    }

    function Mission8(player) {
        if (player.Data.Operation["Mission8"].Progress.tointeger() != 1) {
            local value = player.Data.Operation["Mission8"].Progress.tointeger();

            player.Data.Operation["Mission8"].Progress = 1;

            player.Data.Operation["Mission8"].DateComplete = time();
            this.AddXP(player, 50);

            SqCast.MsgPlr(player, "OperationMissionComplete", "Play at least 1 hour", 50);
        }
    }

    function EnterVehicle(player, vehicle) {
        if (player.Data.OperationVehColor1 != 0 && player.Data.OperationVehColor1 != 0) {

            vehicle.PrimaryColor = player.Data.OperationVehColor1;
            vehicle.SecondaryColor = player.Data.OperationVehColor2;
        }
    }
}