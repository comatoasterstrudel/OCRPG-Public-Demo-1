package util;

class Paths
{
	public static final libraryList:Array<String> = ['battle', 'menu', 'global', 'dialogue', 'misc'];
	
	inline static function getPartialPath(type:String):String
	{
		var returnThis:String = '';

		switch(type){
			case 'image' | 'xml':
				returnThis = 'images/';
			case 'sound':
				returnThis = 'sounds/';
			case 'music':
				returnThis = 'music/';
			case 'txt' | 'hscript':
				returnThis = 'data/'; 
			case 'font':
				returnThis = 'fonts/';
		}

		return returnThis;
	}

	inline static function getFileExtension(type:String):String
	{
		var returnThis:String = '';

		switch(type){
			case 'image':
				returnThis = '.png';
			case 'sound' | 'music':
				returnThis = '.ogg';
			case 'txt':
				returnThis = '.txt'; 
			case 'xml':
				returnThis = '.xml';
			case 'font':
				returnThis = '.ttf';
			case 'hscript':
				returnThis = '.hx';
		}

		return returnThis;
	}

	inline static function getFile(type:String, key:String, library:String)
	{
		if (Modding.modActive && FileSystem.exists('modding/' + Modding.currentMod + '/' + library + '/' + getPartialPath(type) + key + getFileExtension(type))){
			return 'modding/' + Modding.currentMod + '/' + library + '/' + getPartialPath(type) + key + getFileExtension(type);
		} else {
			return 'assets/' + library + '/' + getPartialPath(type) + key + getFileExtension(type);
		}
	}

	inline static public function getSparrowAtlas(key:String, library:String)
	{
		return FlxAtlasFrames.fromSparrow(getFile('image', key, library), getFile('xml', key, library));
	}

	inline static public function txt(key:String, library:String)
	{
		return getFile('txt', key, library);
	}

	inline static public function script(key:String, library:String)
	{
		return getFile('hscript', key, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getFile('xml', key, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getFile('sound', key, library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getFile('music', key, library);
	}

	inline static public function image(key:String, ?library:String)
	{
		return getFile('image', key, library);
	}

	inline static public function font(key:String, ?library:String)
	{
		return getFile('font', key, library);
	}

	public static function clearUnusedMemory() {
		System.gc();
	}
}
