package states.game;
/**
 * A state for playing gauntlets
 * of levels.
 */
class GauntletState extends OcrpgState
{
	public static var levelList:Array<String>;
	public static var levelNum:Int;

	var globaltype:String;
	public static var globalname:String;

	public static var curGauntlet:String;

    public function new(type:String, ?name:String){
        super();

		globaltype = type;
		globalname = name;
    }

	override function create():Void{
		switch (globaltype)
		{
			case 'start':
				curGauntlet = globalname;

				levelNum = 0;

				levelList = [];

				var data = Utilities.dataFromTextFile(Paths.txt('gauntlet/' + globalname, 'menu'));

				for (i in 0...data.length)
				{
					var stuff:Array<String> = data[i].split(":");

					levelList.push(stuff[0]);
				}
			case 'continue':
				levelNum++;
		}

		if (levelNum == levelList.length){
			super.switchState(new GauntletSelectState(true), 'nothing', 0);
		} else {
			Battle.loadBattle(levelList[levelNum], new GauntletState('continue'), new GauntletSelectState(), new GauntletSelectState());
			super.switchState(new BattleSplashScreenState('intro', new PlayState()), 'nothing', 0);
		}

		super.init('none', 0);
	}
}