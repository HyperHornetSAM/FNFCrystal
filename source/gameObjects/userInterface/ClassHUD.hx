package gameObjects.userInterface;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import meta.CoolUtil;
import meta.InfoHud;
import meta.data.Conductor;
import meta.data.Timings;
import meta.state.PlayState;

using StringTools;

class ClassHUD extends FlxTypedGroup<FlxBasic>
{
	// set up variables and stuff here
	var infoBar:FlxText; // small side bar like kade engine that tells you engine info
	var scoreBar:FlxText;

	var scoreLast:Float = -1;
	var scoreDisplay:String;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var SONG = PlayState.SONG;
	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var stupidHealth:Float = 0;

	// eep
	public function new()
	{
		// call the initializations and stuffs
		super();

		// fnf mods
		var scoreDisplay:String = 'beep bop bo skdkdkdbebedeoop brrapadop';

		// le healthbar setup
		var barY = FlxG.height * 0.875;
		if (Init.trueSettings.get('Downscroll'))
			barY = 64;

		healthBarBG = new FlxSprite(0,
			barY).loadGraphic(Paths.image(ForeverTools.returnSkinAsset('healthBar', PlayState.assetModifier, PlayState.changeableSkin, 'UI')));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8));
		healthBar.scrollFactor.set();
		
		//set up color variables
		var P1HealthBarColor:Array<FlxColor> = [0xFF66FF33];
		var P2HealthBarColor:Array<FlxColor> = [0xFFFF0000];
		switch(SONG.player1) {
			case 'bf' | 'bf-pixel' | 'bf-christmas' | 'bf-car' | 'bf-alt':
				switch(Init.trueSettings.get('BF Skin')){
					case 'Mean':
						P1HealthBarColor = [0xFFF6F41C];
					case 'Beta':
						P1HealthBarColor = [0xFFF4313F];
					default:
						P1HealthBarColor = [0xFF2D76FF];
				}
			case 'gf':
				switch(Init.trueSettings.get('BF Skin')){
					case 'Mean':
						P2HealthBarColor = [0xFFF6F41C];
					case 'Beta':
						P2HealthBarColor = [0xFFFF5889];
					default:
						P2HealthBarColor = [0xFFE879FF];
				}
				
			case 'dad':
				P1HealthBarColor = [0xFFFC731E];
				
			case 'parents-christmas':
				P1HealthBarColor = [0xFFFC731E, 0xFFFC731E, 0xFF603373];
				
			case 'spooky': 
				P1HealthBarColor = [0xFF98C73F, 0xFF98C73F, 0xFF604C8D];
				
			case 'monster':
				P1HealthBarColor = [0xFFC92930];
				
			case 'pico':
				P1HealthBarColor = [0xFF1D5A41];
				
			case 'mom' | 'mom-car':
				P1HealthBarColor = [0xFF603373];
				
			case 'christmas-monster':
				P1HealthBarColor = [0xFFE5E9ED];
				
			case 'senpai' | 'roses-senpai':
				P1HealthBarColor = [0xFF3B4759];
				
			case 'spirit':
				P1HealthBarColor = [0xFFA8E8FF];
				
			case 'ace':
				P1HealthBarColor = [0xFFBBE2FE];
				
			case 'tankman':
				P1HealthBarColor = [0xFF81949A];
				
			case 'cancer':
				P1HealthBarColor = [0xFF00FFAA];
			
			case 'vtan':
				P1HealthBarColor = [0xFF7745B1, 0xFF7745B1, 0xFF3AB145];
				
			case 'valerie-opera' | 'valerie-popstar':
				P1HealthBarColor = [0xFF9BD2DC];
				
			case 'onek' | 'onek-happy':
				P1HealthBarColor = [0xFFB05007];
			
			case 'maggie':
				P1HealthBarColor = [0xFFFFB3E5];
			
			case 'maggie-inverted' | 'onek-inverted':
				P1HealthBarColor = [0xFFFFFFFF];
			
			case 'sonic':
				P1HealthBarColor = [0xFF5189B5];
				
			case 'tricky':
				P1HealthBarColor = [0xFF91AC99];
			
			case 'ron':
				P1HealthBarColor = [0xFF9EBFC8];
				
			default:
				P1HealthBarColor = [0xFF66FF33];
			
		}
		switch(SONG.player2) {
			case 'bf' | 'bf-pixel' | 'bf-christmas' | 'bf-car' | 'bf-alt':
				switch(Init.trueSettings.get('BF Skin')){
					case 'Mean':
						P2HealthBarColor = [0xFFF6F41C];
					case 'Beta':
						P2HealthBarColor = [0xFFF4313F];
					default:
						P2HealthBarColor = [0xFF2D76FF];
				}
			case 'gf':
				switch(Init.trueSettings.get('BF Skin')){
					case 'Mean':
						P2HealthBarColor = [0xFFF6F41C];
					case 'Beta':
						P2HealthBarColor = [0xFFFF5889];
					default:
						P2HealthBarColor = [0xFFE879FF];
				}
			case 'dad':
				P2HealthBarColor = [0xFFFC731E];
				
			case 'parents-christmas':
				P2HealthBarColor = [0xFFFC731E, 0xFFFC731E, 0xFF603373];
				
			case 'spooky': 
				P2HealthBarColor = [0xFF98C73F, 0xFF98C73F, 0xFF604C8D];
				
			case 'monster':
				P2HealthBarColor = [0xFFC92930];
				
			case 'pico':
				P2HealthBarColor = [0xFF1D5A41];
				
			case 'mom' | 'mom-car':
				P2HealthBarColor = [0xFF603373];
				
			case 'christmas-monster':
				P2HealthBarColor = [0xFFE5E9ED];
				
			case 'senpai' | 'roses-senpai':
				P2HealthBarColor = [0xFF3B4759];
				
			case 'spirit':
				P2HealthBarColor = [0xFFA8E8FF];
				
			case 'ace':
				P2HealthBarColor = [0xFFBBE2FE];
				
			case 'tankman':
				P2HealthBarColor = [0xFF81949A];
			
			case 'cancer':
				P2HealthBarColor = [0xFF00FFAA];
			
			case 'vtan':
				P2HealthBarColor = [0xFF7745B1, 0xFF7745B1, 0xFF3AB145];
			
			case 'valerie-opera' | 'valerie-popstar':
				P2HealthBarColor = [0xFF9BD2DC];
			
			case 'onek' | 'onek-happy':
				P2HealthBarColor = [0xFFB05007];
			
			case 'maggie':
				P2HealthBarColor = [0xFFFFB3E5];
			
			case 'maggie-inverted' | 'onek-inverted':
				P2HealthBarColor = [0xFFFFFFFF];
				
			case 'sonic':
				P2HealthBarColor = [0xFF5189B5];
				
			case 'tricky':
				P2HealthBarColor = [0xFF91AC99];
				
			case 'ron':
				P2HealthBarColor = [0xFF9EBFC8];
				
			default:
				P2HealthBarColor = [0xFFFF0000];
		}
		healthBar.createGradientBar(P2HealthBarColor, P1HealthBarColor);
		// healthBar
		add(healthBar);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		scoreBar = new FlxText(FlxG.width / 2, healthBarBG.y + 40, 0, scoreDisplay, 20);
		scoreBar.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		updateScoreText();
		scoreBar.scrollFactor.set();
		add(scoreBar);

		// small info bar, kinda like the KE watermark
		// based on scoretxt which I will set up as well
		var infoDisplay:String = CoolUtil.dashToSpace(PlayState.SONG.song) + ' - ' + CoolUtil.difficultyFromNumber(PlayState.storyDifficulty);
		var engineDisplay:String = "Forever Engine BETA v" + Main.gameVersion;
		var engineBar:FlxText = new FlxText(0, FlxG.height - 30, 0, engineDisplay, 16);
		engineBar.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		engineBar.updateHitbox();
		engineBar.x = FlxG.width - engineBar.width - 5;
		engineBar.scrollFactor.set();
		add(engineBar);

		infoBar = new FlxText(5, FlxG.height - 30, 0, infoDisplay, 20);
		infoBar.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoBar.scrollFactor.set();
		add(infoBar);
	}

	override public function update(elapsed:Float)
	{
		// pain, this is like the 7th attempt
		healthBar.percent = (PlayState.health * 50);

		var iconLerp = 0.5;
		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, iconLerp)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, iconLerp)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;
	}

	public function updateScoreText()
	{
		var importSongScore = PlayState.songScore;
		var importPlayStateCombo = PlayState.combo;
		var importMisses = PlayState.misses;
		scoreBar.text = 'Score: $importSongScore';
		// testing purposes
		var displayAccuracy:Bool = Init.trueSettings.get('Display Accuracy');
		if (displayAccuracy)
		{
			scoreBar.text += ' // Accuracy: ' + Std.string(Math.floor(Timings.getAccuracy() * 100) / 100) + '%' + Timings.comboDisplay;
			scoreBar.text += ' // Combo Breaks: ' + Std.string(PlayState.misses);
			scoreBar.text += ' // Rank: ' + Std.string(Timings.returnScoreRating().toUpperCase());
		}

		scoreBar.x = ((FlxG.width / 2) - (scoreBar.width / 2));

		// update playstate
		PlayState.detailsSub = scoreBar.text;
		PlayState.updateRPC(false);
	}

	public function beatHit()
	{
		if (!Init.trueSettings.get('Reduced Movements'))
		{
			iconP1.setGraphicSize(Std.int(iconP1.width + 45));
			iconP2.setGraphicSize(Std.int(iconP2.width + 45));

			iconP1.updateHitbox();
			iconP2.updateHitbox();
		}
		//
	}
	
	public function updateIcons(char:String, isPlayer:Bool)
	{
		if(isPlayer){
			//iconP1 = new HealthIcon(char, true);
			//iconP1.y = healthBar.y - (iconP1.height / 2);
			iconP1.updateIcon(char, true);
		}
		else{
			iconP2.updateIcon(char, false);
		}
		if(char == 'onek-inverted'){
			healthBar.createGradientBar([0xFFFFFFFF], [0xFFFFFFFF]);
		}
		if(char == 'onek'){
			healthBar.createGradientBar([0xFFFFB3E5], [0xFFB05007]);
		}
	}
}
