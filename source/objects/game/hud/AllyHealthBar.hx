package objects.game.hud;

class AllyHealthBar extends FlxTypedGroup<FlxSprite>
{
    //data
    
    var hud:Hud;

	public var hpBarBgArray:Array<FlxSprite> = [];
	public var hpBarArray:Array<FlxBar> = [];
    public var hpTextArray:Array<FlxText> = [];

	public function new(coolhud:Hud)
	{
		super();

		hud = coolhud;

		for (i in 0...2)
		{
			var hpBarBG = new FlxSprite().loadGraphic(Paths.image('ui/hpBar', 'battle'));
			hpBarBG.setGraphicSize(Std.int(hpBarBG.width * .85));
			hpBarBG.updateHitbox();
			hpBarBG.setPosition(hud.characterArray[i].x + hud.characterArray[i].width / 2 - hpBarBG.width / 2, hud.bottomBar.y + 50);
			hpBarBG.antialiasing = SaveData.settings.get('antiAliasing');

			var hpText = new FlxText(0, 80, 0, 'test');
			hpText.setFormat(Paths.font("andy", 'global'), 25, Std.parseInt('0xFF' + Utilities.grabThingFromText(Battle.partyCharacters[i], Paths.txt('allyData', 'battle'), 7)), CENTER);
			hpText.antialiasing = SaveData.settings.get('antiAliasing');
			hpText.y = hpBarBG.y + hpBarBG.height / 2 - hpText.height - 5;

            hpBarBgArray.push(hpBarBG);
			hpTextArray.push(hpText);

			if (i == 0)
			{
				var hpBar:FlxBar = new FlxBar(hpBarBG.x + 4, hpBarBG.y + 4, LEFT_TO_RIGHT, Std.int(hpBarBG.width - 8), Std.int(hpBarBG.height - 8), hud.characterArray[i], 'hplerp', 0, hud.characterArray[i].maxhp);
				hpBar.createFilledBar(Battle.depletedHealthColor, Std.parseInt('0xFF' + Utilities.grabThingFromText(Battle.partyCharacters[0], Paths.txt('allyData', 'battle'), 7)));
				hpBar.updateBar();
				hpBar.numDivisions = Std.int(hpBar.width);
                
				hpBarArray.push(hpBar);

				add(hpBar);
				add(hpBarBG);
				add(hpText);
			}
			else if (i == 1)
			{
				var hpBar:FlxBar = new FlxBar(hpBarBG.x + 4, hpBarBG.y + 4, LEFT_TO_RIGHT, Std.int(hpBarBG.width - 8), Std.int(hpBarBG.height - 8), hud.characterArray[i], 'hplerp', 0, hud.characterArray[i].maxhp);
				hpBar.createFilledBar(Battle.depletedHealthColor, Std.parseInt('0xFF' + Utilities.grabThingFromText(Battle.partyCharacters[1], Paths.txt('allyData', 'battle'), 7)));
				hpBar.updateBar();
				hpBar.numDivisions = Std.int(hpBar.width);
				
				hpBarArray.push(hpBar);

				add(hpBar);
				add(hpBarBG);
				add(hpText);
			}
		}
	}

    public function updateText(elapsed:Float):Void{
        for(i in 0...hpTextArray.length){
            hpTextArray[i].text = hud.characterArray[i].hp + ' / ' + hud.characterArray[i].maxhp;
			hpTextArray[i].x = hud.characterArray[i].x + hud.characterArray[i].width / 2 - hpTextArray[i].width / 2;
			hpTextArray[i].angle = FlxMath.lerp(0, hpTextArray[i].angle, Utilities.boundTo(1 - (elapsed * 15), 0, 1));
        }
    }

    public function move(type:String):Void{
        switch(type){
            case 'up':
				for (i in 0...2)
				{
					FlxTween.tween(hpBarBgArray[i], {y: hpBarBgArray[i].y - 230}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(hpBarArray[i], {y: hpBarArray[i].y - 230}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(hpTextArray[i], {y: hpTextArray[i].y - 175}, .5, {ease: FlxEase.quartInOut});
                }
            case 'down':
				for (i in 0...2)
				{
					FlxTween.tween(hpBarBgArray[i], {y: hpBarBgArray[i].y + 230}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(hpBarArray[i], {y: hpBarArray[i].y + 230}, .5, {ease: FlxEase.quartInOut});
					FlxTween.tween(hpTextArray[i], {y: hpTextArray[i].y + 175}, .5, {ease: FlxEase.quartInOut});
				}
        }
    }
}