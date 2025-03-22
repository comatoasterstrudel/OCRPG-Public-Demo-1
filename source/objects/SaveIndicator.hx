package objects; //i had to learn how to do openfl shit ??

var inProgress:Bool = false;

class SaveIndicator extends Sprite
{
	public function new()
	{
		super();

		var bitmapData = Assets.getBitmapData(Paths.image("saveIndicator", 'global'));
		var bitmap = new Bitmap(bitmapData);

		addChild(bitmap);

		alpha = 0;
	}

	public function trigger():Void{
		var screenWidth = Lib.current.stage.stageWidth / FlxG.game.scaleX;
		var screenHeight = Lib.current.stage.stageHeight / FlxG.game.scaleY;
		x = screenWidth - width;
		y = screenHeight - height;

		if (!inProgress){
			inProgress = true;
			alpha = 1;
			FlxTween.tween(this, {alpha:0}, .5, {
				onComplete: function(FlxTwn)
				{
					inProgress = false;
				}
			});
		}

	}
}
