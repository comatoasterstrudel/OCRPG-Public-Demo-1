package objects;

class MainMenuButton extends FlxSprite
{
	public var selected:Bool = false;

	public var targetX:Float = 0;
	public var targetY:Float = 0;
	public var targetSize:Float = 0;
	public var targetAlpha:Float = 0;

	var scalemult:Float;

	public function new(name:String)
	{
		super();

		var filename:String;

		if(FileSystem.exists(Paths.image('mainMenu/buttons/' + name.toLowerCase(), 'menu'))){
			filename = name.toLowerCase();
		} else if (name.endsWith('back')) {
			filename = 'back';
		} else {
			filename = 'placeholder';
		}

		frames = Paths.getSparrowAtlas('mainMenu/buttons/' + filename, 'menu');
		animation.addByPrefix('select', 'select', 2);
		animation.addByPrefix('nonselect', 'nonselect', 1);
		setGraphicSize(Std.int(width * .225));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');
	}

	override function update(elapsed:Float)
	{
		if (selected){
			animation.play('select');

			targetAlpha = 1;
			targetSize = .25;
		} else {
			animation.play('nonselect');

			targetAlpha = .3;
			targetSize = .15;
		}

		x = FlxMath.lerp(x, (targetX * FlxG.width / 3) + FlxG.width / 2 - width / 2, Utilities.boundTo(elapsed * 10.2, 0, 1));
		y = FlxMath.lerp(y, (targetY), Utilities.boundTo(elapsed * 10.2, 0, 1));
		alpha = FlxMath.lerp(alpha, (targetAlpha), Utilities.boundTo(elapsed * 10.2, 0, 1));

		scale.x = FlxMath.lerp(scale.x, (targetSize), Utilities.boundTo(elapsed * 10.2, 0, 1));
		scale.y = FlxMath.lerp(scale.y, (targetSize), Utilities.boundTo(elapsed * 10.2, 0, 1));

		super.update(elapsed);
	}	
}
