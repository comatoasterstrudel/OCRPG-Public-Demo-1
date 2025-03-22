package objects;

class DebugText extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;
	var text:FlxText;

	public function new()
	{
		super(2);

		visible = false;

		bg = new FlxSprite();
		bg.alpha = .55;
		add(bg);

		text = new FlxText(0, 0, 0, '', 35, false);
		text.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, LEFT);
		text.antialiasing = SaveData.settings.get('antiAliasing');
		add(text);
	}

	override function update(elapsed:Float){
		if(Controls.getControl('DEBUG', 'RELEASE') && !DialogueSubstate.dialogueActive){
			visible = !visible;
		}
		
		super.update(elapsed);
	}

	public function updateText(size:Int, array:Array<String>):Void{
		text.size = size;

		var texttoupdate:String = '';

		for(i in 0...array.length){
			texttoupdate += array[i] + '\n'; 
		}

		text.text = texttoupdate;

		text.setPosition(0, 50);

		bg.y = text.y - 5;
		bg.x = 0;
		bg.makeGraphic(Std.int(text.width + 5), Std.int(text.height + 10), FlxColor.BLACK);
	}
}
