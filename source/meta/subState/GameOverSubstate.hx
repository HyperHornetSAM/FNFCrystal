package meta.subState;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import gameObjects.Boyfriend;
import meta.MusicBeat.MusicBeatSubState;
import meta.data.Conductor.BPMChangeEvent;
import meta.data.Conductor;
import meta.state.*;
import meta.state.menus.*;
import meta.data.dependency.FNFSprite;

class GameOverSubstate extends MusicBeatSubState
{
	//
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var stageSuffix:String = "";
	var randomInt:Int;

	public function new(x:Float, y:Float)
	{
		var daBoyfriendType = PlayState.boyfriend.curCharacter;
		var daBf:String = '';
		switch (daBoyfriendType)
		{
			case 'bf-og':
				daBf = daBoyfriendType;
			case 'bf-pixel':
				daBf = 'bf-pixel-dead';
				stageSuffix = '-pixel';
			case 'mean-bf-pixel':
				daBf = 'bf-pixel-dead';
				stageSuffix = '-pixel';
			case 'beta-bf-pixel':
				daBf = 'bf-pixel-dead';
				stageSuffix = '-pixel';
			case 'chef-bf-pixel':
				daBf = 'bf-pixel-dead';
				stageSuffix = '-pixel';
			case 'bf-alt':
				daBf = 'bf-alt-dead';
				stageSuffix = '';
			case 'beta-bf-alt':
				daBf = 'bf-alt-dead';
				stageSuffix = '';
			case 'mean-bf-alt':
				daBf = 'bf-alt-dead';
				stageSuffix = '';
			case 'chef-bf-alt':
				daBf = 'bf-alt-dead';
				stageSuffix = '';
			case 'onek' | 'onek-happy' | 'onek-inverted':
				daBf = 'bf-onek-dead';
				stageSuffix = '-onek';
			default:
				daBf = 'bf-dead';
				stageSuffix = '';
		}

		PlayState.boyfriend.destroy();

		super();

		Conductor.songPosition = 0;
		
		if(daBf == 'bf-onek-dead'){
			var onekDeathBG:FNFSprite = new FNFSprite(x - 1450, y - 515);
			onekDeathBG.frames = Paths.getSparrowAtlas('characters/onek/onekDeathBG');
			onekDeathBG.setGraphicSize(Std.int(onekDeathBG.width * 0.5));
			onekDeathBG.antialiasing = true;
			onekDeathBG.animation.addByPrefix('anim', "bg", 24, true);
			add(onekDeathBG);
			bf = new Boyfriend(x - 375, y - 145, daBf);
			bf.setGraphicSize(Std.int(bf.width * 0.5));
			add(bf);
			var onekDeathShadow:FNFSprite = new FNFSprite(x - 1015, y - 480).loadGraphic(Paths.image('characters/onek/shadow_cast'));
			onekDeathShadow.setGraphicSize(Std.int(onekDeathShadow.width * 0.5));
			onekDeathShadow.antialiasing = true;
			add(onekDeathShadow);
			onekDeathBG.playAnim('anim');
			FlxG.sound.load(Paths.sound('rainfall'), 0.5, true);
			camFollow = new FlxObject(bf.getGraphicMidpoint().x - 150, bf.getGraphicMidpoint().y - 110, 1, 1);
			add(camFollow);
		}
		else
		{
			bf = new Boyfriend(x, y, daBf);
			add(bf);
			camFollow = new FlxObject(bf.getGraphicMidpoint().x + 20, bf.getGraphicMidpoint().y - 40, 1, 1);
			add(camFollow);
		}
		

		if(stageSuffix != '-onek'){
			FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		}
		else{
			FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix), 0.15, true);
		}
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;
		if(stageSuffix == '-onek'){
			FlxG.camera.zoom = 1.35;
		}

		bf.playAnim('firstDeath');

		#if mobile
		addVirtualPad(NONE, A_B);
		addVirtualPadCamera();
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
			endBullshit();

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
			{
				Main.switchState(this, new StoryMenuState());
			}
			else
				Main.switchState(this, new FreeplayState());
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
			FlxG.camera.follow(camFollow, LOCKON, 0.01);

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished && bf.curCharacter != 'bf-onek-dead'){
			randomInt = FlxG.random.int(0, 9);
			trace("Number pulled is: " + randomInt + "!");
			if(randomInt == 9){
				FlxG.sound.playMusic(Paths.music('altgameOver'));
			}
			else
			{
				FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			}
		}
		
		/*else if(bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished && bf.curCharacter == 'bf-onek-dead'){
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
		}*/

		// if (FlxG.sound.music.playing)
		//	Conductor.songPosition = FlxG.sound.music.time;
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			if(randomInt == 9){
				FlxG.sound.play(Paths.music('altgameOverEnd'));
			}
			else{
				if(stageSuffix == '-onek'){
					FlxG.sound.destroy(true);
				}
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			}
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
				{
					Main.switchState(this, new PlayState());
				});
			});
			//
		}
	}
}
