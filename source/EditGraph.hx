package ;

import flixel.group.FlxSpriteGroup;

class EditGraph extends FlxSpriteGroup
{
    var stages:Array<StageEdit> = [];

    public function new(_stages:Array<Reg.Stage>)
    {
        super();
        var i:Int = 0;
        for (stage in _stages) {
            trace("Hello!");
            ++i;
            var s = new StageEdit(stage, i);
            stages.push(s);
            add(s);
        }
    }

    override public function update():Void
    {
        for (stage in stages) {
            if (stage.changed) {
                stage.changed = false;
            }
        }

        super.update();
    }
}
