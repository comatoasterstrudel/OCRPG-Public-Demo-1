package classes;

class SaveData
{
	public static var saveFileNum:Int = 0;
	public static var saveFileInitialized:Bool = false;
	
	public static var seenInstructions:Bool = false;

	public static final settingsList:Array<Array<String>> = [ //Name, Vanity Name, Description
		['isFullscreen', 'fullscreen', 'Should the game be in Fullscreen?'],
		['performanceVisible', 'performance stats', 'Should the game display Performance Stats?'],
		['antiAliasing', 'anti-aliasing', 'Should the game smooth objects visuals at the cost of performance?'],
		['momMode', 'mom mode', 'Should the game mute all music? (Hello 0uters mom!)'],
		['songCard', 'song cards', 'Should the game display the name of battle themes?'],
	]; 

	public static var settings:Map<String, Bool> = [ // Name, Value
		"isFullscreen" => false,
		"performanceVisible" => false,
		"antiAliasing" => true,
		"momMode" => false,
		"songCard" => true,
	]; 

	public static var bossAllyCompletion:Map<String, Array<String>> = [];
	public static var gauntletAllyCompletion:Map<String, Array<String>> = [];

	public static var savedCharacterNums:Array<Int> = [0, 1];

	public static function save():Void{
		manageSaveData('settings', 'save');
		manageSaveData('seencontrols', 'save');
		if (saveFileInitialized) manageSaveData('characters', 'save');
		if (saveFileInitialized) manageSaveData('bossallycompletion', 'save');
		if (saveFileInitialized) manageSaveData('gauntletallycompletion', 'save');

		trace('Saved Data');

		if(Main.saveIndicator != null) Main.saveIndicator.trigger();
	}

	public static function load():Void{
		manageSaveData('volume', 'load');
		manageSaveData('settings', 'load');
		manageSaveData('seencontrols', 'load');
		if(saveFileInitialized) manageSaveData('characters', 'load');
		if(saveFileInitialized) manageSaveData('bossallycompletion', 'load');
		if(saveFileInitialized) manageSaveData('gauntletallycompletion', 'load');

		trace('Loaded Data');
	}

	public static function manageSaveData(type:String, typetwo:String):Void{ //name of the thing, save or load?
		var save:FlxSave = new FlxSave();

		switch(type){
			case 'volume':
				save.bind('global');

				if(typetwo == 'save'){
					save.data.mute = FlxG.sound.muted;
					save.data.volume = FlxG.sound.volume;
				} else if(typetwo == 'load'){
					if (save.data.mute != null) FlxG.sound.muted = save.data.mute;
					if (save.data.volume != null) FlxG.sound.volume = save.data.volume;
				}
			case 'settings':
				save.bind('global');

				if(typetwo == 'save'){
					save.data.settings = settings;
				} else if(typetwo == 'load'){
					if (save.data.settings != null) settings = save.data.settings;
				}
			case 'seencontrols':
				save.bind('global');

				if (typetwo == 'save')
				{
					save.data.seenInstructions = seenInstructions;
				}
				else if (typetwo == 'load')
				{
					if (save.data.seenInstructions != null) seenInstructions = save.data.seenInstructions;
				}
			case 'characters':
				save.bind('saveslot' + saveFileNum);

				if(typetwo == 'save'){
					save.data.savedCharacterNums = savedCharacterNums;
				} else if(typetwo == 'load'){
					if (save.data.savedCharacterNums != null){
						savedCharacterNums = save.data.savedCharacterNums;
						
						var possibleChars:Array<String> = [];

						var data = Utilities.dataFromTextFile(Paths.txt('allyData', 'battle'));

						for (i in 0...data.length)
						{
							var stuff:Array<String> = data[i].split(":");

							possibleChars.insert(possibleChars.length, stuff[0]);
						}

						Battle.partyCharacters = [possibleChars[savedCharacterNums[0]], possibleChars[savedCharacterNums[1]]];
						CharacterSelectState.characterNumArray = savedCharacterNums;
					}
				}
			case 'bossallycompletion':
				save.bind('saveslot' + saveFileNum);

				if(typetwo == 'save'){
					save.data.bossAllyCompletion = bossAllyCompletion;
				} else if(typetwo == 'load'){
					if (save.data.bossAllyCompletion != null) bossAllyCompletion = save.data.bossAllyCompletion;
				}
			case 'gauntletallycompletion':
				save.bind('saveslot' + saveFileNum);

				if(typetwo == 'save'){
					save.data.gauntletAllyCompletion = gauntletAllyCompletion;
				} else if(typetwo == 'load'){
					if (save.data.gauntletAllyCompletion != null) gauntletAllyCompletion = save.data.gauntletAllyCompletion;
				}
		}

		if(typetwo == 'save') save.flush();
	}

	public static function updateSetting(name:String){
		switch(name){
			case 'isFullscreen':
				FlxG.fullscreen = settings.get('isFullscreen');
			case 'performanceVisible':
				Main.fpsVar.visible = settings.get('performanceVisible');
		}
	}

	inline public static function initializeSaveFile(num:Int){
		saveFileNum = num;
		saveFileInitialized = true;

		trace("Save File " + num + " Initialized.");
	}

	public static function resetSaveFile(num:Int){
		var save:FlxSave = new FlxSave();
		save.bind('saveslot' + num);
		save.erase();

		trace("Save File " + num + " Reset.");
	}

	public static function restoreDefaultData():Void{
		saveFileInitialized = false;

		savedCharacterNums = [0, 1];
		bossAllyCompletion = [];
		gauntletAllyCompletion = [];

		//MainMenuState.menuOptionsGroup = 'main';
		//MainMenuState.curSelected = 0;

		GameLogo.mainLogoSeen = false;
		
		GauntletSelectState.curSelected = 0;
	}
}
