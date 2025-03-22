function create() {
	FlxG.sound.play(Paths.sound('attacksfx/hardBash', 'battle'), .7);

	new FlxTimer().start(.3, function(tmr:FlxTimer)
	{
		target.takeDamage(FlxG.random.int(14, 16));
	});

	var attackanim:AttackAnimation = new AttackAnimation(target, 'bash', 20, camHud, false, allyTurn);
	attackanim.flipY = true;
	add(attackanim);

	new FlxTimer().start(1.3, function(tmr:FlxTimer)
	{
		changeStatEnemy(1, true);
	});
}   

function getTime():Float{
    return 3;
}
