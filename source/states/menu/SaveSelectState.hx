package states.menu;

class SaveSelectState extends OcrpgState
{
	var bg:FlxSprite;

    var counter:FlxSprite;
    var sign:FlxSprite;
    var saveboy:SaveBoy;
	
	var buttonPromptText:FlxText;

    var optionTexts:FlxTypedGroup<MenuText>;

    var curSelected:Int = 0;
    var maxSaves:Int = 5;

    var selected:Bool = true;

    var diaInitialized:Bool = false;
    var diaFirstSeen:Bool = false;
    var diaArray:Array<String> = [];
    var diaSeen:Array<String> = [];

	override public function create()
	{
		persistentUpdate = true;

		#if !debug
		if(!SaveData.seenInstructions){
			super.switchState(new InstructionState(), 'none', 0, false, 0);
			return;
		}
		#end

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		optionTexts = new FlxTypedGroup<MenuText>();
		add(optionTexts);

		counter = new FlxSprite().loadGraphic(Paths.image('saveSelect/counter', 'menu'));
		counter.setGraphicSize(Std.int(FlxG.width));
		counter.updateHitbox();
		counter.screenCenter(X);
		counter.antialiasing = SaveData.settings.get('antiAliasing');
		add(counter);
    
		buttonPromptText = new FlxText(0, 10, 0, Controls.replaceStringControlName('Press {BACK} to Reset this Save Slot\nPress {EXTRAONE} to talk to Saveboy\nPress {EXTRATWO} to read the Instructions'));
		buttonPromptText.setFormat(Paths.font("andy", 'global'), 25, FlxColor.WHITE, RIGHT);
		buttonPromptText.antialiasing = SaveData.settings.get('antiAliasing');
		buttonPromptText.setPosition(FlxG.width - buttonPromptText.width - 10, 10);
		add(buttonPromptText);

		sign = new FlxSprite(30, 0).loadGraphic(Paths.image('saveSelect/sign', 'menu'));
		sign.setGraphicSize(Std.int(sign.width * .55));
		sign.updateHitbox();
		sign.antialiasing = SaveData.settings.get('antiAliasing');
		add(sign);
		FlxTween.tween(sign, {x: sign.x - 20}, 3.5, {ease: FlxEase.quartInOut, type: PINGPONG});

		saveboy = new SaveBoy(maxSaves);
		saveboy.setPosition(FlxG.width / 2 - saveboy.width / 2, counter.y + counter.height - saveboy.height - 10);
		add(saveboy);

		for (i in 0...maxSaves) {
			var num:Int = i + 1;
			var text:MenuText = new MenuText(10, FlxG.height - 70, 'Save Slot ' + num, 'save');
			text.setFormat(Paths.font("andy", 'global'), 50, FlxColor.WHITE, CENTER);
			text.targetX = FlxG.width / 2 - text.width / 2;
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.ID = i;
			optionTexts.add(text);
		}

		var blackbg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackbg);

		changeSelection();

		new FlxTimer().start(.7, function(tmr:FlxTimer)
		{
            selected = false;

			blackbg.destroy();

			FlxG.sound.playMusic(Paths.music('saveboy', 'menu'), 0);
            FlxG.sound.music.fadeIn(1.5, 0, .6);
		});

		super.init('tv', .7, 'custom', 'In The Menus', 'SaveBoy Incorporated');
	}

	override public function update(elapsed:Float)
	{
		if (!selected && !DialogueSubstate.dialogueActive)
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
				makeSelection();
			}
			if (Controls.getControl('BACK', 'RELEASE')){
				resetSave();
			}
			if (Controls.getControl('EXTRAONE', 'RELEASE')){
				startDialogue();
            }
			if (Controls.getControl('EXTRATWO', 'RELEASE')){
				selected = true;
				super.switchState(new InstructionState(), 'fade', 1.5, true, 0);
            }
		}

		super.update(elapsed);
	}

	function changeSelection(?num:Int = 0):Void
	{
		curSelected += num;

		if (curSelected >= maxSaves)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = maxSaves - 1;

		saveboy.doAnimByNumber('idle', curSelected);

		var bullShit:Int = 0;

		optionTexts.forEachAlive(function(spr:MenuText)
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
	}

	function makeSelection():Void{
		SaveData.initializeSaveFile(curSelected + 1);
		SaveData.load();
		
		selected = true;

		optionTexts.forEachAlive(function(spr:MenuText)
		{
			if (spr.ID != curSelected)
			{
				FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
			}
			else
			{
				spr.alpha = 1;
			}
		});

		super.switchState(new MainMenuState(), 'fade', 4, true);
	}

	function resetSave():Void{
		selected = true;

		var trueSelected:Int = curSelected + 1;

		openSubState(new DecisionSubstate('Are you sure you want to reset Save Slot ' + trueSelected + '?', ['Yes', 'No'], [function():Void{
			saveboy.doDeleteAnim(1.5, function():Void
			{
				selected = false;
				saveboy.doAnimByNumber('idle', curSelected);
			});

			SaveData.resetSaveFile(curSelected + 1);
		}, function():Void{
			selected = false;
		}]));
	}

    function startDialogue():Void{
        if(!diaInitialized){
			diaArray = Utilities.findFilesInPath('assets/dialogue/data/dialogue/saveboy/random/', ['.txt']);

			for (i in 0...diaArray.length)
			{
				if (StringTools.endsWith(diaArray[i], '.txt'))
				{
					diaArray[i] = diaArray[i].split('.txt')[0];
				}
				if (StringTools.startsWith(diaArray[i], 'dia_'))
				{
					diaArray[i] = diaArray[i].split('dia_')[1];
				}
			}

            diaInitialized = true;
        }

        var diaToPlay:String;
        var folderToPlay:String;

        if(!diaFirstSeen){
            diaToPlay = 'sb_intro';
			folderToPlay = 'saveboy';
            diaFirstSeen = true;
        } else{
            diaToPlay = pickDialogueLine(0);
			folderToPlay = pickDialogueLine(1);
        }

		saveboy.doAnimByNumber('talk', curSelected);

		openSubState(new DialogueSubstate(diaToPlay, folderToPlay, function():Void{
			changeSelection();
		}));
    }

    function pickDialogueLine(type:Int):String{
        var diaToPlay:String;
		var folderToPlay:String;

		diaToPlay = diaArray[FlxG.random.int(0, diaArray.length - 1)];

        var isRepeat:Bool = false;

        for(i in 0...diaSeen.length){
            if(diaToPlay == diaSeen[i]) isRepeat = true;
        }

        if(diaSeen.length == diaArray.length){
            diaToPlay = 'sb_exhausted';
			folderToPlay = 'saveboy';
        } else {
			folderToPlay = 'saveboy/random';
            if(isRepeat){
				if (type == 0) diaToPlay = pickDialogueLine(0);
			} else {
				if(type == 0) diaSeen.push(diaToPlay);
			}
        }

		if (type == 0) return diaToPlay; else return folderToPlay;
    }
}