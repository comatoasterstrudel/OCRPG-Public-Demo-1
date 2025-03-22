package util;

using StringTools;

class Utilities
{
	public static function dataFromTextFile(path:String):Array<String>
	{
		var daList:Array<String> = [];

		if (FileSystem.exists(path))
			daList = File.getContent(path).split('\n');

		return daList;
	}

	public static function grabThingFromText(thingtoget:String, filename:String, theonetosend:Int):String
	{
		var data = Utilities.dataFromTextFile(filename);
		var thingToSend:String = '';

		for (i in 0...data.length)
		{
			var stuff:Array<String> = data[i].split(":");
			if (stuff[0] == thingtoget)
			{
				thingToSend = stuff[theonetosend];
			}
		}

		return thingToSend;
	}

	public static function findFilesInPath(path:String, extns:Array<String>, ?filePath:Bool = false, ?deepSearch:Bool = true):Array<String>
	{
		var files:Array<String> = [];

		if (FileSystem.exists(path))
		{
			for (file in FileSystem.readDirectory(path))
			{
				var path = haxe.io.Path.join([path, file]);
				if (!FileSystem.isDirectory(path))
				{
					for (extn in extns)
					{
						if (file.endsWith(extn))
						{
							if (filePath)
								files.push(path);
							else
								files.push(file);
						}
					}
				}
				else if (deepSearch) // ! YAY !!!! -lunar
				{
					var pathsFiles:Array<String> = findFilesInPath(path, extns, deepSearch);

					for (_ in pathsFiles)
						files.push(_);
				}
			}
		}
		return files;
	}
	
	public static function invertNum(num:Int):Int{
		if(num == 1) num = 0; else num = 1;
		return num;
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}

	public static function changeGameDetails(?type:String = 'default', ?lineone:String, ?linetwo:String):Void{
		switch(type){
			case 'default':
				DiscordClient.changePresence('In Game', null);
				Application.current.window.title = 'OCRPG';
			case 'custom':
				DiscordClient.changePresence(lineone, linetwo);
				Application.current.window.title = 'OCRPG - ' + linetwo;
		}
	}
}