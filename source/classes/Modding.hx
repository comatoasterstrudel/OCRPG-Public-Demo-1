package classes;

/**
 * A class that has basic functions for modding
 * support. HEAVILY UNFINISHED RN!!
 */
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