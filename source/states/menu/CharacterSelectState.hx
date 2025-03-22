package states.menu;

/**
 * A menu used to switch the characters
 * you have for battle.
 */
class CharacterSelectState extends OcrpgState
{
	var bg:MenuBackground;

	var topText:FlxText;
	var textTween:FlxTween;

	var biobubble:CharacterBioBubble;

	var hudGroup:FlxTypedGroup<Hud>;

    var curSelected:Int = 0;
    var controlAllowed:Bool = false;
    var characterSelectOption:Bool = false;

    var possibleChars:Array<String> = [];
	var optionTexts:FlxTypedGroup<FlxText>;
	var textDataArray:Array<String> = [];

	var moveText:FlxText;

    var charArray:Array<String> = [];
    public static var characterNumArray:Array<Int> = [0, 1];
    var maxNum:Int;

	var hud:Hud;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('charSelect', 'menu'), 0);
		FlxG.sound.music.fadeIn(1, 0, .5);

		possibleChars = loadMenuOptions('chars');
        charArray = loadMenuOptions('charsagain');
        textDataArray = loadMenuOptions('menu');

		maxNum = possibleChars.length;

		bg = new MenuBackground('mainmenu');
		add(bg);

		topText = new FlxText(0, 80, FlxG.width, 'SELECT YOUR CHARACTERS');
		topText.screenCenter(X);
		topText.setFormat(Paths.font("andy", 'global'), 55, FlxColor.WHITE, CENTER);
		topText.antialiasing = SaveData.settings.get('antiAliasing');
		topText.angle = -2;
		add(topText);

		textTween = FlxTween.angle(topText, topText.angle, 2, 3.5, {ease: FlxEase.quartInOut, type: PINGPONG});

		optionTexts = new FlxTypedGroup<FlxText>();
		add(optionTexts);

		for (i in 0...textDataArray.length)
		{
			var designatedY:Float = topText.y + topText.height + 25 + 65 * i + 1;

			var text:FlxText = new FlxText(0, designatedY, FlxG.width, textDataArray[i]);
			text.screenCenter(X);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, CENTER);
			text.antialiasing = SaveData.settings.get('antiAliasing');
            text.alpha = 0.5;
			text.ID = i;
			optionTexts.add(text);
		}

		hudGroup = new FlxTypedGroup<Hud>();
		add(hudGroup);

		moveText = new FlxText(0, 80, FlxG.width, '');
		moveText.screenCenter(X);
		moveText.setFormat(Paths.font("andy", 'global'), 30, FlxColor.WHITE, CENTER);
		moveText.antialiasing = SaveData.settings.get('antiAliasing');
		moveText.visible = false;
		add(moveText);

		biobubble = new CharacterBioBubble();
		add(biobubble);
		
		for(i in 0...2){
			setupAllyPortraits();	
		}

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			changeSelection(0, 'horizontal');
            changeSelection();

			controlAllowed = true;
		});

		super.init('wipe', 1, 'custom', 'In The Menus', 'Character Select Menu');
	}

	override public function update(elapsed:Float)
	{
		if (controlAllowed)
		{
			if(Controls.getControl('LEFT', 'RELEASE') && characterSelectOption)
			{
				changeSelection(-1, 'horizontal');
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('RIGHT', 'RELEASE') && characterSelectOption)
			{
				changeSelection(1, 'horizontal');
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('UP', 'RELEASE'))
			{
				changeSelection(-1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('DOWN', 'RELEASE'))
			{
				changeSelection(1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				makeSelection();
			}
		}

		super.update(elapsed);
	}

	function setupAllyPortraits(){
		if (hud != null){
			hud.destroy();
			Paths.clearUnusedMemory();
		}
		
		hud = new Hud();
		hud.initializeGroups();
		hud.initializeBottomSprites();
		hud.allyHpBars.visible = false;
		hud.motivationBar.visible = false;
		hud.motivationBarOutline.visible = false;
		hudGroup.add(hud);
	}

	function changeSelection(?num:Int = 0, ?type:String = ''):Void
	{
        switch(type){
            case 'horizontal':
				characterNumArray[curSelected] += num;
                
				if (characterNumArray[curSelected] >= maxNum)
					characterNumArray[curSelected] = 0;
				if (characterNumArray[curSelected] < 0)
					characterNumArray[curSelected] = maxNum - 1;

				charArray[curSelected] = possibleChars[characterNumArray[curSelected]];

				Battle.partyCharacters = charArray;

				textDataArray[curSelected] = charArray[curSelected];

				hud.setupAlly(curSelected);
				biobubble.updateText(hud.characterArray[curSelected]);
				changeSelection();
            default:
				curSelected += num;

				if (curSelected >= textDataArray.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = textDataArray.length - 1;

				if (textDataArray[curSelected] != 'back')
				{
					characterSelectOption = true;

					moveText.visible = true;
					moveText.text = '- Moves -\n' + hud.characterArray[curSelected].moveList[0] + ', ' + hud.characterArray[curSelected].moveList[1] + ', '  + hud.characterArray[curSelected].moveList[2] + ', '  + hud.characterArray[curSelected].moveList[3];
					moveText.y = FlxG.height - moveText.height;

					biobubble.visible = true;
					biobubble.updateText(hud.characterArray[curSelected]);
				}
				else
				{
					characterSelectOption = false;

					moveText.visible = false;
					biobubble.visible = false;
				}

				optionTexts.forEach(function(spr:FlxText)
				{
					spr.text = textDataArray[spr.ID];

					if (spr.ID != curSelected)
					{
						spr.alpha = 0.5;
					}
					else
					{
						spr.alpha = 1;

						if (characterSelectOption)
						{
							spr.text = '< ' + textDataArray[spr.ID] + ' >';
						}
					}

					spr.screenCenter(X);
				});
        }
		
	}

	function makeSelection():Void
	{
		switch (textDataArray[curSelected])
		{
			case 'back':
				SaveData.savedCharacterNums = characterNumArray;
				SaveData.save();
				
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);

                controlAllowed = false;

				super.switchState(new MainMenuState(), 'wipe', 1, true);
		}
	}

    function loadMenuOptions(type:String):Array<String>{
        var sendThis:Array<String> = [];

        switch(type){
            case 'menu':
				for (i in 0...2)
				{
					sendThis.insert(sendThis.length, charArray[i]);
				}
                sendThis.insert(sendThis.length, 'back');
			case 'chars':
				var data = Utilities.dataFromTextFile(Paths.txt('allyData', 'battle'));

				for (i in 0...data.length)
				{   
					var stuff:Array<String> = data[i].split(":");

					sendThis.insert(sendThis.length, stuff[0]);
				}
            case 'charsagain':
				sendThis = [possibleChars[characterNumArray[0]], possibleChars[characterNumArray[1]]];
        }

        return sendThis;
    }
}
