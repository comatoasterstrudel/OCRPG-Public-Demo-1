package objects.game.hud;

class DamageText extends FlxText
{
	public function new(textString:String, coolX:Float, coolY:Float, coolWidth:Float, coolHeight:Float)
	{
		super();
		
		text = textString;
		setFormat(Paths.font("andy", 'global'), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
		setPosition(coolX + coolWidth / 2 - width / 2, coolY + coolHeight / 2 - height / 2);
		antialiasing = SaveData.settings.get('antiAliasing');

		FlxTween.tween(this, {y: y + FlxG.random.float(150, 250)}, 1.5, {ease: FlxEase.quartIn});

		FlxTween.tween(this, {alpha: 0,}, 1.5, {ease: FlxEase.quartInOut, onComplete: function(FlxTwn):Void{
			destroy();
		}});
	}
}
