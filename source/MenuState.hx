package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

		add(new FlxButton(
            FlxG.width / 2, FlxG.height / 2 - 100, "Play", function() { 
                              FlxG.switchState(new PlayState());}));
		add(new FlxButton(
            FlxG.width / 2, FlxG.height / 2 + 100, "Edit", function() {
                              FlxG.switchState(new EditorState()); }));
	}
	
    /*
	override public function destroy():Void {
		super.destroy();
	}
    */

	override public function update():Void {
		super.update();

        if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	
}
