package objects;

class CharacterBioBubble extends FlxTypedGroup<FlxSprite>
{
    var hud:Hud;

    var bubble:FlxSprite;
    var text:FlxText;

	public function new()
	{
		super();

        bubble = new FlxSprite();
        bubble.frames = Paths.getSparrowAtlas('characterSelect/biobubble', 'menu');
        bubble.animation.addByPrefix('idle', 'idle', 2);
        bubble.animation.play('idle');
        bubble.setGraphicSize(Std.int(bubble.width * .6));
        bubble.updateHitbox();
		bubble.antialiasing = SaveData.settings.get('antiAliasing');
        add(bubble);

        text = new FlxText(0, 0, bubble.width / 1.5, '-Placeholder-\n\nFUFDFKSDJFKJNSDFJKNKJDNFKJNBSDKFJNS');
		text.setFormat(Paths.font("andy", 'global'), 25, FlxColor.WHITE, CENTER);
        text.antialiasing = SaveData.settings.get('antiAliasing');
        add(text);

        visible = false;
    }

    public function updateText(spr:Ally):Void{
        text.text = '- ' + Battle.getVanityName(spr.name, 'ally') + ' -\n\n' + Utilities.grabThingFromText(spr.name, Paths.txt('allyBios', 'menu'), 1);
        bubble.setPosition(spr.x + spr.width / 2 - bubble.width / 2, 0);
        text.setPosition(bubble.x + bubble.width / 2 - text.width / 2, bubble.y + 25);
    }
}