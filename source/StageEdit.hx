package ;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class StageEdit extends FlxSpriteGroup
{
    var stage:Reg.Stage;

    public var changed:Bool;

    public function new(_stage:Reg.Stage, hack_index:Int)
    {
        super();
        stage = _stage;

        add(new FlxText((hack_index % 6) * 30, Math.floor(hack_index /  6) * 30,
                    ""+stage.id, 20));
    }
}
