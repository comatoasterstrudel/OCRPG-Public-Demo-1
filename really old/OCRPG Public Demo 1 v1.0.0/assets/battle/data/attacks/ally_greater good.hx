function create() {
	FlxG.sound.play(Paths.sound('attacksfx/greatergoodOne', 'battle'), .7);

	new FlxTimer().start(.5, function(tmr:FlxTimer)
	{		
		FlxG.sound.play(Paths.sound('attacksfx/greatergoodTwo', 'battle'), .7);

		var healthPercent:Float = characterArray[allyTurn].healthPercent / 100;

		var damageToTake:Int = Std.int(FlxG.random.int(44, 46) * healthPercent);

		damageToTake = Std.int(damageToTake * effectiveness);

		if (effectiveness >= .95) damageToTake += 3;
		if (effectiveness >= .97) damageToTake += 3;

		if (damageToTake < 15) damageToTake = 15;

		enemyCharacter.takeDamage(damageToTake);

		characterArray[allyTurn].takeDamage(characterArray[allyTurn].allyHp, false);
	});
    	
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'sewerslide', 20, camGame, true, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    return 2.5;
}
