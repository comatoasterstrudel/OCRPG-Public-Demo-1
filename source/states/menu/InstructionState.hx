package states.menu;

/**
 * A menu to display the controls
 * of the game
 */
class InstructionState extends OcrpgState
{
    var topText:FlxText;
    var bottomText:FlxText;
    var controlText:FlxText;

    var keyboardSprite:FlxSprite;
    var controllerSprite:FlxSprite;

    var controlToUse:Bool = Controls.checkGamepad(); //if true, will use controller inputs. else will use keyboard

    var selected:Bool = false;

	override public function create()
	{
		persistentUpdate = true;
		
		FlxG.sound.playMusic(Paths.music('instruction', 'menu'), 0);
		FlxG.sound.music.fadeIn(1, 0, 1.1);

        keyboardSprite = new FlxSprite();
		keyboardSprite.frames = Paths.getSparrowAtlas('instructions/keyboard', 'menu');
		keyboardSprite.animation.addByPrefix('idle', 'idle', 2);
		keyboardSprite.animation.play('idle');
		keyboardSprite.setGraphicSize(Std.int(keyboardSprite.width * .5));
		keyboardSprite.updateHitbox();
		keyboardSprite.screenCenter(Y);
		keyboardSprite.x = 0 - keyboardSprite.width / 3;
        keyboardSprite.angle = 25;
        add(keyboardSprite);

		controllerSprite = new FlxSprite();
		controllerSprite.frames = Paths.getSparrowAtlas('instructions/controller', 'menu');
		controllerSprite.animation.addByPrefix('idle', 'idle', 2);
		controllerSprite.animation.play('idle');
		controllerSprite.setGraphicSize(Std.int(controllerSprite.width * .5));
		controllerSprite.updateHitbox();
		controllerSprite.screenCenter(Y);
		controllerSprite.x = FlxG.width - controllerSprite.width + controllerSprite.width / 3;
		controllerSprite.angle = -25;
		add(controllerSprite);

		topText = new FlxText(0, 5, FlxG.width, 'Before you start..');
		topText.screenCenter(X);
		topText.setFormat(Paths.font("andy", 'global'), 50, FlxColor.WHITE, CENTER);
		topText.antialiasing = SaveData.settings.get('antiAliasing');
		add(topText);

		bottomText = new FlxText(0, 25, FlxG.width, Controls.replaceStringControlName("Press {LEFT} and {RIGHT} to switch between Keyboard and Gamepad controls\nPress {ACCEPT} when you're ready"));
		bottomText.setFormat(Paths.font("andy", 'global'), 20, FlxColor.WHITE, CENTER);
		bottomText.screenCenter(X);
        bottomText.y = FlxG.height - bottomText.height;
		bottomText.antialiasing = SaveData.settings.get('antiAliasing');
		add(bottomText);

		bottomText = new FlxText(0, 25, FlxG.width, 'placeholder UHHHH\nPRESS B TO HAVE SEX!');
		bottomText.setFormat(Paths.font("andy", 'global'), 35, FlxColor.WHITE, CENTER);
		bottomText.antialiasing = SaveData.settings.get('antiAliasing');
		add(bottomText);

        updateText();

		super.init('fade', 1, 'custom', 'In The Menus', 'Reading the Instructions');
	}

	override public function update(elapsed:Float)
	{
		if(!selected){
			if (Controls.getControl('RIGHT', 'RELEASE')){
                if(!controlToUse){
					FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
					controlToUse = true;
                    updateText();
                }
			}
			if (Controls.getControl('LEFT', 'RELEASE')){
				if (controlToUse)
				{
					FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
					controlToUse = false;
					updateText();
				}
			}
			if (Controls.getControl('ACCEPT', 'RELEASE')){
				selected = true;

				FlxG.sound.play(Paths.sound('select', 'menu'), .7);

                if(!SaveData.seenInstructions){
					SaveData.seenInstructions = true;
                    SaveData.save();
                }

                super.switchState(new SaveSelectState(), 'fade', 1, true, 0);
			}
		}

		super.update(elapsed);
	}

    function updateText():Void{
        if(controlToUse){//use controller
			keyboardSprite.alpha = .1;
			controllerSprite.alpha = .5;
        } else {//use keyboard
            keyboardSprite.alpha = .5;
            controllerSprite.alpha = .1;
        }

        bottomText.text = Controls.replaceStringControlName('{DIRECTIONALS} - DIRECTIONALS\n{ACCEPT} - ACCEPT\n{BACK} - BACK\n{EXTRAONE} - EXTRA ONE (Uses will be explained in-game)\n{EXTRATWO} - EXTRA TWO (Uses will be explained in-game)\n{PAUSE} - PAUSE\n{VOLUP} - VOLUME UP\n{VOLDOWN} - VOLUME DOWN\n{MUTE} - MUTE', controlToUse);
		bottomText.screenCenter();
    }
}
