function create() {
	FlxG.sound.play(Paths.sound('attacksfx/glorpGlorp', 'battle'), 1.3);

	new FlxTimer().start(.7, function(tmr:FlxTimer){
		FlxG.sound.play(Paths.sound('attacksfx/glorp', 'battle'), 1);
		for (i in 0...characterArray.length){
			characterArray[i].takeDamage(FlxG.random.int(7, 9));
		}
	});

	for (i in 0...characterArray.length){
		var attackanim:AttackAnimation = new AttackAnimation(characterArray[i], 'glorp', 20, camHud, true, targetNum);
		add(attackanim);
	}
}   

function getTime():Float{
    return 2;
}
