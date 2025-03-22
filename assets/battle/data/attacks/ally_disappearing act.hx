function create() {
	FlxG.sound.play(Paths.sound('attacksfx/dad', 'battle'), 2.7);

	changePriorityStatus(allyTurnOpposite);

	var healthToHeal:Int = FlxG.random.int(30,33);
	healthToHeal = Std.int(healthToHeal * effectiveness);
	if (healthToHeal <= 10) healthToHeal = 10;
	if (effectiveness >= .98) healthToHeal += 10;

	characterArray[allyTurn].heal(healthToHeal);

	var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurn], 'dad', 17, camHud, true, allyTurn, .9);
	attackanim.y = FlxG.height - attackanim.height;
	attackanim.flipX = !attackanim.flipX;
	add(attackanim);

	if (allyTurn == 0) attackanim.x += 30; else attackanim.x -= 30;
}

function getTime():Float{
    return 2;
}
