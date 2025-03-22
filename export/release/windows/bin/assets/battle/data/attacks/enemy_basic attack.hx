function create() {
	FlxG.sound.play(Paths.sound('attacksfx/basicAttack', 'battle'), .7);

	new FlxTimer().start(.2, function(tmr:FlxTimer)
	{
		target.takeDamage(FlxG.random.int(20, 25));
	});

	var attackanim:AttackAnimation = new AttackAnimation(target, 'basic', 20, camHud, true, targetNum);
	add(attackanim);
}   

function getTime():Float{
    return 1.5;
}
