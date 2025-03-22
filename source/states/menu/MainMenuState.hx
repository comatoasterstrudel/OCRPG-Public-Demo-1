package states.menu;

/**
 * A menu that serves as the hud
 * between the rest of the menus and
 * game.
 */
class MainMenuState extends OcrpgState
{
	var camMain:FlxCamera;
	
	var bg:MenuBackground;
	
	var logo:FlxSprite;

	var optionTexts:FlxTypedGroup<MenuText>;
	var descriptionText:FlxText;

	var versionText:FlxText;

	var textDataArray:Array<String>;
	var smallTextDataArray:Array<String>;

	public static var menuOptionsGroup:String = 'main';
	public static var curSelected:Int = 0;
	var resetCurSelected:Bool = false;

	var selected:Bool = true;

	var bossCompletion:BossCompletionChecker;

	#if debug
	var extrabg:MenuBackground;
	#end

	override public function create()
	{
		persistentUpdate = true;
		
		FlxG.sound.playMusic(Paths.music('menu', 'menu'), 0);
		FlxG.sound.music.fadeIn(1, 0, .7);

		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain);

		bg = new MenuBackground();
		bg.cameras = [camMain];
		add(bg);

		logo = new FlxSprite().loadGraphic(Paths.image('gameLogo', 'menu'));
		logo.setGraphicSize(Std.int(logo.width * .35));
		logo.updateHitbox();
		logo.setPosition(FlxG.width - logo.width - 20, 0);
		logo.cameras = [camMain];
		logo.antialiasing = SaveData.settings.get('antiAliasing');
		add(logo);

