function create() {
	FlxG.sound.play(Paths.sound('attacksfx/moralSupport', 'battle'), .7);

	target.heal(FlxG.random.int(25, 28));

	var attackanim:AttackAnimation = new AttackAnimation(target, 'support', 20, camHud, false, allyTurn);
	add(attackanim);
}   

function getTime():Float{
    return 2;
}
