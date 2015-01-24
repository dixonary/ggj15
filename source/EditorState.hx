package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class EditorState extends FlxState
{
	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		if(FlxG.keys.justPressed.Q)
			FlxG.switchState(new PlayState());
	}
}
