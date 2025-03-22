package objects.game;

class BattleBackground extends FlxSprite
{
	public function new(spriteName:String)
	{
		super();

		frames = Paths.getSparrowAtlas('backgrounds/bg_' + spriteName, 'battle');
		animation.addByPrefix('normal', 'normal', 1);
		animation.addByPrefix('dead', 'dead', 1);
		animation.play('normal');
		setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		updateHitbox();
		screenCenter();
		antialiasing = SaveData.settings.get('antiAliasing');
	}
}