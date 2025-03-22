var max:Int = 5;

function create() {
	FlxG.sound.play(Paths.sound('attacksfx/unscrew', 'battle'), .7);
	
	var particleAmount:Int = 10;

	var particleEmitter:FlxEmitter = new FlxEmitter(enemyCharacter.x + enemyCharacter.width / 2, enemyCharacter.y + enemyCharacter.height / 2, particleAmount);
    particleEmitter.cameras = [camGame];
	particleEmitter.lifespan.set(3, 3);
    particleEmitter.angularVelocity.set(-50, 50);
	particleEmitter.velocity.set(-250, 250);
	particleEmitter.acceleration.set(50, 250);
	add(particleEmitter);

    var alllittlemen:Bool = FlxG.random.bool(2);

	for (i in 0...particleAmount)
	{
        var animnum:Int = FlxG.random.int(1,4);

		if (FlxG.random.bool(8) || alllittlemen) animnum = 5;

		var particle:FlxParticle = new FlxParticle();
		particle.frames = Paths.getSparrowAtlas('attackanims/attackanim_unscrew', 'battle');
		particle.animation.addByPrefix('idle', 'idle' + animnum, 2);
		particle.animation.play('idle');
		particle.angle = FlxG.random.int(0, 360);
		particle.antialiasing = SaveData.settings.get('antiAliasing');
		particleEmitter.add(particle);
	}

	particleEmitter.start(false, 0.25, particleAmount);

	new FlxTimer().start(3.5, function(tmr:FlxTimer) {
        if(FlxG.random.bool(7.5)){ //succeed
			FlxG.sound.play(Paths.sound('attacksfx/unscrewSucceed', 'battle'), .7);
            enemyCharacter.takeDamage(FlxG.random.int(enemyCharacter.maxHealth, 1500));
        } else { //fail
            var textarray:Array<String> = ['Nope.', 'Nuh Uh.', "We're closed. Check back later.", 'Oopsie.', 'If you fail unscrew too much, you can go to hell!'];

			FlxG.sound.play(Paths.sound('attacksfx/unscrewFail', 'battle'), .7);

			enemyCharacter.attackActive = true;
			enemyCharacter.textColor = 0xffffff;
			enemyCharacter.textToUse = textarray[FlxG.random.int(0, textarray.length - 1)];
        }
    });
}   
function getTime():Float{
    return 5;
}
