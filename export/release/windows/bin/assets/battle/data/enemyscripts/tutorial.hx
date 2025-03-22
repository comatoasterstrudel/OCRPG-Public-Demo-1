var tutorialTurnCount:Int = 0;
var tutorialDoneDuoAttack:Bool = false;
var tutorialLastDialogueSeen:Bool = false;
var endingBattle:Bool = false;

function startAllyTurn()
{	
	new FlxTimer().start(.7, function(tmr:FlxTimer)
	{
		switch (tutorialTurnCount)
		{
			case 0:
				dialogueManager('openDialogue', 'tut_01', 'tutorial');
				tutorialTurnCount++;
			case 1:
				dialogueManager('openDialogue', 'tut_02', 'tutorial');
				tutorialTurnCount++;
			case 2:
				dialogueManager('openDialogue', 'tut_03', 'tutorial');
				tutorialTurnCount++;
			case 3:
				dialogueManager('openDialogue', 'tut_04', 'tutorial', function():Void
				{
					PlayState.motivation = 100;

					hud.duoButtonPrompt.addDuoButtonPrompt();

					changeExternalVar('movesSelectable', 0, 0, false);

					new FlxTimer().start(1.3, function(tmr:FlxTimer)
					{
						changeExternalVar('movesSelectable', 0, 0, true);
					});
				});
				tutorialTurnCount++;
			case 4:
				if (!tutorialDoneDuoAttack){
					dialogueManager('openDialogue', 'tut_ignore', 'tutorial');
					tutorialTurnCount++;
				}
				else
				{
					tutorialLastDialogueSeen = true;
					dialogueManager('openDialogue', 'tut_05', 'tutorial');
					tutorialTurnCount++;
				}
			default:
				if (tutorialDoneDuoAttack && tutorialTurnCount > 4 && !tutorialLastDialogueSeen)
				{
					tutorialLastDialogueSeen = true;
					dialogueManager('openDialogue', 'tut_05', 'tutorial');
					tutorialTurnCount++;
				}
		}
	});
}

function duoAttack(attackName:String)
{
	tutorialDoneDuoAttack = true;
}

function winBattle(){
	if(!endingBattle){
		endingBattle = true;

		PlayState.battleReadyToEnd = false;

		if (tutorialLastDialogueSeen)
		{
			dialogueManager('openDialogue', 'tut_win_normal', 'tutorial', function():Void
			{
				PlayState.battleReadyToEnd = true;
				doDeathCheck('forceWin');
			});
		}
		else
		{
			dialogueManager('openDialogue', 'tut_win_interrupt', 'tutorial', function():Void
			{
				PlayState.battleReadyToEnd = true;
				doDeathCheck('forceWin');
			});
		}
	}
}

function loseBattle(){
	if (!endingBattle){
		endingBattle = true;

		PlayState.battleReadyToEnd = false;

		dialogueManager('openDialogue', 'tut_lose', 'tutorial', function():Void
		{
			PlayState.battleReadyToEnd = true;
			doDeathCheck('forceLose');
		});
	}
}