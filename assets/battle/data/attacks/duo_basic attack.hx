function create() {
	FlxG.sound.play(Paths.sound('attacksfx/basicAttack', 'battle'), .7);

	new FlxTimer().start(.2, function(tmr:FlxTimer)
	{
		enemyCharacter.takeDamage(FlxG.random.int(20, 25), false);
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'basic', 20, camGame, true, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    var time:Float;

    if(duoType == 0) time = 1; else if(duoType == 1) time = 2;

    return time;
}
