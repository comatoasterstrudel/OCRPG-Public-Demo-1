var newEnemyName:String = 'gameshow';

var readyToGo:Bool = false;
var turnCount:Int = -1;

var seenIntro:Bool = false;
var beenHurt:Bool = false;
var endingBattle:Bool = false;

var singleDataArray:Array<String>;
var realDataArray:Array<String>;

var questionInitialized:Bool = false;
var questionArray:Array<String> = [];
var questionSeen:Array<String> = [];

var playend:Bool = true;

function create()
{
	for (i in 0...characterArray.length)
	{
		if (characterArray[i].name == 'coma')
		{
			characterArray[i].animation.addByPrefix('smirk', 'smirk', 1);
			characterArray[i].idleName = 'smirk';
			characterArray[i].animation.play(characterArray[i].idleName);
		}
	}
}

function startAllyTurn()
{
	if (enemyCharacter.healthPercent <= 50 && !readyToGo){
		readyToGo = true;
	}

	if (readyToGo){
		turnCount++;

		if (turnCount % 2 == 0)
		{
			if (seenIntro)
			{
				bgmanager('add');

				dialogueManager('openDialogue', 'cmgs_opening', 'gameshow', function():Void
				{
					startGameshow();
				}, false);
			}
			else
			{
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.sound('recordScratch', 'misc'), 1);

				seenIntro = true;

				dialogueManager('openDialogue', 'cmgs_intro1', 'gameshow', function():Void
				{
					changeExternalVar('movesSelectable', 0, 0, false);
					
					initializeEnemyCharacter(newEnemyName, true);

					getEnemyCharacter().y -= 30;

					camHud.alpha = 0;
					
					camGame.zoom = 1.25;
					FlxTween.tween(camGame, {angle: 0, zoom: 1}, 2, {ease: FlxEase.cubeInOut});

					camTop.flash(0xFFFFFFFF, 2);
					
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						initializeMusic(Paths.music('bosstheme/' + Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 3), 'battle'), Std.parseFloat(Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 4)), 'fade', Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 3));
					});
				
					FlxG.sound.play(Paths.sound('honk', 'misc'), 1);

					Utilities.changeGameDetails('custom', 'In Game', "Coma's Gameshow! (Featuring " + Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ')');

					initializeEnemyHealthBar(getEnemyCharacter());

					new FlxTimer().start(4.5, function(tmr:FlxTimer)
					{
						FlxTween.tween(camHud, {alpha: 1}, 2, {ease: FlxEase.cubeInOut});

						bgmanager('add');

						dialogueManager('openDialogue', 'cmgs_intro2', 'gameshow', function():Void
						{
							startGameshow();
						}, false);
					});
				});
			}
		}
	}
}

function advanceTurnPre(){
	if (getEnemyCharacter().healthPercent < 100 && seenIntro && !beenHurt) {
		beenHurt = true;

		PlayState.battleOver = true;

		dialogueManager('openDialogue', 'cmgs_hurt', 'gameshow', function():Void
		{
			PlayState.battleOver = false;
			advanceTurnGame();
		});
	}
}

function startGameshow():Void{
	loadQuestion();

	changeExternalVar('movesSelectable', 0, 0, false);
	
	battleSpecific('gameshow', realDataArray, function(truefalse:String):Void{
		dialogueManager('openDialogue', 'cmgs_' + truefalse, 'gameshow', function():Void{
			bgmanager('remove');
			
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				if(truefalse == 'win'){
					changeStatAlly(characterArray[0], 1, true);
					changeStatAlly(characterArray[1], 1, false);

					changeStatEnemy(-2, true);
				} else if(truefalse == 'lose'){
					changeStatEnemy(1, true);

					changeStatAlly(characterArray[0], -1, true);
					changeStatAlly(characterArray[1], -1, false);
				}
			
				new FlxTimer().start(1.3, function(tmr:FlxTimer)
				{
					changeExternalVar('movesSelectable', 0, 0, true);
				});
			});
		}, false);
	}, function():Void{
		explode();
	});
}

function loadQuestion():Void{
	if (!questionInitialized){
		questionArray = Utilities.dataFromTextFile(Paths.txt('gameshowQuestions', 'battle'));
		questionInitialized = true;
	}

	singleDataArray = getQuestion();
	realDataArray = singleDataArray.split(":");
}

function getQuestion():String{
    var questionPicked:String;

	questionPicked = questionArray[FlxG.random.int(0, questionArray.length - 1)];

    var isRepeat:Bool = false;

	for (i in 0...questionSeen.length){
		if (questionPicked == questionSeen[i]) isRepeat = true;
    }

	if (questionSeen.length == questionArray.length){
		questionSeen = [];
		questionPicked = getQuestion();
    } else {
        if(isRepeat){
			questionPicked = getQuestion();
		} else {
			questionSeen.push(questionPicked);
		}
    }

	return questionPicked;
}

