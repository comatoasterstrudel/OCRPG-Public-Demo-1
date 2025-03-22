package substates;

class DialogueSubstate extends OcrpgSubState
{
	var fadeSprite:FlxSprite;
	var diaBox:FlxSprite;
    var diaText:FlxTypeText;

	var portaitGroup:FlxTypedGroup<FlxSprite>;
	var diaPortrait:FlxSprite;

	var dialogueData:Array<String>;
    var fileName:String;
    var curLine:Int = 0;
    var maxLines:Int;

	var volume:Float;

    var controlAllowed:Bool = false;
	public static var dialogueActive:Bool = false;

	var portraitTween:FlxTween;
	
	var finishCallback:Void->Void = null;

	var changeVol:Bool;

	public function new(dialogueFileName:String, ?folder:String, ?finishthing:Void->Void, ?changeVolume:Bool = true)
	{		
		dialogueActive = true;

		if(folder != null) folder = folder + '/'; else folder = '';

 		if(finishthing != null) finishCallback = finishthing;

		changeVol = changeVolume;

		fileName = 'dialogue/' + folder + 'dia_' + dialogueFileName;
		if (!FileSystem.exists(Paths.txt(fileName, 'dialogue'))){
			trace('Couldnt find dialogue file "' + fileName + '"');
			fileName = 'dialogue/dia_placeholder';
		}

		dialogueData = Utilities.dataFromTextFile(Paths.txt(fileName, 'dialogue'));

		maxLines = dialogueData.length - 1;
        
		if (FlxG.sound.music != null) volume = FlxG.sound.music.volume;

		super();
	}

    override function create(){
		if (FlxG.sound.music != null && changeVol) FlxG.sound.music.volume = volume * .5;

		fadeSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF393939);
		fadeSprite.alpha = 0;
		add(fadeSprite);

		portaitGroup = new FlxTypedGroup<FlxSprite>();
		add(portaitGroup);

		diaBox = new FlxSprite().loadGraphic(Paths.image('dialogueBox', 'dialogue'));
		diaBox.setGraphicSize(Std.int(diaBox.width * 1.2));
		diaBox.updateHitbox();
		diaBox.setPosition(FlxG.width / 2 - diaBox.width / 2, FlxG.height - diaBox.height - 30);
		diaBox.antialiasing = SaveData.settings.get('antiAliasing');
		add(diaBox);

		diaText = new FlxTypeText(0, diaBox.y + 35, Std.int(diaBox.width - 50), 'WOAHAAAHHAHAHAHAHA', 40);
		diaText.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        diaText.borderSize = 2;
		diaText.antialiasing = SaveData.settings.get('antiAliasing');
        diaText.screenCenter(X);
		add(diaText);

		initialize();

		super.init('none', 0);
    }

	override public function update(elapsed:Float)
	{
		if(controlAllowed){
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				loadNextLine(1);
			}
			#if debug
			if (Controls.getControl('DEBUG', 'HOLD'))
			{
				loadNextLine(1);
			}
			#end
        }

		super.update(elapsed);
    }

    function loadNextLine(amount:Int):Void{
		if(amount > 0) FlxG.sound.play(Paths.sound('close', 'dialogue'), 1);

        if(curLine >= maxLines){
			exit();
        } else {
			curLine += amount;

			var dialogueDataArray:Array<String> = dialogueData[curLine].split(":");
			var textSpeed:Float = Std.parseFloat(dialogueDataArray[1]);

			var portraitDestroyed:Bool = false;

			if (portraitTween != null && portraitTween.active){
				portraitTween.cancel();
				portraitTween.destroy();
			}

			if (diaPortrait != null){
				diaPortrait.destroy();
				portraitDestroyed = true;
			}

			diaText.sounds = [FlxG.sound.load(Paths.sound('text/text' + dialogueDataArray[2], 'dialogue'), 1)];

			diaText.color = Std.parseInt('0xFF' + Utilities.grabThingFromText(dialogueDataArray[3], Paths.txt('textColors', 'dialogue'), 1));

			if (FileSystem.exists(Paths.image('portraits/' + dialogueDataArray[4], 'dialogue')))
			{
				diaPortrait = new FlxSprite().loadGraphic(Paths.image('portraits/' + dialogueDataArray[4], 'dialogue'));
				diaPortrait.setGraphicSize(Std.int(diaBox.width * .31));
				diaPortrait.updateHitbox();
				diaPortrait.setPosition(diaBox.x + diaBox.width - diaPortrait.width * 1.5, diaBox.y - diaPortrait.height);
				diaPortrait.antialiasing = SaveData.settings.get('antiAliasing');
				portaitGroup.add(diaPortrait);

				if (!portraitDestroyed){
					diaPortrait.alpha = 0;
					portraitTween = FlxTween.tween(diaPortrait, {alpha: 1}, .5);
				}
			}

			diaText.resetText(Controls.replaceStringControlName(dialogueDataArray[0]));
			diaText.start(textSpeed, false, false);
        }
    }

	inline function initialize():Void{
		var scale:Array<Float> = [diaBox.scale.x, diaBox.scale.y];

		diaBox.scale.set(.01, 1.7);

		FlxTween.tween(fadeSprite, {alpha: .3}, .5);

		FlxTween.tween(diaBox.scale, {x: scale[0], y: scale[1]}, .5, {ease: FlxEase.quartInOut, onComplete: function(FlxTwn){
				controlAllowed = true;
				loadNextLine(0);
		}});
	}

	inline function exit():Void
	{
		diaText.visible = false;
		diaText.skip();
		controlAllowed = false;

		if (FlxG.sound.music != null && changeVol) FlxG.sound.music.volume = volume;

		if (portraitTween != null && portraitTween.active){
			portraitTween.cancel();
			portraitTween.destroy();
		}

		if (diaPortrait != null)
			portraitTween = FlxTween.tween(diaPortrait, {alpha: 0}, .5);

		FlxTween.tween(fadeSprite, {alpha: 0}, .5);

		FlxTween.tween(diaBox, {alpha: 0}, .5);
		FlxTween.tween(diaBox.scale, {x: .01, y: 1.7}, .5, {
			ease: FlxEase.quartInOut,
			onComplete: function(FlxTwn)
			{
				dialogueActive = false;

				if (portraitTween != null && portraitTween.active){
					portraitTween.cancel();
					portraitTween.destroy();
				}

				if (finishCallback != null)
					finishCallback();

				close();
			}
		});
	}
}
