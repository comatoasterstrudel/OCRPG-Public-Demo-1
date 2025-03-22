package objects.game.characters;

class Enemy extends Character
{
	public var isDead:Bool = false;
	public var isStunned:Bool = false;

	// callbacks
	public var damageCallbacks:Array<Void->Void> = [];

	/*
		battleData.txt format:
		Name, HP, BG, Music, Volume, Move 1, Move 2, Move 3, Move 4, Sprite Position, Boss/Enemy, Use Dia Intro, HP Color
	*/
	public function new(spriteName:String)
	{
		super('enemy', spriteName);

		setMaxHp(Std.parseInt(Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 1)), true);
		setMoveList([Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 5), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 6), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 7), Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 8)]);
				
		var center:Bool = true;
		if (Utilities.grabThingFromText(spriteName, Paths.txt('battleData', 'battle'), 9) == 'bottom') center = false;

		frames = Paths.getSparrowAtlas('enemy/opponent_' + spriteName, 'battle');
		setAnimations(true);
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

		hp -= damageToTake;

		if (hp <= 0)
			hp = 0;
		if (hp >= maxhp)
			hp = maxhp;

		animation.play('hurt');

		for (i in 0...damageCallbacks.length){
			damageCallbacks[i]();
		}

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (hp <= 0)
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

			hp += damageToHeal;

			if (hp <= 0)
				hp = 0;
			if (hp >= maxhp)
				hp = maxhp;

			attackActive = true;
			textToUse = '+' + damageToHeal;
			textColor = 0x9afe7e;
		}
	}
}
