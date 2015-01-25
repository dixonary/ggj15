package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.ui.FlxInputText;
import flixel.group.FlxSpriteGroup;

using flixel.util.FlxSpriteUtil;

class StageEditPopup extends FlxSpriteGroup {

    var stage:Reg.Stage;
    var bg:FlxSprite;
    var numRows = 0;
    var rows:Array<Row>;

    public function new(Stage:Reg.Stage) {

        super();
        stage = Stage;

        var width:Int = cast FlxG.width*0.6;
        var height:Int = cast FlxG.height*0.6;

        rows = [];

        add(bg=new FlxSprite().makeGraphic(width, height, 0xaa000000)
            .drawRect(0, 0, width-2, height-2, 0xff333333, {thickness:2, color:0xffffffff}));

        addRow(0.2, "World:", Stage.world,
            function(s1,_){ Stage.world=s1; });

        addRow(0.6, "What should we do now,", Stage.title,
            function(s1,_){ Stage.title=s1; });

        for(i in 0 ... 3) {
            if(stage.choices[i] != null) {
                addRow(0.2, ""+stage.choices[i].link, stage.choices[i].text,
                    function(s1,_) { stage.choices[i].text = s1; }, 4+i);
            }
        }

        x = (FlxG.width-width)/2;
        y = (FlxG.height-height)/2;

    }

    public function addRow(SepPos:Float, Label:String, Init:String, 
        F:String->String->Void. ?rowNum:Int) {
        if (rowNum == null) {
            rowNum = numRows++;
        }
        var k:Row;
        add(k=new Row(height*0.1, height*(0.1+rowNum*0.11), width-height*0.2, 
            height*0.1, SepPos, Label, Init, F));
        rows.push(k);
    }

    override public function destroy() {
        super.destroy();
        for (i in rows) {
            i.destroy();
        }
    }

    override public function update():Void {
        super.update();

        if(FlxG.keys.justPressed.ESCAPE) {
            destroy();
        }
    }

}

class Row extends FlxSpriteGroup {

    var bg:FlxSprite;
    var label:FlxText;
    var contents:FlxInputText;

    public function new(X:Float, Y:Float, Width:Float, Height:Float, SepBar:Float,
        Label:String, InitContents:String, OnUpdate:String->String->Void) {

        super(X,Y);
        bg = new FlxSprite();
        bg.makeGraphic(cast Width, cast Height, 0x00ffffff, true);
        bg.drawRect(0,0,Width-2, Height-2, 0x00000000,{thickness:2, color:0xffffffff});
        bg.drawLine(Width*SepBar, 0, Width*SepBar, Height-2, {thickness:2,color:0xffffffff});
        add(bg);

        label = new FlxText(0, Height*0.1, Width*(SepBar-0.02), Label);
        label.setFormat(null, cast height*0.6, 0xffffffff, "right");
        add(label);

        contents = new FlxInputText(Width*(0.02+SepBar), Height*0.1,
            cast Width*(1-SepBar-0.02)-4, InitContents, cast Height*0.6);
        contents.backgroundColor = 0xff333333;
        contents.fieldBorderThickness=0;
        contents.caretColor = 0xffffffff;
        contents.filterMode = FlxInputText.ONLY_ALPHA;
        contents.caretWidth = 3;
        contents.color = 0xffffff;
        contents.callback = OnUpdate;
        add(contents);

    }

    override public function destroy() {
        super.destroy();
        contents.kill();
        bg.destroy();
        label.destroy();
    }

}
