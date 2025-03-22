function create() {
	if(!characterArray[allyTurnOpposite].isDead && characterArray[allyTurnOpposite].healthPercent != 100){
		FlxG.sound.play(Paths.sound('attacksfx/moralSupport', 'battle'), .7);

		var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurnOpposite], 'support', 20, camHud, false, allyTurn);
		add(attackanim);

		var healthToHeal:Int = FlxG.random.int(25,28);
		healthToHeal = Std.int(healthToHeal * effectiveness);
		if (healthToHeal < 10) healthToHeal = 10;
		if(effectiveness >= .98) healthToHeal = Std.int(healthToHeal += 10);

		characterArray[allyTurnOpposite].heal(healthToHeal);
	} else {
		FlxG.sound.play(Paths.sound('attacksfx/what', 'battle'), .7);

		var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurnOpposite], 'what', 20, camHud, false, allyTurn, .8);
		add(attackanim);
	}

}   

function getTime():Float{
    return 2;
}
