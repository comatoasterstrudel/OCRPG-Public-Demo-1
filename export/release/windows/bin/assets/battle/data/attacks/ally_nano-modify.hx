function create() {
	FlxG.sound.play(Paths.sound('attacksfx/nano', 'battle'), 1);

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'nano', 15, camGame, false, allyTurn);
	attackanim.x -= 250;
	attackanim.y - 700;
	add(attackanim);

	new FlxTimer().start(1.7, function(tmr:FlxTimer)
	{
		var defNum:Int = 1;

		if (effectiveness >= .97) defNum += 1;

		changeStatAlly(characterArray[0], defNum, true);
		changeStatAlly(characterArray[1], defNum, false);

		var enemyDefNum:Int = -1;

		if (effectiveness >= .97) enemyDefNum -= 1;

		changeStatEnemy(enemyDefNum, true);
	});
}   

function getTime():Float{
    return 3;
}