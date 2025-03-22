var pizzaWheelAmount:Int = 2;

function create() {
	if (effectiveness >= .8) pizzaWheelAmount ++;
	if (effectiveness >= .97) pizzaWheelAmount ++;

	for(i in 0...pizzaWheelAmount){
		var time:Float = 3 * i;

		new FlxTimer().start(time / 2, function(tmr:FlxTimer){
			makeWheel();
		});
	}
}   

function makeWheel():Void{
	var time:Float = 2;

	FlxG.sound.play(Paths.sound('attacksfx/wheelPlace', 'battle'), .7);

	new FlxTimer().start(time / 2, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('attacksfx/wheelHit', 'battle'), .7);

		var damageToTake:Int = FlxG.random.int(5, 6);

		damageToTake = damageToTake * effectiveness;

		if(damageToTake < 3) damageToTake = FlxG.random.int(2, 3);
		
		enemyCharacter.takeDamage(damageToTake);
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'pizzawheel', 20, camGame, false, allyTurn, .5, false);
	add(attackanim);

	if(FlxG.random.bool(50)){ //come from right
		attackanim.flipX = false;
		attackanim.x = FlxG.width;
		FlxTween.tween(attackanim, {x: -attackanim.width}, time, {onComplete: function(FlxTwn){
			attackanim.destroy();
		}});
	} else { //come from left
		attackanim.flipX = true;
		attackanim.x = -attackanim.width;
		FlxTween.tween(attackanim, {x: FlxG.width}, time, {onComplete: function(FlxTwn){
			attackanim.destroy();
		}});
	}
}

function getTime():Float{
	return pizzaWheelAmount + 3;
}


