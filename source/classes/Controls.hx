package classes;

/**
 * A class that helps detect controls and other
 * control related functions.
 */
class Controls
{
	public static function getControl(type:String, inputtype:String):Bool
	{
		var returnThis:Bool = false;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		switch(inputtype){
			case 'RELEASE':
				switch (type)
				{
					case 'ACCEPT':
						if (FlxG.keys.justPressed.Z || checkGamepad() && gamepad.justPressed.A)
							returnThis = true;
					case 'BACK':
						if (FlxG.keys.justPressed.X || checkGamepad() && gamepad.justPressed.B)
							returnThis = true;
					case 'EXTRAONE':
						if (FlxG.keys.justPressed.CONTROL || checkGamepad() && gamepad.justPressed.X)
							returnThis = true;
					case 'EXTRATWO':
						if (FlxG.keys.justPressed.SHIFT || checkGamepad() && gamepad.justPressed.Y)
							returnThis = true;
					case 'LEFT':
						if (FlxG.keys.justPressed.LEFT || checkGamepad() && gamepad.justPressed.DPAD_LEFT || checkGamepad() && gamepad.justPressed.LEFT_STICK_DIGITAL_LEFT)
							returnThis = true;
					case 'RIGHT':
						if (FlxG.keys.justPressed.RIGHT || checkGamepad() && gamepad.justPressed.DPAD_RIGHT || checkGamepad() && gamepad.justPressed.LEFT_STICK_DIGITAL_RIGHT)
							returnThis = true;
					case 'UP':
						if (FlxG.keys.justPressed.UP || checkGamepad() && gamepad.justPressed.DPAD_UP || checkGamepad() && gamepad.justPressed.LEFT_STICK_DIGITAL_UP)
							returnThis = true;
					case 'DOWN':
						if (FlxG.keys.justPressed.DOWN || checkGamepad() && gamepad.justPressed.DPAD_DOWN || checkGamepad() && gamepad.justPressed.LEFT_STICK_DIGITAL_DOWN)
							returnThis = true;
					case 'PAUSE':
						if (FlxG.keys.justPressed.ESCAPE || checkGamepad() && gamepad.justPressed.START)
							returnThis = true;
					case 'DEBUG':
						if (FlxG.keys.justPressed.SEVEN || checkGamepad() && gamepad.justPressed.LEFT_STICK_CLICK || checkGamepad() && gamepad.justPressed.RIGHT_STICK_CLICK) 
							returnThis = true;
					case 'VOLDOWN':
						if (FlxG.keys.justPressed.MINUS || checkGamepad() && gamepad.justPressed.LEFT_TRIGGER)
							returnThis = true;
					case 'VOLUP':
						if (FlxG.keys.justPressed.PLUS || checkGamepad() && gamepad.justPressed.RIGHT_TRIGGER)
							returnThis = true;
					case 'MUTE':
						if (FlxG.keys.justPressed.ZERO || checkGamepad() && gamepad.justPressed.LEFT_SHOULDER || checkGamepad() && gamepad.justPressed.RIGHT_SHOULDER)
							returnThis = true;
					case 'ANY':
						if (FlxG.keys.justPressed.ANY || checkGamepad() && gamepad.justPressed.ANY)
							returnThis = true;
				}
			case 'HOLD':
				switch (type)
				{
					case 'ACCEPT':
						if (FlxG.keys.pressed.Z || checkGamepad() && gamepad.pressed.A)
							returnThis = true;
					case 'BACK':
						if (FlxG.keys.pressed.X || checkGamepad() && gamepad.pressed.B)
							returnThis = true;
					case 'EXTRAONE':
						if (FlxG.keys.pressed.CONTROL || checkGamepad() && gamepad.pressed.X)
							returnThis = true;
					case 'EXTRATWO':
						if (FlxG.keys.pressed.SHIFT || checkGamepad() && gamepad.pressed.Y)
							returnThis = true;
					case 'LEFT':
						if (FlxG.keys.pressed.LEFT || checkGamepad() && gamepad.pressed.DPAD_LEFT || checkGamepad() && gamepad.pressed.LEFT_STICK_DIGITAL_LEFT)
							returnThis = true;
					case 'RIGHT':
						if (FlxG.keys.pressed.RIGHT || checkGamepad() && gamepad.pressed.DPAD_RIGHT || checkGamepad() && gamepad.pressed.LEFT_STICK_DIGITAL_RIGHT)
							returnThis = true;
					case 'UP':
						if (FlxG.keys.pressed.UP || checkGamepad() && gamepad.pressed.DPAD_UP || checkGamepad() && gamepad.pressed.LEFT_STICK_DIGITAL_UP)
							returnThis = true;
					case 'DOWN':
						if (FlxG.keys.pressed.DOWN || checkGamepad() && gamepad.pressed.DPAD_DOWN || checkGamepad() && gamepad.pressed.LEFT_STICK_DIGITAL_DOWN)
							returnThis = true;
					case 'PAUSE':
						if (FlxG.keys.pressed.ESCAPE || checkGamepad() && gamepad.pressed.START)
							returnThis = true;
					case 'DEBUG':
						if (FlxG.keys.pressed.SEVEN || checkGamepad() && gamepad.pressed.LEFT_STICK_CLICK || checkGamepad() && gamepad.pressed.RIGHT_STICK_CLICK) 
							returnThis = true;
					case 'VOLDOWN':
						if (FlxG.keys.pressed.MINUS || checkGamepad() && gamepad.pressed.LEFT_TRIGGER)
							returnThis = true;
					case 'VOLUP':
						if (FlxG.keys.pressed.PLUS || checkGamepad() && gamepad.pressed.RIGHT_TRIGGER)
							returnThis = true;
					case 'MUTE':
						if (FlxG.keys.pressed.ZERO || checkGamepad() && gamepad.pressed.LEFT_SHOULDER || checkGamepad() && gamepad.pressed.RIGHT_SHOULDER)
							returnThis = true;
					case 'ANY':
						if (FlxG.keys.pressed.ANY || checkGamepad() && gamepad.pressed.ANY)
							returnThis = true;
				}
		}
		
		return returnThis;
	}

