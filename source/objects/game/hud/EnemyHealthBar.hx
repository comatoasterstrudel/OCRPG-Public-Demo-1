package objects.game.hud;

class EnemyHealthBar extends FlxTypedGroup<FlxSprite>
{
    //sprites and groups
    
	public var enemyHealthBarOutline:FlxSprite;
	public var enemyHealthBar:FlxBar;
	public var enemyHealthText:FlxText;

    //data
    
	var enemyCharacter:Enemy;

	public var enemyHealthLerp:Float;
    
	public function new(coolenemy:Enemy)
	{
		super();

		enemyCharacter = coolenemy;

		enemyHealthBarOutline = new FlxSprite().loadGraphic(Paths.image('ui/enemyHpBar', 'battle'));
		enemyHealthBarOutline.setGraphicSize(Std.int(enemyHealthBarOutline.width * .45));
		enemyHealthBarOutline.updateHitbox();
		enemyHealthBarOutline.setPosition(FlxG.width / 2 - enemyHealthBarOutline.width / 2, 0);
		enemyHealthBarOutline.antialiasing = SaveData.settings.get('antiAliasing');

		enemyHealthBar = new FlxBar(0, 20, LEFT_TO_RIGHT, Std.int(enemyHealthBarOutline.width - 55), 48, this, 'enemyHealthLerp', 0, enemyCharacter.maxHealth);
		enemyHealthBar.setPosition(FlxG.width / 2 - enemyHealthBar.width / 2, 42);
		enemyHealthBar.createFilledBar(Battle.depletedHealthColor, Std.parseInt('0xFF' + Utilities.grabThingFromText(enemyCharacter.name, Paths.txt('battleData', 'battle'), 13)));
		enemyHealthBar.updateBar();
		enemyHealthBar.numDivisions = Std.int(enemyHealthBar.width);

		enemyHealthText = new FlxText(0, 5, 0, 'test');
		enemyHealthText.setFormat(Paths.font("andy", 'global'), 30, Std.parseInt('0xFF' + Utilities.grabThingFromText(enemyCharacter.name, Paths.txt('battleData', 'battle'), 13)), CENTER, OUTLINE, FlxColor.BLACK);
		enemyHealthText.borderSize = 2;
		enemyHealthText.antialiasing = SaveData.settings.get('antiAliasing');

		add(enemyHealthBar);
		add(enemyHealthBarOutline);
		add(enemyHealthText);
	}

	public function updateText(elapsed:Float):Void
	{
		enemyHealthText.text = enemyCharacter.enemyHealth + ' / ' + enemyCharacter.maxHealth;
		enemyHealthText.screenCenter(X);
		enemyHealthText.angle = FlxMath.lerp(0, enemyHealthText.angle, Utilities.boundTo(1 - (elapsed * 15), 0, 1));
	}
}