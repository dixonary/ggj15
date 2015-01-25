package ;
import flixel.addons.ui.FlxInputText;
import flash.events.KeyboardEvent;

class InputBox extends FlxInputText {
    
    var dead:Bool = false;
    public function new(x,y,width,text,size) {
        super(x,y,width,text,size);
        backgroundSprite.alpha = 0;
    }
    override public function onKeyDown(e:KeyboardEvent):Void {
        if(dead) return;
        super.onKeyDown(e);
    }
    override public function onChange(action:String):Void {
        if (dead) return;
        super.onChange(action);
    }
    override public function destroy() {
        super.destroy();
        dead=true;
    }
}