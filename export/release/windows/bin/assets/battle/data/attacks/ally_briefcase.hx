function create() {
	new FlxTimer().start(.2, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('attacksfx/briefcase', 'battle'), 1);
	});

	characterArray[allyTurn].briefcaseActive = true;

	var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurn], 'case', 17, camHud, true, allyTurn, .9);
	attackanim.y = FlxG.height - attackanim.height;
	attackanim.flipX = !attackanim.flipX;
	add(attackanim);

	new FlxTimer().start(1, function(tmr:FlxTimer)
	{
		var defNum:Int = 1;

		if (effectiveness >= .95) defNum += 1;
		if (effectiveness >= .97) defNum += 1;

		changeStatAlly(characterArray[allyTurn], defNum, true);
	});

	if (allyTurn == 0) attackanim.x -= 30; else attackanim.x += 30;
}   

function getTime():Float{
    return 2.5;
}
