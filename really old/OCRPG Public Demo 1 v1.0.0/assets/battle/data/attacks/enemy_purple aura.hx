function create() {
	FlxG.sound.play(Paths.sound('attacksfx/aura', 'battle'), .7);

	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'aura', 20, camGame, false, allyTurn);
	add(attackanim);

	PlayState.bossComaPurpleAuraActive = true;
}   

function getTime():Float{
    return 2;
}
