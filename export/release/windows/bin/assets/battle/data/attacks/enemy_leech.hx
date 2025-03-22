function create() {
	FlxG.sound.play(Paths.sound('attacksfx/leech', 'battle'), 1.3);
		
	var damageNum:Int = FlxG.random.int(18, 20);

	target.takeDamage(damageNum);
    enemyCharacter.heal(Std.int(damageNum * .65));

	var attackanim:AttackAnimation = new AttackAnimation(target, 'leach', 15, camHud, false, targetNum);
	attackanim.x -= 15;
	attackanim.y += 25;
	add(attackanim);
}   

function getTime():Float{
    return 2;
}
