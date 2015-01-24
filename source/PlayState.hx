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

	override public function create():Void {
		super.create();
		FlxG.camera.antialiasing = true;

		stageViews = new FlxTypedGroup();
		add(stageViews);

		worldName = new FlxText(0,0,FlxG.width, "", 24);
		add(worldName);

		Reg.stage = 0;

		currentStage = new StageView(Reg.stage);
		stageViews.add(currentStage);

	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		worldName.text = Reg.stages[Reg.stage].prefix + Reg.world;

		if(FlxG.keys.pressed.N)
			switchStage(0);

		if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	

	public function switchStage(NextStage:Int):Void {
		if(moving) return;

		Reg.stage = NextStage;
		prevStage = currentStage;
		currentStage = new StageView(NextStage);
		stageViews.add(currentStage);
		currentStage.y = FlxG.height;
		moving = true;
		
		//Fade out current stage
		FlxTween.tween(prevStage, {alpha:0}, 0.5, 
		    {ease:FlxEase.quadInOut, 
		    complete:function(_){
			    prevStage.destroy();
			    prevStage = null;
			    moving = false;
		    }});

		new FlxTimer(1.5, function(_){
			FlxTween.tween(currentStage, {y:0}, 1, 
			{ease:FlxEase.quadInOut});
			});
	}

}
