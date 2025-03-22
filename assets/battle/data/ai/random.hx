function getChoice():String {
	var moveToSend:String;

	moveToSend = enemyCharacter.moveList[FlxG.random.int(0, enemyCharacter.moveList.length - 1)];

	return moveToSend;
}   