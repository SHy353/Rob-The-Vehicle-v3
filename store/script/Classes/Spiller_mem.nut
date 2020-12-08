class CSpiller extends CContext {
    function constructor(Key) {
        base.constructor();
    }

    function onServerData(type, str) {
        switch (type) {
            case 5000:
            case 5001:

                local data = Stream();
                data.WriteInt(type);
                data.WriteString(Script.GetTicks().tostring());
                Server.SendData(data);

                break;
        }
    }

}