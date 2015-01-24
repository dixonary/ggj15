package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class PlayState extends FlxState
{

	private var worldName:FlxText;

	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

		worldName = new FlxText(0,0,FlxG.width, "", 24);
		add(worldName);
		currentStage = new StageView(0);
		stageViews.add(currentStage);

	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		worldName.text = Reg.stage.prefix + Reg.world;

		if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	


}