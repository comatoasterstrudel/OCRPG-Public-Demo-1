function create() {
	FlxG.sound.play(Paths.sound('attacksfx/spin', 'battle'), .7);

	new FlxTimer().start(.35, function(tmr:FlxTimer)
	{
		var damageToTake:Int = FlxG.random.int(19, 20);

		damageToTake = damageToTake * effectiveness;

		if(effectiveness >= .95) damageToTake += 1;
		if(effectiveness >= .97) damageToTake += 1;

		if (damageToTake <= 5) damageToTake = FlxG.random.int(4, 6);

		enemyCharacter.takeDamage(damageToTake);
	});
	
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'spin', 20, camGame, true, allyTurn);
	attackanim.setGraphicSize(FlxG.width, FlxG.height);
	attackanim.screenCenter();
	add(attackanim);
}   

function getTime():Float{
    return 2;
}
