package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.addons.display.FlxExtendedSprite;

class StageEdit extends FlxSpriteGroup
{
    public inline static var size:Int = 50;
    public inline static var defaultColor = 0xcc996699;
    public inline static var selectedColor = 0xcccc8855;
    public inline static var hoverColor = 0x99aa6644;

    public var selected = false;
    public var changed = false;
    public var hover = false;
    public var stage(default,null):Reg.Stage;
    public var box(default, null) = new FlxExtendedSprite();
    var followMouse:Bool = false;
    var mouseOffset:FlxPoint;

    public function new(_stage:Reg.Stage, _index:Int)
    {
        var x1 = _stage.x == null ? (_index % 15) * size*1.1 : _stage.x;
        var y1 = _stage.y == null ? Math.floor(_index /  15) * size*1.1:_stage.y;
        super(x1, y1);
        stage = _stage;

        box.makeGraphic(size,size);
        box.color = defaultColor;
        add(box);
        var text = new FlxText(0, 0, ""+stage.id, 20) ;
        text.alignment = "center";
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        if (selected) {
            box.color = selectedColor;
        } else if (hover) {
            box.color = hoverColor;
        } else {
            box.color = defaultColor;
        }
        var mousePos = FlxG.mouse.getWorldPosition();
        if (box.mouseOver && FlxG.mouse.justPressed && selected) {
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

        x = Math.floor(x / (size/2)) * (size/2);
        y = Math.floor(y / (size/2)) * (size/2);

        stage.x = x;
        stage.y = y;

        super.update(elapsed);
    }

    public function addChild(child:StageEdit, choice:Int):Void {
        var newText = "";
        if (stage.choices[choice] != null) {
            newText = stage.choices[choice].text;
        }
        stage.choices[choice] = {link: child.stage.id, text: newText};
    }

    public function removeChoice(choice:Int):Void {
        stage.choices[choice] = null;
    }
}
