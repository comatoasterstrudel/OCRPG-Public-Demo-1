package objects.game;

using StringTools;

class AttackAnimation extends FlxSprite
{
	var doDestroy:Bool;

	public function new(sprite:FlxSprite, spriteName:String, fps:Int, camera:FlxCamera, flippable:Bool, alluNum:Int, ?resize:Float = 0, ?destroy:Bool = true, ?loop:Bool = true)
	{
		super();

		var looper:Bool = true;
		if(!destroy && !loop) looper = false;
		if(!destroy && loop) looper = true;
		if(destroy) looper = false;
		
		doDestroy = destroy;
		
		frames = Paths.getSparrowAtlas('attackanims/attackanim_' + spriteName, 'battle');
		animation.addByPrefix('idle', 'idle', fps, looper);
		animation.play('idle');
		setGraphicSize(Std.int(width * .7));
		updateHitbox();
		if(resize != 0){
			setGraphicSize(Std.int(width * resize));
			updateHitbox();
		}
		setPosition(sprite.x + sprite.width / 2 - width / 2, sprite.y + sprite.height / 2 - height / 2);
		SaveData.settings.get('antiAliasing');
		cameras = [camera];

		if(flippable && alluNum == 0) flipX = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (animation.curAnim.finished && doDestroy)
			destroy();
	}
}
