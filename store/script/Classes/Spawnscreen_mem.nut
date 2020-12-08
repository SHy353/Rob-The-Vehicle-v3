class CSpawnScreen extends CContext {
    Background = null;

    Outline = null;

    Red1 = null;
    Red2 = null;
    Red3 = null;
    RedBg = null;
    RedText = null;

    Blue1 = null;
    Blue2 = null;
    Blue3 = null;
    BlueBg = null;
    BlueText = null;

    FooterText = null;
    FooterBg = null;

    SpectatorBtn = null;

    isExist = false;

    RightClick = KeyBind(0x02);

    function constructor(Key) {
        base.constructor();

        this.Load();
    }

    function Load() {
        local rel = GUI.GetScreenSize();

        this.Background = GUISprite();
        this.Background.Size = VectorScreen(rel.X, rel.Y);
        this.Background.Pos = VectorScreen(0, 0);
        this.Background.SetTexture("scbg.png");

        /*    this.Outline = GUISprite();
            this.Outline.Size = VectorScreen(10, 890);
            this.Outline.Pos = VectorScreen(960, 140);
            this.Outline.SetTexture("outline.png");
            this.centerX(this.Outline);*/

        this.Red1 = GUISprite();
        this.Red1.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.3564814814814815);
        this.Red1.Pos = VectorScreen(rel.X * 0.359375, rel.Y * 0.3796296296296296);
        this.Red1.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Red1.SetTexture("red1.png");

        this.Red2 = GUISprite();
        this.Red2.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.3564814814814815);
        this.Red2.Pos = VectorScreen(rel.X * 0.2291666666666667, rel.Y * 0.3796296296296296);
        this.Red2.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Red2.SetTexture("red21.png");

        this.Red3 = GUISprite();
        this.Red3.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.356481481481481);
        this.Red3.Pos = VectorScreen(rel.X * 0.09375, rel.Y * 0.3796296296296296);
        this.Red3.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Red3.SetTexture("red31.png");

        this.RedBg = GUISprite();
        this.RedBg.SetTexture("alert-bg.png");
        this.RedBg.Pos = VectorScreen(rel.X * 0.0375, rel.Y * 0.7157407407407407);
        this.RedBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
        this.RedBg.Colour = Colour(0, 0, 0, 255);

        this.RedText = GUILabel();
        this.RedText.TextColour = Colour(255, 255, 255);
        this.RedText.Pos = VectorScreen(0, rel.Y * 0.062962962962963);
        this.RedText.AddFlags(GUI_FLAG_TEXT_TAGS);
        this.RedText.Text = "Red Team - Defender - Player(s): 60";
        this.RedText.FontName = "Bahnschrift";
        this.RedText.FontSize = (rel.Y * 0.0240740740740741);
        this.RedBg.AddChild(this.RedText);

        this.RedBg.Size.X = this.getTextWidth(this.RedText) * 2;
        this.RedBg.Pos = VectorScreen(rel.X * 0.0947916666666667, rel.Y * 0.7157407407407407);
        this.RedBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
        this.centerinchildX(this.RedBg, this.RedText);

        this.Blue1 = GUISprite();
        this.Blue1.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.3564814814814815);
        this.Blue1.Pos = VectorScreen(rel.X * 0.5364583333333333, rel.Y * 0.3796296296296296);
        this.Blue1.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Blue1.SetTexture("blue1.png");

        this.Blue2 = GUISprite();
        this.Blue2.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.3564814814814815);
        this.Blue2.Pos = VectorScreen(rel.X * 0.6666666666666667, rel.Y * 0.3796296296296296);
        this.Blue2.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Blue2.SetTexture("blue21.png");

        this.Blue3 = GUISprite();
        this.Blue3.Size = VectorScreen(rel.X * 0.1171875, rel.Y * 0.3564814814814815);
        this.Blue3.Pos = VectorScreen(rel.X * 0.796875, rel.Y * 0.3796296296296296);
        this.Blue3.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Blue3.SetTexture("blue31.png");

        this.BlueBg = GUISprite();
        this.BlueBg.SetTexture("alert-bg.png");
        this.BlueBg.Colour = Colour(0, 0, 0, 255);

        this.BlueText = GUILabel();
        this.BlueText.TextColour = Colour(255, 255, 255);
        this.BlueText.Pos = VectorScreen(0, rel.Y * 0.062962962962963);
        this.BlueText.AddFlags(GUI_FLAG_TEXT_TAGS);
        this.BlueText.Text = "Red Team - Defender - Player(s): 60";
        this.BlueText.FontName = "Bahnschrift";
        this.BlueText.FontSize = (rel.Y * 0.0240740740740741);
        this.BlueBg.AddChild(this.BlueText);

        this.BlueBg.Size.X = this.getTextWidth(this.BlueText) * 2;
        this.BlueBg.Pos = VectorScreen(rel.X * 0.553125, rel.Y * 0.7157407407407407);
        this.BlueBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
        this.centerinchildX(this.BlueBg, this.BlueText);

        this.FooterBg = GUISprite();
        this.FooterBg.SetTexture("alert-bg.png");
        this.FooterBg.Pos = VectorScreen(rel.X * 0.5114583333333333, rel.Y * 0.8824074074074074);
        this.FooterBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
        this.FooterBg.Colour = Colour(0, 0, 0, 255);
        this.centerX(this.FooterBg);

        this.FooterText = GUILabel();
        this.FooterText.TextColour = Colour(255, 255, 255);
        this.FooterText.Pos = VectorScreen(0, rel.Y * 0.062037037037037 );
        this.FooterText.AddFlags(GUI_FLAG_TEXT_TAGS);
        this.FooterText.Text = "Press [Right Click] to toggle cursor.";
        this.FooterText.FontName = "Bahnschrift";
        this.FooterText.FontSize = (rel.Y * 0.0240740740740741);
        this.FooterBg.AddChild(this.FooterText);
    //    this.centerX(this.FooterText);

        this.FooterBg.Size.X = this.getTextWidth(this.FooterText) * 2;
        this.centerX(this.FooterBg);
        this.centerinchildX(this.FooterBg, this.FooterText);

        this.SpectatorBtn = GUISprite();
        this.SpectatorBtn.SetTexture("spectatebutton.png");
        this.SpectatorBtn.Pos = VectorScreen(rel.X * 0.75, rel.Y * 0.8611111111111111);
        this.SpectatorBtn.Size = VectorScreen(rel.X * 0.2083333333333333, rel.Y * 0.0925925925925926);
        this.SpectatorBtn.AddFlags(GUI_FLAG_VISIBLE | GUI_FLAG_MOUSECTRL);
        this.Hide();
    }

    function Show() {
        this.Background.AddFlags(GUI_FLAG_VISIBLE);
        this.Red1.AddFlags(GUI_FLAG_VISIBLE);
        this.Red2.AddFlags(GUI_FLAG_VISIBLE);
        this.Red3.AddFlags(GUI_FLAG_VISIBLE);
        this.RedBg.AddFlags(GUI_FLAG_VISIBLE);
        this.RedText.AddFlags(GUI_FLAG_VISIBLE);
        this.Blue1.AddFlags(GUI_FLAG_VISIBLE);
        this.Blue2.AddFlags(GUI_FLAG_VISIBLE);
        this.Blue3.AddFlags(GUI_FLAG_VISIBLE);
        this.BlueBg.AddFlags(GUI_FLAG_VISIBLE);
        this.BlueText.AddFlags(GUI_FLAG_VISIBLE);
        this.SpectatorBtn.AddFlags(GUI_FLAG_VISIBLE);
        this.FooterText.AddFlags(GUI_FLAG_VISIBLE);
        this.FooterBg.AddFlags(GUI_FLAG_VISIBLE);

        this.isExist = true;

     //   GUI.SetMouseEnabled(false);

        Timer.Create(this, function() {
            GUI.SetMouseEnabled(true);
        }, 500, 1);

        Hud.RemoveFlags(HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR);
    }

    function Hide() {
        this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Red1.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Red2.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Red3.RemoveFlags(GUI_FLAG_VISIBLE);
        this.RedBg.RemoveFlags(GUI_FLAG_VISIBLE);
        this.RedText.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Blue1.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Blue2.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Blue3.RemoveFlags(GUI_FLAG_VISIBLE);
        this.BlueBg.RemoveFlags(GUI_FLAG_VISIBLE);
        this.BlueText.RemoveFlags(GUI_FLAG_VISIBLE);
        this.SpectatorBtn.RemoveFlags(GUI_FLAG_VISIBLE);
        this.FooterText.RemoveFlags(GUI_FLAG_VISIBLE);
        this.FooterBg.RemoveFlags(GUI_FLAG_VISIBLE);

        this.isExist = false;

        GUI.SetMouseEnabled(false);

        Hud.AddFlags(HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR);
    }

    function ChangeRedName(text) {
        if (this.isExist) {
            local rel = GUI.GetScreenSize();

            this.RedText.Text = text;

            this.RedBg.Size.X = this.getTextWidth(this.RedText) * 2;
            this.RedBg.Pos = VectorScreen(rel.X * 0.0947916666666667, rel.Y * 0.7157407407407407);
            this.RedBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
            this.centerinchildX(this.RedBg, this.RedText);
        }
    }

    function ChangeBlueName(text) {
        if (this.isExist) {
            local rel = GUI.GetScreenSize();

            this.BlueText.Text = text;

            this.BlueBg.Size.X = this.getTextWidth(this.BlueText) * 2;
            this.BlueBg.Pos = VectorScreen(rel.X * 0.553125, rel.Y * 0.7157407407407407);
            this.BlueBg.Size = VectorScreen(rel.X * 0.369692532942899, rel.Y * 0.1666666666666667);
            this.centerinchildX(this.BlueBg, this.BlueText);
        }
    }

    function onElementHoverOver(element) {
        switch (element) {
            case this.Red1:
                this.Red1.SetTexture("red2.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.Red2:
                this.Red2.SetTexture("red22.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.Red3:
                this.Red3.SetTexture("red32.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.Blue1:
                this.Blue1.SetTexture("blue2.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.Blue2:
                this.Blue2.SetTexture("blue22.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.Blue3:
                this.Blue3.SetTexture("blue32.png");
                Handler.Handlers.Player.playHoverSound();
                break;

            case this.SpectatorBtn:
                this.SpectatorBtn.Colour = Colour(255, 255, 26, 255);
                Handler.Handlers.Player.playHoverSound();
                break;
            
            case this.SpectatorBtn:
                Handler.Handlers.Player.playHoverSound();
                break;
        }
    }

    function onElementHoverOut(element) {
        switch (element) {
            case this.Red1:
                this.Red1.SetTexture("red1.png");
                break;

            case this.Red2:
                this.Red2.SetTexture("red21.png");
                break;

            case this.Red3:
                this.Red3.SetTexture("red31.png");
                break;

            case this.Blue1:
                this.Blue1.SetTexture("blue1.png");
                break;

            case this.Blue2:
                this.Blue2.SetTexture("blue21.png");
                break;

            case this.Blue3:
                this.Blue3.SetTexture("blue31.png");
                break;

            case this.SpectatorBtn:
                this.SpectatorBtn.Colour = Colour(255, 255, 255, 255);
                break;
        }
    }

    function onElementRelease(element, x, y) {
        local type = null;
        switch (element) {
            case this.Red1:
                type = "1:200";
                break;

            case this.Red2:
                type = "1:202";
                break;

            case this.Red3:
                type = "1:200";
                break;

            case this.Blue1:
                type = "2:204";
                break;

            case this.Blue2:
                type = "2:203";
                break;

            case this.Blue3:
                type = "2:5";
                break;

            case this.SpectatorBtn:
                type = "7:173";
                break;
        }

        if (type) {
            local data = Stream();
            data.WriteInt(3200);
            data.WriteString(type.tostring());
            Server.SendData(data);
        }
    }

    function onServerData(type, str) {
        switch (type) {
            case 4100:
                this.Hide();
                break;

            case 4200:
                this.Show();
                break;

            case 4300:
                this.ChangeRedName(str);
                break;

            case 4400:
                this.ChangeBlueName(str);
                break;
        }
    }

    function onKeyBindDown(keybind) {
        if(keybind == this.RightClick) {
            if(this.isExist) {
                if(GUI.GetMouseEnabled()) GUI.SetMouseEnabled(false);
                else GUI.SetMouseEnabled(true);
            }
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

    function left(instance, instance2 = null) {
        if (!instance2) instance.Position.X = 0;
        else {
            local position = instance2.Position;
            local size = instance2.Size;
            instance.Position.X = position.X;
        }
    }

    function centerinchild(parents, child) {
        local parentElement = parents.Size;
        local childElement = child.Size;
        local x = (parentElement.X / 2) - (childElement.X / 2);
        local y = (parentElement.Y / 2) - (childElement.Y / 2);

        child.Pos = ::VectorScreen(x, y);
    }

    function centerinchildX(parents, child) {
        local parentElement = parents.Size;
        local childElement = child.Size;
        local x = (parentElement.X / 2) - (childElement.X / 2);

        child.Pos.X = x;
    }

    function getTextWidth(element) {
        local size = element.Size;
        return size.X;
    }

}