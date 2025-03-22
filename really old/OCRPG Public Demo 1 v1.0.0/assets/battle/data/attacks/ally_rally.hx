function create() {
	FlxG.sound.play(Paths.sound('attacksfx/rally', 'battle'), .7);

	if (characterArray[allyTurnOpposite].isDead){ // revive other ally
		var healthToHeal:Int = Std.int(characterArray[allyTurnOpposite].maxHp / FlxG.random.float(3, 5));
		healthToHeal = Std.int(healthToHeal * effectiveness);
		if(healthToHeal <= 0) healthToHeal = 1; 
		if (effectiveness >= .98) healthToHeal = Std.int(healthToHeal * 1.5);

		characterArray[allyTurnOpposite].restore(healthToHeal, false);

		var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurnOpposite], 'rally', 20, camHud, false, allyTurn, .7);
		add(attackanim);
	}
	else{ // heal self
		characterArray[allyTurn].isStunned = true;

		var healthToHeal = FlxG.random.int(40, 42);
		healthToHeal = Std.int(healthToHeal * effectiveness);
		if (healthToHeal <= 10) healthToHeal = 10;
		if (effectiveness >= .98) healthToHeal = Std.int(healthToHeal += 10);
		
		characterArray[allyTurn].heal(healthToHeal);

		var attackanim:AttackAnimation = new AttackAnimation(characterArray[allyTurn], 'rally', 20, camHud, false, allyTurn, .7);
		add(attackanim);
	}
}   

function getTime():Float{
    return 2;
}