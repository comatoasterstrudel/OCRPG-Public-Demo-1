function getChoice():String {
	var moveToSend:String;

	if (enemyCharacter.hppercent <= 25 && FlxG.random.bool(FlxG.random.float(30,50))) //healing glorp (low hp)
	{
		moveToSend = enemyCharacter.moveList[3];
	}
	else if (FlxG.random.bool(FlxG.random.float(10, 15))) // healing glorp (normal hp)
	{
		moveToSend = enemyCharacter.moveList[3];
	}
	else if (!characterArray[0].isDead && !characterArray[1].isDead && !characterArray[0].hasPriority && !characterArray[1].hasPriority && FlxG.random.bool(FlxG.random.float(45, 60))) //glorp glorp
	{
		moveToSend = enemyCharacter.moveList[1];
	}
	else //glorp
	{
		moveToSend = enemyCharacter.moveList[0];
	}
	
	return moveToSend;
}   