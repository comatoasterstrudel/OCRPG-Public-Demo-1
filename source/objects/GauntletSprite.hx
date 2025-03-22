package objects;

class GauntletSprite extends FlxSprite
{
    public var targetX:Float = 0;

	public function new(name:String)
	{
		super();

		loadGraphic(Paths.image('gauntletSelect/gauntletSprites/' + name, 'menu'));
		setGraphicSize(Std.int(width * .5));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');
		targetX = FlxG.width / 2 - width / 2;
	}

	override function update(elapsed:Float)
	{
		x = FlxMath.lerp(x, (targetX * FlxG.width / 2) + FlxG.width / 2 - width / 2, Utilities.boundTo(elapsed * 10.2, 0, 1));
        screenCenter(Y);

		super.update(elapsed);
	}	
}
