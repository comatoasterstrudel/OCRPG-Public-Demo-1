package objects.game.characters;

class Character extends FlxSprite
{
    public var type:String; //ally or enemy

	public var name:String;

    public var hp:Int;
	public var maxhp:Int;
    public var hppercent:Float;
	public var hplerp:Float;
    
	public var moveList:Array<String> = ['Basic Attack', 'Basic Attack', 'Basic Attack', 'Basic Attack'];

	public var idleName:String = 'idle';
	public var hurtName:String = 'hurt';
	public var deadName:String = 'dead';

	public final maxDefense:Int = 5;
	public final defMult:Float = 0.06;
	public var defense:Int = 0;
	public var realDefense:Float = 1;

	public var attackActive:Bool;
	public var textColor:FlxColor;
	public var textToUse:String;

    public function new(newtype:String, newname:String){
        super();

		type = newtype;
		name = newname;
    }

    override function update(elapsed:Float){
        super.update(elapsed);

        updateHp(elapsed);
    }

    public function updateHp(elapsed:Float) {
		hppercent = Std.int(hp / maxhp * 100);
		hplerp = FlxMath.lerp(hp, hplerp, Utilities.boundTo(1 - (elapsed * 15), 0, 1));	
    }

	public function changeDefense(num:Int):Bool{
		var returnThis:Bool = false;

		defense += num;

		if (defense > maxDefense)
		{
			defense = maxDefense;
			returnThis = true;
		}
		else if (defense < -maxDefense)
		{
			defense = -maxDefense;
			returnThis = true;
		}

		var addThis:Float = defMult * defense;

		realDefense = 1 - addThis;

		return returnThis;
	}

    
    //initializing stuff
    
    public inline function setMaxHp(amount:Int, sethp:Bool):Void{
		maxhp = amount;
        if(sethp) hp = maxhp;
    }

    public inline function setMoveList(newlist:Array<String>):Void{
		moveList = newlist;
    }

    public inline function setAnimations(playidle:Bool):Void{
		var fps:Int = type == 'enemy' ? 2 : 1;

		animation.addByPrefix(idleName, idleName, fps);
		animation.addByPrefix(hurtName, hurtName, fps);
		animation.addByPrefix(deadName, deadName, 1);
		if(playidle) animation.play(idleName);
    }
}