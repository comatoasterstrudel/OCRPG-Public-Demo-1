package objects.game.hud;

/**
 * An object that holds the entire UI
 * for battles. Includes allies, healthbars
 * etc.
 */
class Hud extends FlxTypedGroup<FlxTypedGroup<FlxSprite>>
{
    //sprites and groups

	public var miscSprites:FlxTypedGroup<FlxSprite>;
    public var bottomSprites:FlxTypedGroup<FlxSprite>;

	public var fadeSprite:FlxSprite;
    public var bottomBar:FlxSprite;

	public var enemyHealthBar:EnemyHealthBar;

	public var moveText:MoveText;

	public var turnIndicatorArrow:FlxSprite;

	public var duoButtonPrompt:DuoButtonPrompt;

    public var partyMember1:Ally;
    public var partyMember2:Ally;

	public var allyHpBars:AllyHealthBar;

    public var motivationBarOutline:FlxSprite;
	public var motivationBar:FlxBar;

	public var characterArray:Array<Ally> = [];
	
    //data

	public final maxMotivation:Int = 15;

	public var motivationLerp:Float = 0;

	public function new()
	{
		super();

		/*
		HERES ALL THE FUNCTIONS NEEDED TO SETUP THE HUD
		SEPERATED SO YOU CAN CHOOSE ONLY WHAT YOU NEED

		initializeGroups();
		initializeFadeSprite();
		initializeBottomSprites();
		initializeMoveText(allyAttackCallback, duoAttackCallback)
		initializeEnemyHealthBar(enemyCharacter);

		MAY CRASH IF YOU DONT USE CERTAIN ONES
		*/
	}

	inline public function initializeGroups():Void{
		miscSprites = new FlxTypedGroup<FlxSprite>();
		add(miscSprites);

		bottomSprites = new FlxTypedGroup<FlxSprite>();
		add(bottomSprites);
	}

