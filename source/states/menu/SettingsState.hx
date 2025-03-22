package states.menu;

class SettingsState extends OcrpgState
{
	var bg:MenuBackground;

	var optionTexts:FlxTypedGroup<MenuText>;
	var descriptionText:FlxText;

	var curSelected:Int = 0;

	var selected:Bool = true;

	var textDataArray:Array<Array<String>>;

	override public function create()
	{
		persistentUpdate = true;

		textDataArray = loadTextDataArray();

		FlxG.sound.playMusic(Paths.music('options', 'menu'), 0);
		FlxG.sound.music.fadeIn(1, 0, .7);

		bg = new MenuBackground('mainmenu');
		add(bg);

		descriptionText = new FlxText(FlxG.width - 300, 0, 300, 'placeholder');
		descriptionText.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, RIGHT);
		descriptionText.antialiasing = SaveData.settings.get('antiAliasing');
        descriptionText.screenCenter(Y);
		add(descriptionText);

		optionTexts = new FlxTypedGroup<MenuText>();
		add(optionTexts);

		for (i in 0...textDataArray.length)
		{
			var text:MenuText = new MenuText(10, 0, textDataArray[i][0]);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, LEFT);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.ID = i;
			optionTexts.add(text);
		}

		changeSelection();

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			selected = false;
		});

		super.init('wipe', 1, 'custom', 'In The Menus', 'Settings Menu');
	}

	override public function update(elapsed:Float)
	{
		if (!selected)
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
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
				makeSelection();
			}
		}
        
		super.update(elapsed);
	}

	function changeSelection(?num:Int = 0):Void
	{
		curSelected += num;

		if (curSelected >= textDataArray.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = textDataArray.length - 1;

		var bullShit:Int = 0;

		optionTexts.forEachAlive(function(spr:MenuText)
		{
			spr.targetY = bullShit - curSelected;
			bullShit++;

			if (textDataArray[spr.ID][0] != textDataArray[curSelected][0])
			{
				spr.alpha = 0.5;
				spr.targetX = 5;
				spr.text = getTextName(textDataArray[spr.ID][0], spr.ID);
			}
			else
			{
				spr.alpha = 1;
				spr.targetX = 35;
				spr.text = '> ' + getTextName(textDataArray[spr.ID][0], spr.ID);
			}
		});

        descriptionText.text = textDataArray[curSelected][2];
	}

    function makeSelection(){
        switch(textDataArray[curSelected][0]){
            case 'back':
                SaveData.save();

                selected = true;

				super.switchState(new MainMenuState(), 'wipe', 1, true);
            default:
				SaveData.settings.set(textDataArray[curSelected][0], !SaveData.settings.get(textDataArray[curSelected][0]));
				SaveData.updateSetting(textDataArray[curSelected][0]);
				updateSetting(textDataArray[curSelected][0]);
                changeSelection();
        }
    }

    function getTextName(optionName:String, id:Int):String{
        var name:String = '';

        if(optionName == 'back'){
            name = 'back';
        } else {
			if(SaveData.settings.get(optionName)) name = textDataArray[id][1] + ' (On)'; else name = textDataArray[id][1] + ' (Off)';
        }
        return name;
    }

	function loadTextDataArray():Array<Array<String>>{
		var returnThis:Array<Array<String>> = [];

		for (i in 0...SaveData.settingsList.length){
			returnThis.insert(returnThis.length, SaveData.settingsList[i]);
		}

		returnThis.insert(returnThis.length, ['back', 'back', 'Go back.']);

		return returnThis;
	}

	function updateSetting(name:String){
		switch(name){
			case 'momMode':
				if(!SaveData.settings.get('momMode')){
					FlxG.sound.music.volume = .7;
				}
		}
	}
}