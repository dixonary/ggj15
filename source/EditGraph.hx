package ;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxCollision;
import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;

enum SelectMode { SELECT; LINK; }

class EditGraph extends FlxSpriteGroup
{
    var linkIndex:Int = 0;
    var graph:Array<StageEdit> = [];
    var selected:StageEdit;
    var modeText:FlxText;
    var linkKeys:Array<Int> = [FlxKey.ONE, FlxKey.TWO, FlxKey.THREE];

    var selectMode:SelectMode = SELECT;

    public function new(_stages:Array<Reg.Stage>)
    {
        super();

        // add ui text reflecting mode
        modeText = new FlxText(FlxG.width / 2, FlxG.height / 2, "SELECT", 30);
        modeText.color = 0xff666666;
        add(modeText);

        // add nodes
        var i:Int = 0;
        for (stage in _stages) {
            ++i;
            var s = new StageEdit(Reflect.copy(stage), i);
            graph[stage.id] = s;
            add(s);
        }
    }

    override public function update():Void
    {
        var mousePos = FlxG.mouse.getWorldPosition();
        var mouseOverNode:StageEdit = null;

        // update all nodes
        for (node in graph) {
            if (node.changed) {
                node.changed = false;
            }

            if (FlxCollision.pixelPerfectPointCheck(
                        cast(mousePos.x), cast(mousePos.y), node.box)) {
                mouseOverNode = node;
            } else {
                if (FlxG.mouse.justPressed && selectMode == SELECT) {
                    node.selected = false;
                }
                node.hover = false;
            }
        }

        // set selectMode
        if (selected != null) {
            for (i in (0 ... linkKeys.length)) {
                if (FlxG.keys.checkStatus(linkKeys[i], FlxKey.JUST_PRESSED)) {
                    linkIndex = i;
                    selectMode = LINK;
                }
            }
        } else {
            // no selected node
            if (selectMode == LINK) {
                selectMode = SELECT;
            }
        }

        // update focussed node
        if (mouseOverNode != null) {
            mouseOverNode.hover = true;
            if (FlxG.mouse.justPressed) {
                if (selectMode == SELECT) {
                    selected = mouseOverNode;
                    selected.selected = true;
                } else if (selectMode == LINK) {
                    selected.addChild(mouseOverNode, linkIndex);
                }
            }
        } else if (FlxG.mouse.justPressed) {
            // no node focussed but user has clicked
            if (selected != null) {
                selectMode = SELECT;
                selected.selected = false;
            }
        }

        // update mode text
        switch (selectMode) {
            case SELECT: modeText.text = "SELECT";
            case LINK: modeText.text = "LINK" + linkIndex;
        }

        super.update();
    }
}
