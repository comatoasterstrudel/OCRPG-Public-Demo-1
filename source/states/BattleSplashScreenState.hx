package states;

class BattleSplashScreenState extends OcrpgState //i am so fucking sorry
{
    var splashType:String;
	var imageNamePrefix:String = 'splashscreens/';
	var spritePrefix:String;
	var spriteAmount:Int;

    var stateToGo:FlxState;

	var timeToWait:Float;

    var fadeTime:Float;
    var timerTime:Float;

    var tranType:String;

	var spriteWidth:Float;
	var spriteHeight:Float;

	var spriteGroup:FlxTypedGroup<FlxSprite>;

	public function new(type:String, state:FlxState){
		super();

		stateToGo = state;
		splashType = type;
		spritePrefix = splashType + '/';
    }

	override function create()
	{
		var details:String = '';

		switch (splashType)
		{
			case 'intro':
				details = 'Battle Intro';

				spritePrefix = 'intro/';
				spriteAmount = 9;
				timeToWait = 7.5;

				fadeTime = 1;
				timerTime = 1.2;

				tranType = 'battle';

				if (Battle.checkCharacterValue('isBoss', Battle.enemyCharacterName))
				{
					FlxG.sound.playMusic(Paths.music('battleIntroBoss', 'battle'), .3, false);
				}
				else
				{
					FlxG.sound.playMusic(Paths.music('battleIntro', 'battle'), .3, false);
				}
			case 'win':
				details = 'Battle Won';

				spritePrefix = 'win/';
				spriteAmount = 9;
				timeToWait = 7;

				fadeTime = 1;
				timerTime = 1.2;

				tranType = 'fade';

				if (Battle.checkCharacterValue('isBoss', Battle.enemyCharacterName))
				{
					FlxG.sound.playMusic(Paths.music('battleWinBoss', 'battle'), .3, false);
				}
				else
				{
					FlxG.sound.playMusic(Paths.music('battleWin', 'battle'), .3, false);
				}
			case 'lose':
				details = 'Battle Lost';

				spritePrefix = 'lose/';
				spriteAmount = 9;
				timeToWait = 7;

				fadeTime = 1.8;
				timerTime = 2;

				tranType = 'fade';

				FlxG.sound.playMusic(Paths.music('battleLose', 'battle'), .8, false);
		}

		makeSprites();
		makeExclusives();
		
		switch(splashType){
			case 'lose':
				new FlxTimer().start(timeToWait, function(tmr:FlxTimer)
				{
					var tran:ScreenTransition = new ScreenTransition('fade', 'out', 2, function():Void{
						openSubState(new DecisionSubstate('Again?', ['Yes', 'No'], [
							function():Void
							{
								FlxG.switchState(new BattleSplashScreenState('intro', new PlayState()));
							},
							function():Void
							{
								FlxG.switchState(stateToGo);
							}
						]));
					});
					add(tran);
				});
			default:
				super.switchState(stateToGo, tranType, fadeTime, true, timeToWait);
		}

		super.init('none', 0, 'custom', 'In Battle', details);
    }

