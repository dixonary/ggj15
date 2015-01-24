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
				FlxG.width/4, FlxG.height/2+i*FlxG.height/8, FlxG.width/2,FlxG.height/9, 
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

class ChoiceButton extends FlxSprite {

	function new(X:Float, Y:Float, Width:Float, Height:Float, 
		         Id:Int, Link:Int, Text:String):Void {		
		super(X, Y);

        makeGraphic(cast Width, cast Height, 0xff123456, true);

	}

}