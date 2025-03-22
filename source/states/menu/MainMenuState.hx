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
	
	var logo:GameLogo;
	var nameText:FlxText;

	var versionText:FlxText;

	var textDataArray:Array<String>;
	var smallTextDataArray:Array<String>;

	public static var menuOptionsGroup:String = 'main';
	public static var curSelected:Int = 0;
	var resetCurSelected:Bool = false;

	var spriteGroup:FlxTypedGroup<MainMenuButton>;

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

		bg = new MenuBackground('mainmenu');
		bg.cameras = [camMain];
		add(bg);

		logo = new GameLogo();
		logo.screenCenter(X);
		logo.y = -10;
		logo.cameras = [camMain];
		add(logo);

		nameText = new FlxText(0, logo.y + logo.height / 1.1, FlxG.width, '');
		nameText.y -= 20;
		nameText.setFormat(Paths.font("andy", 'global'), 50, FlxColor.WHITE, CENTER);
		nameText.cameras = [camMain];
		nameText.antialiasing = SaveData.settings.get('antiAliasing');
		add(nameText);

		versionText = new FlxText(0, 0, FlxG.width, 'OCRPG ' + Main.versionString);
		versionText.setFormat(Paths.font("andy", 'global'), 15, FlxColor.WHITE, CENTER);
		versionText.setPosition(FlxG.width / 2 - versionText.width / 2, FlxG.height - versionText.height - 5);
		versionText.cameras = [camMain];
		versionText.antialiasing = SaveData.settings.get('antiAliasing');
		add(versionText);

		spriteGroup = new FlxTypedGroup<MainMenuButton>();
		add(spriteGroup);

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
			if (Controls.getControl('LEFT', 'RELEASE')){
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
				changeSelection(-1);
			}
			if (Controls.getControl('RIGHT', 'RELEASE')){
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

		nameText.text = textDataArray[curSelected];
		nameText.screenCenter(X);
		
		var bullShit:Int = 0;

		spriteGroup.forEachAlive(function(spr:MainMenuButton)
		{
			spr.targetX = bullShit - curSelected;
			bullShit++;

			if(spr.ID == curSelected){
				spr.selected = true;
			} else {
				spr.selected = false;
			}
		});
	}

	function loadMenuItems(type:String):Void{
		loadMenuOptions(type);

		if(resetCurSelected) curSelected = 0;

		spriteGroup.forEach(function(spr:MainMenuButton)
		{	
			spr.destroy();
		});

		loadMenuOptions(type);

		for (i in 0...textDataArray.length)
		{
			var stuff:Array<String> = textDataArray[i].split(":");

			var sprite:MainMenuButton = new MainMenuButton(menuOptionsGroup + '/' + stuff[0]);
			sprite.ID = i;
			sprite.targetX = FlxG.width / 2 - sprite.width / 2;
			sprite.targetY = nameText.y + 130;
			sprite.y = sprite.targetY;
			spriteGroup.add(sprite);
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
