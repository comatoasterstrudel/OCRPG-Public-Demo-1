function create() {
	FlxG.sound.play(Paths.sound('attacksfx/venomShot', 'battle'), .7);

	new FlxTimer().start(.2, function(tmr:FlxTimer)
	{
		var damageToTake:Int = getDamageAmount();

		damageToTake = Std.int(damageToTake * effectiveness);

		if(effectiveness >= .97) damageToTake += 1;

		if(damageToTake <= 3) damageToTake = FlxG.random.int(3, 5);

		enemyCharacter.takeDamage(damageToTake);
	});

	var amountToIncrease:Int = 1;

	if (effectiveness >= .97) amountToIncrease += 1;

	characterArray[allyTurn].venomAmount += 1;
	if (characterArray[allyTurn].venomAmount > characterArray[allyTurn].maxVenomAmount) characterArray[allyTurn].venomAmount = characterArray[allyTurn].maxVenomAmount;

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'venom', 20, camGame, true, allyTurn);
    attackanim.y += 30;
	add(attackanim);
}

function getDamageAmount():Int{
    var damageNum:Int;

	switch(characterArray[allyTurn].venomAmount){
		case 1:
			damageNum = FlxG.random.int(12, 14);
		case 2:
			damageNum = FlxG.random.int(15, 17);
		case 3:
			damageNum = FlxG.random.int(18, 20);
		case 4:
			damageNum = FlxG.random.int(21, 23);
		default:
			damageNum = FlxG.random.int(9, 11);
	}

	return damageNum;
}

function getTime():Float{
    return 1.5;
}
