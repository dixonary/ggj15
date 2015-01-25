package ;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxCollision;
import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;
import sys.FileSystem;
import sys.io.File;

enum SelectMode { SELECT; LINK; EDIT; }

class EditGraph extends FlxSpriteGroup
{
    var linkIndex:Int = 0;
    var graph:Array<StageEdit> = [];
    var selected:StageEdit;
    var modeText:FlxText;
    var linkKeys:Array<Int> = [FlxKey.ONE, FlxKey.TWO, FlxKey.THREE];
    var arcList:Array<Array<Arc>> = [];
    var arcs:FlxSpriteGroup;
    var popup:StageEditPopup;

    var selectMode:SelectMode = SELECT;

    public function new(_stages:Array<Reg.Stage>)
    {
        super();

        // add ui text reflecting mode
        modeText = new FlxText(0, FlxG.height/2-50, FlxG.width, "SELECT", 30);
        modeText.alignment="center";
        modeText.color = 0xff666666;
        add(modeText);

        //Add behind arc group
        arcs = new FlxSpriteGroup();
        add(arcs);

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
            drawLinks(node);
            if (node.pixelsOverlapPoint(mousePos)) {
                mouseOverNode = node;
            }
            node.hover = false;
        }

        // show which node has focus
        if (mouseOverNode != null) {
            mouseOverNode.hover = true;
        }

        // Clicking
        if(FlxG.mouse.justPressed) {
            switch(selectMode) {
                case SELECT:
                    if(mouseOverNode == null) {
                        deselect();
                    }
                    else {
                        select(mouseOverNode);
                    }
                case LINK:
                    if(mouseOverNode != null) {
                        selected.addChild(mouseOverNode, linkIndex);
                    } else {
                        selected.selected = false;
                        selected = null;
                    }
                    selectMode = SELECT;
                default:
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
                if(FlxG.keys.justPressed.ENTER) {
                    selectMode = EDIT;
                    add(popup = new StageEditPopup(selected.stage));
                }
            }
            if(FlxG.keys.justPressed.INSERT) {
                //Add new node
                var i = 0;
                while(true) {
                    if(graph[i] == null) {
                        var s = new StageEdit(
                        {id:i, world:"WORLD", title:"TITLE", 
                        choices:[], image:"", x:null, y:null},
                         i);
                        graph[i] = s;
                        add(s);
                        break;
                    }
                    i++;
                }
            }
        } else if(selectMode == EDIT) {
            if(FlxG.keys.anyJustPressed(["ESCAPE", "ENTER"])) {
                remove(popup);
                popup = null;
                selectMode = SELECT;
            }
        } else if (selectMode == LINK) {
            if (FlxG.keys.justPressed.DELETE) {
                selected.removeChoice(linkIndex);
                selectMode = SELECT;
            }
        }

        // update mode text
        switch (selectMode) {
            case SELECT: modeText.text = "SELECT";
            case LINK: modeText.text = "LINK " + (linkIndex+1);
            case EDIT: modeText.text = "EDIT " + (selected.stage.id+1);
        }

        if(selectMode == SELECT && FlxG.keys.justPressed.F4)
            save(graph.map(function(st){return st.stage;}));

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

    function drawLinks(n:StageEdit) {
        var stage = n.stage;
        for (i in (0...3)) {
            if (arcList[stage.id] == null) {
                arcList[stage.id] = [];
            }
            var arc = arcList[stage.id][i];
            var choice = stage.choices[i];

            if (choice == null) {
                arcs.remove(arc);
                arcList[stage.id][i] = null;
            } else {
                var target = graph[choice.link];
                var halfSize = StageEdit.size/2;
                var nX = n.x + halfSize;
                var nY = n.y + halfSize;
                var targetX = target.x + halfSize;
                var targetY = target.y + halfSize;

                if (arc == null) {
                    arcList[stage.id][i] =
                                     arc = new Arc(nX, nY, targetX, targetY);
                    arcs.add(arc);
                } else {
                    arc.updatePos(nX, nY, targetX, targetY);
                }
            }
        }
    }

    // Writes an array of stages to the filesystem 
    // and backs up the old version
    static function save(Stages:Array<Reg.Stage>):Void {
        if(FileSystem.exists("assets/data/gamedata-old")) {
            if(!FileSystem.isDirectory("assets/data/gamedata-old")) {
                trace("Error: assets/data/gamedata-old exists 
                    but is not a directory; quitting");
                return;
            }
        }
        else
            FileSystem.createDirectory("assets/data/gamedata-old");
        
        FileSystem.rename(
                    "assets/data/gamedata.json", 
                    "assets/data/gamedata-old/"+Date.now()+".json");

        File.saveContent("assets/data/gamedata.json",haxe.Json.stringify(Stages,null,"    "));
    }
}
