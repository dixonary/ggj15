package ;

import flixel.group.FlxTypedGroup;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.*;

class PlayState extends FlxState
{
	private var worldName:FlxText;
	private var currentStage:StageView;
	private var prevStage:StageView;

	private var stageViews:FlxTypedGroup<StageView>;
	private var moving = false;
    var stages:Array<Reg.Stage>;

    public function new(_stages:Array<Reg.Stage>, ?_start:Int = 0) {
        super();
        stages = _stages;
        Reg.stage = _start;
    }

	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

		stageViews = new FlxTypedGroup();
		add(stageViews);

		worldName = new FlxText(0,0,FlxG.width, "", 24);
		add(worldName);

		currentStage = new StageView(stages[Reg.stage]);
		stageViews.add(currentStage);
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		worldName.text = stages[Reg.stage].world;

        if(FlxG.keys.justPressed.F5) {
            FlxG.switchState((new EditorState(stages)));
        }

		if(FlxG.keys.justPressed.END)
			Sys.exit(0);

	}

	public function switchStage(NextStage:Int):Void {
		if(moving) return;

		Reg.stage = NextStage;
		prevStage = currentStage;
		currentStage = new StageView(stages[Reg.stage]);
		stageViews.add(currentStage);
		currentStage.y = FlxG.height;
		moving = true;
		prevStage.close();
		prevStage = null;
		new FlxTimer(
			0.5, function(_){
		    prevStage = null;
		    moving = false;
			});

	}

}
