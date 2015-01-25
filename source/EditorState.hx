package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import sys.FileSystem;
import sys.io.File;

class EditorState extends FlxState
{
	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

        add(new EditGraph(Reg.stages));
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		if(FlxG.keys.justPressed.S)
			save(Reg.stages);

		if(FlxG.keys.justPressed.END)
			FlxG.switchState(new PlayState());
	}

	// Writes an array of stages to the filesystem 
	// and backs up the old version
	static function save(Stages:Array<Reg.Stage>):Void {
		if(FileSystem.exists("assets/data/gamedata-old")) {
			if(!FileSystem.isDirectory("assets/data/gamedata-old")) {
				trace("Error: assets/data/gamedata-old exists 
					but is not a directory; quitting");
				return;
			}
		}
		else
			FileSystem.createDirectory("assets/data/gamedata-old");
		
		FileSystem.rename(
					"assets/data/gamedata.json", 
					"assets/data/gamedata-old/"+Date.now()+".json");

		File.saveContent("assets/data/gamedata.json",haxe.Json.stringify(Stages,null,"    "));
	}
}
