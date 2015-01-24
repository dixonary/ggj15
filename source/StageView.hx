package ;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

using flixel.util.FlxSpriteUtil;

class StageView extends FlxSpriteGroup {

	private var whatNow:FlxText;	
	private var choices:Array<ChoiceButton>;

	private var stageNum:Int;

	function new(StageNum:Int):Void {
		super();
		stageNum = StageNum;

		whatNow = new FlxText(0, FlxG.height/6, FlxG.width, "", cast FlxG.height/15);
		whatNow.alignment = "center";
		add(whatNow);

		choices = [];
		var ch = Reg.stages[stageNum].choices;
		for(i in 0 ... ch.length) {
			var c = new ChoiceButton(
				FlxG.width/4, FlxG.height/2+i*FlxG.height/6, FlxG.width/2,FlxG.height/8, 
				i, ch[i].link, ch[i].text);
			choices.push(c);
			add(c);
		}	
	}

	override public function update():Void {
		super.update();
		whatNow.text = Reg.stages[stageNum].text; 
	}	
}

class ChoiceButton extends FlxSpriteGroup {

	private var bg:FlxSprite;
	private var label:FlxText;

	function new(X:Float, Y:Float, Width:Float, Height:Float, 
		         Id:Int, Link:Int, Text:String):Void {		
		super(X, Y);

		bg = new FlxSprite();
        bg.makeGraphic(cast Width, cast Height, 0x00123456, true);
        bg.drawRoundRect(1, 1, Width-2, Height-2, Height/4,Height/4,0xff123456,
        	{thickness:2, color:0xff2468ac, pixelHinting:true});
        add(bg);

        label = new FlxText(0,0.1*Height,Width,Text,cast 0.6*Height);
        label.alignment = "center";
        add(label);

	}

}