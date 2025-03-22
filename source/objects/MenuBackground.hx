package objects;

class MenuBackground extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;
	var checker:FlxBackdrop;

	public function new(?type:String = 'default')
	{
		super(2);

		switch(type){
			case 'mainmenu':
				bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
				add(bg);

				checker = new FlxBackdrop(Paths.image('mainMenu/checker', 'menu'));
				checker.velocity.set(15, 15);
				checker.alpha = 0.1;
				add(checker);
			default:
				bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
				add(bg);

				checker = new FlxBackdrop(Paths.image('checker', 'menu'));
				checker.velocity.set(15, 15);
				checker.alpha = 0.5;
				add(checker);
		}
	}
}
