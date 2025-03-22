package objects.game.hud;

class InnerBar extends FlxTypedGroup<FlxSprite>
{
    //sprites and groups
    
	public var barSprite:FlxSprite;
	public var barBar:FlxBar;

    //data
    
    var characterArray:Array<Ally>;

    public var initdeaths:Int = 0;
	public var deaths:Int = 0;
    public var deathlerp:Float = 0;
    public final maxdeaths:Int = 3;
    
    var posArray:Array<Float>;
    
    final shakeBase:Float = 1.5;

	var finishCallback:Void->Void = null;
    var finished:Bool = false;

	public function new(charArray:Array<Ally>, endCallback:Void -> Void)
	{
		super();

		finishCallback = endCallback;

		characterArray = charArray;

		for (i in 0...characterArray.length)
		{
			initdeaths += characterArray[i].deathCount;
		}

		barSprite = new FlxSprite();
		barSprite.frames = Paths.getSparrowAtlas('bossspecific/inner/innerbarsprite', 'battle');
		barSprite.setPosition(FlxG.width - barSprite.width - 10, 10);
		barSprite.antialiasing = SaveData.settings.get('antiAliasing');

        for(i in 0...maxdeaths + 1){
			barSprite.animation.addByPrefix('' + i, '' + i, 1);
        }

		barBar = new FlxBar(barSprite.x, barSprite.y, BOTTOM_TO_TOP, 75, 145, this, 'deathlerp', 0, maxdeaths);
        barBar.setPosition(barSprite.x + barSprite.width / 2 - barBar.width / 2, barSprite.y + barSprite.height / 2 - barBar.height / 2);
        barBar.y += 40;
        barBar.x += 3;
		barBar.createFilledBar(FlxColor.BLACK, Battle.depletedHealthColor);
		barBar.updateBar();
		barBar.numDivisions = Std.int(barBar.height);

		posArray = [barSprite.x, barSprite.y, barBar.x, barBar.y];

		add(barBar);
		add(barSprite);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        deaths = 0;

        for(i in 0...characterArray.length){
			deaths += characterArray[i].deathCount;
        }

		deaths -= initdeaths;

        if(deaths < 0) 
            deaths = 0;
        else if(deaths > maxdeaths) 
            deaths = maxdeaths;

		barSprite.animation.play('' + deaths);

		deathlerp = FlxMath.lerp(deathlerp, deaths, Utilities.boundTo(1 - (elapsed * 15), 0, 1));	

		var shakeamountX:Float = FlxG.random.float(-shakeBase, shakeBase) * deaths;
		var shakeamountY:Float = FlxG.random.float(-shakeBase, shakeBase) * deaths;

        barSprite.setPosition(posArray[0] + shakeamountX, posArray[1] + shakeamountY);
		barBar.setPosition(posArray[2] + shakeamountX, posArray[3] + shakeamountY);

        if (deaths == maxdeaths && !finished){
            finished = true;
            finishCallback();
        }
    }
}