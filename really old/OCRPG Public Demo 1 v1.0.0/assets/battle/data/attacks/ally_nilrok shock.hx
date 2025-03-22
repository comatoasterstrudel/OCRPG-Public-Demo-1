function create() {
	FlxG.sound.play(Paths.sound('attacksfx/nilrokslash', 'battle'), .7);

	new FlxTimer().start(.3, function(tmr:FlxTimer)
	{
		var damageToTake:Int = FlxG.random.int(7, 8);

		damageToTake = Std.int(damageToTake * effectiveness);

		if (effectiveness >= .95) damageToTake += 1;
		if (effectiveness >= .97) damageToTake += 1;

		if (damageToTake <= 3) damageToTake = FlxG.random.int(3, 5);

		enemyCharacter.takeDamage(damageToTake);

		changeExternalVar('enemyStunned', 0, 0, true);
	});
    
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'nilrokshock', 15, camGame, true, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    return 1.5;
}
