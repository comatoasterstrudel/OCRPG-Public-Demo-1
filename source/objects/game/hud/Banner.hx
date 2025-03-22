package objects.game.hud;

class Banner extends FlxTypedGroup<FlxSprite>
{
	public function new(spriteName:String, side:String, delay:Float)
	{
		super(3);

		var endsuffix:String;
		var spritesuffix:String;

		if(side == 'top') endsuffix = '_vertical'; else endsuffix = '_horizontal';

		if (side == 'top') spritesuffix = 'boss_'; else spritesuffix = '';

		var bannerBack:FlxSprite = new FlxSprite().loadGraphic(Paths.image('banner/bg/bannerBack' + endsuffix, 'battle'));
		bannerBack.setGraphicSize(Std.int(bannerBack.width * .4));
		bannerBack.antialiasing = SaveData.settings.get('antiAliasing');
		bannerBack.updateHitbox();
		bannerBack.screenCenter(Y);

		var bannerFront:FlxSprite = new FlxSprite().loadGraphic(Paths.image('banner/bg/bannerFront' + endsuffix, 'battle'));
		bannerFront.setGraphicSize(Std.int(bannerFront.width * .4));
		bannerFront.antialiasing = SaveData.settings.get('antiAliasing');
		bannerFront.updateHitbox();
		bannerFront.screenCenter(Y);

		var characSprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('banner/sprites/sprite_' + spritesuffix + spriteName, 'battle'));
		characSprite.setGraphicSize(Std.int(characSprite.width * .4));
		characSprite.antialiasing = SaveData.settings.get('antiAliasing');
		characSprite.updateHitbox();
		characSprite.screenCenter(Y);

		add(bannerBack);
		add(characSprite);
		add(bannerFront);

		bannerBack.ID = 1;
		characSprite.ID = 2;
		bannerFront.ID = 3;

		bannerBack.color = grabColor('back', spriteName);
		bannerFront.color = grabColor('front', spriteName);
		if(side == 'top'){
			forEach(function(spr:FlxSprite){
				spr.screenCenter(X);
				spr.y = -spr.height;

				FlxTween.tween(spr, {y: 0}, .5, {
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
		else if (side == 'right')
		{
			forEach(function(spr:FlxSprite)
			{
				spr.flipX = true;
				spr.x = FlxG.width;

				FlxTween.tween(spr, {x: FlxG.width - spr.width}, .5, {
					ease: FlxEase.quartInOut,
					startDelay: delay,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {x: FlxG.width}, .7, {
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
		else // defaults to the left
		{
			forEach(function(spr:FlxSprite)
			{
				spr.x = -spr.width;

				FlxTween.tween(spr, {x: 0}, .5, {
					ease: FlxEase.quartInOut,
					startDelay: delay,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(spr, {x: -spr.width}, .7, {
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

	function grabColor(type:String, colortoget:String):FlxColor
	{
		var colorToSend:FlxColor = FlxColor.WHITE;

		if (type == 'back')
			colorToSend = Std.parseInt('0xFF' + Utilities.grabThingFromText(colortoget, Paths.txt('bannerColors', 'battle'), 1));
		else
			colorToSend = Std.parseInt('0xFF' + Utilities.grabThingFromText(colortoget, Paths.txt('bannerColors', 'battle'), 2));

		return colorToSend;
	}
}
