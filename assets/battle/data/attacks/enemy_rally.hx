function create() {
	FlxG.sound.play(Paths.sound('attacksfx/rally', 'battle'), .7);

	enemyCharacter.heal(Std.int(FlxG.random.int(10,13)));

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'rally', 20, camGame, false, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    return 1.5;
}
