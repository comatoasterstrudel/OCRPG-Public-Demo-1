package objects.game.hud;

/**
 * An object that holds the move texts
 * during a battle.
 */
class MoveText extends FlxTypedGroup<FlxSprite>
{
	var hud:Hud;

	var textDataArray:Array<String>;

    var moveSelected:Int;

    var descriptionText:FlxText;

	var lastSelectedArray:Array<Int> = [0, 0];
	
	public var movesSelectable:Bool = false;

	var allyAttackCallback:String -> Void;
	var duoAttackCallback:Int -> Void;

	public function new(hudData:Hud, allyAttackCallbackNew:String->Void, duoAttackCallbackNew:Int->Void){
		super();

		hud = hudData;
		allyAttackCallback = allyAttackCallbackNew;
		duoAttackCallback = duoAttackCallbackNew;
    }

	override function update(elapsed:Float){
		super.update(elapsed);

		if (!DialogueSubstate.dialogueActive && movesSelectable)
		{
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				selectMove(PlayState.allyTurn, function(name:String):Void
				{
					allyAttackCallback(name);
				});
				FlxG.sound.play(Paths.sound('select', 'menu'), 1);
			}
			if (Controls.getControl('EXTRAONE', 'RELEASE') && PlayState.duoAttackReady)
			{
				doDuoAttack();

				FlxG.sound.play(Paths.sound('select', 'menu'), 1);
			}
			if (Controls.getControl('UP', 'RELEASE'))
			{
				changeSelection(-1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), 1);
			}
			if (Controls.getControl('DOWN', 'RELEASE'))
			{
				changeSelection(1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), 1);
			}
		}
	}

	public function addMoveText(allyNum:Int):Void{
		setDataArray(hud.characterArray[PlayState.allyTurn].moveList);

		moveSelected = lastSelectedArray[allyNum];

		for (i in 0...textDataArray.length)
		{
			var ii:Int = i + 1;
			var yval:Float = 60 * ii;

			var movetext:FlxText = new FlxText(0, 0, FlxG.width, textDataArray[i], 35, false);
			movetext.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, CENTER);
			movetext.screenCenter(X);
			movetext.x -= 200;
			movetext.y = 410 + yval;
			movetext.ID = i;
			movetext.alpha = 0.3;
			movetext.antialiasing = SaveData.settings.get('antiAliasing');
			add(movetext);

			var designatedY:Float = movetext.y;
			movetext.y += 400;

			var time:Float = 0.1 * ii;

			FlxTween.tween(movetext, {y: designatedY}, 0.5 + time, {ease: FlxEase.quartInOut});
		}

		descriptionText = new FlxText(0, 0, 300, '', 35, false);
		descriptionText.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, CENTER);
		descriptionText.screenCenter(X);
		descriptionText.x += 200;
		descriptionText.alpha = 0;
		descriptionText.antialiasing = SaveData.settings.get('antiAliasing');
		descriptionText.ID = -1;
		add(descriptionText);

		new FlxTimer().start(.7, function(tmr:FlxTimer)
		{
			changeSelection(0);
			FlxTween.tween(descriptionText, {alpha: 1}, .3, {ease: FlxEase.cubeInOut});
		});

		if (PlayState.duoAttackReady)
		{
			hud.duoButtonPrompt.addDuoButtonPrompt();
		}

		new FlxTimer().start(.7, function(tmr:FlxTimer)
		{
			movesSelectable = true;
		});

		hud.addTurnIndicator();
	}

	public function removeMoveText(){
		FlxTween.tween(hud.turnIndicatorArrow, {alpha: 0}, .3, {ease: FlxEase.cubeInOut, onComplete: function(FlxTwn):Void{
			hud.turnIndicatorArrow.destroy();
		}});

		forEach(function(spr:FlxSprite)
		{
			FlxTween.tween(spr, {alpha: 0}, .3, {
				ease: FlxEase.cubeInOut,
				onComplete: function(FlxTwn):Void
				{
					spr.destroy();
				}
			});
		});

		movesSelectable = false;
	}

	public function changeSelection(amount:Int){
		moveSelected += amount;

		if (moveSelected >= textDataArray.length)
			moveSelected = 0;
		if (moveSelected < 0)
			moveSelected = textDataArray.length - 1;

		forEach(function(spr:FlxSprite)
		{
			if (spr.ID != -1)
			{
				if (spr.ID == moveSelected)
					spr.alpha = 1;
				else
					spr.alpha = 0.3;
			}
		});

		descriptionText.text = Utilities.grabThingFromText(textDataArray[moveSelected], Paths.txt('moveInfo', 'battle'), 1);
		descriptionText.y = FlxG.height - hud.bottomBar.height / 2 - descriptionText.height / 2 + 10;
	}

	public function selectMove(allyNum:Int, callbackFunction:String -> Void){
		lastSelectedArray[allyNum] = moveSelected;
		callbackFunction(textDataArray[moveSelected]);
	}

	public function doDuoAttack(){
		removeMoveText();

		hud.duoButtonPrompt.doDuoAnim();

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			duoAttackCallback(0);
		});
    }

    public function setDataArray(data:Array<String>){
		textDataArray = data;
    }
}