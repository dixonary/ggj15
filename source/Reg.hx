package ;

class Reg
{
	// Globals
	public static var stages:Array<Stage>;
	
	public static var stage:Stage;
}

typedef Stage = {
	var id:Int;
	var image:String;
	var text:String;
	var choices:Array<Choice>;
}

typedef Choice = {
	var text:String;
	var link:Int;
}