function create() {
    stab();
    
	new FlxTimer().start(1, function(tmr:FlxTimer) {
		target = characterArray[getTargetNum];
        stab();
    });
}   

function getTime():Float{
    return 2.5;
}

function stab():Void{
	new FlxTimer().start(.3, function(tmr:FlxTimer)
	{
		FlxG.sound.play(Paths.sound('attacksfx/stab', 'battle'), 1.3);

		target.takeDamage(FlxG.random.int(15, 20));
    });

	var attackanim:AttackAnimation = new AttackAnimation(target, 'stab', 24, camHud, false, targetNum, .7);
	add(attackanim);
}