var bg:FlxSprite;
var rope:FlxSprite;

function bgmanager(type:String):Void{
	switch(type){
		case 'add':
			rope = new FlxSprite(0, FlxG.height).loadGraphic(Paths.image('bossspecific/gameshow/rope', 'battle'));
			rope.setGraphicSize(FlxG.width);
			rope.updateHitbox();
			rope.antialiasing = SaveData.settings.get('antiAliasing');
			add(rope);

			bg = new FlxSprite(0, FlxG.height + rope.height).loadGraphic(Paths.image('bossspecific/gameshow/bg', 'battle'));
			bg.setGraphicSize(FlxG.width, FlxG.height);
			bg.updateHitbox();
			bg.antialiasing = SaveData.settings.get('antiAliasing');
			add(bg);

			FlxTween.tween(rope, {y: -rope.height}, 2, {ease: FlxEase.cubeInOut});
			FlxTween.tween(bg, {y: 0}, 2, {ease: FlxEase.cubeInOut});
		case 'remove':
			FlxTween.tween(rope, {y: FlxG.height}, 1, {ease: FlxEase.cubeInOut, onComplete: function(FlxTwn):Void{
					rope.destroy();
			}});
			FlxTween.tween(bg, {y: FlxG.height + rope.height}, 1, {ease: FlxEase.cubeInOut, onComplete: function(FlxTwn):Void{
					bg.destroy();
			}});
	}
}

function winBattle()
{
	if (!endingBattle)
	{
		if (FlxG.random.bool(2)) FlxG.sound.play(Paths.sound('screamer/comaDies', 'battle'), 1);

		endingBattle = true;

		PlayState.battleReadyToEnd = false;

		if (!seenIntro){
			dialogueManager('openDialogue', 'cmgs_early', 'gameshow', function():Void
			{
				PlayState.battleReadyToEnd = true;
				doDeathCheck('forceWin');
			}, false);
		} else {
			FlxTween.tween(camHud, {alpha: 0}, .5, {ease: FlxEase.cubeInOut});

			FlxG.sound.play(Paths.sound('tablebreak', 'misc'), 1);
			FlxG.sound.music.volume = 0;

			camGame.shake(getEnemyCharacter().maxHealth / 7000, 3.5);

			initializeMusic(Paths.music('bosstheme/comadepression', 'battle'), 0, 'instant', 'comadepression');

			FlxG.sound.music.fadeIn(5.5, 0, .2);

			new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				dialogueManager('openDialogue', 'cmgs_battlewon', 'gameshow', function():Void
				{
					PlayState.battleReadyToEnd = true;
					doDeathCheck('forceWin');
				}, false);
			});
		}
	}
}

function loseBattle()
{
	if (!endingBattle && playend)
	{
		endingBattle = true;

		PlayState.battleReadyToEnd = false;

		var diatoplay:String = 'cmgs_battlelost';

		if(!seenIntro) diatoplay = 'cmgs_early';

		dialogueManager('openDialogue', diatoplay, 'gameshow', function():Void
		{
			PlayState.battleReadyToEnd = true;
			doDeathCheck('forceLose');
		});
	}
}

function explode():Void{
	playend = false;

	PlayState.battleOver = true;
	PlayState.battleReadyToEnd = false;

	camGame.visible = false;
	camHud.visible = false;

	if(bg != null) bg.visible = false;

	camTop.flash(0xFFFFFFFF, 8);

	FlxG.sound.play(Paths.sound('hugeexplosion', 'misc'), 1);

	FlxG.sound.music.volume = 0;

	var comasad:FlxSprite;
	comasad = new FlxSprite(0, 0).loadGraphic(Paths.image('bossspecific/gameshow/thecomasareweeping', 'battle'));
	comasad.setGraphicSize(Std.int(comasad.width * .6));
	comasad.updateHitbox();
	comasad.alpha = 0;
	comasad.setPosition(FlxG.width / 2 - comasad.width / 2, FlxG.height - comasad.height);
	comasad.antialiasing = SaveData.settings.get('antiAliasing');
	add(comasad);

	FlxTween.tween(comasad, {alpha: 1}, 4, {startDelay: 3, ease: FlxEase.cubeInOut});

	new FlxTimer().start(7.5, function(tmr:FlxTimer)
	{
		PlayState.battleReadyToEnd = true;
		doDeathCheck('forceLose');
	});
}