function create() {
	FlxG.sound.play(Paths.sound('attacksfx/aura', 'battle'), .7);

	for (i in 0...2){
		if (!characterArray[i].isDead){
			var attackanim:AttackAnimation = new AttackAnimation(characterArray[i], 'aura', 20, camHud, false, allyTurn);
			add(attackanim);
		}
	}

	var additive:Float = .5;
	additive = additive * effectiveness;
	if(additive <= .1) additive = .1;
	if(effectiveness >= .98) additive = .7;

	PlayState.comaPurpleAuraActive = true;
	PlayState.comaPurpleAuraMult = 1 + additive;
}   

function getTime():Float{
    return 2;
}
