function create() {
	FlxG.sound.play(Paths.sound('attacksfx/train', 'battle'), .7);

	var statNum:Int = 2;

	if (effectiveness >= .80) statNum += 1;
	if (effectiveness >= .95) statNum += 1;
	if (effectiveness >= .97) statNum += 1;

	characterArray[allyTurn].trainedFocus = statNum;
    
	var attackanim:AttackAnimation = new AttackAnimation(enemyCharacter, 'train', 20, camGame, true, allyTurn);
	add(attackanim);

	attackanim.alpha = 0;
	FlxTween.tween(attackanim, {alpha: 1}, .3, {ease: FlxEase.quartInOut});

	attackanim.x += 20;
}   

function getTime():Float{
    return 1.5;
}
