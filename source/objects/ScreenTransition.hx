package objects;

class ScreenTransition extends FlxTypedGroup<FlxSprite>
{
	public function new(type:String, inOut:String, time:Float, ?finishCallback:Void -> Void)
	{
		super();

		var timeToWait:Float = time;

		if(type == 'tv') timeToWait += 2;
		
		new FlxTimer().start(timeToWait, function(tmr:FlxTimer)
		{
			if (finishCallback != null) finishCallback();
		});
		
		switch (type)
		{
			case 'fade':
				switch (inOut)
				{
					case 'in':
						var fade:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						fade.alpha = 1;
						add(fade);
						FlxTween.tween(fade, {alpha: 0}, time, {ease: FlxEase.cubeInOut,});
					case 'out':
						var fade:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						fade.alpha = 0;
						add(fade);
						FlxTween.tween(fade, {alpha: 1}, time, { ease: FlxEase.cubeInOut, });
				}
			case 'battle':
				switch (inOut)
				{
					case 'in':
						var left:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						left.scale.set(.5, 1);
						left.updateHitbox();
						left.setPosition(0, 0);
						add(left);
						var right:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						right.scale.set(.5, 1);
						right.updateHitbox();
						right.setPosition(FlxG.width / 2, 0);
						add(right);
						FlxTween.tween(left, {x: left.x - left.width}, time, {ease: FlxEase.quartInOut});
						FlxTween.tween(right, {x: right.x + right.width}, time, {ease: FlxEase.quartInOut});
					case 'out':
						var left:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						left.scale.set(.5, 1);
						left.updateHitbox();
						left.setPosition(-left.width, 0);
						add(left);
						var right:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						right.scale.set(.5, 1);
						right.updateHitbox();
						right.setPosition(FlxG.width, 0);
						add(right);
						FlxTween.tween(left, {x: left.x + left.width}, time, {ease: FlxEase.quartInOut});
						FlxTween.tween(right, {x: right.x - right.width}, time, {ease: FlxEase.quartInOut});
				}
			case 'wipe':
				switch(inOut){
					case 'in':
						var wipe:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						wipe.alpha = 1;
						add(wipe);
						FlxTween.tween(wipe, {x: -FlxG.width}, time, {ease: FlxEase.cubeInOut,});
					case 'out':
						var wipe:FlxSprite = new FlxSprite(FlxG.width, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
						wipe.alpha = 1;
						add(wipe);
						FlxTween.tween(wipe, {x: 0}, time, {ease: FlxEase.cubeInOut,});
				}
			case 'tv':
				switch(inOut){
					case 'in':
						var tveffect = new FlxSprite().makeGraphic(1, 1, FlxColor.WHITE);
						tveffect.screenCenter();
						add(tveffect);
						FlxTween.tween(tveffect.scale, {y: FlxG.height}, time, {ease: FlxEase.cubeInOut, onComplete: function(FlxTwn):Void{
								FlxTween.tween(tveffect, {alpha: 0}, 2, {
									onComplete: function(FlxTwn):Void
									{
										tveffect.destroy();
									}
								});
						}});
						FlxTween.tween(tveffect.scale, {x: FlxG.width}, time / 2.5, {ease: FlxEase.cubeInOut,});

						new FlxTimer().start(.15, function(tmr:FlxTimer) {
							FlxG.sound.play(Paths.sound('tvTran', 'global'), .7);
						});
				}

		}
	}
}
