package ;

import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class Arc extends FlxSprite {
    
    public function new(FromX:Float, FromY:Float, ToX:Float, ToY:Float) {
        super(FromX, FromY);
        updatePos(FromX, FromY, ToX, ToY);
    }

    public function updatePos(FromX:Float, FromY:Float, ToX:Float, ToY:Float) {
        var dx = ToX-FromX;
        var dy = ToY-FromY;
        var length:Int = cast Math.sqrt(dx*dx+dy*dy);

        x = FromX;
        y = FromY - height/2;


        makeGraphic(length, 9, 0x00ffffff, true);

        drawLine(0, height/2, width, height/2, 
            {thickness:1, color:0xffffffff});
        drawLine(width/2-height/2, 0, width/2, height/2, 
            {thickness:1, color:0xffffffff});
        drawLine(width/2, height/2, width/2-height/2, height, 
            {thickness:1, color:0xffffffff});

        this.angle = Math.atan2(dy,dx) * 180 / Math.PI;
        origin.y = height/2;
        origin.x = 0;

    }

}