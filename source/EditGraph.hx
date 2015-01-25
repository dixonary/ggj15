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
            var s = new StageEdit(Reflect.copy(stage), i);
            graph[stage.id] = s;
            ++i;
            add(s);
        }
    }

    override public function update():Void
    {
        var mousePos = FlxG.mouse.getWorldPosition();
        var mouseOverNode:StageEdit = null;

        // update all nodes
        for (node in graph) {
            if (node.pixelsOverlapPoint(mousePos)) {
                mouseOverNode = node;
                node.hover = true;
            } else
                node.hover = false;
        }

        // Clicking
        if(FlxG.mouse.justPressed) {
            switch(selectMode) {
                case SELECT: 
                    if(mouseOverNode == null)
                        deselect();
                    else 
                        select(mouseOverNode);
                case LINK:
                    if(mouseOverNode != null)
                        selected.addChild(mouseOverNode, linkIndex);
                    selectMode = SELECT;
            }
        }

        // Checking for link mode
        if (selectMode == SELECT) {
            if(selected != null) {
                for (i in (0 ... linkKeys.length)) {
                    if (FlxG.keys.checkStatus(linkKeys[i], FlxKey.JUST_PRESSED)) {
                        linkIndex = i;
                        selectMode = LINK;
                    }
                }
                if(FlxG.keys.pressed.SHIFT && FlxG.keys.justPressed.DELETE) {
                    //Remove node
                }
            }
            if(FlxG.keys.justPressed.INSERT) {
                //Add new node
                var i = 0;
                while(true) {
                    if(graph[i] == null) {
                        var s = new StageEdit(
                        {"id":i, "world":"___", "title":"hmm?", "choices":[], "image":""},
                         i);
                        graph[i] = s;
                        add(s);
                        break;
                    }
                    i++;
                }
            }
        }

        // update mode text
        switch (selectMode) {
            case SELECT: modeText.text = "SELECT";
            case LINK: modeText.text = "LINK" + linkIndex;
        }

        super.update();
    }

    function deselect() {
        if(selected != null)
            selected.selected = false;
        selected = null;
        selectMode = SELECT;
    }
    function select(N:StageEdit) {
        deselect();
        N.selected = true;
        selected = N;
    }
}
