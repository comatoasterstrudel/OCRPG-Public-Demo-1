package states.menu;

class SoundTestState extends OcrpgState
{
	var bg:MenuBackground;
	
    var recordSprite:FlxSprite;

    var soundList:Array<String> = [];
    var musicList:Array<String> = [];
    var listList:Array<Array<String>> = [];

    var curSelected:Int;
    var curSelectedHorizontal:Array<Int> = [0, 0];
	var controlAllowed:Bool = false;
    var horizontalAllowed:Bool = false;

	var optionTexts:FlxTypedGroup<FlxText>;
	var textDataArray:Array<String> = [];
    
    var playing:Bool;
    var theSound:FlxSound;

	override public function create()
	{
        loadLists();
        loadMenuItems();

		bg = new MenuBackground();
		add(bg);

		recordSprite = new FlxSprite(0, 10).loadGraphic(Paths.image('soundTest/soundTestRecord', 'menu'));
		recordSprite.setGraphicSize(Std.int(recordSprite.width * .5));
        recordSprite.updateHitbox();
		recordSprite.screenCenter(X);
		add(recordSprite);

		optionTexts = new FlxTypedGroup<FlxText>();
		add(optionTexts);

		for (i in 0...textDataArray.length)
		{
			var designatedY:Float = recordSprite.y + recordSprite.height + 60 + 80 * i + 1;

			var text:FlxText = new FlxText(0, designatedY, FlxG.width, textDataArray[i]);
			text.screenCenter(X);
			text.setFormat(Paths.font("andy", 'global'), 40, FlxColor.WHITE, CENTER);
			text.antialiasing = SaveData.settings.get('antiAliasing');
			text.alpha = 0.5;
			text.ID = i;
			optionTexts.add(text);
		}

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			changeSelection();

			controlAllowed = true;
		});

		super.init('wipe', 1, 'custom', 'In The Menus', 'Sound Test Menu');
	}

	override public function update(elapsed:Float)
	{
        if(playing){
            recordSprite.angle += 5 * elapsed;
            FlxG.autoPause = false;
        } else {
			FlxG.autoPause = true;
        }

		if (controlAllowed)
		{
			if (Controls.getControl('LEFT', 'RELEASE') && horizontalAllowed)
			{
				changeSelection(-1, 'horizontal');
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('RIGHT', 'RELEASE') && horizontalAllowed)
			{
				changeSelection(1, 'horizontal');
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('UP', 'RELEASE'))
			{
				changeSelection(-1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('DOWN', 'RELEASE'))
			{
				changeSelection(1);
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
			}
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				makeSelection();
			}
		}

		super.update(elapsed);
	}

	function changeSelection(?num:Int = 0, ?type:String):Void
	{
        switch(type){
            case 'horizontal':
				var listLength:Int = 0;

                switch(curSelected){
                    case 0: //sound
                        listLength = soundList.length - 1;
                    case 1: //music
						listLength = musicList.length - 1;
                }
                curSelectedHorizontal[curSelected] += num;
        
				if (curSelectedHorizontal[curSelected] > listLength) {
                    curSelectedHorizontal[curSelected] = 0;
				} else if (curSelectedHorizontal[curSelected] < 0){
					curSelectedHorizontal[curSelected] = listLength;
                }

				textDataArray[curSelected] = listList[curSelected][curSelectedHorizontal[curSelected]];

                changeSelection(0);
            default:
				curSelected += num;

				if (curSelected >= textDataArray.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = textDataArray.length - 1;

				if (textDataArray[curSelected] != 'back')
				{
					horizontalAllowed = true;
				}
				else
				{
					horizontalAllowed = false;
				}

				optionTexts.forEach(function(spr:FlxText)
				{
					spr.text = textDataArray[spr.ID];

					if (spr.ID != curSelected)
					{
						spr.alpha = 0.5;
					}
					else
					{
						spr.alpha = 1;

						if (horizontalAllowed)
						{
							spr.text = '< ' + textDataArray[spr.ID] + ' >';
						}
						spr.screenCenter(X);
					}
				});
        }
	}

    function makeSelection():Void{
        switch(textDataArray[curSelected]){
            case 'back':
				changePlayingStatus(false);

				FlxG.sound.play(Paths.sound('select', 'menu'), .7);

				controlAllowed = false;

				super.switchState(new MainMenuState(), 'wipe', 1, false);
            default:
                switch(curSelected){
                    case 0:
						changePlayingStatus(false);
						changePlayingStatus(true, soundList[curSelectedHorizontal[curSelected]]);
                    case 1:
						changePlayingStatus(false);
						changePlayingStatus(true, musicList[curSelectedHorizontal[curSelected]]);
                }
        }
    }

    function changePlayingStatus(yesnt:Bool, ?soundName:String){
        if(yesnt){
			theSound = new FlxSound().loadEmbedded(soundName, false, true);
            theSound.play();
            theSound.onComplete = function():Void{
                playing = false;
            }
			FlxG.sound.list.add(theSound);
			playing = true;            
        }  else {
			if (theSound != null) theSound.destroy();
			playing = false;
        }
    }

    inline function loadLists():Void{
        var extns:String = '.ogg';

		for(i in 0...Paths.libraryList.length){
			var addthis:Array<String> = Utilities.findFilesInPath('assets/' + Paths.libraryList[i] + '/sounds/', [extns], true);

			for(i in 0...addthis.length){
				soundList.push(addthis[i]);
			}

			var addthis:Array<String> = Utilities.findFilesInPath('assets/' + Paths.libraryList[i] + '/music/', [extns], true);

			for (i in 0...addthis.length)
			{
				musicList.push(addthis[i]);
			}
		}
		

        listList = [soundList, musicList];
    }

    inline function loadMenuItems():Void{
        for(i in 0...2){
			textDataArray.insert(textDataArray.length, listList[i][curSelectedHorizontal[0]]);
        }
		textDataArray.insert(textDataArray.length, 'back');
    }
}
