function create() {
	FlxG.sound.play(Paths.sound('attacksfx/duoComa', 'battle'), .7);

	for (i in 0...characterArray.length){
		characterArray[i].heal(FlxG.random.int(32,34));

		var attackanim:AttackAnimation = new AttackAnimation(characterArray[i], 'duoComa', 20, camHud, true, allyTurn);
		add(attackanim);
	}
}   

function getTime():Float{
    var time:Float;

    if(duoType == 0) time = 1; else if(duoType == 1) time = 2;

    return time;
}
