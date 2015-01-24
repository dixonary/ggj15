package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;

class MenuState extends FlxState
{
	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

        var play = new FlxButton(FlxG.width / 2, FlxG.height / 2 - 50, "Play",
                                 function() {
                                     FlxG.switchState(new PlayState());});
        play.scale.set(4,4);
        var edit = new FlxButton(FlxG.width / 2, FlxG.height / 2 + 50, "Edit",
                                 function() {
                                     FlxG.switchState(new EditorState());});
        edit.scale.set(4,4);
		add(play);
		add(edit);
	}

    /*
	override public function destroy():Void {
		super.destroy();
	}
    */

	override public function update():Void {
		super.update();

        if(FlxG.keys.justPressed.END)
			Sys.exit(0);
	}
}
