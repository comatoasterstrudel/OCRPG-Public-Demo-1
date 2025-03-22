package ocrpgstate;

/**
 * A template for substates
 * so that code doesnt
 * have to be repeated.
 */
class OcrpgSubState extends FlxSubState
{
	public var screenTransition:ScreenTransition;

	public function init(transitionType:String, transitionTime:Float)
	{
		super.create();

		FlxG.mouse.visible = false;

		Paths.clearUnusedMemory();

		screenTransition = new ScreenTransition(transitionType, 'in', transitionTime, function():Void{
			screenTransition.destroy();
		});
		add(screenTransition);
	}

	public function switchState(state:FlxState, transitionType:String, transitionTime:Float, ?fadeMusic:Bool = false, ?delay:Float = 0){
		new FlxTimer().start(delay, function(tmr:FlxTimer)
		{
			if (fadeMusic)
				FlxG.sound.music.fadeOut(transitionTime, 0);

			screenTransition = new ScreenTransition(transitionType, 'out', transitionTime, function():Void{
				FlxG.switchState(state);
			});
			add(screenTransition);
		});

	}
}