    inline function makeSprites(){        
        spriteGroup = new FlxTypedGroup<FlxSprite>();
		add(spriteGroup);
        
        for (i in 0...spriteAmount){ // v/defe, s/ated, char1, char2, char1text, and, char2text, enemy, enemytext
			var spriteNameArray:Array<String> = [];
			var spriteFlipArray:Array<Bool> = [];
			var spriteFadeArray:Array<Bool> = [];
			var spriteSizeArray:Array<Float> = [];

            switch(splashType){
                case 'intro':
					spriteNameArray = ['words/v', 'words/s', spritePrefix + 'ally_' + Battle.partyCharacters[0], spritePrefix + 'ally_' + Battle.partyCharacters[1], 'words/char_' + Battle.partyCharacters[0], 'words/and', 'words/char_' + Battle.partyCharacters[1], spritePrefix + 'enemy_' + Battle.enemyCharacterName, 'words/char_' + Battle.enemyCharacterName];
					spriteFlipArray = [false, false, false, true, false, false, false, false, false]; 
					spriteFadeArray = [false, false, false, true, false, false, false, true, true];
					spriteSizeArray = [.15, .15, .3, .3, .2, .175, .2, .3, .23];
                case 'win':
                    spriteNameArray = ['words/defe', 'words/ated', spritePrefix + 'ally_' + Battle.partyCharacters[0], spritePrefix + 'ally_' + Battle.partyCharacters[1], 'words/char_' + Battle.partyCharacters[0], 'words/and', 'words/char_' + Battle.partyCharacters[1], spritePrefix + 'enemy_' + Battle.enemyCharacterName, 'words/char_' + Battle.enemyCharacterName];
					spriteFlipArray = [false, false, false, true, false, false, false, false, false];
					spriteFadeArray = [false, false, false, true, false, false, false, true, true];
					spriteSizeArray = [.25, .25, .3, .3, .2, .175, .2, .3, .23];
                case 'lose':
                    spriteNameArray = ['words/defe', 'words/ated', spritePrefix + 'ally_' + Battle.partyCharacters[0], spritePrefix + 'ally_' + Battle.partyCharacters[1], 'words/char_' + Battle.partyCharacters[0], 'words/and', 'words/char_' + Battle.partyCharacters[1], spritePrefix + 'enemy_' + Battle.enemyCharacterName, 'words/char_' + Battle.enemyCharacterName];
			        spriteFlipArray = [false, false, false, true, false, false, false, false, false];
			        spriteFadeArray = [false, false, true, true, true, true, true, true, true];
			        spriteSizeArray = [.25, .25, .3, .3, .2, .175, .2, .3, .23];
            }

			var sprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image(imageNamePrefix + spriteNameArray[i], 'battle'));
			sprite.setGraphicSize(Std.int(sprite.width * spriteSizeArray[i]));
			sprite.updateHitbox();
			sprite.flipX = spriteFlipArray[i];
			if(spriteFadeArray[i]) sprite.alpha = 0;
			spriteGroup.add(sprite);

			spriteWidth = sprite.width;
			spriteHeight = sprite.height;

			var spritePositionHorizontalArray:Array<Float> = [];
			var spritePositionVerticalArray:Array<Float> = [];
			var spritePositionOffsetHorizontalArray:Array<Float> = [];
			var spritePositionOffsetVerticalArray:Array<Float> = [];
			var spriteHardOffsetHorizontalArray:Array<Float> = [];
			var spriteHardOffsetVerticalArray:Array<Float> = [];

			switch (splashType){
				case 'intro':
					spritePositionHorizontalArray = [FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, 0, FlxG.width - spriteWidth, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2];
					spritePositionVerticalArray = [FlxG.height / 2 - spriteHeight / 2 + 75, FlxG.height / 2 - spriteHeight / 2 + 100, FlxG.height - spriteHeight, FlxG.height - spriteHeight, FlxG.height - 200, FlxG.height - 200, FlxG.height - 200, -90, 120];
					spritePositionOffsetHorizontalArray = [-1000, 1000, 0, 0, 0, 0, 0, 0, 0];
					spritePositionOffsetVerticalArray = [0, 0, 400, 400, 400, 400, 400, -100, -150];
					spriteHardOffsetHorizontalArray = [0, 0, 0, 0, -200, 0, 200, 0, 0];
					spriteHardOffsetVerticalArray = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                case 'win':
                    spritePositionHorizontalArray = [FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, 0, FlxG.width - spriteWidth, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2];
                    spritePositionVerticalArray = [FlxG.height / 2 - spriteHeight / 2 + 75, FlxG.height / 2 - spriteHeight / 2 + 75, FlxG.height - spriteHeight, FlxG.height - spriteHeight, FlxG.height - 200, FlxG.height - 200, FlxG.height - 200, -90, 120];
					spritePositionOffsetHorizontalArray = [-1000, 1000, 0, 0, 0, 0, 0, 0, 0];
					spritePositionOffsetVerticalArray = [0, 0, 400, 400, 400, 400, 400, -100, -150];
					spriteHardOffsetHorizontalArray = [0, 0, 0, 0, -200, 0, 200, 0, 0];
					spriteHardOffsetVerticalArray = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                case 'lose':
                    spritePositionHorizontalArray = [FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, 0, FlxG.width - spriteWidth, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2, FlxG.width / 2 - spriteWidth / 2];
			        spritePositionVerticalArray = [FlxG.height / 2 - spriteHeight / 2 + 75, FlxG.height / 2 - spriteHeight / 2 + 75, FlxG.height - spriteHeight, FlxG.height - spriteHeight, FlxG.height - 200, FlxG.height - 200, FlxG.height - 200, -90, 120];
			        spritePositionOffsetHorizontalArray = [-1000, 1000, 0, 0, 0, 0, 0, 0, 0];
			        spritePositionOffsetVerticalArray = [0, 0, 400, 400, 400, 400, 400, -100, -150];
			        spriteHardOffsetHorizontalArray = [0, 0, 0, 0, -200, 0, 200, 0, 0];
			        spriteHardOffsetVerticalArray = [0, 0, 0, 0, 0, 0, 0, 0, 0];
            }

			sprite.x = spritePositionHorizontalArray[i];
			sprite.y = spritePositionVerticalArray[i];
			sprite.x += spriteHardOffsetHorizontalArray[i];
			sprite.y += spriteHardOffsetVerticalArray[i];

			var tweenTimeArray:Array<Float> = [];
			var tweenDelayArray:Array<Float> = [];

            switch (splashType){
				case 'intro':
					tweenTimeArray = [1.5, 1.5, .5, .7, .7, .5, .5, 2, 2];
					tweenDelayArray = [2.5, 2.5, 0, 1.6, 0, .7, 1.6, 4, 4];
                case 'win':
					tweenTimeArray = [1.5, 1.5, .5, .7, .7, .5, .5, 1, 1];
					tweenDelayArray = [2, 2, 0, 1.6, 0, .7, 1.6, 3.1, 3.1];
                case 'lose':
					tweenTimeArray = [1.5, 1.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2, 2];
					tweenDelayArray = [1, 1, 2.3, 2.3, 2.3, 2.3, 2.3, 0, 0];
            }

			var tweenAmountHorizontal:Float = sprite.x;
			var tweenAmountVertical:Float = sprite.y;

			sprite.x += spritePositionOffsetHorizontalArray[i] * 2;
			sprite.y += spritePositionOffsetVerticalArray[i] * 2;

			if (spritePositionOffsetHorizontalArray[i] != 0) sprite.x -= spritePositionOffsetHorizontalArray[i];
			if (spritePositionOffsetVerticalArray[i] != 0) sprite.y -= spritePositionOffsetVerticalArray[i];

			FlxTween.tween(sprite, {x: tweenAmountHorizontal, y: tweenAmountVertical, alpha: 1}, tweenTimeArray[i], {ease: FlxEase.quartInOut, startDelay: tweenDelayArray[i]});
		} 
    }

    inline function makeExclusives(){
        if(splashType == 'win'){
			new FlxTimer().start(3.7, function(tmr:FlxTimer){
				var redX:FlxSprite = new FlxSprite().loadGraphic(Paths.image(imageNamePrefix + spritePrefix + 'bigRedX', 'battle'));
				redX.screenCenter(X);
                redX.y = -550;
				redX.updateHitbox();
				redX.alpha = 0;
				add(redX);

				FlxTween.tween(redX, {alpha: 1.5}, 1, {ease: FlxEase.quartInOut});
				FlxTween.tween(redX.scale, {x: .3, y: .3}, 1.5, {ease: FlxEase.quartInOut});
			});
        }
    }
}
