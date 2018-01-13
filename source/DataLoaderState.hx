package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flash.events.Event;
import flash.events.IOErrorEvent;

/**
 * State which does all the important data loading before the game starts.
 * Will only ever be run once per game to initialise stuff.
 */
class DataLoaderState extends FlxState {

    var nextState:Class<FlxState> = MenuState;

    override public function create():Void {
        FlxG.camera.antialiasing = true;

        //Placeholder text for loading panel
        var t = new FlxText(0,FlxG.height/2-100, FlxG.width,
                            "loading levels...");
        t.setFormat(null, 50, 0xffffffff, "center");
        add(t);

        //Load save information
        if(FlxG.save.data.saveExists == null) {
            FlxG.save.data.saveExists = true;
            FlxG.save.flush();
        }

        //Load in level data from external
        var loader = new flash.net.URLLoader();
        loader.addEventListener(Event.COMPLETE, doneLevels);
        loader.addEventListener(IOErrorEvent.IO_ERROR, fail);
        loader.load(new flash.net.URLRequest("assets/data/gamedata.json"));

        // //Disable sound tray
        // FlxG.sound.muteKeys =
        // FlxG.sound.volumeDownKeys =
        // FlxG.sound.volumeUpKeys = null;
    }

    //Called when levels are finished downloading
    public function doneLevels(e:flash.events.Event):Void {
        var stages = haxe.Json.parse(e.target.data);

        //If no level data exists, initialise as empty
        Reg.stage = 0;
        FlxG.switchState(Type.createInstance(nextState,[stages]));
    }

    //Called when levels FAIL to download
    public function fail(e):Void {
        var t = new FlxText(0,FlxG.height/2-50, FlxG.width,
                            "An error has occurred");
        t.setFormat(null, 50, 0xffffffff, "center");
        add(t);
        var t = new FlxText(0,FlxG.height/2+20, FlxG.width,
                            "the level data could not be downloaded");
        t.setFormat(null, 20, 0xffffffff, "center");
        add(t);
    }

    public override function update(elapsed:Float):Void {
        super.update(elapsed);
        if(FlxG.keys.justPressed.Q)
            Sys.exit(0);
    }

}