		descriptionText = new FlxText(logo.x, logo.y + logo.height, logo.width, '- Developer Note -\nplaceholder');
		descriptionText.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, CENTER);
		descriptionText.cameras = [camMain];
		descriptionText.antialiasing = SaveData.settings.get('antiAliasing');
		add(descriptionText);

		versionText = new FlxText(0, 0, FlxG.width, 'OCRPG ' + Main.versionString);
		versionText.setFormat(Paths.font("andy", 'global'), 15, FlxColor.WHITE, CENTER);
		versionText.setPosition(FlxG.width / 2 - versionText.width / 2, FlxG.height - versionText.height - 5);
		versionText.cameras = [camMain];
		versionText.antialiasing = SaveData.settings.get('antiAliasing');
		add(versionText);

		optionTexts = new FlxTypedGroup<MenuText>();
		optionTexts.cameras = [camMain];
		add(optionTexts);

		loadMenuItems(menuOptionsGroup);
		
		resetCurSelected = true;

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			selected = false;
		});
		
		super.init('fade', 1, 'custom', 'In The Menus', 'Main Menu');
	}

	override public function update(elapsed:Float)
	{
		if(!selected && !DialogueSubstate.dialogueActive){
			if (Controls.getControl('UP', 'RELEASE')){
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(-1);
			}
			if (Controls.getControl('DOWN', 'RELEASE')){
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(1);
			}
			if (Controls.getControl('ACCEPT', 'RELEASE')){
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
				makeSelection();
			}
			#if debug
			if(Controls.getControl('DEBUG', 'RELEASE')){
				if(extrabg == null){
					extrabg = new MenuBackground();
					add(extrabg);
				} else {
					extrabg.destroy();
					extrabg = null;
				}
			}
			#end
		}

		super.update(elapsed);
	}

	function changeSelection(?num:Int = 0):Void{
		if (bossCompletion != null) bossCompletion.destroy(); 

		curSelected += num;

		if(curSelected >= textDataArray.length) curSelected = 0;
		if(curSelected < 0) curSelected = textDataArray.length - 1;

		var bullShit:Int = 0;

		optionTexts.forEachAlive(function(spr:MenuText){
			spr.targetY = bullShit - curSelected;
			bullShit++;

			var stuff:Array<String> = textDataArray[spr.ID].split(":");

			switch(menuOptionsGroup){
				case 'freeplay':
					if(stuff[0] != 'back'){

						if (textDataArray[spr.ID] != textDataArray[curSelected])
						{
							spr.alpha = 0.5;
							spr.targetX = 5;
							spr.text = Battle.getVanityName(stuff[0], 'enemy').toLowerCase();
						}
						else
						{
							spr.alpha = 1;
							spr.targetX = 35;
							spr.text = '> ' + Battle.getVanityName(stuff[0], 'enemy').toLowerCase();

							descriptionText.text = smallTextDataArray[curSelected];

							bossCompletion = new BossCompletionChecker('boss', spr, textDataArray[spr.ID]);
							add(bossCompletion);
						}
					} else {
						if (textDataArray[spr.ID] != textDataArray[curSelected])
						{
							spr.alpha = 0.5;
							spr.targetX = 5;
							spr.text = stuff[0];
						}
						else
						{
							spr.alpha = 1;
							spr.targetX = 35;
							spr.text = '> ' + stuff[0];

							descriptionText.text = smallTextDataArray[curSelected];
						}
					}
				default:
					if (textDataArray[spr.ID] != textDataArray[curSelected]){
						spr.alpha = 0.5;
						spr.targetX = 5;
						spr.text = stuff[0];
					} else {
						spr.alpha = 1;
						spr.targetX = 35;
						spr.text = '> ' + stuff[0];

						descriptionText.text = smallTextDataArray[curSelected];
					}
			}
		});
	}

	function loadMenuItems(type:String):Void{
		loadMenuOptions(type);

		if(resetCurSelected) curSelected = 0;

		optionTexts.forEach(function(spr:FlxText)
		{	
			spr.destroy();
		});

		loadMenuOptions(type);

		for (i in 0...textDataArray.length)
		{
			var stuff:Array<String> = textDataArray[i].split(":");

			var text:MenuText = new MenuText(10, 0, stuff[0]);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, LEFT);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.ID = i;
			optionTexts.add(text);
		}

		changeSelection();
	}

	function loadMenuOptions(whattoload:String){
		menuOptionsGroup = whattoload;

		switch(menuOptionsGroup){
			case 'main':
				textDataArray = ['play', 'extras', 'credits', 'settings', 'quit'];
				smallTextDataArray = ['Play the game.', 'Look at some extra stuff that has absolutely nothing to do with the rest of the game.', 'See who made OCRPG.', 'Change how the game functions.', 'Leave the game.'];
			case 'play':
				textDataArray = ['gauntlets', 'freeplay', 'change characters', 'tutorial', 'back'];
				smallTextDataArray = ['Play a gauntlet of levels back to back.', 'Play any battle you want.', 'Change the characters you play as.', 'Learn How to Play.', 'Go Back.'];
			case 'extras':
				textDataArray = ['sound test', 'back'];
				smallTextDataArray = ['Listen to the sounds of OCRPG.', 'Go Back.'];
				//textDataArray = ['sound test', 'character bios', 'back'];
				//smallTextDataArray = ['Listen to the sounds of OCRPG.', 'Look at info about the OCRPG characters', 'Go Back.'];
			case 'freeplay':
				textDataArray = [];
				smallTextDataArray = [];

				var data = Utilities.dataFromTextFile(Paths.txt('menuBattleList', 'menu'));

				for (i in 0...data.length)
				{
					var stuff:Array<String> = data[i].split(":");

					textDataArray.insert(textDataArray.length, stuff[0]);
					smallTextDataArray.insert(smallTextDataArray.length, stuff[1]);
				}

				textDataArray.insert(textDataArray.length, 'back');
				smallTextDataArray.insert(smallTextDataArray.length, 'Go back');
		}
	}

	function makeSelection():Void{
		switch(menuOptionsGroup){
			case 'main':
				switch(textDataArray[curSelected]){
					case 'play':
						loadMenuItems('play');
					case 'settings':
						selected = true;

						super.switchState(new SettingsState(), 'wipe', 1, true);
					case 'extras':
						loadMenuItems('extras');
					case 'credits':
						selected = true;

						super.switchState(new CreditsState(), 'wipe', 1, true);
					case 'quit':
						selected = true;

						openSubState(new DecisionSubstate('What do you want to do?', ['Quit Game', 'Quit to Save Select Menu', 'Cancel'], [
							function():Void
							{
								Utilities.changeGameDetails('custom', 'Bye Bye!', 'See ya next time!');
								
								FlxG.sound.music.fadeOut(1.5, 0);

								var tran:ScreenTransition = new ScreenTransition('fade', 'out', 1.5, function():Void{
									Sys.exit(1);
								});
								add(tran);
							},
							function():Void
							{
								SaveData.restoreDefaultData();
								var tran:ScreenTransition = new ScreenTransition('fade', 'out', 1.5, function():Void
								{
									FlxG.switchState(new SaveSelectState());
								});
								add(tran);
							},
							function():Void
							{
								selected = false;
							}
						]));
				}
			case 'play':
				switch (textDataArray[curSelected])
				{
					case 'gauntlets':
						selected = true;

						super.switchState(new GauntletSelectState(), 'fade', 1, true);		
					case 'freeplay':
						loadMenuItems('freeplay');
					case 'change characters':
						selected = true;

						super.switchState(new CharacterSelectState(), 'wipe', 1, true);
					case 'tutorial':
						selected = true;

						openSubState(new DialogueSubstate('tut_intro', 'tutorial', function():Void
						{
							startBattle('tutorial');
						}));
					case 'back':
						loadMenuItems('main');
				}
			case 'extras':
				switch (textDataArray[curSelected])
				{
					case 'sound test':
						selected = true;

						super.switchState(new SoundTestState(), 'wipe', 1, true);
					case 'back':
						loadMenuItems('main');
				}
			case 'freeplay':
				switch (textDataArray[curSelected])
				{
					case 'back':
						loadMenuItems('play');
					default:
						selected = true;

						var stuff:Array<String> = textDataArray[curSelected].split(":");

						startBattle(stuff[0]);
				}
		}
	}

	function startBattle(name:String):Void{
		Battle.loadBattle(name);

		super.switchState(new BattleSplashScreenState('intro', new PlayState()), 'fade', 1, true);
	}
}
