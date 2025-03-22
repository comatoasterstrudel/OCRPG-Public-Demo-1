package ocrpgstate;

/**
 * A template for menus
 * so that code doesnt
 * have to be repeated.
 */
class OcrpgMenuState extends OcrpgState
{
	public var curSelected:Int = 0;
    public var isSelected:Bool = false;

    public function playMenuSound(type:String):Void{
        switch(type){
            case 'scroll':
				FlxG.sound.play(Paths.sound('scroll', 'menu'), .7);
            case 'select':
				FlxG.sound.play(Paths.sound('select', 'menu'), .7);
            case 'back':

        }
    }
}