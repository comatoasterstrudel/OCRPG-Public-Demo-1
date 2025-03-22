package objects;

class GameLogo extends FlxSprite
{
	public static var mainLogoSeen:Bool = false;

	public function new()
	{
		super();

		var name:String = 'main';

		var possibleLogos = Utilities.findFilesInPath('assets/menu/images/mainMenu/logos/', ['.png']);

		for (i in 0...possibleLogos.length)
		{
			if (StringTools.endsWith(possibleLogos[i], '.png'))
			{
				possibleLogos[i] = possibleLogos[i].split('.png')[0];
			}
		}

		if(!mainLogoSeen){
			mainLogoSeen = true;
		} else if(FlxG.random.bool(5)){
			name = possibleLogos[FlxG.random.int(0, possibleLogos.length - 1)];
		}

		loadGraphic(Paths.image('mainMenu/logos/' + name, 'menu'));
		setGraphicSize(Std.int(width * .3));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');
	}	
}