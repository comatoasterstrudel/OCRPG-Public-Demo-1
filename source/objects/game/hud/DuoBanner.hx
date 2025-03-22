package objects.game.hud;

class DuoBanner extends FlxTypedGroup<FlxSprite>
{
	public function new(spriteName:String, delay:Float)
	{
		super(2);

		var endsuffix:String;

		var back:FlxSprite = new FlxSprite().loadGraphic(Paths.image('duo/bg', 'battle'));
		back.setGraphicSize(Std.int(back.width * .4));
		back.antialiasing = SaveData.settings.get('antiAliasing');
		back.updateHitbox();
		back.screenCenter(X);

		if(!FileSystem.exists(Paths.image('duo/sprites/' + spriteName, 'battle'))) spriteName = 'placeholder';
		
		var characSprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('duo/sprites/' + spriteName, 'battle'));
		characSprite.setGraphicSize(Std.int(characSprite.width * .4));
		characSprite.antialiasing = SaveData.settings.get('antiAliasing');
		characSprite.updateHitbox();
		characSprite.screenCenter(X);

		add(back);
		add(characSprite);

		back.ID = 1;
		characSprite.ID = 2;

		forEach(function(spr:FlxSprite)
		{
			spr.y = FlxG.height;

			FlxTween.tween(spr, {y: FlxG.height / 2 - spr.height / 2}, .5, {
				ease: FlxEase.quartInOut,
				startDelay: delay,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(spr, {y: -spr.height}, .7, {
						ease: FlxEase.quartInOut,
						startDelay: 1,
						onComplete: function(twn:FlxTween)
						{
							spr.destroy();

							if (spr.ID == 3)
							{
								destroy();
							}
						}
					});
				}
			});
		});
	}
}
