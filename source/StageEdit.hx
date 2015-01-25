package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.addons.display.FlxExtendedSprite;

class StageEdit extends FlxSpriteGroup
{
    public inline static var size:Int = 50;
    public var selected = false;
    public var changed = false;
    public var hover = false;
    public var stage(default,null):Reg.Stage;
    public var box(default, null) = new FlxExtendedSprite();
    var followMouse:Bool = false;
    var mouseOffset:FlxPoint;
    var defaultColor = 0xcc996699;
    var selectedColor = 0xcccc8855;
    var hoverColor = 0x99aa6644;

    public function new(_stage:Reg.Stage, hack_index:Int)
    {
        super((hack_index % 6) * size*1.1, Math.floor(hack_index /  6) * size*1.1);
        stage = _stage;

        box.makeGraphic(size,size);
        box.color = defaultColor;
        add(box);
        var text = new FlxText(0, 0, ""+stage.id, 20) ;
        text.alignment = "center";
        add(text);
    }

    override public function update():Void
    {
        if (selected) {
            box.color = selectedColor;
        } else if (hover) {
            box.color = hoverColor;
        } else {
            box.color = defaultColor;
        }
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

    public function addChild(child:StageEdit, choice:Int) {
        var newText = "";
        if (stage.choices[choice] != null) {
            newText = stage.choices[choice].text;
        }
        stage.choices[choice] = {link: child.stage.id, text: newText};
    }
}
