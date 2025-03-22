package states.menu;
/**
 * A menu for selecting which
 * gauntlet of levels to play.
 */
class GauntletSelectState extends OcrpgState
{
	var bg:FlxBackdrop;
    var gauntletText:FlxText;
	var gauntletSprites:FlxTypedGroup<GauntletSprite>;
    var completionDisplay:BossCompletionChecker;

	var menuSprites:FlxTypedGroup<FlxSprite>;

    var textDataArray:Array<String>;

    public static var curSelected:Int = 0;

    var canSelect:Bool = false;
	var submenuOpen:Bool = false;

	var doSave:Bool = false;

	public function new(?savename:Bool = false){
		super();

		doSave = savename;
	}

	override public function create()
	{
		if (doSave) Battle.saveGauntletAllyCompletion();
		
		persistentUpdate = true;
		
		FlxG.sound.playMusic(Paths.music('gauntlet', 'menu'), 0);
		FlxG.sound.music.fadeIn(2, 0, .2);

		textDataArray = Battle.getCharacterList('gauntlet');

		bg = new FlxBackdrop(Paths.image('gauntletSelect/bg', 'menu'));
		bg.velocity.set(-10, 10);
		bg.alpha = 0.3;
		add(bg);

		gauntletSprites = new FlxTypedGroup<GauntletSprite>();
		add(gauntletSprites);

        for(i in 0...textDataArray.length){
			var gSprite = new GauntletSprite(textDataArray[i]);
            gSprite.ID = i;
			gauntletSprites.add(gSprite);
        }

		gauntletText = new FlxText(15, 30, 0, '');
		gauntletText.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, LEFT);
		gauntletText.antialiasing = SaveData.settings.get('antiAliasing');
		add(gauntletText);

		changeSelection();

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			canSelect = true;
		});

		menuSprites = new FlxTypedGroup<FlxSprite>();
		add(menuSprites);

		super.init('fade', 2, 'custom', 'In The Menus', 'Gauntlet Select');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canSelect)
		{
			if (Controls.getControl('LEFT', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(-1);
			}
			if (Controls.getControl('RIGHT', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(1);
			}
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
				openGauntletMenu();
			}
			if (Controls.getControl('BACK', 'RELEASE'))
			{
				canSelect = false;
				super.switchState(new MainMenuState(), 'fade', 1, true);
			}
		} else if(submenuOpen){
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				canSelect = false;
				FlxG.sound.play(Paths.sound('gauntletStart', 'menu'), 1.3);
				super.switchState(new GauntletState('start', textDataArray[curSelected]), 'battle', 1, true);
			}
			if (Controls.getControl('BACK', 'RELEASE'))
			{
				closeGuantletMenu();
			}
		}
	}

	function changeSelection(?num:Int = 0):Void
	{        
		curSelected += num;

		if (curSelected >= textDataArray.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = textDataArray.length - 1;

		var bullShit:Int = 0;

		gauntletSprites.forEachAlive(function(spr:GauntletSprite)
		{
			spr.targetX = bullShit - curSelected;
			bullShit++;

			if (spr.ID != curSelected)
			{
				spr.alpha = 0.5;
			}
			else
			{
				spr.alpha = 1;
			}
		});

		gauntletText.text = Battle.getVanityName(textDataArray[curSelected], 'gauntlet');

		if (completionDisplay != null) completionDisplay.destroy();

		completionDisplay = new BossCompletionChecker('gauntlet', gauntletText, textDataArray[curSelected]);
        add(completionDisplay);

    }

	function openGauntletMenu():Void{
		submenuOpen = true;
		canSelect = false;

		var menubg = new FlxSprite().makeGraphic(FlxG.width, 300, FlxColor.BLACK);
		menubg.alpha = 0.6;
		menubg.setPosition(0, FlxG.height - menubg.height);
		menuSprites.add(menubg);

		var battleTitleText:FlxText = new FlxText(0, menubg.y + 10, 0, 'Battles');
		battleTitleText.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, CENTER);
		battleTitleText.antialiasing = SaveData.settings.get('antiAliasing');
		battleTitleText.screenCenter(X);
		menuSprites.add(battleTitleText);

		var battleText:FlxText = new FlxText(0, battleTitleText.y + battleTitleText.height + 30, 0, '');
		battleText.setFormat(Paths.font("andy", 'global'), 30, FlxColor.WHITE, CENTER);
		battleText.antialiasing = SaveData.settings.get('antiAliasing');
		menuSprites.add(battleText);

		var dataArray:Array<String> = getLevelList(textDataArray[curSelected]);

		for(i in 0...dataArray.length){
			if(Battle.checkCharacterValue('isBoss', dataArray[i])) battleText.text += '^';
			battleText.text += Battle.getVanityName(dataArray[i], 'enemy');
			if(i != dataArray.length - 1) battleText.text += ', ';
			if (Battle.checkCharacterValue('isBoss', dataArray[i])) battleText.text += '^';
		}

		battleText.applyMarkup(battleText.text, [
			new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.RED), "^"),
		]);
		
		battleText.screenCenter(X);
	}

	function closeGuantletMenu():Void
	{
		submenuOpen = false;
		canSelect = true;

		menuSprites.forEach(function(spr:FlxSprite){
			spr.destroy();
		});
	}

	function getLevelList(name:String):Array<String>{
		var returnThis:Array<String> = [];

		var data = Utilities.dataFromTextFile(Paths.txt('gauntlet/' + name, 'menu'));

		for (i in 0...data.length)
		{
			var stuff:Array<String> = data[i].split(":");

			returnThis.push(stuff[0]);
		}

		return returnThis;
	}
}