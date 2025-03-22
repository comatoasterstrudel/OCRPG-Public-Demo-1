package objects.game.hud;

class SongCard extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;
	var text:FlxText;
    var sprite:FlxSprite;

    var initialPosition:Array<Float> = []; //text x, bg x
    var destinedPosition:Array<Float> = []; //text x, bg x

    var shaketween:FlxTween;
    var bgtween:FlxTween;
    var texttween:FlxTween;
    var spritetween:FlxTween;

	public function new(name:String)
	{
		super(3);

		if (!SaveData.settings.get('songCard') || SaveData.settings.get('momMode')){
            return;
        }

        var texttoupdate = '"' + Utilities.grabThingFromText(name, Paths.txt('songNames', 'battle'), 1) + '"\n' + Utilities.grabThingFromText(name, Paths.txt('songNames', 'battle'), 2);

		text = new FlxText(0, 0, 0, texttoupdate, 35, false);
		text.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, CENTER);
		text.antialiasing = SaveData.settings.get('antiAliasing');
		text.setPosition(10, 50);

		sprite = new FlxSprite().loadGraphic(Paths.image('ui/musicnote', 'battle'));
        sprite.setPosition(text.x + text.width / 2 - sprite.width / 2, text.y + text.height + 3);
		sprite.antialiasing = SaveData.settings.get('antiAliasing');
        
		bg = new FlxSprite(10, text.y - 5).makeGraphic(Std.int(text.width + 5), Std.int(text.height + sprite.height + 13), FlxColor.BLACK);
		bg.alpha = .55;

		add(bg);
		add(text);
        add(sprite);

		initialPosition = [text.x, bg.x, sprite.x];

        text.x = -text.width;
        bg.x = -text.width;
		sprite.x = text.x + text.width / 2 - sprite.width / 2;

		destinedPosition = [text.x, bg.x, sprite.x];

		shaketween = FlxTween.shake(sprite, 0.01, 4, XY);

		texttween = FlxTween.tween(text, {x: initialPosition[0]}, 1, {ease: FlxEase.backOut, onComplete: function(FlxTwn):Void{
				texttween = FlxTween.tween(text, {x: destinedPosition[0]}, 1, {startDelay: 2, ease: FlxEase.backIn});
        }});

		bgtween = FlxTween.tween(bg, {x: initialPosition[1]}, 1, {ease: FlxEase.backOut, onComplete: function(FlxTwn):Void{
				bgtween = FlxTween.tween(bg, {x: destinedPosition[1]}, 1, {startDelay: 2, ease: FlxEase.backIn});
        }});

        spritetween = FlxTween.tween(sprite, {x: initialPosition[2]}, 1, {ease: FlxEase.backOut, onComplete: function(FlxTwn):Void{
				spritetween = FlxTween.tween(sprite, {x: destinedPosition[2]}, 1, {startDelay: 2, ease: FlxEase.backIn, onComplete: function(FlxTwn):Void{
                    close();
            }});
        }});
	}

    public inline function close():Void{
        if(shaketween.active && shaketween != null){
			shaketween.cancel();
        }
		if (texttween.active && texttween != null){
			texttween.cancel();
        }
		if (bgtween.active && bgtween != null){
			bgtween.cancel();
        }
		if (spritetween.active && shaketween != null){
			spritetween.cancel();
        }

        if(sprite != null) sprite.destroy();
		if(text != null) text.destroy();
		if(bg != null) bg.destroy();
        
		this.destroy();
    }
}
