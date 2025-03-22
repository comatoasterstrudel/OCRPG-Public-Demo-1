function create() {
	FlxG.sound.play(Paths.sound('attacksfx/glorpGlorp', 'battle'), 1.3);

	new FlxTimer().start(.7, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('attacksfx/glorp', 'battle'), 1);

		target.takeDamage(FlxG.random.int(13, 15));
	});

	var attackanim:AttackAnimation = new AttackAnimation(target, 'glorp', 20, camHud, true, targetNum);
	add(attackanim);
}   

function getTime():Float{
    return 2;
}
