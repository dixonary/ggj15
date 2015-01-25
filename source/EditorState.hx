package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
class EditorState extends FlxState
{
    var stages:Array<Reg.Stage>;

    public function new(?_stages:Array<Reg.Stage>)
    {
        super();
        if (_stages == null) {
            _stages = [];
        }
        stages = _stages;
    }

	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

        add(new EditGraph(stages));
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		if(FlxG.keys.justPressed.END) 
			Sys.exit(0);
	}

}
