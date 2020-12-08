class CBases {
    Bases = {};


    function constructor() {

    }

    function LoadBases() {
        try {
            local result = Handler.Handlers.Script.Database.QueryF("SELECT * FROM rtv3_bases");

            while (result.Step()) {
                this.Bases.rawset(result.GetInteger("ID"), {
                    Name = result.GetString("Name"),
                    Team1Pos = Vector3.FromStr(result.GetString("DefPos")),
                    Team2Pos = Vector3.FromStr(result.GetString("AttPos")),
                    SpherePos = Vector3.FromStr(result.GetString("CheckpointPos")),
                    VehicleModel = result.GetInteger("VehicleModel"),
                    VehiclePos = Vector3.FromStr(result.GetString("VehiclePos")),
                    VehicleAngle = result.GetFloat("VehicleAngle"),
                    TopPlayer = result.GetInteger("TopPlayer"),
                    TopScore = result.GetInteger("Score"),
                    Author = result.GetInteger("Author"),
                    Selected = false,
                    InVote = false,
               //     BaseType  = result.GetString("BaseType");
                });
            }
        } catch (e) SqLog.Err("Error on CBases::LoadBases [%s]", e);
    }

    function getBaseDefaultName(id) {
        try {
            if (id == 0) return "RTV";

            else return Handler.Handlers.PlayerAccount.GetAccountNameFromID(id);
        } catch (e) SqLog.Err("Error on CBases::getBaseDefaultName [%s]", e);
    }

    function updateBase(id, player, score) {
        try {
            if (!Handler.Handlers.Script.ReadOnly) {
                this.Bases[id].TopPlayer = player;
                this.Bases[id].TopScore = score;

                Handler.Handlers.Script.Database.ExecuteF("UPDATE rtv3_bases SET TopPlayer = %d, Score = %d WHERE ID = %d;", player, score, id);
            }
        } catch (e) SqLog.Err("Error on CBases::updateBase [%s]", e);
    }

    function chooseBase2() {
        local getarray = [];
        foreach(index, value in this.Bases) {
            if (!value.InVote && !value.Selected) {
                getarray.push(index);
            }
        }

        if (getarray.len() == 0) return null;

        local getbase = getarray[rand() % getarray.len()];

        if (this.Bases.rawin(getbase)) return getbase;
    }

    function resetPlayHistory() {
        foreach(index, value in this.Bases) {
            value.Selected = false;
        }
    }

    function resetVoteHistory() {
        foreach(index, value in this.Bases) {
            value.InVote = false;
        }
    }

    function chooseBase() {
        local getbase = this.chooseBase2();

        if (!getbase) {
            this.resetPlayHistory();
            getbase = this.chooseBase2();
        }

        this.Bases[ this.chooseBase2() ].InVote = true;

        return getbase;
    }
}