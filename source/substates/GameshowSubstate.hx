package substates;

class GameshowSubstate extends OcrpgSubState
{
	var fadeSprite:FlxSprite;

	var topSpriteGroup:FlxTypedGroup<FlxSprite>;
	var boxSpriteGroup:FlxTypedGroup<FlxSprite>;
	var textSpriteGroup:FlxTypedGroup<FlxSprite>;

	var topSprite:FlxSprite;
	var topText:FlxText;

    var curAnswers:Array<String>;
    var curQuestion:String;
    var answerArray:Array<String>;
    var correctAnswers:Array<Int> = [];

	var controlAllowed:Bool = false;

	var finishCallback:String->Void = null;

	var bombSprite:FlxSprite;
	var bombText:FlxText;
	var bombTimer:FlxTimer;
	var bombTextTimer:FlxTimer;
	var shakeTween:FlxTween;
	var shakeTweenTwo:FlxTween;
	var time:Int = 20;
	var loseFunction:Void -> Void;
	var bombActive:Bool = true;

	public function new(realDataArray:Array<String>, finishthing:String->Void, loseFunctionCCC:Void -> Void)
	{
		super();

		finishCallback = finishthing;
		loseFunction = loseFunctionCCC;

		curAnswers = [realDataArray[1], realDataArray[2], realDataArray[3], realDataArray[4]];
		curQuestion = realDataArray[0];
		
        var answerArray:Array<String> = realDataArray[5].split("+");

		for (i in 0...answerArray.length){
			correctAnswers.insert(correctAnswers.length, Std.parseInt(answerArray[i]));
        }
	}

	override function create()
	{		
		topSpriteGroup = new FlxTypedGroup<FlxSprite>();
		add(topSpriteGroup);

		boxSpriteGroup = new FlxTypedGroup<FlxSprite>();
		add(boxSpriteGroup);

		textSpriteGroup = new FlxTypedGroup<FlxSprite>();
		add(textSpriteGroup);

		fadeSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF393939);
		fadeSprite.alpha = 0;
		add(fadeSprite);

		FlxTween.tween(fadeSprite, {alpha: .3}, .5, {ease: FlxEase.quartInOut});

		topSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width / 1.5), 100, 0xFFFFFFFF);
		topSprite.setPosition(FlxG.width / 2 - topSprite.width / 2, 20);
		topSprite.alpha = .8;
		topSpriteGroup.add(topSprite);

		topText = new FlxText(0, 0, 500, curQuestion, 35, false);
		topText.setFormat(Paths.font("andy", 'global'), 35, Std.parseInt('0xFF' + Utilities.grabThingFromText('Coma', Paths.txt('textColors', 'dialogue'), 1)), CENTER, OUTLINE, FlxColor.BLACK);
		topText.borderSize = 2;
		topText.screenCenter(X);
		topText.y = topSprite.y + topSprite.height / 2 - topText.height / 2;
		topText.antialiasing = SaveData.settings.get('antiAliasing');
		topSpriteGroup.add(topText);

        for(i in 0...curAnswers.length){
			var sprite:FlxSprite = new FlxSprite().makeGraphic(230, 100, 0xFFFFFFFF);
			sprite.alpha = 0;
			sprite.ID = i;
			boxSpriteGroup.add(sprite);

			switch (i){
				case 0:
                    sprite.setPosition(FlxG.width / 2 - sprite.width / 2, FlxG.height / 2 - sprite.height / 2 - 130);
				case 1:
					sprite.setPosition(FlxG.width / 2 - sprite.width / 2 + 200, FlxG.height / 2 - sprite.height / 2);
				case 2:
					sprite.setPosition(FlxG.width / 2 - sprite.width / 2, FlxG.height / 2 - sprite.height / 2 + 130);
				case 3:
					sprite.setPosition(FlxG.width / 2 - sprite.width / 2 - 200, FlxG.height / 2 - sprite.height / 2);
			}

			var text:FlxText = new FlxText(0, 0, sprite.width, curAnswers[i], 25, false);
			text.setFormat(Paths.font("andy", 'global'), 25, Std.parseInt('0xFF' + Utilities.grabThingFromText('Coma', Paths.txt('textColors', 'dialogue'), 1)), CENTER, OUTLINE, FlxColor.BLACK);
			text.borderSize = 2;
			text.screenCenter(X);
			text.setPosition(sprite.x + sprite.width / 2 - text.width / 2, sprite.y + sprite.height / 2 - text.height / 2);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.alpha = 0;
            text.ID = i;
			textSpriteGroup.add(text);
        }

		bombSprite = new FlxSprite();
		bombSprite.frames = Paths.getSparrowAtlas('bossspecific/gameshow/comabomberletsgo', 'battle');
		bombSprite.animation.addByPrefix('normal', 'normal', 24);
		bombSprite.animation.addByPrefix('erratic', 'erratic', 24);
		bombSprite.animation.addByPrefix('erraticmore', 'erratic', 30);
		bombSprite.animation.play('normal');
		bombSprite.setGraphicSize(Std.int(bombSprite.width * .2));
		bombSprite.updateHitbox();
		bombSprite.setPosition(FlxG.width - bombSprite.width, FlxG.height - bombSprite.height);
		add(bombSprite);
		
		bombText = new FlxText(bombSprite.x, bombSprite.y, 0, '20', 60, false);
		bombText.setFormat(Paths.font("andy", 'global'), 60, FlxColor.WHITE, CENTER);
		bombText.antialiasing = SaveData.settings.get('antiAliasing');
		bombText.alpha = 0;
		add(bombText);

		bombSprite.y += bombSprite.height * 1.5;
		FlxTween.tween(bombSprite, {y: bombSprite.y - bombSprite.height * 1.5}, .5, {startDelay: 1, ease: FlxEase.backOut});

		new FlxTimer().start(2, function(tmr:FlxTimer){
			controlAllowed = true;

			shakeTweenTwo = FlxTween.shake(bombSprite, 0.005, time / 2, XY);

			bombTimer = new FlxTimer().start(time / 2, function(tmr:FlxTimer)
			{
				shakeTweenTwo = FlxTween.shake(bombSprite, 0.015, time / 4, XY);
				bombSprite.animation.play('erratic');
				bombTimer = new FlxTimer().start(time / 4, function(tmr:FlxTimer)
				{
					shakeTweenTwo = FlxTween.shake(bombSprite, 0.025, time / 4, XY);
					bombSprite.animation.play('erraticmore');
					bombTimer = new FlxTimer().start(time / 4, function(tmr:FlxTimer)
					{
						if (bombActive){
							close();
							loseFunction();
						}
					});
				});
			});

			shakeTween = FlxTween.shake(bombText, 0.05, time, XY);

			FlxTween.tween(bombText, {alpha: 1}, .5, {ease: FlxEase.quartInOut});

			for (i in 0...time)
			{
				bombTextTimer = new FlxTimer().start(i, function(tmr:FlxTimer)
				{
					var realtime:Int = time - i;
					bombText.text = '' + realtime;
					bombText.setPosition(bombSprite.x + bombSprite.width / 2 - bombText.width / 2 - 25, bombSprite.y + bombSprite.height / 2 - bombText.height / 2 + 25);
				});
			}
		});

		topSpriteGroup.forEach(function(spr:FlxSprite):Void
		{
			var positionArray:Array<Float> = [spr.x, spr.y];

			spr.y -= topSprite.height - 30;

			FlxTween.tween(spr, {y: positionArray[1]}, .5, {ease: FlxEase.quartInOut});
		});

		new FlxTimer().start(.9, function(tmr:FlxTimer)
		{
			boxSpriteGroup.forEach(function(spr:FlxSprite):Void
			{
				spr.alpha = 0;

				var positionArray:Array<Float> = [spr.x, spr.y];

				switch (spr.ID)
				{
					case 0:
						spr.y -= 50;
					case 1:
						spr.x += 50;
					case 2:
						spr.y += 50;
					case 3:
						spr.x -= 50;
				}

				FlxTween.tween(spr, {x: positionArray[0], y: positionArray[1], alpha: .8}, .5, {
					ease: FlxEase.cubeInOut,
					onComplete: function(FlxTwn):Void
					{
						textSpriteGroup.forEach(function(sprtext:FlxSprite):Void
						{
							if (sprtext.ID == spr.ID)
							{
								sprtext.setPosition(spr.x + spr.width / 2 - sprtext.width / 2, spr.y + spr.height / 2 - sprtext.height / 2);

								var additive:Float = .1 * spr.ID;
								FlxTween.tween(sprtext, {alpha: 1}, .5 + additive, {ease: FlxEase.quartInOut});
							}
						});
					}
				});
			});
		});

		super.init('none', 0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(controlAllowed){
			if (Controls.getControl('UP', 'RELEASE') || Controls.getControl('RIGHT', 'RELEASE') || Controls.getControl('DOWN', 'RELEASE') || Controls.getControl('LEFT', 'RELEASE')){
				if (Controls.getControl('UP', 'RELEASE')) 
           	     checkAnswer(0);
				if (Controls.getControl('RIGHT', 'RELEASE'))
					checkAnswer(1);
				if (Controls.getControl('DOWN', 'RELEASE'))
					checkAnswer(2);
				if (Controls.getControl('LEFT', 'RELEASE'))
					checkAnswer(3);
      	  }
		}
	}

    function checkAnswer(answer:Int):Void{
		controlAllowed = false;

        var answerIsTrue:Bool = false;

		for (i in 0...correctAnswers.length){
			if(answer == correctAnswers[i]) answerIsTrue = true;
		}

		var returnthis:String = '';

		if (answerIsTrue) returnthis = 'win'; else returnthis = 'lose';

		finishGameshow(answer, returnthis);
    }

	function finishGameshow(answer:Int, title:String):Void{
		new FlxTimer().start(4, function(tmr:FlxTimer)
		{
			finishCallback(title);
			close();
		});

		bombActive = false;

		bombTimer.cancel();
		bombTextTimer.cancel();

		FlxTween.tween(bombText, {alpha: 0}, .5, {ease: FlxEase.quartInOut, onComplete: function(FlxTwn):Void{
				if(shakeTween.active && shakeTween != null){
					shakeTween.cancel();
				}
				FlxTween.tween(bombSprite, {y: bombSprite.y + bombSprite.height * 1.5}, .5, {ease: FlxEase.backIn, onComplete: function(FlxTwn):Void{
						if (shakeTweenTwo.active && shakeTween != null)
						{
							shakeTweenTwo.cancel();
						}
				}});
		}});

		topSpriteGroup.forEach(function(spr:FlxSprite):Void {
			FlxTween.tween(spr, {y: spr.y - topSprite.height - 30}, .5, {ease: FlxEase.quartInOut});
		});

		boxSpriteGroup.forEach(function(spr:FlxSprite):Void{
			if(spr.ID != answer) FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.quartInOut, startDelay: .2});
			if(spr.ID == answer){
				FlxTween.tween(spr, {x: FlxG.width / 2 - spr.width / 2, y: FlxG.height / 2 - spr.height / 2}, 1, {ease: FlxEase.quartInOut, startDelay: .7});

				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					spr.destroy();
				});
			} 
		});

		textSpriteGroup.forEach(function(spr:FlxSprite):Void{
			if (spr.ID != answer) FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.quartInOut, startDelay: .2});
			if(spr.ID == answer){
				FlxTween.tween(spr, {x: FlxG.width / 2 - spr.width / 2, y: FlxG.height / 2 - spr.height / 2}, 1, {ease: FlxEase.quartInOut, startDelay: .7});
	
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					spr.destroy();
				});
			} 
		});

		new FlxTimer().start(3, function(tmr:FlxTimer){
			var weird:Bool = FlxG.random.bool(2);
			
			FlxTween.tween(fadeSprite, {alpha: 0}, .5, {ease: FlxEase.quartInOut});

			var suffix:String = '';

			if(weird) suffix = '_scary';

			var flashsprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bossspecific/gameshow/flasher_' + title + suffix, 'battle'));
			flashsprite.setGraphicSize(Std.int(flashsprite.width * .7));
			flashsprite.screenCenter();
			add(flashsprite);
			
			FlxTween.tween(flashsprite, {alpha: 0}, 1, {ease: FlxEase.quartInOut});

			if (!weird) FlxG.sound.play(Paths.sound('gameshow' + title, 'misc'), 1); else FlxG.sound.play(Paths.sound('gameshowweird', 'misc'), 1);
		});
	}
}