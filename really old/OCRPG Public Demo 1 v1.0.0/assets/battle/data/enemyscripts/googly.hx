function winBattle(){
	if (FlxG.random.bool(2)) FlxG.sound.play(Paths.sound('screamer/googlyDies', 'battle'), 1);
}