package states;

class SplashScreenState extends OcrpgState
{
	var logo:FlxSprite;
	var text:FlxText;

	override public function create()
	{
		logo = new FlxSprite().loadGraphic(Paths.image('introSplashScreen/companyLogo', 'misc'));
		logo.setGraphicSize(Std.int(logo.width * .4));
		logo.updateHitbox();
		logo.screenCenter();
		logo.y += 50;
		logo.antialiasing = SaveData.settings.get('antiAliasing');
		logo.alpha = 0;
		add(logo);

		text = new FlxText(0, logo.y - 100, 0, "A Game by Happy Campers", 54);
		text.setFormat(Paths.font("andy", 'global'), 54, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.antialiasing = SaveData.settings.get('antiAliasing');
		text.screenCenter(X);
		text.alpha = 0;
		add(text);

		FlxTween.tween(logo, {alpha: 1}, 1, {ease: FlxEase.cubeInOut});
		FlxTween.tween(text, {alpha: 1}, 1, {ease: FlxEase.cubeInOut});

		FlxG.sound.play(Paths.sound('splashSound', 'misc'), .6);

		var fadeIn:ScreenTransition = new ScreenTransition('fade', 'in', 2);
		add(fadeIn);

		super.switchState(new SaveSelectState(), 'fade', 1, false, 5.5);

		new FlxTimer().start(4, function(tmr:FlxTimer)
		{
			FlxTween.tween(logo, {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
			FlxTween.tween(text, {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
		});

		super.init('fade', 1, 'custom', 'Starting the Game...', 'A Game by Happy Campers');
	}
}
