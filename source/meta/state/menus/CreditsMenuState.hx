package meta.state.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.addons.transition.FlxTransitionableState;
import meta.data.*;
import openfl.Assets;
import meta.MusicBeat.MusicBeatState;
import gameObjects.*;
import gameObjects.userInterface.*;
import sys.io.File;
import flixel.system.FlxSound;

using StringTools;

class CreditsMenuState extends MusicBeatState
{
	var creditstop:FlxText;
	var credits1:FlxText;
	var credits2:FlxText;
	var credits3:FlxText;
	var credits4:FlxText;
	var credits5:FlxText;
	var credits6:FlxText;
	var credits7:FlxText;
	var credits8:FlxText;
	var credits9:FlxText;
	var credits10:FlxText;
	var bg:FlxSprite;
	var icon1:FlxSprite;
	var icon2:FlxSprite;
	var icon3:FlxSprite;
	
	override function create()
	{
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('credits'), 0.7);
		bg = new FlxSprite(-85);
		//bg.loadGraphic(Paths.image('menus/base/menuBGMagenta'));
		switch(Init.trueSettings.get('BF Skin')){
			case 'Beta':
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-beta'));
			case 'Mean':
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-mean'));
			case 'Cheffriend':
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-chef'));
			default:
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-bf'));
		}
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
		
		icon1 = new FlxSprite(605, 30).loadGraphic(Paths.image('menus/base/creditsmenu/hornet-icon'));
		add(icon1);
		icon2 = new FlxSprite(250, 10).loadGraphic(Paths.image('menus/base/creditsmenu/onek-icon'));
		add(icon2);
		icon3 = new FlxSprite(865, 30).loadGraphic(Paths.image('menus/base/creditsmenu/tatsu-icon'));
		add(icon3);
		creditstop = new FlxText(400, 5, 0, "", 20);
		creditstop.text = "Friday Night Funkin': Crystal Credits";
		creditstop.alignment = CENTER;
		creditstop.scrollFactor.set();
		add(creditstop);
		credits1 = new FlxText(200, 125, 0, "", 20);
		credits1.text = "Keno9988\nDirector, Artist,\nComposer, Charter";
		credits1.alignment = CENTER;
		credits1.scrollFactor.set();
		add(credits1);
		credits2 = new FlxText(400, 125, 0, "", 20);
		credits2.text = "HyperSAM\nProgrammer";
		credits2.screenCenter(X);
		credits2.alignment = CENTER;
		credits2.scrollFactor.set();
		add(credits2);
		credits3 = new FlxText(800, 125, 0, "", 20);
		credits3.text = "KinbeeLovemail\nSmug Crystal GF VA";
		credits3.alignment = CENTER;
		credits3.scrollFactor.set();
		add(credits3);
		credits4 = new FlxText(300, 225, 0, "", 20);
		credits4.text = "Anonymous\nCrystal Bonus Song Charts";
		credits4.alignment = CENTER;
		credits4.scrollFactor.set();
		add(credits4);
		credits5 = new FlxText(700, 225, 0, "", 20);
		credits5.text = "spacelaboratory\nProto Crystal GF VA";
		credits5.alignment = CENTER;
		credits5.scrollFactor.set();
		add(credits5);
		credits6 = new FlxText(400, 500, 0, "", 20);
		credits6.text = "Special Thanks:\nForever Engine Devs - Crystal 2.0 Assistance\nninjamuffin, phantomarcade, kawaisprite, evilsk8r - Base Game\nGabeDut - Original Minus Smug GF and Minus Proto GF Designs";
		credits6.screenCenter(X);
		credits6.alignment = CENTER;
		credits6.scrollFactor.set();
		add(credits6);
		credits7 = new FlxText(400, 615, 0, "", 20);
		credits7.text = "The bonus songs in this mod are not part of \nany official collaboration with the original creators of those characters.";
		credits7.screenCenter(X);
		credits7.alignment = CENTER;
		credits7.scrollFactor.set();
		add(credits7);
		credits8 = new FlxText(400, 685, 0, "", 20);
		credits8.text = #if mobile "Touch the [SCREEN]" #else "Press [ENTER]" #end + " to return to the main menu.";
		credits8.screenCenter(X);
		credits8.alignment = CENTER;
		credits8.scrollFactor.set();
		add(credits8);
		credits10 = new FlxText(400, 300, 0, "", 20);
		credits10.text = "Bonus Character Credits:\nAGOTI - SugarRatio \nRon - HiPhlox\nAce - Kamex\nValerie - ZipCorner\n/v/-tan & Cancer Lord - 3AB\nMaggie - Theycallhimcake";
		credits10.screenCenter(X);
		credits10.alignment = CENTER;
		credits10.scrollFactor.set();
		add(credits10);
	}
	
	override function update(elapsed:Float)
	{
		#if mobile
		var justTouched:Bool = false;
		for (touch in FlxG.touches.list)
			if (touch.justPressed)
				justTouched = true;
		#else

		if(controls.ACCEPT #if mobile || justTouched #end){
			exitState();
		}

		super.update(elapsed);
	}

	public function exitState()
	{
		trace("Yo lol");
		FlxG.sound.music.stop();
		// play menu music
		ForeverTools.resetMenuMusic();

		// set up transitions
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		Main.switchState(this, new MainMenuState());
		
	}
}
