package ;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.text.FlxText;

class StageView extends FlxSpriteGroup {

	private var whatNow:FlxText;	
	private var stageNum:Int;

	function new(StageNum:Int):Void {
		super();
		stageNum = StageNum;

		whatNow = new FlxText(0, FlxG.height/6, FlxG.width, "", 48);
		whatNow.alignment = "center";
		add(whatNow);	
	}

	override public function update():Void {
		super.update();
		whatNow.text   = Reg.stages[stageNum].text; 
	}	
	
}