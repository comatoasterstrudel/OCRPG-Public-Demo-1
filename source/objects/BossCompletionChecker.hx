package objects;

class BossCompletionChecker extends FlxTypedGroup<FlxSprite>
{	
	public var targetY:Float = 0;
	public var targetX:Float = 0;

	var menuText:FlxSprite;

	public function new(type:String, menuTextNew:FlxSprite, enemyName:String)
	{
		super();

		menuText = menuTextNew;

		var characterList:Array<String> = Battle.getCharacterList('ally');

		for (i in 0...characterList.length){
			var sprite:CharacterIcon = new CharacterIcon('ally', characterList[i], .3);
			sprite.updateHitbox();
			sprite.setPosition(menuText.x + menuText.width + 20, menuText.y + menuText.height / 2 - sprite.height / 2);
			sprite.ID = i;
			add(sprite);

			switch(type){
				case 'boss':
					if (!Battle.checkBossAllyCompletion(enemyName, characterList[i]))
					{
						sprite.color = FlxColor.BLACK;
					}
				case 'gauntlet':
					if (!Battle.checkGauntletAllyCompletion(enemyName, characterList[i]))
					{
						sprite.color = FlxColor.BLACK;
					}
			}

		}
    }

	override function update(elapsed:Float)
	{
		forEach(function(spr:FlxSprite):Void{
			targetX = menuText.x + menuText.width + 20;
			targetY = menuText.y + menuText.height / 2 - spr.height / 2;

			targetX += 85 * spr.ID;

			spr.x = FlxMath.lerp(spr.x, (targetX), Utilities.boundTo(elapsed * 10.2, .3, 1));
			spr.y = FlxMath.lerp(spr.y, (targetY), Utilities.boundTo(elapsed * 10.2, .55, 1));
		});

		super.update(elapsed);
	}
}