var cutsceneSeen:Bool = false;
var fallSprite:FlxSprite;

function create(){
	initializeBackgroundSprite('slimefall');
    initializeEnemyCharacter('googly', false);

    camHud.visible = false;
}

function createPost(){
	Utilities.changeGameDetails('custom', 'In Game', Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ' VS Googly... again?');

}

function battleStart(){
	fallSprite = new FlxSprite().loadGraphic(Paths.image('bossspecific/war/warFallSprite', 'battle'));
	fallSprite.setGraphicSize(Std.int(fallSprite.width * .5));
	fallSprite.updateHitbox();
	fallSprite.setPosition(FlxG.width / 2 - fallSprite.width / 2, -fallSprite.height);
	fallSprite.cameras = [camGame];
	fallSprite.antialiasing = SaveData.settings.get('antiAliasing');
	add(fallSprite);

	FlxTween.tween(fallSprite, {y: FlxG.height / 2 - fallSprite.height / 2}, 19, {onComplete: function(FlxTwn):Void{
			cutsceneSeen = true;

			camTop.flash(0xFFFFFFFF, 2);
			camHud.visible = true;

			fallSprite.destroy();

			changeExternalVar('movesSelectable', 0, 0, true);

			initializeBackgroundSprite('war');
			initializeEnemyCharacter('war', false);
			initializeEnemyHealthBar(getEnemyCharacter());

			Utilities.changeGameDetails('custom', 'In Game', Battle.getVanityName(Battle.partyCharacters[0], 'ally') + ' and ' + Battle.getVanityName(Battle.partyCharacters[1], 'ally') + ' VS ' + Battle.getVanityName(Battle.enemyCharacterName, 'enemy'));

    }});

}

function update(elapsed:Float){
	if (!cutsceneSeen) changeExternalVar('movesSelectable', 0, 0, false);
}

function winBattle(){
	if (FlxG.random.bool(2))
		FlxG.sound.play(Paths.sound('screamer/googlyDies', 'battle'), 1);
}