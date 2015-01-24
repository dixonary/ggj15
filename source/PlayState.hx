package ;

import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	override public function create():Void {
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	
}