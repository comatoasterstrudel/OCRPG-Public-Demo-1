var newEnemyName:String = 'innerpuppet';
var ogEnemyName:String = 'inner';

var turnTimer:Int = -1;
var turnsToWait = 4;

var secondPhase:Bool = false;

var transitioning:Bool = false;

var seenJumpscare:Bool = false;

function create(){
	initializeEnemyCharacter(newEnemyName, false);

	initializeEnemyHealthBar(getEnemyCharacter());

	changeStatEnemy(10, false, false);

	for (i in 0...characterArray.length){
		if(characterArray[i].name == 'outer'){
			characterArray[i].animation.addByPrefix('scared', 'scared', 1);
			characterArray[i].idleName = 'scared';
			characterArray[i].animation.play(characterArray[i].idleName);
		}
	}
}

function createPost(){
	Utilities.changeGameDetails('custom', 'In Game', Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ' VS ' + Battle.getVanityName(Battle.enemyCharacterName, 'enemy') + '...?');
}


function update(elapsed:Float){
	if (transitioning) changeExternalVar('movesSelectable', 0, 0, false);

	if (!secondPhase){
		changeExternalVar('enemyStunned', 0, 0, true);
	}
}

function battleStart(){
	initializeMusic(Paths.music('bosstheme/' + Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 3), 'battle'), Std.parseFloat(Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 4)), 'fade', Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 3));
}

function startAllyTurn(){
    turnTimer ++;

    if(turnTimer >= turnsToWait && !secondPhase){
        startSecondPhase();
    }
}

function startSecondPhase():Void{
    transitioning = true;
    secondPhase = true;

	FlxG.sound.music.fadeOut(5, 0);
	FlxTween.tween(camHud, {alpha: 0}, 5, {ease: FlxEase.cubeInOut});

	new FlxTimer().start(8, function(tmr:FlxTimer)
	{
        camGame.alpha = 0;
		camGame.zoom = 2;

		var flashsprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bossspecific/inner/innerScare', 'battle'));
		flashsprite.setGraphicSize(Std.int(flashsprite.width * .45));
		flashsprite.screenCenter();
		add(flashsprite);

		var shaketween = FlxTween.shake(flashsprite, 0.025, .8);

		FlxG.sound.play(Paths.sound('innerScareShort', 'misc'), 1);

		new FlxTimer().start(.8, function(tmr:FlxTimer)
		{
			flashsprite.destroy();

			new FlxTimer().start(2.5, function(tmr:FlxTimer)
			{
				makeBar();

				initializeEnemyCharacter(ogEnemyName, true);

				initializeEnemyHealthBar(getEnemyCharacter());

				initializeMusic(Paths.music('bosstheme/' + Utilities.grabThingFromText(ogEnemyName, Paths.txt('battleData', 'battle'), 3), 'battle'), Std.parseFloat(Utilities.grabThingFromText(newEnemyName, Paths.txt('battleData', 'battle'), 4)), 'fade', Utilities.grabThingFromText(ogEnemyName, Paths.txt('battleData', 'battle'), 3));

				FlxTween.tween(camGame, {alpha: 1, zoom: 1}, 6.25, {startDelay: 2});

				new FlxTimer().start(8.25, function(tmr:FlxTimer)
				{
					Utilities.changeGameDetails('custom', 'In Game', Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ' VS ' + Battle.getVanityName(Battle.enemyCharacterName, 'enemy'));

					camTop.flash(0xFFFFFFFF, 2);

					camHud.alpha = 1;
                    
					transitioning = false;

					changeExternalVar('movesSelectable', 0, 0, true);
				});
            });
        });
    });
}

function loseBattle(){
	if(!seenJumpscare){
		seenJumpscare = true;

		PlayState.battleReadyToEnd = false;

		FlxG.sound.music.fadeOut(6, 0);

		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			var tran:ScreenTransition = new ScreenTransition('fade', 'out', 3);
			add(tran);

			jumpscare();
		});
	}
}

function jumpscare(){
	seenJumpscare = true;

	new FlxTimer().start(4, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('innerScareLong', 'misc'), 1);

		var jumpscare = new FlxSprite();
		jumpscare.frames = Paths.getSparrowAtlas('bossspecific/inner/innerJumpscare', 'battle');
		jumpscare.animation.addByPrefix('normal', 'idle', 24, false);
		jumpscare.animation.play('normal');
		jumpscare.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		jumpscare.updateHitbox();
		jumpscare.antialiasing = SaveData.settings.get('antiAliasing');
		jumpscare.screenCenter();
		jumpscare.cameras = [camTop];
		add(jumpscare);

		new FlxTimer().start(6, function(tmr:FlxTimer)
		{
			PlayState.battleReadyToEnd = true;
			PlayState.forceEnd = 'lose';
		});
	});
}

var bar:InnerBar;

function makeBar():Void{
	bar = new InnerBar(characterArray, endBattleFromBar);
	bar.camera = camHud;
	preHudGroup.add(bar);
}

function endBattleFromBar(){
	PlayState.battleReadyToEnd = false;
	changeExternalVar('movesSelectable', 0, 0, false);
	PlayState.battleOver = true;

	new FlxTimer().start(2, function(tmr:FlxTimer)
	{
		FlxG.sound.music.fadeOut(0.001, 0);

		camGame.visible = false;
		camHud.visible = false;

		var staticsprite = new FlxSprite();
		staticsprite.frames = Paths.getSparrowAtlas('bossspecific/inner/static', 'battle');
		staticsprite.animation.addByPrefix('normal', 'static idle', 24, true);
		staticsprite.animation.play('normal');
		staticsprite.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		staticsprite.updateHitbox();
		staticsprite.screenCenter();
		staticsprite.cameras = [camTop];
		add(staticsprite);

		FlxG.sound.play(Paths.sound('static', 'misc'), 2);

		new FlxTimer().start(.24, function(tmr:FlxTimer)
		{
			staticsprite.destroy();
		});

		jumpscare();
	});
}