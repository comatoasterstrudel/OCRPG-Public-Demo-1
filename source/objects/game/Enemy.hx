package objects.game;

class Enemy extends FlxSprite
{
	public var name:String;

	public var moveList:Array<String> = ['Basic Attack', 'Basic Attack', 'Basic Attack', 'Basic Attack'];	

	public var enemyHealth:Int;
	public var maxHealth:Int;

	public var healthPercent:Float;

	public var isDead:Bool = false;
	public var isStunned:Bool = false;

	public final maxDefense:Int = 5;
	public final defMult:Float = 0.06;
	public var defense:Int = 0;
	public var realDefense:Float = 1;
	
	public var attackActive:Bool;
	public var textColor:FlxColor;
	public var textToUse:String;

	// callbacks
	public var damageCallbacks:Array<Void->Void> = [];

	/*
		battleData.txt format:
		Name, HP, BG, Music, Volume, Move 1, Move 2, Move 3, Move 4, Sprite Position, Boss/Enemy, Use Dia Intro, HP Color
	*/
	public function new(spriteName:String)
	{
		super();

		name = spriteName;
		maxHealth = Std.parseInt(Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 1));
		healthPercent = Std.int(enemyHealth / maxHealth * 100);
		enemyHealth = maxHealth;
		moveList = [Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 5), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 6), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 7), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 8)];
				
		var center:Bool = true;
		if (Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 9) == 'bottom') center = false;

		frames = Paths.getSparrowAtlas('enemy/opponent_' + spriteName, 'battle');
		animation.addByPrefix('idle', 'idle', 2);
		animation.addByPrefix('hurt', 'hurt', 2);
		animation.addByPrefix('dead', 'dead', 1);
		animation.play('idle');
		setGraphicSize(Std.int(width * Std.parseFloat(Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 10))));
		updateHitbox();
		screenCenter(X);
		antialiasing = SaveData.settings.get('antiAliasing');

		if (center)
			screenCenter(Y);
		else
			y = FlxG.height - height;
	}
	
	override function update(elapsed:Float){
		healthPercent = Std.int(enemyHealth / maxHealth * 100);

		super.update(elapsed);
	}
	
	public function takeDamage(amount:Int, ?increaseMotivation:Bool = true):Void
	{	
		var damageToTake:Int = amount;

		if(increaseMotivation) PlayState.motivation ++;
		
		if (PlayState.comaPurpleAuraActive) {
			damageToTake = Std.int(damageToTake * PlayState.comaPurpleAuraMult);
			PlayState.comaPurpleAuraActive = false;
		}

		damageToTake = Std.int(damageToTake * realDefense);

		enemyHealth -= damageToTake;

		if (enemyHealth <= 0)
			enemyHealth = 0;
		if (enemyHealth >= maxHealth)
			enemyHealth = maxHealth;

		animation.play('hurt');

		for (i in 0...damageCallbacks.length){
			damageCallbacks[i]();
		}

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (enemyHealth <= 0)
				isDead = true;
			else
				animation.play('idle');
		});

		FlxTween.shake(this, damageToTake / 2000, .2);

		attackActive = true;
		textColor = 0xfe7e7e;
		textToUse = '-' + damageToTake;
	}

	public function heal(amount:Int):Void
	{
		if (!isDead)
		{			
			var damageToHeal:Int = amount;

			enemyHealth += damageToHeal;

			if (enemyHealth <= 0)
				enemyHealth = 0;
			if (enemyHealth >= maxHealth)
				enemyHealth = maxHealth;

			attackActive = true;
			textToUse = '+' + damageToHeal;
			textColor = 0x9afe7e;
		}
	}

	public function changeDefense(num:Int):Bool{
		var returnThis:Bool = false;

		defense += num;

		if(defense > maxDefense){
			defense = maxDefense;
			returnThis = true;
		} else if(defense < -maxDefense){
			defense = -maxDefense;
			returnThis = true;
		}

		var addThis:Float = defMult * defense;

		realDefense = 1 - addThis;
		
		return returnThis;
	}
}
