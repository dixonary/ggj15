package ;

class Reg
{
	// Globals
	public static var stages:Array<Stage>;
	public static var stage:Int;
}

typedef Stage = {
    var id:Int;
    var world:String;
    var image:String;
    var title:String;
    var choices:Array<Choice>;
}

typedef Choice = {
    var text:String;
    var link:Int;
}
