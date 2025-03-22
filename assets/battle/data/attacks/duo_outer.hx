function create() {
	FlxG.sound.play(Paths.sound('attacksfx/duoOuter', 'battle'), .7);

	new FlxTimer().start(.15, function(tmr:FlxTimer){
		enemyCharacter.takeDamage(FlxG.random.int(20, 30), false);
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'duoOuter', 26, camGame, true, allyTurn, 1.4);
	attackanim.y += 45;
	add(attackanim);
}   

function getTime():Float{
    var time:Float;

    if(duoType == 0) time = 1; else if(duoType == 1) time = 2;

    return time;
}
