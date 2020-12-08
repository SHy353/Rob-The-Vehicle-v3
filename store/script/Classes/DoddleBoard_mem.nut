class CDoddle extends CContext {
    Background = null;
    Background1 = null;

    Title = null;

    Top5Killers = null;

    function constructor(Key) {
        base.constructor();

        this.Top5Killers = [];

        this.Load();
    }

    function Load() {
        this.Background = GUICanvas();
        this.Background.Size = VectorScreen(1360, 970);
        this.Background.Colour = Colour(47, 49, 54, 0);
        this.Background.AddFlags(GUI_FLAG_3D_ENTITY);
        this.Background.Pos3D = Vector(-973.293, -233.385, 381);
        this.Background.Size3D = Vector(8, 9, 0);
        this.Background.Rotation3D = Vector(11, 0, 0.0899999);

        this.Background1 = GUISprite();
        this.Background.AddChild(this.Background1);
        this.Background1.Pos = VectorScreen(-300, -146);
        this.Background1.Size = VectorScreen(2300, 1470);
        this.Background1.SetTexture("doodle-bg.png");

        this.Title = GUILabel();
        this.Title.TextColour = Colour(255, 0, 0);
        this.Title.FontName = "Bahnschrift";
        this.Title.FontFlags = GUI_FFLAG_BOLD;
        this.Title.Text = "";
        this.Title.TextAlignment = GUI_ALIGN_LEFT;
        this.Title.FontSize = 15;
        this.Title.Pos = VectorScreen(0, 10);
        this.Background.AddChild(this.Title);
        this.centerinchildX(this.Background, this.Title);

        Init();

        for (local i = 0; i < 20; i++) {
            this.AddList("", "", "", "", "");
        }
    }

    function AddList(name1, kills, deaths, assign, tscore) {
        local number = GUILabel();
        local score = GUILabel();
        local score3 = GUILabel();

        this.Background.AddChild(number);
        number.TextColour = Colour(255, 255, 255);
        number.FontSize = 30;
        number.FontName = "Bahnschrift";
        number.FontFlags = GUI_FFLAG_BOLD;
        number.Text = "";
        number.TextAlignment = GUI_ALIGN_CENTER;
        number.Pos = VectorScreen(40, (80 + (40 * this.Top5Killers.len())));

        this.Background.AddChild(score);
        score.TextColour = Colour(255, 255, 255);
        score.FontSize = 30;
        score.FontName = "Bahnschrift";
        score.FontFlags = GUI_FFLAG_BOLD;
        score.Text = kills;
        score.TextAlignment = GUI_ALIGN_CENTER;
        score.Pos = VectorScreen(680, (80 + (40 * this.Top5Killers.len())));

        this.Background.AddChild(score3);
        score3.TextColour = Colour(255, 255, 255);
        score3.FontSize = 30;
        score3.FontName = "Bahnschrift";
        score3.FontFlags = GUI_FFLAG_BOLD;
        score3.Text = tscore;
        score3.TextAlignment = GUI_ALIGN_CENTER;
        score3.Pos = VectorScreen(1185, (80 + (40 * this.Top5Killers.len())));

        this.Top5Killers.append({
            Number = number,
            Kills = score,
            TScore = score3,
            Owner = "",
        });
    }

    function UpdateList(idx, name1, kills, deaths, assign, tscore) {
        foreach(index, value in this.Top5Killers) {
            if (value.Owner == tscore) {
                value.Kills.Text = kills;
                this.centerX(value.Kills, this.Top5Killers[0].Kills);

                return index;
            }
        }

        this.Top5Killers[idx.tointeger()].Kills.Text = kills;
        this.Top5Killers[idx.tointeger()].TScore.Text = "~" + tscore;
        this.Top5Killers[idx.tointeger()].Owner = tscore;

        this.centerX(this.Top5Killers[idx.tointeger()].Kills, this.Top5Killers[0].Kills);
        this.centerX(this.Top5Killers[idx.tointeger()].TScore, this.Top5Killers[0].TScore);

        return idx.tointeger();
    }

    function StripLine(str) {
        local strip2 = split(str, "`");
        local result = null;

        if (strip2[2] != "x") result = UpdateList(strip2[0], "", strip2[1], "", "", strip2[2]);

        if (result != null) {
            local data = Stream();
            data.WriteInt(2200);
            data.WriteString(strip2[1] + "`" + strip2[2] + "`" + result);
            Server.SendData(data);
        }
    }

    function StripLine1(str) {
        local strip2 = split(str, "`");
        local result = null;

        if (strip2[2] != "x") result = UpdateList(strip2[0], "", strip2[1], "", "", strip2[2]);
    }

    function onServerData(type, str) {
        switch (type) {
            case 2200:
                this.StripLine1(str);
                break;

            case 2201:
                this.StripLine(str);
                break;

            case 2201:
                foreach(index, value in this.Top5Killers) {
                    if (index != 0) {
                        value.Number.Text = "";
                        value.Kills.Text = "";
                        value.TScore.Text = "";
                    }
                }
                break;
        }
    }

    function Init() {
        local number = GUILabel();
        local score = GUILabel();
        local score3 = GUILabel();

        this.Background.AddChild(number);
        number.TextColour = Colour(255, 255, 255);
        number.FontSize = 30;
        number.FontName = "Bahnschrift";
        number.FontFlags = GUI_FFLAG_BOLD;
        number.TextAlignment = GUI_ALIGN_LEFT;
        number.Pos = VectorScreen(40, (40 + (20 * this.Top5Killers.len())));

        this.Background.AddChild(score);
        score.TextColour = Colour(255, 255, 255);
        score.FontSize = 30;
        score.FontName = "Bahnschrift";
        score.FontFlags = GUI_FFLAG_BOLD;
        score.Text = "";
        score.TextAlignment = GUI_ALIGN_LEFT;
        score.Pos = VectorScreen(680, (40 + (20 * this.Top5Killers.len())));

        this.Background.AddChild(score3);
        score3.TextColour = Colour(255, 255, 255);
        score3.FontSize = 30;
        score3.FontName = "Bahnschrift";
        score3.FontFlags = GUI_FFLAG_BOLD;
        score3.Text = "";
        score3.TextAlignment = GUI_ALIGN_LEFT;
        score3.Pos = VectorScreen(1370, (40 + (20 * this.Top5Killers.len())));

        this.Top5Killers.append({
            Number = number,
            Kills = score,
            TScore = score3,
            Owner = "",
        });
    }

    function centerX(instance, instance2 = null) {
        if (!instance2) {
            local size = instance.Size;
            local screen = ::GUI.GetScreenSize();
            local x = (screen.X / 2) - (size.X / 2);

            instance.Position.X = x;
        } else {
            local position = instance2.Position;
            local size = instance2.Size;
            instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X) / 2;
        }
    }

    function centerinchildX(parents, child) {
        local parentElement = parents.Size;
        local childElement = child.Size;
        local x = (parentElement.X / 2) - (childElement.X / 2);

        child.Pos.X = x;
    }
}