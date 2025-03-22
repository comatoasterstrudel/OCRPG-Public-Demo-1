package states.menu;

class CreditsState extends OcrpgState
{
	var bg:FlxSprite;

	var curSelected:Int = 0;

	var selected:Bool = true;

	var creditData = Utilities.dataFromTextFile(Paths.txt('creditsList', 'menu'));
	var optionTexts:FlxTypedGroup<MenuText>;

    var extraText:FlxText;
    var characterSprite:FlxSprite;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('credits', 'menu'), 0);
		FlxG.sound.music.fadeIn(1, 0, .7);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		optionTexts = new FlxTypedGroup<MenuText>();
		add(optionTexts);

		for (i in 0...creditData.length)
		{
			var stuff:Array<String> = creditData[i].split(":");

			var text:MenuText = new MenuText(10, 10, stuff[0]);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, LEFT);
			text.antialiasing = SaveData.settings.get('antiAliasing');
            text.alpha = 0.5;
			text.ID = i;
			optionTexts.add(text);
		}

		changeSelection();
        
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			selected = false;
		});

		super.init('wipe', 1, 'custom', 'In The Menus', 'Credits Menu');
	}

	override public function update(elapsed:Float)
	{
		if (!selected && !DialogueSubstate.dialogueActive)
		{
			if (Controls.getControl('UP', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(-1);
			}
			if (Controls.getControl('DOWN', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(1);
			}
			if (Controls.getControl('BACK', 'RELEASE'))
			{
				leave();
			}
		}

		super.update(elapsed);
	}

	function changeSelection(?num:Int = 0):Void
	{
		curSelected += num;

		if (curSelected >= creditData.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = creditData.length - 1;

		var bullShit = 0;

		optionTexts.forEach(function(spr:MenuText)
		{
			spr.targetY = bullShit - curSelected;
			bullShit++;

			if (creditData[spr.ID] != creditData[curSelected])
			{
				spr.alpha = 0.5;
                spr.targetX = 5;
			}
			else
			{
				spr.alpha = 1;
				spr.targetX = 35;
			}
		});

		makeSpritesStuff();
	}

	function leave():Void{
        selected = true;

		super.switchState(new MainMenuState(), 'wipe', 1, true);
	}

    function makeSpritesStuff():Void{
        if(characterSprite != null) characterSprite.destroy();
		if (extraText != null)
			extraText.destroy();

		var stuff:Array<String> = creditData[curSelected].split(":");

        characterSprite = new FlxSprite();
        characterSprite.frames = Paths.getSparrowAtlas('creditMenu/credSprite_' + stuff[3], 'menu');
        characterSprite.animation.addByPrefix('idle', 'idle', 3);
        characterSprite.animation.play('idle');
        characterSprite.setGraphicSize(Std.int(characterSprite.width * .4));
        characterSprite.updateHitbox();
		characterSprite.setPosition(FlxG.width - characterSprite.width, FlxG.height - characterSprite.height);
        add(characterSprite);

		extraText = new FlxText(0, 0, characterSprite.width, stuff[1] + '\n\n"' + stuff[2] + '"');
		extraText.setFormat(Paths.font("andy", 'global'), 30, FlxColor.WHITE, CENTER);
        extraText.setPosition(characterSprite.x + characterSprite.width / 2 - extraText.width / 2, 40);
		extraText.antialiasing = SaveData.settings.get('antiAliasing');
		add(extraText);
    }
}