function getChoice():String {
	var moveToSend:String;

	if (enemyCharacter.healthPercent <= 10 && FlxG.random.bool(FlxG.random.float(20, 35))) // rally (low hp)
	{
		moveToSend = enemyCharacter.moveList[3];
	}
	else if(FlxG.random.bool(FlxG.random.float(50, 75)) && PlayState.bossComaPurpleAuraActive) // purple aura active
	{
		moveToSend = enemyCharacter.moveList[0];
	}
	else if (FlxG.random.bool(FlxG.random.float(2, 4)) && PlayState.bossComaPurpleAuraActive) // purple aura with purple aura active just to make it look more fluid idk
	{
		moveToSend = enemyCharacter.moveList[2];
	}
	else if (FlxG.random.bool(FlxG.random.float(25, 35)) && !PlayState.bossComaPurpleAuraActive) //purple aura
	{
		moveToSend = enemyCharacter.moveList[2];
	}
	else if (FlxG.random.bool(FlxG.random.float(2, 5))) // moral support lol
	{
		moveToSend = enemyCharacter.moveList[1];
	}
	else //hardened bash
	{
		moveToSend = enemyCharacter.moveList[0];
	}

	return moveToSend;
}   