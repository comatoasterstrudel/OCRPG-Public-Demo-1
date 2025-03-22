package objects;

class MenuText extends FlxText
{
	public var targetY:Float = 0;
    public var targetX:Float = 0;

	var type:String;
	public function new(x:Float, y:Float, name:String, ?thetype:String)
	{
		super(x, y);
		targetX = x;
        targetY = y;
		text = name;
		type = thetype;
	}


	override function update(elapsed:Float)
	{
		switch(type){
			case 'save':
				y = FlxMath.lerp(y, (targetY), Utilities.boundTo(elapsed * 10.2, 0, 1));
				x = FlxMath.lerp(x, (targetX * FlxG.width / 3) + FlxG.width / 2 - width / 2, Utilities.boundTo(elapsed * 10.2, 0, 1));
			default:
				y = FlxMath.lerp(y, (targetY * 120) + FlxG.height / 2 - height / 2, Utilities.boundTo(elapsed * 10.2, 0, 1));
				x = FlxMath.lerp(x, (targetX), Utilities.boundTo(elapsed * 10.2, 0, 1));
		}

		super.update(elapsed);
	}	
}
