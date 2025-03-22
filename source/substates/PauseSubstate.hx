package substates;

class PauseSubstate extends OcrpgSubState
{
	var camHud:FlxCamera;
	var camTop:FlxCamera;

	var fadeSprite:FlxSprite;
    var checker:FlxBackdrop;

    var volume:Float;
    var music:FlxSound;

    var controlAllowed:Bool = false;
	var curSelected:Int = 0;

    var pausedSprite:FlxText;

	var optionTexts:FlxTypedGroup<FlxText>;
	var textDataArray:Array<String> = [''];

	var characterTimer:FlxTimer;
	var characterSprite:FlxSprite;
	var characterTween:FlxTween;
	var characterNum:Int = 0;
	final characterTimeArray:Array<Float> = [4, 7, 4, 7]; //min timer, max timer, min character, max character

	public function new(options:Array<String>)
	{
		super();

		textDataArray = options;

		volume = FlxG.sound.music.volume;
	}

    override function create(){
		camHud = new FlxCamera();
		camTop = new FlxCamera();

		camHud.bgColor.alpha = 0;
		camTop.bgColor.alpha = 0;

		FlxG.cameras.add(camHud);
		FlxG.cameras.add(camTop);

		music = new FlxSound().loadEmbedded(Paths.music('pause', 'menu'), true, true);
		music.play();
		music.volume = 0;
		FlxG.sound.list.add(music);

		fadeSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		fadeSprite.alpha = 0;
		fadeSprite.cameras = [camHud];
		add(fadeSprite);

		checker = new FlxBackdrop(Paths.image('pauseMenu/checker', 'menu'));
		checker.velocity.set(15, 15);
		checker.alpha = 0;
		checker.cameras = [camHud];
		add(checker);

		optionTexts = new FlxTypedGroup<FlxText>();
		optionTexts.cameras = [camHud];
		add(optionTexts);

		pausedSprite = new FlxText(0, 150, FlxG.width, '- PAUSED -');
        pausedSprite.screenCenter(X);
		pausedSprite.setFormat(Paths.font("andy", 'global'), 65, FlxColor.WHITE, CENTER);
		pausedSprite.antialiasing = SaveData.settings.get('antiAliasing');
        pausedSprite.alpha = 0;
		pausedSprite.cameras = [camHud];
		add(pausedSprite);

		for (i in 0...textDataArray.length)
		{
			var designatedY:Float = pausedSprite.y + pausedSprite.height + 65 * i + 1;

			var text:FlxText = new FlxText(10, designatedY, FlxG.width, textDataArray[i]);
            text.screenCenter(X);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, CENTER);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.ID = i;
            text.alpha = 0;
			optionTexts.add(text);
		}
        
        initialize();
		initializeCharacters();

		super.init('none', 0);
    }

	override public function update(elapsed:Float)
	{
        if(controlAllowed){
			if (Controls.getControl('PAUSE', 'RELEASE')){
                exit('normal');
            }
			if (Controls.getControl('UP', 'RELEASE')){
                changeSelection(-1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
            }
			if (Controls.getControl('DOWN', 'RELEASE')){
                changeSelection(1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
            }
			if (Controls.getControl('ACCEPT', 'RELEASE')){
                makeSelection();
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
            }
        }

		super.update(elapsed);
    }

	function changeSelection(?num:Int = 0):Void
	{
		curSelected += num;

		if (curSelected >= textDataArray.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = textDataArray.length - 1;

		optionTexts.forEach(function(spr:FlxText)
		{
			if (textDataArray[spr.ID] != textDataArray[curSelected])
			{
				spr.alpha = 0.5;

				spr.text = textDataArray[spr.ID];
			}
			else
			{
				spr.alpha = 1;

				spr.text = '> ' + textDataArray[spr.ID] + ' <';
			}

            spr.screenCenter(X);
		});
	}

	function makeSelection():Void
	{
        switch(textDataArray[curSelected]){
            case 'resume':
                exit('normal');
            case 'restart battle':
                exit('restart');
            case 'quit to menu':
                exit('menu');
        }
    }

	inline function initialize():Void{
		FlxG.sound.music.fadeOut(.5, 0);

        new FlxTimer().start(.5, function(tmr:FlxTimer)
		{
            music.fadeIn(.5, 0, .35);
		});

		FlxTween.tween(fadeSprite, {alpha: 0.6}, .5, {ease: FlxEase.quartInOut});
		FlxTween.tween(checker, {alpha: 0.1}, .5, {ease: FlxEase.quartInOut});

		FlxTween.tween(pausedSprite, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
		optionTexts.forEach(function(spr:FlxText) {
			FlxTween.tween(spr, {alpha: 0.5}, .5, {ease: FlxEase.quartInOut});
        });

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
            controlAllowed = true;
			changeSelection();
		});
	}

	function exit(type:String):Void
	{
        switch(type){
            case 'normal':
				if(characterTimer.active) characterTimer.cancel();

				controlAllowed = false;

				music.fadeOut(.5, 0);

				new FlxTimer().start(.5, function(tmr:FlxTimer)
				{
					FlxG.sound.music.fadeIn(.5, 0, volume);
				});

				if (characterTween != null && characterTween.active){
					characterTween.cancel();
					characterTween.destroy();
				} 

				if (characterSprite != null){
					characterSprite.animation.pause();
				}

				FlxTween.tween(camHud, {alpha: 0}, .5, {ease: FlxEase.quartInOut});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					close();
				});    
            case 'restart':
				if (characterTimer.active) characterTimer.cancel();

				controlAllowed = false;

				music.fadeOut(1, 0);

				super.switchState(new BattleSplashScreenState('intro', new PlayState()), 'battle', 1.5, false);
            case 'menu':
				if (characterTimer.active) characterTimer.cancel();

				controlAllowed = false;

				music.fadeOut(1, 0);

				super.switchState(Battle.callbackArray[2], 'fade', 1.5, false);
        }
	}

	inline function initializeCharacters():Void{
		characterTimer = new FlxTimer().start(FlxG.random.float(characterTimeArray[0], characterTimeArray[1]), function(tmr:FlxTimer)
		{
			if (characterTween != null && characterTween.active){
				characterTween.cancel();
				characterTween.destroy();
			} 
			if(characterSprite != null) characterSprite.destroy();

			characterSprite = new FlxSprite();
			characterSprite.frames = Paths.getSparrowAtlas('pauseMenu/dancer_' + Battle.partyCharacters[characterNum], 'menu');
			characterSprite.animation.addByPrefix('idle', 'idle', 2);
			characterSprite.animation.play('idle');
			characterSprite.setGraphicSize(Std.int(characterSprite.width * .23));
			characterSprite.updateHitbox();
			characterSprite.cameras = [camHud];
			add(characterSprite);

			switch(characterNum){
				case 0:
					characterSprite.setPosition(50, FlxG.height);
					characterSprite.flipX = true;
				case 1:
					characterSprite.setPosition(FlxG.width - characterSprite.width - 50, FlxG.height);
			}

			characterTween = FlxTween.tween(characterSprite, {angle: FlxG.random.float(-40, 40), y: characterSprite.y - FlxG.random.float(500, 570), alpha: 0}, FlxG.random.float(characterTimeArray[2], characterTimeArray[3]), {onComplete: function(FlxTwn):Void{
				characterNum = Utilities.invertNum(characterNum);

				tmr.reset(FlxG.random.float(characterTimeArray[0], characterTimeArray[1]));
			}});
		});
	}
}
