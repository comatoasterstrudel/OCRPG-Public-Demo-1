function create() {
	FlxG.sound.play(Paths.sound('attacksfx/duoLuigiSpin', 'battle'), .7);
    
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'duoLuigi', 1, camGame, true, allyTurn, .5);
	attackanim.angle = FlxG.random.int(0, 360);
	add(attackanim);

	switch (duoAttackNumber){
        case 0: //leftr
			attackanim.angularVelocity = 450;
			attackanim.setPosition(-attackanim.width, FlxG.random.int(0, Std.int(FlxG.height - attackanim.height)));
        case 1: //right
			attackanim.angularVelocity = -450;
			attackanim.setPosition(FlxG.width, FlxG.random.int(0, Std.int(FlxG.height - attackanim.height)));
    }

	FlxTween.tween(attackanim, {x: enemyCharacter.x + enemyCharacter.width / 2 - attackanim.width / 2, y: enemyCharacter.y + enemyCharacter.height / 2 - attackanim.height / 2}, 1, { onComplete: function(FlxTwn){
		FlxG.sound.play(Paths.sound('attacksfx/duoLuigiHit', 'battle'), .7);

		enemyCharacter.takeDamage(FlxG.random.int(20, 23));
		changeExternalVar('enemyStunned', 0, 0, true);

		attackanim.animation.addByPrefix('hit', 'hurt', 1);
		attackanim.animation.play('hit');

		attackanim.angularVelocity = FlxG.random.int(-50, 50);
		attackanim.velocity.set(-250, 250);
		attackanim.acceleration.set(50, 250);
	}});
}   

function getTime():Float{
	if (duoType == 0) time = 2; else if (duoType == 1) time = 2.7;

}
