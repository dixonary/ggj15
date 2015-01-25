package ;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

using flixel.util.FlxSpriteUtil;

class StageView extends FlxSpriteGroup {
	private var whatNow:FlxText;	
	private var text:FlxText;
	private var choices:Array<ChoiceButton>;

    var stage:Reg.Stage;

	function new(_stage:Reg.Stage):Void {
		super();
        stage = _stage;

        text = new FlxText(0, FlxG.height/6, FlxG.width, 
        	_stage.text, cast FlxG.height/20);
        text.alignment = "center";
        add(text);

		whatNow = new FlxText(0, FlxG.height/3, FlxG.width, 
			_stage.title==""?"":"What do we do now, " + _stage.title, cast FlxG.height/15);
		whatNow.alignment = "center";
		add(whatNow);

		choices = [];
		var ch = stage.choices;
		for(i in 0 ... ch.length) {
			var c = new ChoiceButton(
				FlxG.width/8, FlxG.height/2+i*FlxG.height/6, FlxG.width*0.75,FlxG.height/8, 
				i, ch[i].link, ch[i].text);
			choices.push(c);
			add(c);
		}	
	}

	override public function update():Void {
		super.update();
	}
}


class ChoiceButton extends FlxSpriteGroup {

	private var bg:FlxSprite;
	private var label:FlxText;
	private var link:Int;

	function new(X:Float, Y:Float, Width:Float, Height:Float, 
		         Id:Int, Link:Int, Text:String):Void {		
		super(X, Y);

	link = Link;

	bg = new FlxSprite();
        bg.makeGraphic(cast Width, cast Height, 0x00123456, true);
        bg.drawRoundRect(1, 1, Width-2, Height-2, Height/4,Height/4,0xff123456,
        	{thickness:2, color:0xff2468ac, pixelHinting:true});
        add(bg);

        label = new FlxText(-Width,0.3*Height,Width*3,Text,cast 0.4*Height);
        label.alignment = "center";
        add(label);

	}

	override public function update():Void {
		super.update();

		var mw = FlxG.mouse.getWorldPosition();
		if(FlxG.mouse.justPressed) {
			if(mw.x > x && mw.x < x+bg.width
		       && mw.y > y && mw.y < y+bg.height) {
				var state:PlayState = cast FlxG.state;
				state.switchStage(link);
			}
		}
	}
}
