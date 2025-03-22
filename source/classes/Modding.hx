package classes;

class Modding
{
    public static var currentMod:String = '';
    public static var modActive:Bool = false;

    public static function loadMod():Void{
        if(FileSystem.exists('modding/currentMod.txt')){
			var curMod = Utilities.dataFromTextFile('modding/currentMod.txt');

            if(curMod[0] != 'none'){
                trace('Mod Loaded (' + curMod[0] + ')');
				currentMod = curMod[0];
				modActive = true;
            }
        }
    }
}