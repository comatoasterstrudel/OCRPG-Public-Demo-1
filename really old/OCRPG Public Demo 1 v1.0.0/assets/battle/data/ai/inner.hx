function getChoice():String {
	var moveToSend:String;

    if(FlxG.random.float(10,20))//stab
    {
		moveToSend = enemyCharacter.moveList[1];
    }
	if (enemyCharacter.healthPercent <= 12 && FlxG.random.bool(FlxG.random.float(50,70))) //leech (low hp)
	{
		moveToSend = enemyCharacter.moveList[0];
	}
	else if (FlxG.random.bool(FlxG.random.float(15, 20))) // leech (normal hp)
	{
		moveToSend = enemyCharacter.moveList[0];
	}
	else if (!target.isStunned && FlxG.random.bool(FlxG.random.float(20, 35))) //bomb stall
	{
		moveToSend = enemyCharacter.moveList[2];
	}
	else //stab
	{
		moveToSend = enemyCharacter.moveList[1];
	}
	
	return moveToSend;
}   