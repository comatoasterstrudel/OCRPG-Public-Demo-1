package flixel.system;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class FlxSplash extends OcrpgState
{
	public static var nextState:Class<FlxState>;

	/**
	 * @since 4.8.0
	 */
	public static var muted:Bool = #if html5 true #else false #end;

	var _sprite:Sprite;
	var _gfx:Graphics;
	var _text:TextField;

	var _times:Array<Float>;
	var _colors:Array<Int>;
	var _functions:Array<Void->Void>;
	var _curPart:Int = 0;
	var _cachedBgColor:FlxColor;
	var _cachedTimestep:Bool;
	var _cachedAutoPause:Bool;

	var spriteLeft:FlxSprite;
	var spriteRight:FlxSprite;
	
	override public function create():Void
	{
		_cachedBgColor = FlxG.cameras.bgColor;
		FlxG.cameras.bgColor = FlxColor.BLACK;

		// This is required for sound and animation to synch up properly
		_cachedTimestep = FlxG.fixedTimestep;
		FlxG.fixedTimestep = false;

		_cachedAutoPause = FlxG.autoPause;
		FlxG.autoPause = false;

		#if FLX_KEYBOARD
		FlxG.keys.enabled = false;
		#end

		_times = [0.041, 0.184, 0.334, 0.495, 0.636];
		_colors = [0x00b922, 0xffc132, 0xf5274e, 0x3641ff, 0x04cdfb];
		_functions = [drawGreen, drawYellow, drawRed, drawBlue, drawLightBlue];

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		_sprite = new Sprite();
		FlxG.stage.addChild(_sprite);
		_gfx = _sprite.graphics;

		_text = new TextField();
		_text.selectable = false;
		_text.embedFonts = true;
		var dtf = new TextFormat(FlxAssets.FONT_DEFAULT, 16, 0xffffff);
		dtf.align = TextFormatAlign.CENTER;
		_text.defaultTextFormat = dtf;
		_text.text = "HaxeFlixel";

		onResize(stageWidth, stageHeight);
				
		spriteLeft = new FlxSprite().loadGraphic(Paths.image('introSplashScreen/outer', 'misc'));
		spriteLeft.setGraphicSize(Std.int(spriteLeft.width * .65));
		spriteLeft.updateHitbox();
		spriteLeft.setPosition(FlxG.width / 2 - spriteLeft.width / 2 - 300, FlxG.height - spriteLeft.height);
		spriteLeft.antialiasing = true;
	
		spriteRight = new FlxSprite().loadGraphic(Paths.image('introSplashScreen/coma', 'misc'));
		spriteRight.setGraphicSize(Std.int(spriteRight.width * .65));
		spriteRight.updateHitbox();
		spriteRight.setPosition(FlxG.width / 2 - spriteRight.width / 2 + 300, FlxG.height - spriteRight.height);
		spriteRight.antialiasing = true;

		new FlxTimer().start(1, function(FlxTimer):Void
		{
			for (time in _times)
			{
				new FlxTimer().start(time, timerCallback);
			}

			#if FLX_SOUND_SYSTEM
			if (!muted)
			{
				FlxG.sound.load(FlxAssets.getSound("flixel/sounds/flixel")).play();
			}
			#end

			FlxG.stage.addChild(_text);
		});

		super.init('none', 0, 'custom', 'Starting the Game...', 'Made in HaxeFlixel');
	}

	override public function destroy():Void
	{
		_sprite = null;
		_gfx = null;
		_text = null;
		_times = null;
		_colors = null;
		_functions = null;
		super.destroy();
	}

	override public function onResize(Width:Int, Height:Int):Void
	{
		super.onResize(Width, Height);

		_sprite.x = (Width / 2);
		_sprite.y = (Height / 2) - 20 * FlxG.game.scaleY;

		_text.width = Width / FlxG.game.scaleX;
		_text.x = 0;
		_text.y = _sprite.y + 80 * FlxG.game.scaleY;

		_sprite.scaleX = _text.scaleX = FlxG.game.scaleX;
		_sprite.scaleY = _text.scaleY = FlxG.game.scaleY;
	}

	function timerCallback(Timer:FlxTimer):Void
	{
		_functions[_curPart]();
		_text.textColor = _colors[_curPart];
		_text.text = "HaxeFlixel";
		_curPart++;

		if (_curPart == 5)
		{
			doCustomStuff();

			// Make the logo a tad bit longer, so our users fully appreciate our hard work :D
			FlxTween.tween(_sprite, {alpha: 0}, 3.0, {startDelay: 1.5, ease: FlxEase.quadOut, onComplete: onComplete});
			FlxTween.tween(_text, {alpha: 0}, 3.0, {startDelay: 1.5, ease: FlxEase.quadOut});
			FlxTween.tween(spriteLeft, {alpha: 0}, 3.0, {startDelay: 1.5, ease: FlxEase.quadOut});
			FlxTween.tween(spriteRight, {alpha: 0}, 3.0, {startDelay: 1.5, ease: FlxEase.quadOut});
		}
	}

	var makebig:Bool = false;
	
	function drawGreen():Void
	{
		if(makebig){
			_gfx.beginFill(_colors[0]);
			_gfx.moveTo(-1, -38);
			_gfx.lineTo(2, -38);
			_gfx.lineTo(38, -1);
			_gfx.lineTo(38, 2);
			_gfx.lineTo(2, 38);
			_gfx.lineTo(-1, 38);
			_gfx.lineTo(-38, 2);
			_gfx.lineTo(-38, -1);
			_gfx.lineTo(-1, -38);
			_gfx.endFill();
		} else {
			_gfx.beginFill(_colors[0]);
			_gfx.moveTo(0, -37);
			_gfx.lineTo(1, -37);
			_gfx.lineTo(37, 0);
			_gfx.lineTo(37, 1);
			_gfx.lineTo(1, 37);
			_gfx.lineTo(0, 37);
			_gfx.lineTo(-37, 1);
			_gfx.lineTo(-37, 0);
			_gfx.lineTo(0, -37);
			_gfx.endFill();
		}
	}

	function drawYellow():Void
	{
		_gfx.beginFill(_colors[1]);
		_gfx.moveTo(-50, -50);
		_gfx.lineTo(-25, -50);
		_gfx.lineTo(0, -37);
		_gfx.lineTo(-37, 0);
		_gfx.lineTo(-50, -25);
		_gfx.lineTo(-50, -50);
		_gfx.endFill();
	}

	function drawRed():Void
	{
		_gfx.beginFill(_colors[2]);
		_gfx.moveTo(50, -50);
		_gfx.lineTo(25, -50);
		_gfx.lineTo(1, -37);
		_gfx.lineTo(37, 0);
		_gfx.lineTo(50, -25);
		_gfx.lineTo(50, -50);
		_gfx.endFill();
	}

	function drawBlue():Void
	{
		_gfx.beginFill(_colors[3]);
		_gfx.moveTo(-50, 50);
		_gfx.lineTo(-25, 50);
		_gfx.lineTo(0, 37);
		_gfx.lineTo(-37, 1);
		_gfx.lineTo(-50, 25);
		_gfx.lineTo(-50, 50);
		_gfx.endFill();
	}

	function drawLightBlue():Void
	{
		_gfx.beginFill(_colors[4]);
		_gfx.moveTo(50, 50);
		_gfx.lineTo(25, 50);
		_gfx.lineTo(1, 37);
		_gfx.lineTo(37, 1);
		_gfx.lineTo(50, 25);
		_gfx.lineTo(50, 50);
		_gfx.endFill();
	}

	function onComplete(Tween:FlxTween):Void
	{
		FlxG.cameras.bgColor = _cachedBgColor;
		FlxG.fixedTimestep = _cachedTimestep;
		FlxG.autoPause = _cachedAutoPause;
		#if FLX_KEYBOARD
		FlxG.keys.enabled = true;
		#end
		FlxG.stage.removeChild(_sprite);
		FlxG.stage.removeChild(_text);
		FlxG.switchState(Type.createInstance(nextState, []));
		FlxG.game._gameJustStarted = true;
	}

	inline function doCustomStuff():Void{
		FlxG.camera.flash(FlxColor.WHITE, .5);

		_colors = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff];

		makebig = true;
		
		drawGreen();
		drawYellow();
		drawRed();
		drawBlue();
		drawLightBlue();

		_text.textColor = 0xffffff;

		add(spriteLeft);
		add(spriteRight);
	}
}