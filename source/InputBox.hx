package ;

import flixel.addons.ui.FlxInputText;

class InputBox extends FlxInputText {
    
    public function new(x,y,width,text,size) {
        super(x,y,width,text,size);
        backgroundSprite.alpha = 0;
    }

}