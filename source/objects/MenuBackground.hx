package objects;

class MenuBackground extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;
	var checker:FlxBackdrop;

	public function new()
	{
		super(2);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		add(bg);

		checker = new FlxBackdrop(Paths.image('checker', 'menu'));
		checker.velocity.set(15, 15);
		checker.alpha = 0.5;
		add(checker);
	}
}
