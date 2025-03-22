package objects;

class CharacterIcon extends FlxSprite
{
	public function new(type:String, name:String, ?resize:Float = 1)
	{
		super();

		loadGraphic(Paths.image('characterIcons/' + type + '_' + name, 'misc'));
		setGraphicSize(Std.int(width * resize));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');
	}	
}