	inline public function initializeFadeSprite(group:FlxTypedGroup<FlxSprite>):Void{
		if(fadeSprite != null) fadeSprite.destroy();

		fadeSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF393939);
		fadeSprite.alpha = 0;
		group.add(fadeSprite);
	}

	inline public function initializeBottomSprites():Void{
		bottomBar = new FlxSprite().loadGraphic(Paths.image('ui/battleLowerBar', 'battle'));
		bottomBar.scale.x = FlxG.width;
		bottomBar.updateHitbox();
		bottomBar.antialiasing = SaveData.settings.get('antiAliasing');
		bottomBar.screenCenter(X);
		bottomBar.y = FlxG.height - 100;
		bottomSprites.add(bottomBar);

		setupAlly(0);
		setupAlly(1);
		
		duoButtonPrompt = new DuoButtonPrompt(this);
		add(duoButtonPrompt);

		allyHpBars = new AllyHealthBar(this);
		add(allyHpBars);

		for(i in 0...characterArray.length){
			characterArray[i].damageCallbacks.push(function():Void{
				if(allyHpBars.hpTextArray[i] != null){
					allyHpBars.hpTextArray[i].angle = FlxG.random.int(-50, 50);
				}
			});
		}

		motivationBarOutline = new FlxSprite().loadGraphic(Paths.image('ui/motivationBar', 'battle'));
		motivationBarOutline.setGraphicSize(Std.int(motivationBarOutline.width * 1.1));
		motivationBarOutline.updateHitbox();
		motivationBarOutline.setPosition(FlxG.width / 2 - motivationBarOutline.width / 2, bottomBar.y - motivationBarOutline.height);
		motivationBarOutline.antialiasing = SaveData.settings.get('antiAliasing');

		motivationBar = new FlxBar(motivationBarOutline.x + 8, motivationBarOutline.y + 4, LEFT_TO_RIGHT, Std.int(motivationBarOutline.width - 30), Std.int(motivationBarOutline.height - 3), this, 'motivationLerp', 0, maxMotivation);
		motivationBar.screenCenter(X);
		motivationBar.createColoredEmptyBar(FlxColor.BLACK);
		motivationBar.createImageFilledBar(Paths.image('ui/motivationBarBG', 'battle'), FlxColor.BLACK);
		motivationBar.updateBar();
		motivationBar.numDivisions = Std.int(motivationBar.width);

		bottomSprites.add(motivationBar);
		bottomSprites.add(motivationBarOutline);
	}

	inline public function setupAlly(num:Int):Void{
		if(num == 0){
			if(partyMember1 != null) partyMember1.destroy();

			partyMember1 = new Ally(Battle.partyCharacters[0], 'left');
			partyMember1.setPosition(25, bottomBar.y - partyMember1.height);
			bottomSprites.add(partyMember1);

			characterArray[0] = partyMember1;
		} else if(num == 1){
			if (partyMember2 != null) partyMember2.destroy();

			partyMember2 = new Ally(Battle.partyCharacters[1], 'right');
			partyMember2.setPosition(FlxG.width - partyMember2.width - 25, bottomBar.y - partyMember2.height);
			bottomSprites.add(partyMember2);

			characterArray[1] = partyMember2;
		}
	}

	inline public function initializeMoveText(allyAttackCallback:String->Void, duoAttackCallback:Int->Void):Void{
		moveText = new MoveText(this, allyAttackCallback, duoAttackCallback);
		add(moveText);
	}

	public function addTurnIndicator():Void
	{
		if (turnIndicatorArrow != null)
			turnIndicatorArrow.destroy();

		turnIndicatorArrow = new FlxSprite();
		turnIndicatorArrow.frames = Paths.getSparrowAtlas('ui/turnIndicator', 'battle');
		turnIndicatorArrow.animation.addByPrefix('idle', 'idle', 18);
		turnIndicatorArrow.animation.play('idle');
		turnIndicatorArrow.setGraphicSize(Std.int(turnIndicatorArrow.width * .3));
		turnIndicatorArrow.updateHitbox();
		turnIndicatorArrow.antialiasing = SaveData.settings.get('antiAliasing');
		turnIndicatorArrow.alpha = 0;
		miscSprites.add(turnIndicatorArrow);

		new FlxTimer().start(.7, function(tmr:FlxTimer)
		{
			turnIndicatorArrow.setPosition(characterArray[PlayState.allyTurn].x + characterArray[PlayState.allyTurn].width / 2 - turnIndicatorArrow.width / 2, characterArray[PlayState.allyTurn].y - 225);
			FlxTween.tween(turnIndicatorArrow, {alpha: 1}, .3, {ease: FlxEase.cubeInOut});
		});
	}

	public function initializeEnemyHealthBar(enemyCharacter:Enemy):Void
	{
		if (enemyHealthBar != null)
			enemyHealthBar.destroy();

		enemyHealthBar = new EnemyHealthBar(enemyCharacter);
		add(enemyHealthBar);

		enemyCharacter.damageCallbacks.push(function():Void
		{
			if (enemyHealthBar.enemyHealthText != null)
			{
				enemyHealthBar.enemyHealthText.angle = FlxG.random.int(-50, 50);
			}
		});
	}

	public function bottomBarManager(type:String):Void{
		switch(type){
			case 'up':
				bottomSprites.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {y: spr.y - 200}, .5, {ease: FlxEase.quartInOut});
				});

				allyHpBars.move('up');		

				FlxTween.tween(fadeSprite, {alpha: 0.2}, .5, {ease: FlxEase.quartInOut});

				moveText.addMoveText(PlayState.allyTurn);
			case 'down':
				bottomSprites.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {y: spr.y + 200}, .5, {ease: FlxEase.quartInOut});
				});

				allyHpBars.move('down');

				FlxTween.tween(fadeSprite, {alpha: 0}, .5, {ease: FlxEase.quartInOut});

				moveText.removeMoveText();

				duoButtonPrompt.removeDuoButtonPrompt();
		}
	}
}