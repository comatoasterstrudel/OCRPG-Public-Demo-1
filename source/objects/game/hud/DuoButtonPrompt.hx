package objects.game.hud;

class DuoButtonPrompt extends FlxTypedGroup<FlxSprite>
{
	public var duoButtonPrompt:FlxSprite;

    var hud:Hud;
    
	public function new(huddata:Hud)
	{
		super();

        hud = huddata;
	}

    public function addDuoButtonPrompt(){
		if(duoButtonPrompt != null) duoButtonPrompt.destroy();

		duoButtonPrompt = new FlxSprite().loadGraphic(Paths.image('ui/duoPrompt', 'battle'));
		duoButtonPrompt.setGraphicSize(Std.int(duoButtonPrompt.width * .15));
		duoButtonPrompt.updateHitbox();
		duoButtonPrompt.setPosition(hud.characterArray[0].x + hud.characterArray[0].width / 2 - duoButtonPrompt.width / 2, 0);
		duoButtonPrompt.antialiasing = SaveData.settings.get('antiAliasing');
		duoButtonPrompt.alpha = 0;
		add(duoButtonPrompt);

		new FlxTimer().start(.3, function(tmr:FlxTimer)
		{
			FlxTween.tween(duoButtonPrompt, {alpha: 1}, .3, {ease: FlxEase.cubeInOut});
			duoButtonPrompt.y = FlxG.height - hud.bottomBar.height / 2 - duoButtonPrompt.height / 2 + 10;
		});
    }

    public function removeDuoButtonPrompt(){
		if (duoButtonPrompt != null)
		{
			FlxTween.tween(duoButtonPrompt, {alpha: 0}, .3, {
				ease: FlxEase.cubeInOut,
				onComplete: function(FlxTwn)
				{
					duoButtonPrompt.destroy();
				}
			});
		}
    }

    public function doDuoAnim(){
		FlxTween.tween(duoButtonPrompt, {x: FlxG.width / 2 - duoButtonPrompt.width / 2}, 1, { ease: FlxEase.cubeInOut, onComplete: function(FlxTwn){
				FlxTween.tween(duoButtonPrompt, {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
				FlxTween.tween(duoButtonPrompt.scale, {x: 0.01, y: 0.01}, 1, { ease: FlxEase.cubeInOut, onComplete: function(FlxTwn){
						duoButtonPrompt.destroy();
					}
				});
			}
		});
    }
}