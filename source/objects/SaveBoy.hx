package objects;

class SaveBoy extends FlxSprite
{
	public function new(animamount:Int)
	{
		super();

		frames = Paths.getSparrowAtlas('saveSelect/saveboy', 'menu');
		setGraphicSize(Std.int(width * .4));
		updateHitbox();
		antialiasing = SaveData.settings.get('antiAliasing');

		for (i in 0...animamount){
			animation.addByPrefix('idle_' + i, 'idle_' + i, 2);
			animation.addByPrefix('talk_' + i, 'talk_' + i, 2);
        }

		animation.addByPrefix('destroy', 'destroy', 2);
	}

    public function doAnimByNumber(name:String, num:Int):Void{
		if (animation.exists(name + '_' + num)){
			animation.play(name + '_' + num);
		}
		else
		{
			animation.play(name + '_0');
		}
    }

    public function doDeleteAnim(time:Float, ?finishThing:Void -> Void):Void{
		FlxG.sound.play(Paths.sound('saveboyScream', 'menu'), 1.1);
		animation.play('destroy');
        FlxTween.shake(this, 0.01, time, XY, {onComplete: function(FlxTwn):Void{
				if (finishThing != null) finishThing();
        }});
    }
}
