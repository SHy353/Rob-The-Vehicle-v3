class CDiscord {
    // To hold the raw session
    session = null;

    isConnected = false;

    function constructor() {
        // Initialize the session
        session = SqDiscord.Session();

        // Bind our events
        session.Bind(SqDiscordEvent.Ready, this, onReady);
        session.Bind(SqDiscordEvent.Message, this, onMessage);
        session.Bind(SqDiscordEvent.Error, this, onError);

        session.ErrorEventEnabled = false;
    }

    function Connect(token) {
        session.Connect(token);
    }

    function onError(code, message) {
        if (code != 429 && code != 5005)
            SqLog.Err("%d - %s", code, message);
    }

    function ToDiscord(id, ...) {
        if (isConnected) {
            vargv.insert(0, this);

            local text = format.acall(vargv)

            switch (id) {
                case 6:
                case 7:
                case 8:
                    this.SimpleEmbed(id, text);
                    break;

                default:
                    session.Message(Handler.Handlers.Script.EchoChannel, text);
                    break;
            }
        }

    }

    function sendToStaff(id, ...) {
        if (isConnected) {
            vargv.insert(0, this);

            local text = format.acall(vargv)

            switch (id) {
                case 6:
                    local embed = ::SqDiscord.Embed.Embed();
                    embed.SetTitle(text);
                    embed.SetColor(0x1EFF00);

                    session.MessageEmbed(Handler.Handlers.Script.StaffChannel, "", embed);
                    break;

                case 7:
                    local embed = ::SqDiscord.Embed.Embed();
                    embed.SetTitle(text);
                    embed.SetColor(0xFF0000);

                    session.MessageEmbed(Handler.Handlers.Script.StaffChannel, "", embed);
                    break;

                case 8:
                    local embed = ::SqDiscord.Embed.Embed();
                    embed.SetTitle(text);
                    embed.SetColor(0xFFEA00);

                    session.MessageEmbed(Handler.Handlers.Script.StaffChannel, "", embed);
                    break;
                    break;

                default:
                    session.Message(Handler.Handlers.Script.StaffChannel, text);
                    break;
            }
        }

    }

    function sendEmbed(channelID, content, embed) {
        session.MessageEmbed(channelID, content, embed);
    }

    function SendPlayerCount(left = false) {
        if (isConnected) {
            if (Handler.Handlers.Script.PlayerCountChannel != "") session.EditChannel(Handler.Handlers.Script.PlayerCountChannel, "Player Online: " + GetPlayers(), "");
        }
    }

    function PartReason(player, reason) {
        switch (reason) {
            case 1:
                reason = "**%s** disconnected from the server.";
                break;
            case 0:
                reason = "**%s** lost connection to server.";
                break;
            case 2:
                reason = "**%s** has been kicked from the server.";
                break;
            case 3:
                reason = "**%s** game crashed.";
                break;
        }

        this.ToDiscord(7, reason, player);
    }

    // Event onReady (Very first event for doing discord related stuff)
    function onReady() {
        ::SqLog.Inf("Discord bot connection established successfully.");

        /*        local embed = ::SqDiscord.Embed.Embed();
                embed.SetTitle("title here");
                embed.SetDescription("description here");

                local field = ::SqDiscord.Embed.EmbedField();
                field.SetName("field #1");
                field.SetValue("value");

                embed.AddField(field);
                sendEmbed(Handler.Handlers.Script.EchoChannel, "content here", embed);

             /*   sendMessage(Handler.Handlers.Script.EchoChannel, "message here");*/

        isConnected = true;
    }

    // Event onMessage is called when a message is recieved to an acessible channel to bot
    function onMessage(channelID, author, authorNick, authorID, roles, message) {
        /*	::SqLog.Inf("Channel ID: " + channelID);
        	::SqLog.Inf("Author: " + author);
        	::SqLog.Inf("Author Nick: " + authorNick);
        	::SqLog.Inf("Author ID: " + authorID);
        	::SqLog.Inf("Message: " + message);
        	
        	foreach(role in roles) {
        		::SqLog.Inf("Role: " + role);
        		::SqLog.Inf("Role Name: " + session.GetRoleName("339341411860086784", role));
        	}*/
        if (authorID == Handler.Handlers.Script.BotID) return;

        local user = (authorNick == "") ? author : authorNick;
        local level = this.AssignUserlevel(roles);
        if (Handler.Handlers.Script.EchoChannel == channelID) this.ProcessMessage(user, message);
        if (Handler.Handlers.Script.StaffChannel == channelID) this.ProcessMessageAdmin(user, level, message);
    }

    function AssignUserlevel(roles) {
        foreach(role in roles) {
            switch (role) {
                case "541196804650172447":
                case "674581818783301634":
                    return 4;

                case "566727867434533021":
                    return 3;

                case "558975524022517806":
                    return 2;

                case "558975653735825409":
                    return 1;

                default:
                    return 0;
            }
        }
    }

    function SimpleEmbed(id, text) {
        switch (id) {
            case 6:
                local embed = ::SqDiscord.Embed.Embed();
                embed.SetTitle(text);
                embed.SetColor(0x1EFF00);

                session.MessageEmbed(Handler.Handlers.Script.EchoChannel, "", embed);
                break;

            case 7:
                local embed = ::SqDiscord.Embed.Embed();
                embed.SetTitle(text);
                embed.SetColor(0xFF0000);

                session.MessageEmbed(Handler.Handlers.Script.EchoChannel, "", embed);
                break;

            case 8:
                local embed = ::SqDiscord.Embed.Embed();
                embed.SetTitle(text);
                embed.SetColor(0xFFEA00);

                session.MessageEmbed(Handler.Handlers.Script.EchoChannel, "", embed);
                break;
        }
    }

    function ProcessMessage(user, message) {
        local
        isadmin = 0,
            plr = user,
            cmds = split(message.slice(0), " ")[0],
            arr = split(message, " ").len() > 1 ? message.slice(message.find(" ") + 1) : "";

        switch (cmds) {
            case "!cmds":
                //    this.ToDiscord(3, "**!players, !stats, !pinfo, !roundinfo, !serverinfo**");
                this.ToDiscord(3, "**!players**");
                break;

            case "!acmds":
                if (isadmin > 1) {
                    if (isadmin == 3) this.ToDiscord(10, "**!setweather**");
                    else if (isadmin == 4) this.ToDiscord(10, "**!setweather, !removeacc**");
                    else if (isadmin == 5) this.ToDiscord(10, "**!setweather, !removeacc, !lockserver, !unlockserver**");
                    else if (isadmin == 6) this.ToDiscord(10, "**!setweather, !removeacc, !lockserver, !unlockserver, !exe**");
                }
                break;

            case "!players":
                local count = 0, unknowncount = 0, blue = null, red = null, unknown = null;
                local gameplay = Handler.Handlers.Gameplay;
                local pdata = {};

                SqForeach.Player.Active(this, function(player) {
                    if (player.Team == 1 && player.Spawned) {
                        if (red) red = red + ", " + player.Name;
                        else red = player.Name;
                    }

                    if (player.Team == 2 && player.Spawned) {
                        if (blue) blue = blue + ", " + player.Name;
                        else blue = player.Name;
                    }

                    if (!player.Spawned || player.Team == 7) {
                        if (unknown) unknown += ", " + player.Name;
                        else unknown = player.Name;
                        unknowncount++;
                    }

                    count++;
                });

                if (!red) red = "None";
                if (!blue) blue = "None";
                if (!unknown) unknown = "None";

                /*   if (red) pdata.rawset("Red", red);
                   if (blue) pdata.rawset("Blue", blue);
                   if (unknown) pdata.rawset("Unspawn", unknown);*/

                if (count > 0) {

                    local embed = ::SqDiscord.Embed.Embed();
                    embed.SetTitle("Players Online");
                    embed.SetColor(0xCD1AEC);

                    local field = ::SqDiscord.Embed.EmbedField();
                    field.SetName("Red");
                    field.SetValue(red);

                    local field2 = ::SqDiscord.Embed.EmbedField();
                    field2.SetName("Blue");
                    field2.SetValue(blue);

                    local field3 = ::SqDiscord.Embed.EmbedField();
                    field3.SetName("Unspawned");
                    field3.SetValue(unknown);

                    local field4 = ::SqDiscord.Embed.EmbedField();
                    field4.SetName("Total Players");
                    field4.SetValue(count);

                    embed.AddField(field);
                    embed.AddField(field2);
                    embed.AddField(field3);
                    session.MessageEmbed(Handler.Handlers.Script.EchoChannel, "", embed);

                } else this.ToDiscord(3, "**No player online** :sob:");
                break;

                /*   case "!stats":
                       if (arr != " ") {
                           local q = Handler.Handlers.Script.Database.QueryF("SELECT * FROM rtv3_account INNER JOIN rtv3_pstats ON rtv3_account.ID = rtv3_pstats.ID WHERE Lower(Name) = '%s'", arr.tolower());
                           local pdata = {};

                           if (q.Step()) {
                               local ratio = (typeof(q.GetFloat("Kills") / q.GetFloat("Deaths")) != "float") ? 0.0 : q.GetFloat("Kills") / q.GetFloat("Deaths");

                               pdata.rawset("Name", q.GetString("Name"));
                               pdata.rawset("Kills", q.GetInteger("Kills"));
                               pdata.rawset("Deaths", q.GetInteger("Deaths"));
                               pdata.rawset("Ratio", ratio);

                               pdata.rawset("TopSpree", q.GetInteger("TopSpree"));
                               pdata.rawset("Stolen", q.GetInteger("Stolen"));

                               pdata.rawset("RoundPlayed", q.GetInteger("RoundPlayed"));
                               pdata.rawset("WinAtt", q.GetInteger("AttWon"));
                               pdata.rawset("WinDef", q.GetInteger("DefWon"));
                               pdata.rawset("MVP", q.GetInteger("MVP"));

                               if (arr.tolower().find("kiki") >= 0 || arr.tolower().find("kingofvc") >= 0) pdata.rawset("Image", "https://a.rsg.sc//n/kikita0106/n");
                               else pdata.rawset("Image", "https://cdn.discordapp.com/icons/339341411860086784/ed4f466c9825284242b8ffa9d674b820.webp");

                               this.ToDiscord2(4, pdata);
                           } else this.ToDiscord(1, "**Error: ** Player does not exist.");
                       } else this.ToDiscord(1, "**Syntax: ** !stats [player]");
                       break;

                /*   case "!pinfo":
                   case "!playerinfo":
                       if (arr != " ") {
                           local q = Handler.Handlers.Script.Database.QueryF("SELECT * FROM rtv3_account INNER JOIN rtv3_pstats ON rtv3_account.ID = rtv3_pstats.ID WHERE Lower(Name) = '%s'", arr.tolower());
                           local pdata = {};

                           if (q.Step()) {
                               pdata.rawset("Name", q.GetString("Name"));
                               pdata.rawset("DateReg", ::GetDate(q.GetInteger("DateReg")));
                               pdata.rawset("DateLog", ::GetDate(q.GetInteger("DateLog")));
                               pdata.rawset("Playtime", ::GetTiming(q.GetInteger("Playtime")));
                               pdata.rawset("Position", ::GetRank(q.GetInteger("AdminLevel")));

                               if (arr.tolower().find("kiki") >= 0 || arr.tolower().find("kingofvc") >= 0) pdata.rawset("Image", "https://a.rsg.sc//n/kikita0106/n");
                               else pdata.rawset("Image", "https://cdn.discordapp.com/icons/339341411860086784/ed4f466c9825284242b8ffa9d674b820.webp");

                               this.ToDiscord2(5, pdata);
                           } else this.ToDiscord(1, "**Error: ** Player does not exist.");
                       } else this.ToDiscord(1, "**Syntax: ** %s [player]", cmds);
                       break;

                   case "!round":
                   case "!roundinfo":
                       local gameplay = Handler.Handlers.Gameplay;
                       local roundtime = ::seconds_to_mmss(gameplay.RoundTime);
                       local basename = "None";
                       if (gameplay.Status > 2) {
                           if (gameplay.Status == 3) roundtime = "Preparing round, it will start in " + roundtime + " seconds.";
                           basename = Handler.Handlers.Bases.Bases[gameplay.Bases].Name;
                           local pdata = {};
                           pdata.rawset("Name", basename);
                           pdata.rawset("Time", roundtime);
                           pdata.rawset("Sprees", ::GetSprees());

                           this.ToDiscord2(9, pdata);
                       } else this.ToDiscord(3, "**Round is not active.**");
                       break;

                   case "!exe":
                       if (isadmin > 5) {
                           if (arr != " ") {
                               try {
                                   local script = compilestring(arr);
                                   if (script) {
                                       this.ToDiscord(10, "Code [ %s ] executed.", arr);
                                       SqCast.MsgAllAdmin("DiscordExecSucs", plr);
                                       script();
                                   }
                               } catch (e) this.ToDiscord(10, "Execute error [ %s ]", e);
                           } else this.ToDiscord(10, "**Syntax: ** %s [code]", cmds);
                       }
                       break;

                   case "!removeacc":
                       if (isadmin > 3) {
                           if (arr != " ") {
                               local nick = Handler.Handlers.Script.Database.QueryF("SELECT Name FROM rtv3_account WHERE Name LIKE '%s';", arr);
                               if (nick.Step()) {
                                   local target = ::FindPlayer(arr);
                                   if (!target) {
                                       Handler.Handlers.Script.Database.ExecuteF("DELETE FROM rtv3_account WHERE Name = '%s';", arr);
                                       this.ToDiscord(10, "Account [ %s ] has been removed successfully.", arr);
                                       SqCast.MsgAllAdmin("DiscRemoveAcc", plr, arr);
                                   } else this.ToDiscord(10, "Target in the server right now.");
                               } else this.ToDiscord(10, "Given name does not exist.");
                           } else this.ToDiscord(10, "**Syntax: ** %s [full nick]", cmds);
                       }
                       break;

                   case "!lockserver":
                       if (isadmin > 4) {
                           if (arr != " ") {
                               local servp = Handler.Handlers.Script.Database.QueryF("SELECT ServPass FROM rtv3_server;");
                               SqServer.SetPassword(arr);
                               if (servp.Step()) Handler.Handlers.Script.Database.ExecuteF("UPDATE rtv3_server SET ServPass = '%s';", arr);
                               else Handler.Handlers.Script.Database.ExecuteF("INSERT INTO rtv3_server VALUES( '%s' );", arr);

                               this.ToDiscord(10, "Server has been locked with password [ %s ].", arr);
                               SqCast.MsgAllAdmin("DiscLockServer", plr);
                           } else this.ToDiscord(10, "**Syntax: ** %s [password]", cmds);
                       }
                       break;

                   case "!unlockserver":
                       if (isadmin > 4) {
                           local servp = Handler.Handlers.Script.Database.QueryF("SELECT ServPass FROM rtv3_server;");
                           if (servp.Step()) {
                               SqServer.SetPassword("");
                               Handler.Handlers.Script.Database.ExecuteF("DELETE FROM rtv3_server;");

                               SqCast.MsgAllAdmin("DiscUnlockServer", plr);
                               this.ToDiscord(10, "Server has been unlocked.");
                           } else this.ToDiscord(10, "Server is already unlocked.");
                       }
                       break;

                   case "!setweather":
                       if (isadmin > 2) {
                           if (arr != " ") {
                               SqServer.SetWeather(arr.tointeger());

                               SqCast.MsgAll("DiscSW", plr, ::GetWeatherName(arr.tointeger()));
                               this.ToDiscord(10, "Server weather changed: **[ " + ::GetWeatherName(arr.tointeger()) + " ]**");
                           } else this.ToDiscord(10, "**Syntax: ** %s [ID]", cmds);
                       }
                       break;*/

            default:
                SqCast.MsgAll("DiscordChat", plr, cmds + " " + arr);
                this.ToDiscord(1, "**%s [Discord]:** %s", plr, cmds + " " + arr);
                break;
        }
    }

    function SendToPrivate(text, type) {
        local urlType = "Rob The Vehicle", urlName = "";

        switch (type) {
            case "pm":
                urlType = "discordapp.com/api/webhooks/702055784040890378/EyjWHejdoKYm_I-Xm0FTJtQQDyeEF1scgEJqA5cuXyGa3f5IG9Pq-Ph7zz-WEgA9kwXm";
                urlName = "Private Message";
                break;

            case "tc":
                urlType = "discordapp.com/api/webhooks/702059738451542116/6aO3B1AxRYCrq4faGZ7ul34qhvRLO-I4JbJtBmSlnXsIRGczWKd-TPqsQ2zsSEgxbVqX"
                urlName = "Team Chat";
                break;

        }
        return system("curl -H \"Accept: application/json\" -H \"Content-type: application/json\" -X POST -d '{\"content\":\"" + text + "\", \"username\":\"" + urlName + "\"}' https://" + urlType);
        //     return print( "curl -H \"Accept: application/json\" -H \"Content-type: application/json\" -X POST -d '{\"embeds\": [{ \"title\": \"Private Message\", \"description\": \"" + text + "\", \"color\": 16056320,\"footer\": {\"text\": \"" + GetDate( time() ) + "\"}}], \"username\": \"" + urlName + "\"}' https://" + urlType );


    }

    function ProcessMessageAdmin(user, level, message) {
        local
        isadmin = 0,
            plr = user,
            cmds = split(message.slice(0), " ")[0],
            arr = split(message, " ").len() > 1 ? message.slice(message.find(" ") + 1) : "";


        switch (cmds) {
            case "!ac":
                if (level > 0) {
                    if (arr != "") {
                        SqCast.MsgAllAdmin("AdminChat", user, arr);
                        Handler.Handlers.Discord.sendToStaff(0, "``[ADMIN CHAT]`` **%s**: %s", user, arr);
                    } else Handler.Handlers.Discord.sendToStaff(0, "**Syntax, !ac [text]**");
                } else Handler.Handlers.Discord.sendToStaff(0, "**Syntax, !ac [text]**");
                break;

            case "!readonly":
                if (level > 0) {
                    switch( Handler.Handlers.Script.ReadOnly ) {
                        case true:
                        Handler.Handlers.Script.ReadOnly = false;

				        SqCast.MsgAll( "DisableReadOnly", user );
                        break;

                        case false:
                        Handler.Handlers.Script.ReadOnly = true;

                        SqCast.MsgAll( "EnableReadOnly", user );
                        break;
                    }
                } else Handler.Handlers.Discord.sendToStaff(0, "**You dont have access to this command.**");
                break;
               
        }
        
    }
}