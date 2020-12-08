class CRoundEnd extends CContext {
    Background = null;

    Title = null;
    MVP = null;
    Track = null;

    function constructor(Key) {
        base.constructor();

        this.Load();
    }

    function Load() {
        local rel = GUI.GetScreenSize();

        this.Background = GUISprite();
        this.Background.SetTexture("alert-bg.png");
        this.Background.Pos = VectorScreen(0, rel.Y * 0.0833333333333333);
        this.Background.Size = VectorScreen(rel.X * 0.4427083333333333, rel.Y * 0.3796296296296296);
        this.Background.Colour = Colour(255, 255, 255, 255);

        this.Title = GUILabel();
        this.Title.TextColour = Colour(255, 0, 0);
        this.Title.Pos = VectorScreen(0, rel.Y * 0.1388888888888889);
        this.Title.FontFlags = GUI_FFLAG_BOLD;
        this.Title.Text = "Red Team has won the round";
        this.Title.FontName = "Bahnschrift";
        this.Title.FontSize = (rel.Y * 0.025);
        this.Background.AddChild(this.Title);
        //    this.Title.AddFlags(GUI_FLAG_TEXT_TAGS);

        this.MVP = GUILabel();
        this.MVP.TextColour = Colour(255, 255, 255);
        this.MVP.Pos = VectorScreen(0, rel.Y * 0.1851851851851852);
        this.MVP.Text = "MVP: ImKiKi for delivered the vehicle.";
        this.MVP.FontName = "Bahnschrift";
        this.MVP.FontSize = (rel.Y * 0.0185185185185185);
        this.Background.AddChild(this.MVP);
        //    this.MVP.AddFlags(GUI_FLAG_TEXT_TAGS);

        this.Track = GUILabel();
        this.Track.TextColour = Colour(255, 255, 255);
        this.Track.Pos = VectorScreen(0, rel.Y * 0.212962962962963);
        this.Track.Text = "Now Playing: Nico Nico Nii!";
        this.Track.FontName = "Bahnschrift";
        this.Track.FontSize = (rel.Y * 0.012962962962963);
        this.Background.AddChild(this.Track);
        //   this.Track.AddFlags(GUI_FLAG_TEXT_TAGS);

        /*    if (rel.X <= 1024) {
                this.Title.FontSize = (rel.X * 0.02734375);
                this.MVP.FontSize = (rel.X * 0.01953125);
                this.Track.FontSize = (rel.X * 0.013671875);
            }
        */

        this.centerX(this.Background);

        this.centerinchildX(this.Background, this.Title);
        this.centerinchildX(this.Background, this.MVP);
        this.centerinchildX(this.Background, this.Track);

        this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
    }

    function update(title1, mvp1, track1, col) {
        this.Title.Text = title1;
        this.MVP.Text = mvp1;
        this.Track.Text = track1;
        this.Title.TextColour = this.GetCol(col);


        this.Background.Size.X = this.getTextWidth(this.Title) * 1.5;
        if (this.getTextWidth(this.MVP) > this.getTextWidth(this.Title)) this.Background.Size.X = this.getTextWidth(this.MVP) * 1.5;
        if (this.getTextWidth(this.Track) > this.getTextWidth(this.MVP)) this.Background.Size.X = this.getTextWidth(this.Track) * 1.5;

        this.centerX(this.Background);

        this.centerinchildX(this.Background, this.Title);
        this.centerinchildX(this.Background, this.MVP);
        this.centerinchildX(this.Background, this.Track);

        this.Background.AddFlags(GUI_FLAG_VISIBLE);

        local getHash = Timer.Create(this, function() {
            this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
        }, 10000, 1);
    }

    function onServerData(type, str) {
        switch (type) {
            case 3100:
                local sp = split(str, "?");
                this.update(sp[0], sp[1], sp[2], sp[3]);
                break;

            case 3101:
                this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
                break;
        }
    }

    function GetCol(col) {
        switch (col) {
            case "blue":
            case "2":
                return Colour(26, 26, 255);
            case "red":
            case "1":
                return Colour(230, 0, 0);

            default:
                return Colour(255, 255, 255);
        }
    }

    function center(instance, instance2 = null) {
        if (!instance2) {
            local size = instance.Size;
            local screen = ::GUI.GetScreenSize();
            local x = (screen.X / 2) - (size.X / 2);
            local y = (screen.Y / 2) - (size.Y / 2);

            instance.Position = ::VectorScreen(x, y);
        } else {
            local position = instance2.Position;
            local size = instance2.Size;
            instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X) / 2;
            instance.Position.Y = (position.Y + (position.Y + size.Y) - instance.Size.Y) / 2;
        }
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

    function getTextWidth(element) {
        local size = element.Size;
        return size.X;
    }

    function centerinchildX(parents, child) {
        local parentElement = parents.Size;
        local childElement = child.Size;
        local x = (parentElement.X / 2) - (childElement.X / 2);

        child.Pos.X = x;
    }
}