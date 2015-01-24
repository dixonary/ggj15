package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.addons.display.FlxExtendedSprite;

class StageEdit extends FlxSpriteGroup
{
    inline static var size:Int = 30;
    public var selected(default,set) = false;
    public var stage(get,null):Reg.Stage;
    public var box(default, null) = new FlxExtendedSprite();
    var followMouse:Bool = false;
    var mouseOffset:FlxPoint;
    var defaultColor = 0xcc996699;
    var selectedColor = 0xcccc8855;
    public var changed:Bool;

    public function new(_stage:Reg.Stage, hack_index:Int)
    {
        super((hack_index % 6) * size, Math.floor(hack_index /  6) * size);
        stage = _stage;

        box.makeGraphic(size,size);
        box.color = defaultColor;
        add(box);
        var text = new FlxText(0,0, ""+stage.id, 20) ;
        text.alignment = "center";
        add(text);
    }

    override public function update():Void
    {
        var mousePos = FlxG.mouse.getWorldPosition();
        if (box.mouseOver && FlxG.mouse.justPressed) {
            var pos = new FlxPoint(x,y);
            followMouse = true;
            mouseOffset = pos.subtractPoint(mousePos);
        } else if (followMouse && FlxG.mouse.justReleased) {
            followMouse = false;
        }

        if (followMouse) {
            var newPos = mousePos.addPoint(mouseOffset);
            x = newPos.x;
            y = newPos.y;
        }

        super.update();
    }

    public function set_selected(v:Bool):Bool
    {
        if (v) {
            box.color = selectedColor;
        } else {
            box.color = defaultColor;
        }
        selected = v;
        return selected;
    }

    public function get_stage():Reg.Stage
    {
        return stage;
    }
}
