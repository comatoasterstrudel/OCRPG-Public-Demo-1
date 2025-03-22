function create() {
	FlxG.sound.play(Paths.sound('attacksfx/bompPlace', 'battle'), 1.3);

	new FlxTimer().start(.7, function(tmr:FlxTimer){
		FlxG.sound.play(Paths.sound('attacksfx/bompPlode', 'battle'), 1.3);

		target.isStunned = true;
    });

	var attackanim:AttackAnimation = new AttackAnimation(target, 'bomb', 20, camHud, false, targetNum);
	attackanim.setPosition(attackanim.x - 80, attackanim.y + 80);
	add(attackanim);
}   

function getTime():Float{
    return 2;
}
