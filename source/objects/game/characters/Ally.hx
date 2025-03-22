package objects.game.characters;

class Ally extends Character
{		
	public var isDead:Bool = false;
	public var isStunned:Bool = false;
	
	public var hasPriority:Bool = false;

	//stats

	//attack
	public final maxAttack:Int = 5;
	public final attMult:Float = 0.06;
	public var attack:Int = 0;
	public var realAttack:Float = 1;

	public var deathCount:Int;

	//death ticker
	final deathTurnsNeeded:Int = 3;
	var deathCurTurn:Int; 

	//callbacks
	public var damageCallbacks:Array<Void -> Void> = [];

	//custom attack vars
	public var briefcaseActive:Bool = false;
	public var trainedFocus:Int = 0;
	public var venomAmount:Int = 0;
	public final maxVenomAmount:Int = 4;

	/*
		allyData.txt format:
		Name, HP, Move1, Move 2, Move 3, Move 4, Use Flip Sprite, HP Color
	 */
	public function new(spriteName:String, side:String)
	{
		super('ally', spriteName);

		setMaxHp(Std.parseInt(Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 1)), true);
		setMoveList([Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 2), Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 3), Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 4), Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 5)]);

		var loadFlipSprite:String = Utilities.grabThingFromText(spriteName, Paths.txt('allyData', 'battle'), 6);
		
		var suffix:String = '';
		
		if (loadFlipSprite == 'true' && side == 'right') suffix = '_flipped';

		frames = Paths.getSparrowAtlas('portraits/portrait_' + spriteName + suffix, 'battle');
		setAnimations(true);
		setGraphicSize(Std.int(width * .2));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');

		if (side == 'right') flipX = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function takeDamage(amount:Int, ?blockable:Bool = true):Void
	{
		if (!isDead){		
			if (trainedFocus <= 0 || trainedFocus > 0 && !FlxG.random.bool(Std.int(FlxG.random.int(25,45) * FlxG.random.float(.9, 1.1)))){	
				var damageToTake:Int = amount;

				PlayState.motivation += 1;
			
				if(hasPriority) hasPriority = false;
			
				if (PlayState.bossComaPurpleAuraActive){
					damageToTake = Std.int(damageToTake * FlxG.random.float(1.5, 2));
					PlayState.bossComaPurpleAuraActive = false;
				}
			
				if(blockable){
					if (briefcaseActive)
					{
						damageToTake = Std.int(damageToTake * FlxG.random.float(.55, .65));
						briefcaseActive = false;
					}

					damageToTake = Std.int(damageToTake * realDefense);
				}

				hp -= damageToTake;

				if (hp <= 0)
					hp = 0;
				if (hp >= maxhp)
					hp = maxhp;

				animation.play(hurtName);

				for(i in 0...damageCallbacks.length){
					damageCallbacks[i]();
				}

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if (hp <= 0)
						doDeath();
					else
						animation.play(idleName);
				});

				FlxTween.shake(this, damageToTake / 1750, .3, X);

				attackActive = true;
				textColor = 0xfe7e7e;
				textToUse = '-' + damageToTake;
			} else {
				FlxG.sound.play(Paths.sound('dodge', 'battle'), 3);

				attackActive = true;
				textColor = 0xffffff;
				textToUse = 'Miss';
			}
		}
	}

	public function heal(amount:Int):Void
	{
		if(!isDead){			
			var damageToHeal:Int = amount;

			hp += damageToHeal;

			if (hp <= 0)
				hp = 0;
			if (hp >= maxhp)
				hp = maxhp;

			attackActive = true;
			textColor = 0x9afe7e;
			textToUse = '+' + damageToHeal;
		}
	}

	public function doDeath():Void{
		deathCurTurn = 0;
		deathCount ++;
		
		FlxTween.shake(this, maxhp / 3000, .2, X);

		FlxG.sound.play(Paths.sound('death', 'battle'), .7);

		animation.play(deadName);

		defense = 0;
		realDefense = 1;

		isStunned = true;
		isDead = true;
	}

	public function restore(hp:Int, sound:Bool = true):Void{
		deathCurTurn = 0;
		isDead = false;
		isStunned = false;
		animation.play(idleName);
		heal(hp);
		if(sound) FlxG.sound.play(Paths.sound('revive', 'battle'), 1);
	}

	public function deathTicker():Void{
		deathCurTurn ++;

		if(deathCurTurn >= deathTurnsNeeded){
			restore(Std.int(maxhp / 2.5), true);
		} else {
			FlxG.sound.play(Paths.sound('dodge', 'battle'), 1);

			var turnsleft:Int = deathTurnsNeeded - deathCurTurn;
			attackActive = true;
			textColor = 0xffffff;
			textToUse = 'Revive in ' + turnsleft;
		}
	}
}
