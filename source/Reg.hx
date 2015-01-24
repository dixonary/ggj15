package ;

class Reg
{
	// Globals
	public static var stages:Array<Stage>;
	public static var stage:Int;

	public static var world:String = "Testplace";
}

typedef Stage = {
    var id:Int;
    var prefix:String;
    var image:String;
    var text:String;
    var choices:Array<Choice>;
}

typedef Choice = {
    var text:String;
    var link:Int;
}
