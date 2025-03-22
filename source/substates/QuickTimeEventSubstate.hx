package substates;

class QuickTimeEventSubstate extends OcrpgSubState
{
    var barSprite:FlxSprite;
    var lineSprite:FlxSprite;

    var moveDirection:String;
    final moveSpeed:Int = 675;

    var controlAllowed:Bool = false;

	var finishCallback:Float->Void = null;

    var effectiveness:Float = 1;
    
	public function new(charname:String, doevent:Bool, finishthing:Float->Void)
	{		
		super();

		finishCallback = finishthing;

        if(!doevent){
            effectiveness = 1;
            exit();
            return;
        }

		barSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/quickTimeEventBar', 'battle'));
		barSprite.antialiasing = SaveData.settings.get('antiAliasing');
        barSprite.screenCenter();
		add(barSprite);

        if(FlxG.random.bool(50)) moveDirection = 'left'; else moveDirection = 'right';

		lineSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/quickTimeEventLine', 'battle'));
		lineSprite.antialiasing = SaveData.settings.get('antiAliasing');
		lineSprite.screenCenter(Y);
		add(lineSprite);

        switch(moveDirection){
            case 'left':
				lineSprite.x = barSprite.x;
			case 'right':
				lineSprite.x = barSprite.x + barSprite.width - lineSprite.width;
        }

		initialize();
	}

	override public function create(){
		super.init('none', 0);
	}

	override public function update(elapsed:Float)
	{
		if(controlAllowed){
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				doCalculation();
			}

            switch(moveDirection){
                case 'left':
                    if(lineSprite.x > barSprite.x + barSprite.width - lineSprite.width)
                        doCalculation();
                case 'right':
					if (lineSprite.x < barSprite.x)
						doCalculation();
            }
        }

		super.update(elapsed);
    }

    inline function doCalculation():Void{
		controlAllowed = false;

        var trueLinePos:Float = lineSprite.x + lineSprite.width / 2;
       
		var distance:Float = FlxPoint.get((lineSprite.x + lineSprite.width / 2) - FlxG.width / 2, (lineSprite.y + lineSprite.height / 2) - FlxG.height / 2).x;
        if(distance < 0) distance = -distance;
    
		effectiveness = Std.int(100 - (Math.abs(distance) / (barSprite.width / 2)) * 100);
        
        if(trueLinePos == FlxG.width / 2){ //100% perfect i think its impossible
            effectiveness = 100;
        }

		//trace(effectiveness + '% accurate!');

        effectiveness /= 100;

		lineSprite.velocity.x = 0;

		FlxTween.tween(barSprite, {alpha: 0}, .5, {ease: FlxEase.quartInOut});
		FlxTween.tween(lineSprite, {alpha: 0}, .5, {ease: FlxEase.quartInOut, startDelay: 0.3});

		FlxTween.tween(barSprite.scale, {x: 4, y: 0.01}, .5, {ease: FlxEase.quartInOut});
		FlxTween.tween(lineSprite.scale, {x: 4, y: 0.01}, .5, {ease: FlxEase.quartInOut, startDelay: 0.3});

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			exit();
		});
    }

	inline function initialize():Void
	{
		var scaleBar:Array<Float> = [barSprite.scale.x, barSprite.scale.y];
		var scaleLine:Array<Float> = [barSprite.scale.x, barSprite.scale.y];

		barSprite.alpha = 0;
		lineSprite.alpha = 0;

		barSprite.scale.set(.01, 4);
		lineSprite.scale.set(.01, 4);

		FlxTween.tween(barSprite, {alpha: 1}, .5, {ease: FlxEase.quartInOut});
		FlxTween.tween(lineSprite, {alpha: 1}, .5, {ease: FlxEase.quartInOut, startDelay: 0.3});

		FlxTween.tween(barSprite.scale, {x: scaleBar[0], y: scaleBar[1]}, .5, {ease: FlxEase.quartInOut});
		FlxTween.tween(lineSprite.scale, {x: scaleLine[0], y: scaleLine[1]}, .5, {ease: FlxEase.quartInOut, startDelay: 0.3});

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			controlAllowed = true;

			switch (moveDirection)
			{
				case 'left':
					lineSprite.velocity.x = moveSpeed;
				case 'right':
					lineSprite.velocity.x = -moveSpeed;
			}
		});
	}

	inline function exit():Void
	{
	    finishCallback(effectiveness);
			
        close();			
	}
}
