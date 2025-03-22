package substates;

class DecisionSubstate extends OcrpgSubState
{
	var camHud:FlxCamera;

	var fadeSprite:FlxSprite;

    var controlAllowed:Bool = false;
	var curSelected:Int = 0;

    var pausedSprite:FlxText;

	var optionTexts:FlxTypedGroup<FlxText>;

    var bigTextString:String = '';
	var textDataArray:Array<String> = [''];
    var callBackArray:Array<Void -> Void> = [];

	public function new(text:String, options:Array<String>, callbacks:Array<Void -> Void>)
	{
		super();

		bigTextString = text;
		textDataArray = options;
		callBackArray = callbacks;
	}

    override function create(){
		camHud = new FlxCamera();

		camHud.bgColor.alpha = 0;

		FlxG.cameras.add(camHud);

        camHud.alpha = 0;

		fadeSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		fadeSprite.alpha = .6;
		fadeSprite.cameras = [camHud];
		add(fadeSprite);

		optionTexts = new FlxTypedGroup<FlxText>();
		optionTexts.cameras = [camHud];
		add(optionTexts);

		pausedSprite = new FlxText(0, 150, FlxG.width, bigTextString);
        pausedSprite.screenCenter(X);
		pausedSprite.setFormat(Paths.font("andy", 'global'), 65, FlxColor.WHITE, CENTER);
		pausedSprite.antialiasing = SaveData.settings.get('antiAliasing');
		pausedSprite.cameras = [camHud];
		add(pausedSprite);

		for (i in 0...textDataArray.length)
		{
			var designatedY:Float = pausedSprite.y + pausedSprite.height + 65 * i + 1;

			var text:FlxText = new FlxText(10, designatedY, FlxG.width, textDataArray[i]);
            text.screenCenter(X);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, CENTER);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.ID = i;
            text.alpha = .5;
			optionTexts.add(text);
		}
        
        initialize();

		super.init('none', 0);
    }

	override public function update(elapsed:Float)
	{
        if(controlAllowed){
			if (Controls.getControl('UP', 'RELEASE')){
                changeSelection(-1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
            }
			if (Controls.getControl('DOWN', 'RELEASE')){
                changeSelection(1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
            }
			if (Controls.getControl('ACCEPT', 'RELEASE')){
                makeSelection();
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
            }
        }

		super.update(elapsed);
    }

	function changeSelection(?num:Int = 0):Void
	{
		curSelected += num;

		if (curSelected >= textDataArray.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = textDataArray.length - 1;

		optionTexts.forEach(function(spr:FlxText)
		{
			if (textDataArray[spr.ID] != textDataArray[curSelected])
			{
				spr.alpha = 0.5;

				spr.text = textDataArray[spr.ID];
			}
			else
			{
				spr.alpha = 1;

				spr.text = '> ' + textDataArray[spr.ID] + ' <';
			}

            spr.screenCenter(X);
		});
	}

	function makeSelection():Void
	{
		FlxTween.tween(camHud, {alpha: 0}, .5, {ease: FlxEase.quartInOut, onComplete: function(FlxTwn):Void{
				close();
				if (callBackArray[curSelected] != null) callBackArray[curSelected]();
        }});
    }

	inline function initialize():Void{
		FlxTween.tween(camHud, {alpha: 1}, .5, {ease: FlxEase.quartInOut});

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
            controlAllowed = true;
			changeSelection();
		});
	}
}