class CChatbox extends CContext {
    Background = null;
    Membox = null;
    Scrollbar = null;
    Background2 = null;

    Timeout = null;
    isChating = false;

    function constructor(key) {
        base.constructor();

        this.Load();
    }

    function Load() {
        local rel = GUI.GetScreenSize();

        this.Background = GUICanvas();
        this.Background.Pos = VectorScreen(rel.X * 0.015625, rel.Y * 0.3981481481481481);
        this.Background.Size = VectorScreen(rel.X * 0.3645833333333333, rel.Y * 0.3240740740740741);
        this.Background.Colour = Colour(0, 0, 0, 0);

        this.Membox = GUIMemobox();
        this.Membox.FontFlags = 1 //| GUI_FFLAG_OUTLINE;
        this.Membox.AddFlags(GUI_FLAG_SCROLLABLE | GUI_FLAG_SCROLLBAR_HORIZ | GUI_FLAG_TEXT_TAGS);
        this.Membox.RemoveFlags(GUI_FLAG_BORDER | GUI_FLAG_MEMOBOX_TOPBOTTOM | GUI_FLAG_BACKGROUND);
        this.Membox.FontName = "Bahnschrift";
        this.Membox.TextPaddingTop = 10;
        this.Membox.TextPaddingBottom = 4;
        this.Membox.TextPaddingLeft = 10;
        this.Membox.TextPaddingRight = 10;
        this.Membox.FontSize = (rel.Y * 0.0166666666666667);
        this.Membox.Pos = VectorScreen(rel.X * 0.0208333333333333, rel.Y * 0.4074074074074074);
        this.Membox.Size = VectorScreen(rel.X * 0.3463541666666667, rel.Y * 0.3055555555555556);
        this.Membox.Colour = Colour(43, 38, 38, 200);
        this.Membox.TextColour = Colour(246, 123, 78, 255);
        this.Membox.HistorySize = 255;


        this.Scrollbar = GUIScrollbar();
        //    this.Membox.AddChild(this.Scrollbar);
        this.Scrollbar.Colour = Colour(43, 38, 38, 0);
        this.Scrollbar.Size = VectorScreen(rel.X * 0.0078125, rel.Y * 0.3055555555555556);
        this.Scrollbar.Pos = VectorScreen(rel.X * 0.3671875, rel.Y * 0.4074074074074074);
        this.Scrollbar.SendToTop();
        this.Scrollbar.RemoveFlags(GUI_FLAG_BORDER);
        this.Scrollbar.AddFlags(GUI_FLAG_SCROLLABLE);

        this.Background2 = GUISprite();
        this.Background2.SetTexture("alert-bg.png");
        this.Background2.Pos = VectorScreen(0, rel.Y * 0.212962962962963);
        this.Background2.Size = VectorScreen(rel.X * 0.3854166666666667, rel.Y * 0.5462962962962963);
        this.Background2.Colour = Colour(0, 0, 0, 255);
        this.Background2.RemoveFlags(GUI_FLAG_VISIBLE);

        this.Scrollbar.AddFlags(GUI_FLAG_MOUSECTRL);
        this.Membox.RemoveFlags(GUI_FLAG_MOUSECTRL);
        this.Background.RemoveFlags(GUI_FLAG_MOUSECTRL);
        this.Scrollbar.RemoveFlags(GUI_FLAG_VISIBLE);
    }

    function AddLine(str) {
        this.Membox.AddLine(str);

        if (!this.isChating) {
            local rel = GUI.GetScreenSize();

            this.Membox.AddFlags(GUI_FLAG_VISIBLE);
            this.Background2.AddFlags(GUI_FLAG_VISIBLE);
            this.Membox.Size.Y = (rel.Y * 0.1481481481481481);
            this.Membox.SendToTop();

            Timer.Destroy(this.Timeout);

            this.Timeout = Timer.Create(this, function() {
                if (!this.isChating) {
                    this.Membox.RemoveFlags(GUI_FLAG_VISIBLE);
                    this.Scrollbar.RemoveFlags(GUI_FLAG_VISIBLE);
                    this.Background2.RemoveFlags(GUI_FLAG_VISIBLE);
                }
            }, 10000, 1);
        }
    }

    function StartTyping() {
        local rel = GUI.GetScreenSize();

        Timer.Destroy(this.Timeout);

        this.Membox.AddFlags(GUI_FLAG_BACKGROUND);
        this.Membox.AddFlags(GUI_FLAG_VISIBLE);
        this.Scrollbar.AddFlags(GUI_FLAG_VISIBLE);
        this.Background.Colour = Colour(0, 0, 0, 155);
        this.Scrollbar.Colour = Colour(43, 38, 38, 200);
        this.Membox.FontFlags = 1;
        this.isChating = true;
        this.Membox.Size.Y = (rel.Y * 0.3055555555555556);

        GUI.SetMouseEnabled(true);
    }

    function StopTyping() {
        local rel = GUI.GetScreenSize();

        this.Membox.RemoveFlags(GUI_FLAG_BACKGROUND);
        this.Scrollbar.RemoveFlags(GUI_FLAG_VISIBLE);

        this.Background2.AddFlags(GUI_FLAG_VISIBLE);
        this.Membox.Size.Y = (rel.Y * 0.1481481481481481);
        this.Membox.SendToTop();

        this.Background.Colour = Colour(0, 0, 0, 0);
        this.Scrollbar.Colour = Colour(43, 38, 38, 0);
        this.Membox.FontFlags = 1 //| GUI_FFLAG_OUTLINE;
        this.isChating = false;

        this.Timeout = Timer.Create(this, function() {
            if (!this.isChating) {
                this.Membox.RemoveFlags(GUI_FLAG_VISIBLE);
                this.Scrollbar.RemoveFlags(GUI_FLAG_VISIBLE);
                this.Background2.RemoveFlags(GUI_FLAG_VISIBLE);
            }
        }, 10000, 1);

        GUI.SetMouseEnabled(false);
    }

    function Hide() {
        this.Membox.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Scrollbar.RemoveFlags(GUI_FLAG_VISIBLE);
        this.Background2.RemoveFlags(GUI_FLAG_VISIBLE);
    }

    function onServerData(type, str) {
        switch (type) {
            case 2600:
                this.AddLine(str);
                break;

            case 2601:
                this.StartTyping();
                break;

            case 2602:
                this.StopTyping();
                break;

            case 2603:
                this.Hide();
                break;
        }
    }

    function onScrollbarScroll(scrollbar, position, change) {
        if (scrollbar == this.Scrollbar) this.Membox.DisplayPos = 1 - position;
    }

}