function create() {
	FlxG.sound.play(Paths.sound('attacksfx/hardBash', 'battle'), .7);

	new FlxTimer().start(.3, function(tmr:FlxTimer)
	{
		var damageToTake:Int = FlxG.random.int(15, 17);

		damageToTake = Std.int(damageToTake * effectiveness);

		if(effectiveness >= .95) damageToTake += 1;
		if(effectiveness >= .97) damageToTake += 1;

		if(damageToTake <= 4) damageToTake = FlxG.random.int(3, 5);

		enemyCharacter.takeDamage(damageToTake);
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'bash', 20, camGame, false, allyTurn);
	attackanim.x -= 10;
	add(attackanim);

	new FlxTimer().start(1.3, function(tmr:FlxTimer)
	{
		var defNum:Int = 1;

		if (effectiveness >= .97) defNum += 1;

		changeStatAlly(characterArray[0], defNum, true);
		changeStatAlly(characterArray[1], defNum, false);
	});
}   

function getTime():Float{
    return 2.5;
}