function create() {
	FlxG.sound.play(Paths.sound('attacksfx/shitpizza', 'battle'), .7);

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'shitpizza', 15, camGame, false, allyTurn);
	attackanim.x -= 10;
	add(attackanim);

	new FlxTimer().start(1.5, function(tmr:FlxTimer)
	{
		var defNum:Int = -2;

		if (effectiveness >= .97) defNum --;

		changeStatEnemy(defNum, true);
	});
}   

function getTime():Float{
    return 3;
}