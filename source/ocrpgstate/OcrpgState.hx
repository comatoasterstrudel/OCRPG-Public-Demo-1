package ocrpgstate;

/**
 * A template for states
 * so that code doesnt
 * have to be repeated.
 */
class OcrpgState extends FlxState
{
	public var screenTransitionIn:ScreenTransition;
	public var screenTransitionOut:ScreenTransition;

	public function init(transitionType:String, transitionTime:Float, ?detailsType:String = 'default', ?detailsOne:String = '', ?detailsTwo:String = '')
	{
		super.create();

		FlxG.mouse.visible = false;
		
		Paths.clearUnusedMemory();

		screenTransitionIn = new ScreenTransition(transitionType, 'in', transitionTime, function():Void{
			screenTransitionIn.destroy();
		});
		add(screenTransitionIn);

		Utilities.changeGameDetails(detailsType, detailsOne, detailsTwo);
	}

	public function switchState(state:FlxState, transitionType:String, transitionTime:Float, ?fadeMusic:Bool = false, ?delay:Float = 0){
		new FlxTimer().start(delay, function(tmr:FlxTimer)
		{
			if (fadeMusic) FlxG.sound.music.fadeOut(transitionTime, 0);

			screenTransitionOut = new ScreenTransition(transitionType, 'out', transitionTime, function():Void{
				FlxG.switchState(state);
			});
			add(screenTransitionOut);
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if(SaveData.settings.get('momMode') && FlxG.sound.music != null){
			FlxG.sound.music.volume = 0;
		}
	}
}