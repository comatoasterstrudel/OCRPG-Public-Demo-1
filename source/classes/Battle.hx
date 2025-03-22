package classes;

/**
 * A class that has basic functions and data needed for battles.
 */
class Battle
{
	public static var enemyCharacterName:String = 'googly';
	public static var partyCharacters:Array<String> = ['coma', 'outer'];
	public static var callbackArray:Array<FlxState>;

	public static final depletedHealthColor:FlxColor = 0xFFB30000;
	
	public static function loadBattle(name:String, ?winCallback:FlxState, ?loseCallback:FlxState, ?exitCallback:FlxState):Void{
		enemyCharacterName = name;

		if(winCallback == null) winCallback = new MainMenuState(); 
		if(loseCallback == null) loseCallback = new MainMenuState(); 
		if(exitCallback == null) exitCallback = new MainMenuState(); 

		callbackArray = [winCallback, loseCallback, exitCallback];
    }

    public static function getVanityName(name:String, type:String):String{
		var returnThis:String = '';

		
		returnThis = Utilities.grabThingFromText(name, Paths.txt('vanityname_' + type, 'misc'), 1);

		return returnThis;
    }

	public static function getDuoName():String {
        var returnThis:String = '';

		var data = Utilities.dataFromTextFile(Paths.txt('allyData', 'battle'));

		for (i in 0...data.length)
		{
			var stuff:Array<String> = data[i].split(":");
			if (stuff[0] == partyCharacters[0] || stuff[0] == partyCharacters[1])
			{
				returnThis += stuff[0];
			}
		}

        return returnThis;
	}

	public static function getIntroDialogueName(num:Int, num2:Int):String{
		var returnThis:String = '';

		switch(num2){
			case 0:
				returnThis = 'intro_' + enemyCharacterName;
			case 1:
				returnThis = 'intro/' + partyCharacters[num];

		}
		
		return returnThis;
	}

	public static function checkCharacterValue(type:String, name:String):Bool{
		var returnThis:Bool = false;

		switch(type){
			case 'isBoss':
				if (Utilities.grabThingFromText(name, Paths.txt('battleData', 'battle'), 11) == 'boss')
					returnThis = true;
			case 'useIntroDialogue':
				if (Utilities.grabThingFromText(name, Paths.txt('battleData', 'battle'), 12) == 'use')
					returnThis = true;
		}
		
		return returnThis;
	}
	
	public static function getCharacterList(type:String):Array<String>{
		var returnThis:Array<String> = [];

		switch(type){
			case 'ally':
				var data = Utilities.dataFromTextFile(Paths.txt('allyData', 'battle'));

				for (i in 0...data.length)
				{
					var stuff:Array<String> = data[i].split(":");

					returnThis.push(stuff[0]);
				}
			case 'enemy':
				var data = Utilities.dataFromTextFile(Paths.txt('menuBattleList', 'menu'));

				for (i in 0...data.length)
				{
					var stuff:Array<String> = data[i].split(":");

					returnThis.push(stuff[0]);
				}
			case 'gauntlet':
				var data = Utilities.dataFromTextFile(Paths.txt('gauntlet/gl_list', 'menu'));

				for (i in 0...data.length)
				{
					var stuff:Array<String> = data[i].split(":");

					returnThis.push(stuff[0]);
				}
		}
		return returnThis;
	}

	public static function saveBossAllyCompletion():Void{
		if (SaveData.bossAllyCompletion.get(enemyCharacterName) == null) SaveData.bossAllyCompletion.set(enemyCharacterName, []);

		var preExistingArray:Array<String> = SaveData.bossAllyCompletion.get(enemyCharacterName);

		for(i in 0...partyCharacters.length){
			if (!checkBossAllyCompletion(enemyCharacterName, partyCharacters[i]))
				preExistingArray.push(partyCharacters[i]);
		}

		SaveData.bossAllyCompletion.set(enemyCharacterName, preExistingArray);
		SaveData.save();
	}

	public static function checkBossAllyCompletion(bossname:String, allyname:String):Bool{
		var returnThis:Bool = false;

		if (SaveData.bossAllyCompletion.get(bossname) == null) SaveData.bossAllyCompletion.set(bossname, []);

		var preExistingArray:Array<String> = SaveData.bossAllyCompletion.get(bossname);

		for (i in 0...preExistingArray.length) {
			if (preExistingArray[i] == allyname) returnThis = true;
		}

		return returnThis;
	}

	public static function saveGauntletAllyCompletion():Void
	{
		if (SaveData.gauntletAllyCompletion.get(GauntletState.curGauntlet) == null) SaveData.gauntletAllyCompletion.set(GauntletState.curGauntlet, []);

		var preExistingArray:Array<String> = SaveData.gauntletAllyCompletion.get(GauntletState.curGauntlet);

		for (i in 0...partyCharacters.length)
		{
			if (!checkGauntletAllyCompletion(GauntletState.curGauntlet, partyCharacters[i]))
				preExistingArray.push(partyCharacters[i]);
		}

		SaveData.gauntletAllyCompletion.set(GauntletState.curGauntlet, preExistingArray);
		SaveData.save();
	}

	public static function checkGauntletAllyCompletion(name:String, allyname:String):Bool
	{
		var returnThis:Bool = false;

		if (SaveData.gauntletAllyCompletion.get(name) == null) SaveData.gauntletAllyCompletion.set(name, []);

		var preExistingArray:Array<String> = SaveData.gauntletAllyCompletion.get(name);

		for (i in 0...preExistingArray.length)
		{
			if (preExistingArray[i] == allyname)
				returnThis = true;
		}

		return returnThis;
	}
}