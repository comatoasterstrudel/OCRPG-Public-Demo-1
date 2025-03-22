package states.game;

class PlayState extends OcrpgState
{
	//stuff needed for hscipt
	public var vars:Map<String, Dynamic> = [];
	public static var current:PlayState = new PlayState();

	// cameras
	var camGame:FlxCamera;
	var camHud:FlxCamera;
	var camTop:FlxCamera;

	//background
	var background:BattleBackground;

	//enemy
	var enemyCharacter:Enemy;

	// pre hud group
	var preHudGroup:FlxTypedGroup<FlxSprite>;

	// hud
	var hud:Hud;

	//duo attack
	public static var motivation:Int = 0;
	public static var duoAttackReady:Bool = false;

	//ally array
	var characterArray:Array<Ally>;
	
	//turn stuff
	var enemyTurn:Bool = false;
	public static var allyTurn:Int = 0;
	public static var allyTurnOpposite:Int = 1;

	//ending battle
	public static var battleOver:Bool = false;
	public static var battleReadyToEnd:Bool;
	public static var forceEnd:String = '';

	//globalscript
	var globalScript:HaxeScript;
	var globalScriptActive:Bool;

	//song card
	var songCard:SongCard;

	//debug
	#if debug
	var debugtext:DebugText;
	#end

	// ally exclusive vars
	public static var comaPurpleAuraActive:Bool = false;
	public static var comaPurpleAuraMult:Float = 1.5;

	// enemy exclusive vars
	public static var bossComaPurpleAuraActive:Bool = false;

	override public function create()
	{
		resetExternalVars();

		camGame = new FlxCamera();
		camHud = new FlxCamera();
		camTop = new FlxCamera();

		camGame.bgColor = FlxColor.BLACK;
		camHud.bgColor.alpha = 0;
		camTop.bgColor.alpha = 0;

		FlxG.cameras.add(camGame);
		FlxG.cameras.add(camHud);
		FlxG.cameras.add(camTop);

		initializeBackgroundSprite(Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 2));

		initializeEnemyCharacter(Battle.enemyCharacterName, false);

		preHudGroup = new FlxTypedGroup<FlxSprite>();
		preHudGroup.camera = camHud;
		add(preHudGroup);

		initializeHud();

		initializeGlobalScript();

		#if debug
		debugtext = new DebugText();
		debugtext.cameras = [camTop];
		add(debugtext);
		#end

		startBattle();

		super.init('battle', 1, 'custom', 'In Game', Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ' VS ' + Battle.getVanityName(Battle.enemyCharacterName, 'enemy'));

		if(globalScriptActive) globalScript.executeFunc("createPost");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		damageNumManager('check');

		if (!DialogueSubstate.dialogueActive && hud.moveText.movesSelectable){
			if (Controls.getControl('PAUSE', 'RELEASE'))
			{
				startPause();
			}
		}

		updateHealthBars(elapsed);

		checkForceEnds();

		if(globalScriptActive) globalScript.executeFunc('update', [elapsed]);

