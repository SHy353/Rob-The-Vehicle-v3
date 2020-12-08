class CSpectate extends CContext {
    Background = null;

    Title = null;
    Name = null;

    Kills = null;
    Deaths = null;
    Ratio = null;
    Score = null;

    SpectatorBack = null;
    SpectatorText = null;

    function constructor(Key) {
        base.constructor();

        this.Load();
    }

    function Load() {
        local rel = GUI.GetScreenSize();

        this.Background = GUISprite();
        this.Background.Size = VectorScreen(rel.X * 0.3697916666666667, rel.Y * 0.2777777777777778);
        this.Background.Pos = VectorScreen(0, rel.Y * 0.6574074074074074);
        this.Background.SetTexture("spec-ui.png");
        this.centerX(this.Background);

        this.Title = GUILabel();
        this.Title.TextAlignment = GUI_ALIGN_LEFT;
        this.Title.FontSize = (rel.Y * 0.0138888888888889);
        this.Title.Text = "Denied from Miami Killers 2020";
        this.Title.FontName = "Bahnschrift";
        this.Title.FontFlags = GUI_FFLAG_BOLD;
        this.Title.TextColour = Colour(246, 123, 78, 255);
        this.Title.Alpha = 160;
        this.Title.Pos = VectorScreen(rel.X * 0.34375, rel.Y * 0.6712962962962963);

        this.Name = GUILabel();
        this.Name.TextAlignment = GUI_ALIGN_LEFT;
        this.Name.FontSize = (rel.Y * 0.0185185185185185);
        this.Name.Text = "ImKiKi";
        this.Name.FontName = "Bahnschrift";
        this.Name.FontFlags = GUI_FFLAG_BOLD;
        this.Name.TextColour = Colour(246, 123, 78, 160);
        this.Name.Alpha = 160;
        this.Name.Pos = VectorScreen(rel.X * 0.34375, rel.Y * 0.7222222222222222);

        this.Kills = GUILabel();
        this.Kills.TextAlignment = GUI_ALIGN_CENTER;
        this.Kills.FontSize = (rel.Y * 0.0222222222222222);
        this.Kills.Text = "0";
        this.Kills.FontName = "Bahnschrift";
        this.Kills.TextColour = Colour(246, 123, 78, 160);
        this.Kills.Alpha = 160;
        this.Kills.Pos = VectorScreen(rel.X * 0.3489583333333333, rel.Y * 0.8287037037037037);

        this.Deaths = GUILabel();
        this.Deaths.TextAlignment = GUI_ALIGN_CENTER;
        this.Deaths.FontSize = (rel.Y * 0.0222222222222222);
        this.Deaths.Text = "19";
        this.Deaths.FontName = "Bahnschrift";
        this.Deaths.TextColour = Colour(246, 123, 78, 160);
        this.Deaths.Alpha = 160;
        this.Deaths.Pos = VectorScreen(rel.X * 0.4375, rel.Y * 0.8287037037037037);

        this.Ratio = GUILabel();
        this.Ratio.TextAlignment = GUI_ALIGN_CENTER;
        this.Ratio.FontSize = (rel.Y * 0.0222222222222222);
        this.Ratio.Text = "0.00";
        this.Ratio.FontName = "Bahnschrift";
        this.Ratio.TextColour = Colour(246, 123, 78, 160);
        this.Ratio.Alpha = 160;
        this.Ratio.Pos = VectorScreen(rel.X * 0.5260416666666667, rel.Y * 0.8287037037037037);

        this.Score = GUILabel();
        this.Score.TextAlignment = GUI_ALIGN_CENTER;
        this.Score.FontSize = (rel.Y * 0.0222222222222222);
        this.Score.Text = "5";
        this.Score.FontName = "Bahnschrift";
        this.Score.TextColour = Colour(246, 123, 78, 160);
        this.Score.Alpha = 160;
        this.Score.Pos = VectorScreen(rel.X * 0.6197916666666667, rel.Y * 0.8287037037037037);

		this.SpectatorBack = GUISprite();
		this.SpectatorBack.SetTexture( "alert-bg.png" );
		this.SpectatorBack.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.8981481481481481 );
		this.SpectatorBack.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.1302083333333333 ); 
		this.SpectatorBack.Colour = Colour( 0, 0, 0, 255 );

		this.SpectatorText = GUILabel();
		this.SpectatorText.TextColour = Colour( 255, 255, 255 );
		this.SpectatorText.Pos = VectorScreen( 0, rel.Y * 0.0494791666666667 );		
	//	this.SpectatorText.FontFlags = GUI_FFLAG_BOLD;
		this.SpectatorText.Text = "/spec - spectate player  /exitspec - exit spectating mode";
		this.SpectatorText.FontName = "Bahnschrift";
		this.SpectatorText.FontSize = ( rel.Y * 0.0175925925925926 );
		this.SpectatorBack.AddChild( this.SpectatorText );
		this.SpectatorText.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.SpectatorBack.Size.X = this.getTextWidth( this.SpectatorText ) * 2;
		this.centerX( this.SpectatorBack );
		this.centerinchildX( this.SpectatorBack, this.SpectatorText );

   /*     this.SpectatorBack.Size.X = this.getTextWidth(this.SpectatorText) * 1.5;
        this.centerX(this.SpectatorBack);
        this.center(this.SpectatorText,this.SpectatorBack);*/

        this.SpectatorBack.RemoveFlags(GUI_FLAG_VISIBLE);
        this.SpectatorText.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Title.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Name.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Kills.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Deaths.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Ratio.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Score.RemoveFlags(GUI_FLAG_VISIBLE);

    }

    function ShowSpecMsg(text) {
        this.SpectatorBack.AddFlags(GUI_FLAG_VISIBLE);
         this.SpectatorText.AddFlags(GUI_FLAG_VISIBLE);
    }

    function RemoveSpecMsg() {
        this.SpectatorBack.RemoveFlags(GUI_FLAG_VISIBLE);
        this.SpectatorText.RemoveFlags(GUI_FLAG_VISIBLE);
    }

    function Show(str) {

        local sp = split(str, ";");

        this.Title.Text = sp[0];
        this.Name.Text = sp[1];
        this.Kills.Text = sp[2];
        this.Deaths.Text = sp[3];
        this.Ratio.Text = sp[4];
        this.Score.Text = sp[5];

        this.Background.AddFlags(GUI_FLAG_VISIBLE);
        this.Title.AddFlags(GUI_FLAG_VISIBLE);

        this.Name.AddFlags(GUI_FLAG_VISIBLE);
        this.Kills.AddFlags(GUI_FLAG_VISIBLE);
        this.Deaths.AddFlags(GUI_FLAG_VISIBLE);
        this.Ratio.AddFlags(GUI_FLAG_VISIBLE);
        this.Score.AddFlags(GUI_FLAG_VISIBLE);
    }

    function Hide() {
        this.Background.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Title.RemoveFlags(GUI_FLAG_VISIBLE);

        this.Name.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Kills.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Deaths.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Ratio.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Score.RemoveFlags(GUI_FLAG_VISIBLE);
    }

    function onServerData(type, str) {
        switch (type) {
            case 404:
                this.ShowSpecMsg(str);
                break;
        
            case 405:
                this.RemoveSpecMsg();
                this.Hide();
                break;
        
            case 2800:
                this.Show(str);
                break;

            case 2801:
                this.Hide();
                break;
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