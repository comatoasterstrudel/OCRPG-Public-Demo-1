function create() {
	new FlxTimer().start(.15, function(tmr:FlxTimer){
		FlxG.sound.play(Paths.sound('attacksfx/duoParagon', 'battle'), .7);
				
		enemyCharacter.takeDamage(FlxG.random.int(30, 45), false);
		characterArray[Utilities.invertNum(duoAttackNumber)].takeDamage(Std.int(characterArray[Utilities.invertNum(duoAttackNumber)].maxHp / FlxG.random.float(1.1, 3), false));
	});

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'duoParagon', 26, camGame, true, allyTurn, 1.4);
	add(attackanim);
}   

function getTime():Float{
    var time:Float;

    if(duoType == 0) time = 1; else if(duoType == 1) time = 2;

    return time;
}
