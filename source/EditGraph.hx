package ;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxCollision;

class EditGraph extends FlxSpriteGroup
{
    var stages:Array<StageEdit> = [];
    var selected:StageEdit;

    public function new(_stages:Array<Reg.Stage>)
    {
        super();
        var i:Int = 0;
        for (stage in _stages) {
            ++i;
            var s = new StageEdit(Reflect.copy(stage), i);
            stages.push(s);
            add(s);
        }
    }

    override public function update():Void
    {
        var mousePos = FlxG.mouse.getWorldPosition();

        for (stage in stages) {
            if (stage.changed) {
                stage.changed = false;
            }

            if (FlxG.mouse.justPressed) {
                if (FlxCollision.pixelPerfectPointCheck(
                            cast(mousePos.x), cast(mousePos.y), stage.box)) {
                    selected = stage;
                }
                stage.set_selected(false);
            }
        }
        if (FlxG.mouse.justPressed && selected != null) {
            selected.set_selected(true);
        }

        super.update();
    }
}
