function create() {
	new FlxTimer().start(.3, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('attacksfx/glorpHeal', 'battle'), 2);

		enemyCharacter.heal(Std.int(enemyCharacter.maxhp / FlxG.random.float(11, 14) * FlxG.random.float(.9, 1.1)));
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'slimeHeal', 25, camGame, false, targetNum);
	attackanim.x -= 25;
	add(attackanim);
}   

function getTime():Float{
    return 1.5;
}