	public static function replaceStringControlName(ogstring:String, ?useController:Bool):String{
		var returnThis:String = ogstring;

		if(useController == null) useController = checkGamepad();

		var controlNamesArray:Array<String> = ['DIRECTIONALS', 'ACCEPT', 'BACK', 'EXTRAONE', 'EXTRATWO', 'LEFT', 'RIGHT', 'UP', 'DOWN', 'PAUSE', 'ANY', 'VOLDOWN', 'VOLUP', 'MUTE'];

		for(i in 0...controlNamesArray.length){
			if (returnThis.contains('{' + controlNamesArray[i] + '}')) returnThis = returnThis.replace('{' + controlNamesArray[i] + '}', getControlName(controlNamesArray[i], useController));
		}

		return returnThis;
	}

	public static function getControlName(type:String, useController:Bool):String{
		var returnThis:String = '';

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		switch (type)
		{
			case 'DIRECTIONALS':
				if (useController) returnThis = 'Left Stick / D-Pad'; else returnThis = 'Arrow Keys';
			case 'ACCEPT':
				if (useController) returnThis = 'A'; else returnThis = 'Z';
			case 'BACK':
				if (useController) returnThis = 'B'; else returnThis = 'X';
			case 'EXTRAONE':
				if (useController) returnThis = 'X'; else returnThis = 'CTRL';
			case 'EXTRATWO':
				if (useController) returnThis = 'Y'; else returnThis = 'SHIFT';
			case 'LEFT':
				returnThis = type;
			case 'RIGHT':
				returnThis = type;
			case 'UP':
				returnThis = type;
			case 'DOWN':
				returnThis = type;
			case 'PAUSE':
				if (useController) returnThis = 'START'; else returnThis = 'ESCAPE';
			case 'ANY':
				returnThis = type;
			case 'VOLDOWN':
				if (useController) returnThis = 'Left Trigger'; else returnThis = 'MINUS';
			case 'VOLUP':
				if (useController) returnThis = 'Right Trigger'; else returnThis = 'PLUS';
			case 'MUTE':
				if (useController) returnThis = 'Left / Right Bumpers'; else returnThis = 'ZERO';
		}
		return returnThis;
	}

	public static function checkGamepad():Bool{
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null) return true; else return false;
	}
}