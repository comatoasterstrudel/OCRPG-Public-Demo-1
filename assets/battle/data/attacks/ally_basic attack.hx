function create() {
	FlxG.sound.play(Paths.sound('attacksfx/basicAttack', 'battle'), .7);

	new FlxTimer().start(.2, function(tmr:FlxTimer)
	{
		enemyCharacter.takeDamage(FlxG.random.int(8, 12));
	});
    
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'basic', 20, camGame, true, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    return 1.5;
}
