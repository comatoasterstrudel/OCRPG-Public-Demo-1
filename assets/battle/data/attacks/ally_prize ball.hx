var max:Int = 5;

function create() {
	FlxG.sound.play(Paths.sound('attacksfx/capsule', 'battle'), 1.3);
	
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'prize', 17, camGame, false, allyTurn, .55);
    attackanim.y = FlxG.height / 2 - attackanim.height + 150;
	add(attackanim);

	new FlxTimer().start(2, function(tmr:FlxTimer) {
		randomEffect(FlxG.random.int(0, max));
    });
}   

function randomEffect(type:Int):Void{
    switch(type){
        case 0: //buff both allys
			changeStatAlly(characterArray[0], 1, true);
			changeStatAlly(characterArray[1], 1, false);
        case 1: //debuff both allys
			changeStatAlly(characterArray[0], -1, true);
			changeStatAlly(characterArray[1], -1, false);
        case 2: //buff random ally
			changeStatAlly(characterArray[FlxG.random.int(0, 1)], 1, true);
        case 3: //debuff random ally
			changeStatAlly(characterArray[FlxG.random.int(0, 1)], -1, true);
        case 4: //buff enemy
			changeStatEnemy(1, true);
        case 5: //debuff enemy
			changeStatEnemy(-1, true);
    }
}

function getTime():Float{
    return 4;
}