		#if debug
		debugtext.updateText(15, [
			'- General -\n',
			'Enemy Character: ' + enemyCharacter.name,
			'Left Character: ' + characterArray[0].name,
			'Right Character: ' + characterArray[1].name,
			'Enemy HP: ' + enemyCharacter.hp,
			'Left Character HP: ' + characterArray[0].hp,
			'Right Character HP: ' + characterArray[1].hp,
			'Enemy HP Percent: ' + enemyCharacter.hppercent,
			'Left Character HP Percent: ' + characterArray[0].hppercent,
			'Right Character HP Percent: ' + characterArray[1].hppercent,
			'Enemy Character Defense: ' + enemyCharacter.defense + ' (' + enemyCharacter.realDefense + ')',
			'Left Character Defense: ' + characterArray[0].defense + ' (' + characterArray[0].realDefense + ')',
			'Right Character Defense: ' + characterArray[1].defense + ' (' + characterArray[1].realDefense + ')',
			'Left Character Stunned: ' + characterArray[0].isStunned,
			'Right Character Stunned: ' + characterArray[1].isStunned,
			'\n- Ally Move Specific -\n',
			'Purple Aura: ' + comaPurpleAuraActive,
			'Purple Aura Mult: ' + comaPurpleAuraMult,
			'Left Character Briefcase: ' + characterArray[0].briefcaseActive,
			'Right Character Briefcase: ' + characterArray[1].briefcaseActive,
			'Left Character Basilisk Venom: ' + characterArray[0].venomAmount,
			'Right Character Basilisk Venom: ' + characterArray[1].venomAmount,
		]);
		#end
	}

	inline function startBattle():Void{
		if (Battle.checkCharacterValue('useIntroDialogue', Battle.enemyCharacterName)){
			new FlxTimer().start(1, function(tmr:FlxTimer){
				initializeMusic(Paths.music('diaIntro', 'dialogue'), 2, 'fade');

				dialogueManager('openDialogue', Battle.getIntroDialogueName(0, 0), Battle.getIntroDialogueName(0, 1), function():Void
				{
					dialogueManager('openDialogue', Battle.getIntroDialogueName(1, 0), Battle.getIntroDialogueName(1, 1), function():Void
					{
						FlxG.sound.music.fadeOut(.5, 0);

						new FlxTimer().start(.7, function(tmr:FlxTimer)
						{
							initializeMusic(Paths.music('bosstheme/' + Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 3), 'battle'), Std.parseFloat(Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 4)), 'fade', Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 3));

							if (globalScriptActive) globalScript.executeFunc('battleStart');

							new FlxTimer().start(.7, function(tmr:FlxTimer)
							{
								hud.bottomBarManager('up');
								if (globalScriptActive) globalScript.executeFunc('startAllyTurn');
							});
						});
					}, false);
				}, false);
			});
		} else {
			initializeMusic(Paths.music('bosstheme/' + Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 3), 'battle'), Std.parseFloat(Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 4)), 'fade', Utilities.grabThingFromText(Battle.enemyCharacterName, Paths.txt('battleData', 'battle'), 3));

			if (globalScriptActive)
				globalScript.executeFunc('battleStart');

			new FlxTimer().start(.7, function(tmr:FlxTimer)
			{
				hud.bottomBarManager('up');
				if (globalScriptActive) globalScript.executeFunc('startAllyTurn');
			});
		}
	}

	function allyAttack(attackName:String):Void
	{
		hud.bottomBarManager('down');
		hud.moveText.removeMoveText();

		persistentUpdate = true;

		var useQte:Bool = false;

		if (Utilities.grabThingFromText(attackName, Paths.txt('moveInfo', 'battle'), 2) == 'use') useQte = true;

		openSubState(new QuickTimeEventSubstate(characterArray[allyTurn].name, useQte, function(effectiveness:Float):Void{
			if (allyTurn == 0)
				makeBanner(characterArray[allyTurn].name, 'left', 0);
			else
				makeBanner(characterArray[allyTurn].name, 'right', 0);

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				doDeathCheck();
				if (!battleOver)
				{
					if (globalScriptActive)
						globalScript.executeFunc('allyAttack', [attackName]);

					new FlxTimer().start(doAttack('ally', attackName, 0, characterArray[allyTurn], effectiveness), function(tmr:FlxTimer)
					{
						doDeathCheck();
						if (!battleOver)
							advanceTurn();
					});
				}
			});
		}));
	}

	function enemyAttack(attackName:String, targetNum:Int, target:Ally):Void{
		doDeathCheck();
	
		if (globalScriptActive) globalScript.executeFunc('enemyAttackPre');

		if(!battleOver){	
			if (globalScriptActive) globalScript.executeFunc('enemyAttack');

			new FlxTimer().start(doAttack('enemy', attackName, targetNum, target), function(tmr:FlxTimer){
				doDeathCheck();
				if (!battleOver)
					advanceTurn();
			});
		}
	}
	
	function duoAttack(type:Int):Void{
		if (type == 0){
			hud.bottomBarManager('down');
			makeBanner(Battle.getDuoName(), 'duo', 0);
			motivation = 0;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				var attackNumber:Int = 0;
				var attackName:String = '';

				switch (allyTurn)
				{
					case 0:
						attackName = characterArray[type].name;
						attackNumber = type;
					case 1:
						attackName = characterArray[Utilities.invertNum(type)].name;
						attackNumber = Utilities.invertNum(type);
				}

				if (globalScriptActive) globalScript.executeFunc('duoAttack', [attackName]);

				new FlxTimer().start(doAttack('duo', attackName, type, null, attackNumber), function(tmr:FlxTimer)
				{
					if (type == 0)
					{
						duoAttack(1);
					}
					else if (type == 1)
					{
						advanceTurn();
					}
				});
			});
		} else {
			var attackNumber:Int = 0;
			var attackName:String = '';
		
			switch(allyTurn){
				case 0:
					attackName = characterArray[type].name;
					attackNumber = type;
				case 1:
					attackName = characterArray[Utilities.invertNum(type)].name;
					attackNumber = Utilities.invertNum(type);
			}

			if (globalScriptActive) globalScript.executeFunc('duoAttack', [attackName]);

			new FlxTimer().start(doAttack('duo', attackName, type, null, attackNumber), function(tmr:FlxTimer){
				if (type == 0){
					duoAttack(1);
				} else if (type == 1) {
					advanceTurn();
				}
			});
		}
	}

	function doAttack(type:String, attackName:String, ?extraNum:Int, ?target:Ally, ?extraNumTwo:Float):Float{ //this function returns a float so you can get the time as well btw
		var attackScript:HaxeScript;

		if (FileSystem.exists(Paths.script('attacks/' + type + '_' + attackName.toLowerCase(), 'battle'))){
			attackScript = HaxeScript.create(Paths.script('attacks/' + type + '_' + attackName.toLowerCase(), 'battle'));
			attackScript.loadFile(Paths.script('attacks/' + type + '_' + attackName.toLowerCase(), 'battle'));
		} else {
			attackScript = HaxeScript.create(Paths.script('attacks/' + type + '_basic attack', 'battle'));
			attackScript.loadFile(Paths.script('attacks/' + type + '_basic attack', 'battle'));
		}

		ScriptSupport.setScriptDefaultVars(attackScript, '', '');

		attackScript.setVariable("camGame", camGame);
		attackScript.setVariable("camHud", camHud);
		attackScript.setVariable("camTop", camHud);

		attackScript.setVariable("allyTurn", allyTurn);
		attackScript.setVariable("allyTurnOpposite", allyTurnOpposite);

		attackScript.setVariable("enemyCharacter", enemyCharacter);
		attackScript.setVariable("partyMember1", hud.partyMember1);
		attackScript.setVariable("partyMember2", hud.partyMember2);
		attackScript.setVariable("characterArray", characterArray);

		attackScript.setVariable("changePriorityStatus", changePriorityStatus);
		attackScript.setVariable("changeStatAlly", changeStatAlly);
		attackScript.setVariable("changeStatEnemy", changeStatEnemy);

		attackScript.setVariable('changeExternalVar', changeExternalVar);

		attackScript.setVariable("getTargetNum", getTargetNum);

		attackScript.setVariable("damageNumManager", damageNumManager);

		if (extraNum != null) attackScript.setVariable("targetNum", extraNum);
		if (target != null) attackScript.setVariable("target", target);

		if (extraNum != null) attackScript.setVariable("duoType", extraNum);

		if (extraNumTwo != null) attackScript.setVariable("effectiveness", extraNumTwo);
		if (extraNumTwo != null) attackScript.setVariable("duoAttackNumber", extraNumTwo);

		attackScript.executeFunc("create");

		var time:Float = attackScript.executeFunc("getTime", []);

		new FlxTimer().start(time, function(tmr:FlxTimer)
		{
			attackScript.destroy();
		});

		return time;
	}

	function getTargetNum():Int{
		var turnToSend:Int = FlxG.random.int(0, 1);
		
		for(i in 0...characterArray.length){
			if (characterArray[i].isDead && !characterArray[Utilities.invertNum(i)].isDead && i == turnToSend) turnToSend = Utilities.invertNum(turnToSend);
		}
		for (i in 0...characterArray.length){
			if (characterArray[i].hasPriority && !characterArray[i].isDead) turnToSend = i;
		}
		
		return turnToSend;
	}
	
	function getEnemyAttack(target:Ally):String{
		var aiScript:HaxeScript;

		if (FileSystem.exists(Paths.script('ai/' + enemyCharacter.name.toLowerCase(), 'battle')))
		{
			aiScript = HaxeScript.create(Paths.script('ai/' + enemyCharacter.name.toLowerCase(), 'battle'));
			aiScript.loadFile(Paths.script('ai/' + enemyCharacter.name.toLowerCase(), 'battle'));
		}
		else
		{
			aiScript = HaxeScript.create(Paths.script('ai/random', 'battle'));
			aiScript.loadFile(Paths.script('ai/random', 'battle'));
		}

		ScriptSupport.setScriptDefaultVars(aiScript, '', '');

		aiScript.setVariable("allyTurn", allyTurn);
		aiScript.setVariable("allyTurnOpposite", allyTurnOpposite);

		aiScript.setVariable("target", target);

		aiScript.setVariable("enemyCharacter", enemyCharacter);
		aiScript.setVariable("partyMember1", hud.partyMember1);
		aiScript.setVariable("partyMember2", hud.partyMember2);
		aiScript.setVariable("characterArray", characterArray);

		return(aiScript.executeFunc('getChoice'));

		aiScript.destroy();
	}

	function advanceTurn():Void
	{
		if (globalScriptActive) globalScript.executeFunc('advanceTurnPre');

		doDeathCheck();
		if(!battleOver){
			if (globalScriptActive) globalScript.executeFunc('advanceTurn');

			enemyTurn = !enemyTurn;

			if (enemyTurn){ // do enemy turn
				if(enemyCharacter.isStunned){
					enemyCharacter.isStunned = false;
					advanceTurn();
				} else {
					makeBanner(enemyCharacter.name, 'top', 0);
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						var targetNum = getTargetNum();
						var target:Ally = characterArray[targetNum];

						enemyAttack(getEnemyAttack(target), targetNum, target);
					});	
				}
			}
			else{ // do player turn
				if (characterArray[allyTurn].trainedFocus > 0) characterArray[allyTurn].trainedFocus--;

				allyTurn = Utilities.invertNum(allyTurn);
				allyTurnOpposite = Utilities.invertNum(allyTurn);
				
				var timeToWait:Float = 0;

				if(characterArray[allyTurn].isDead){
					characterArray[allyTurn].deathTicker();
					timeToWait += 2;
				}

				new FlxTimer().start(timeToWait, function(tmr:FlxTimer)
				{
					if (characterArray[0].isStunned && characterArray[1].isStunned){ // both characters stunned skip turn
						if (!characterArray[0].isDead)
							characterArray[0].isStunned = false;
						if (!characterArray[1].isDead)
							characterArray[1].isStunned = false;
						advanceTurn();
					} else if (characterArray[allyTurn].isStunned && !characterArray[allyTurn].isDead){ //1 character stunned (not dead)
						characterArray[allyTurn].isStunned = false;
						advanceTurn();
					} else if (characterArray[allyTurn].isDead) { // one character is dead so erm do whatevrer fuck
						if (!characterArray[allyTurn].isDead)
							characterArray[allyTurn].isStunned = false;
						if (allyTurn == 1){
							allyTurn = 0;
							allyTurnOpposite = 1;
						} else {
							allyTurn = 1;
							allyTurnOpposite = 0;
						}
						hud.bottomBarManager('up');
						if (globalScriptActive) globalScript.executeFunc('startAllyTurn');
					}
					else { // proceed as normal
						hud.bottomBarManager('up');
						if (globalScriptActive) globalScript.executeFunc('startAllyTurn');
					}
				});
			}
		}
	}

	function makeBanner(name:String, side:String, delay:Float):Void
	{
		if(side == 'duo'){
			var banner:DuoBanner = new DuoBanner(name, delay);
			banner.cameras = [camHud];
			add(banner);
		} else {
			var banner:Banner = new Banner(name, side, delay);
			banner.cameras = [camHud];
			add(banner);
		}
	}

	function makeSongCard(name:String):Void
	{
		if (songCard != null) songCard.close();

		songCard = new SongCard(name);
		songCard.cameras = [camTop];
		add(songCard);
	}

	function damageNumManager(type:String, ?sprite:FlxSprite, ?text:String, ?thecolor:FlxColor):Void
	{
		switch (type)
		{
			case 'check':
				if (enemyCharacter.attackActive)
				{
					damageNumManager('add', enemyCharacter, enemyCharacter.textToUse, enemyCharacter.textColor);
					enemyCharacter.attackActive = false;
				}
				for (i in 0...characterArray.length)
				{
					if (characterArray[i].attackActive)
					{
						damageNumManager('add', characterArray[i], characterArray[i].textToUse, characterArray[i].textColor);
						characterArray[i].attackActive = false;
					}
				}
			case 'add':
				var spr:DamageText = new DamageText(text, sprite.x, sprite.y, sprite.width, sprite.height);
				spr.color = thecolor;
				spr.cameras = [camHud];
				add(spr);
		}
	}

	function checkForceEnds():Void{
		switch(forceEnd){
			case 'win':
				if(globalScriptActive){
					globalScriptActive = false;
					globalScript.destroy();
				}

				forceEnd = '';
				doDeathCheck('forceWin', 0, false);
			case 'lose':
				if (globalScriptActive){
					globalScriptActive = false;
					globalScript.destroy();
				}

				forceEnd = '';
				doDeathCheck('forceLose', 0, false);
		}
	}

	function doDeathCheck(?type:String, ?time:Float = 3, ?doTran:Bool = true):Void{
		if (enemyCharacter.isDead && !battleOver || type == 'forceWin'){ //YOU WIN
			if (globalScriptActive) globalScript.executeFunc('winBattle');

			battleOver = true;

			if(battleReadyToEnd){
				FlxG.sound.music.fadeOut(6, 0);

				FlxG.sound.play(Paths.sound('death', 'battle'), 1);
				enemyCharacter.animation.play('dead');
				camGame.shake(enemyCharacter.maxhp / 5000, .2);

				background.animation.play('dead');

				Battle.saveBossAllyCompletion();
				
				new FlxTimer().start(time, function(tmr:FlxTimer)
				{
					endBattle(new BattleSplashScreenState('win', Battle.callbackArray[0]), doTran);
				});
			}
		}
		else if (characterArray[0].isDead && characterArray[1].isDead && !battleOver || type == 'forceLose') // YOU LOSE
		{
			if (globalScriptActive) globalScript.executeFunc('loseBattle');

			battleOver = true;

			if (battleReadyToEnd)
			{

				FlxG.sound.music.fadeOut(6, 0);

				new FlxTimer().start(time, function(tmr:FlxTimer)
				{
					endBattle(new BattleSplashScreenState('lose', Battle.callbackArray[1]), doTran);
				});
			}
		}
	}

	function endBattle(state:FlxState, ?doTran:Bool = true):Void{
		if (globalScriptActive){
			globalScriptActive = false;
			globalScript.destroy();
		}

		if(doTran){
			super.switchState(state, 'fade', 4, false);
		} else {
			super.switchState(state, '', 0, false);
		}
	}

	function changePriorityStatus(targetNumber:Int):Void{
		for(i in 0...characterArray.length){
			characterArray[i].hasPriority = false;

			if(i == targetNumber) characterArray[i].hasPriority = true;
		}
	}

	function changeStatEnemy(amount:Int, ?sound:Bool = true, ?anim:Bool = true):Void{
		var pos:Bool = false;

		if(amount > 0){
			pos = true;

			if(sound) FlxG.sound.play(Paths.sound('statUp', 'battle'), .4);
		} else if(amount < 0){
			pos = false;

			if (sound) FlxG.sound.play(Paths.sound('statDown', 'battle'), .4);
		}

		var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'defense', 20, camGame, false, allyTurn, .45, false, false);
		if(anim) add(attackanim);

		if(pos){
			attackanim.color = 0x6EFF7A;
			attackanim.flipY = true;
		} else {
			attackanim.color = 0xFD6A6A;
			attackanim.flipY = false;
		}
		if (enemyCharacter.changeDefense(amount)){
			attackanim.color = 0xA9A9A9;
		}

		FlxTween.tween(attackanim, {alpha: 0}, .3, {ease: FlxEase.cubeInOut, startDelay: 1, onComplete: function(FlxTwn){
			attackanim.destroy();
		}});
	}
	
	function changeStatAlly(char:Ally, amount:Int, ?sound:Bool = true):Void{
		if(!char.isDead){
			var pos:Bool = false;

			if(amount > 0){
				pos = true;

				if(sound) FlxG.sound.play(Paths.sound('statUp', 'battle'), .4);
			} else if(amount < 0){
				pos = false;

				if (sound) FlxG.sound.play(Paths.sound('statDown', 'battle'), .4);
			}

			var attackanim:AttackAnimation = new AttackAnimation(char, 'defense', 20, camHud, false, allyTurn, .35, false, false);
			add(attackanim);

			if(pos){
				attackanim.color = 0x6EFF7A;
				attackanim.flipY = true;
			} else {
				attackanim.color = 0xFD6A6A;
				attackanim.flipY = false;
			}
			if(char.changeDefense(amount)){
				attackanim.color = 0xA9A9A9;
			}
		
			FlxTween.tween(attackanim, {alpha: 0}, .3, {ease: FlxEase.cubeInOut, startDelay: 1, onComplete: function(FlxTwn){
				attackanim.destroy();
			}});
		}

	}	

	function updateHealthBars(elapsed:Float):Void{
		hud.enemyHealthBar.updateText(elapsed);
		hud.allyHpBars.updateText(elapsed);

		if(motivation > hud.maxMotivation) motivation = hud.maxMotivation;
		if(motivation < 0) motivation = 0;

		if (motivation >= hud.maxMotivation && !characterArray[0].isDead && !characterArray[1].isDead) 
			duoAttackReady = true;
		else 
			duoAttackReady = false;
		
		hud.motivationLerp = FlxMath.lerp(motivation, hud.motivationLerp, Utilities.boundTo(1 - (elapsed * 15), 0, 1));	
	}

	function getEnemyCharacter():Enemy{
		return enemyCharacter;
	}

	function dialogueManager(type:String, ?thing2:String, ?thing3:String, ?thing4:Void->Void, ?thing5:Bool = true):Void{
		switch(type){
			case 'openDialogue':
				persistentUpdate = true;

				openSubState(new DialogueSubstate(thing2, thing3, function():Void{
					if (thing4 != null) thing4();
				}, thing5));

		}
	}

	function startPause():Void{
		persistentUpdate = false;

		openSubState(new PauseSubstate(['resume', 'restart battle', 'quit to menu']));
	}

	function battleSpecific(name:String, ?stringArray:Array<String>, ?stringFuncton:String->Void, ?coolFunction:Void -> Void):Void{
		switch(name){
			case 'gameshow':
				openSubState(new GameshowSubstate(stringArray, stringFuncton, coolFunction));
		}
	}

	inline function initializeMusic(name:String, volume:Float, type:String, ?displayname:String):Void{
		if(displayname != null){
			makeSongCard(displayname);
		}

		FlxG.sound.playMusic(name, 0);

		switch(type){
			case 'fade':
				FlxG.sound.music.fadeIn(2.5, 0, volume);
			case 'instant':
				FlxG.sound.music.volume = volume;
		}
	}

	inline function initializeBackgroundSprite(name:String):Void{
		if (background != null){
			background.destroy();
		}

		background = new BattleBackground(name);
		background.cameras = [camGame];
		add(background);
	}

	inline function initializeEnemyCharacter(name:String, persistStats:Bool):Void{
		var statArray:Array<Int> = []; //defense, attack

		if(enemyCharacter != null){
			statArray[0] = enemyCharacter.defense;

			enemyCharacter.destroy();
			Paths.clearUnusedMemory();
		}

		enemyCharacter = new Enemy(name);
		enemyCharacter.cameras = [camGame];
		add(enemyCharacter);

		if (persistStats) {
			enemyCharacter.defense = statArray[0];

			enemyCharacter.changeDefense(0);
		}
	}

	inline function initializeHud():Void{
		if (hud != null){
			hud.destroy();
			Paths.clearUnusedMemory();
		}

		hud = new Hud();
		hud.cameras = [camHud];
		hud.initializeGroups();
		hud.initializeFadeSprite(preHudGroup);
		hud.initializeBottomSprites();
		hud.initializeMoveText(allyAttack, duoAttack);
		hud.initializeEnemyHealthBar(enemyCharacter);
		add(hud);

		characterArray = hud.characterArray;
	}

	inline function initializeGlobalScript():Void{
		if (FileSystem.exists(Paths.script('enemyscripts/' + Battle.enemyCharacterName, 'battle')))
		{
			globalScriptActive = true;
			trace('Enemy HScript found at ' + 'enemyscripts/' + Battle.enemyCharacterName);
		}
		else
		{
			globalScriptActive = false;
			trace('Enemy HScript not found.');
		}

		if (globalScriptActive){
			globalScript = HaxeScript.create(Paths.script('enemyscripts/' + enemyCharacter.name, 'battle'));
			globalScript.loadFile(Paths.script('enemyscripts/' + enemyCharacter.name, 'battle'));

			ScriptSupport.setScriptDefaultVars(globalScript, '', '');

			globalScript.setVariable("background", background);

			globalScript.setVariable("hud", hud);

			globalScript.setVariable("camGame", camGame);
			globalScript.setVariable("camHud", camHud);
			globalScript.setVariable("camTop", camTop);

			globalScript.setVariable("allyTurn", allyTurn);
			globalScript.setVariable("allyTurnOpposite", allyTurnOpposite);

			globalScript.setVariable("changePriorityStatus", changePriorityStatus);
			globalScript.setVariable("changeStatAlly", changeStatAlly);
			globalScript.setVariable("changeStatEnemy", changeStatEnemy);

			globalScript.setVariable("enemyCharacter", enemyCharacter);
			globalScript.setVariable("partyMember1", hud.partyMember1);
			globalScript.setVariable("partyMember2", hud.partyMember2);
			globalScript.setVariable("characterArray", characterArray);

			globalScript.setVariable("getEnemyCharacter", getEnemyCharacter);

			globalScript.setVariable("battleSpecific", battleSpecific);

			globalScript.setVariable("dialogueManager", dialogueManager);
			globalScript.setVariable("doDeathCheck", doDeathCheck);
			globalScript.setVariable("endBattle", endBattle);
			globalScript.setVariable("advanceTurnGame", advanceTurn);

			globalScript.setVariable('changeExternalVar', changeExternalVar);

			globalScript.setVariable('preHudGroup', preHudGroup);
			
			globalScript.setVariable("initializeEnemyHealthBar", hud.initializeEnemyHealthBar);
			globalScript.setVariable("initializeBackgroundSprite", initializeBackgroundSprite);
			globalScript.setVariable("initializeEnemyCharacter", initializeEnemyCharacter);
			globalScript.setVariable("initializeMusic", initializeMusic);

			globalScript.setVariable("makeSongCard", makeSongCard);
			globalScript.setVariable("makeBanner", makeBanner);
			globalScript.setVariable("damageNumManager", damageNumManager);

			globalScript.executeFunc("create");
		}
	}


	function changeExternalVar(type:String, ?integer:Int, ?float:Float, ?bool:Bool, ?string:String):Void{
		switch(type){
			case 'movesSelectable':
				hud.moveText.movesSelectable = bool;
			case 'enemyStunned':
				enemyCharacter.isStunned = bool;
		}
	}

	inline function resetExternalVars(){		
		//duo attack
		motivation = 0;
		duoAttackReady = false;
		
		// turn stuff
		allyTurn = 0;
		allyTurnOpposite = 1;

		//ending battle
		battleOver = false;
		battleReadyToEnd = true;
		forceEnd = '';

		//ally exclusive vars
		comaPurpleAuraActive = false;
		comaPurpleAuraMult = 1.5;

		//enemy exclusive vars
		bossComaPurpleAuraActive = false;
	}
}