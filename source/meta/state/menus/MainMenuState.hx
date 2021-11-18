package meta.state.menus;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import meta.MusicBeat.MusicBeatState;
import meta.data.dependency.Discord;

using StringTools;

/**
	This is the main menu state! Not a lot is going to change about it so it'll remain similar to the original, but I do want to condense some code and such.
	Get as expressive as you can with this, create your own menu!
**/
class MainMenuState extends MusicBeatState
{
	var menuItems:FlxTypedGroup<FlxSprite>;
	var curSelected:Float = 0;

	var bg:FlxSprite; // the background has been separated for more control
	var magenta:FlxSprite;
	var camFollow:FlxObject;

	var optionShit:Array<String> = ['story mode', 'freeplay', 'options', 'twitter'];
	var canSnap:Array<Float> = [];

	// the create 'state'
	override function create()
	{
		super.create();

		// set the transitions to the previously set ones
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		// make sure the music is playing
		ForeverTools.resetMenuMusic();

		#if !html5
		Discord.changePresence('MENU SCREEN', 'Main Menu');
		#end

		// uh
		persistentUpdate = persistentDraw = true;

		// background
		bg = new FlxSprite(-85);
		bg.loadGraphic(Paths.image('menus/base/menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		magenta = new FlxSprite(-85).loadGraphic(Paths.image('menus/base/menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

		// add the camera
		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		// add the menu items
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		// create the menu items themselves
		var tex = Paths.getSparrowAtlas('menus/base/title/FNF_main_menu_assets');
		
		var storyMenuItem:FlxSprite = new FlxSprite(150, 50).loadGraphic(Paths.image('menus/base/crystalmenu/story'));
		var freeplayMenuItem:FlxSprite = new FlxSprite(482.5, 50).loadGraphic(Paths.image('menus/base/crystalmenu/freeplay'));
		var optionsMenuItem:FlxSprite = new FlxSprite(815, 50).loadGraphic(Paths.image('menus/base/crystalmenu/options'));
		var twitterMenuItem:FlxSprite = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/twitter_yuck'));
		var selectorMenuItem_1:FlxSprite = new FlxSprite(133, 24).loadGraphic(Paths.image('menus/base/crystalmenu/selector1'));
		var selectorMenuItem_2:FlxSprite = new FlxSprite(133, 509).loadGraphic(Paths.image('menus/base/crystalmenu/selector2'));
		
		storyMenuItem.antialiasing = true;
		freeplayMenuItem.antialiasing = true;
		optionsMenuItem.antialiasing = true;
		twitterMenuItem.antialiasing = true;
		selectorMenuItem_1.antialiasing = true;
		selectorMenuItem_2.antialiasing = true;
		
		add(storyMenuItem);
		add(freeplayMenuItem);
		add(optionsMenuItem);
		add(twitterMenuItem);
		selectorMenuItem_1.ID = 0;
		selectorMenuItem_2.ID = 1;
		menuItems.add(selectorMenuItem_1);
		menuItems.add(selectorMenuItem_2);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Forever Engine v" + Main.gameVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

	}

	// var colorTest:Float = 0;
	var selectedSomethin:Bool = false;
	var counterControl:Float = 0;

	override function update(elapsed:Float)
	{
		var left_p = controls.LEFT_P;
		var right_p = controls.RIGHT_P;
		var up_p = controls.UP_P;
		var down_p = controls.DOWN_P;
		var controlArray:Array<Bool> = [left_p, right_p, up_p, down_p];
		
		if ((controlArray.contains(true)) && (!selectedSomethin))
		{	
			for (i in 0...controlArray.length)
			{
				// here we check which keys are pressed
				if (controlArray[i] == true)
				{
					// if single press
					switch(curSelected){
						case 0:
							switch(i){
								case 0:
									curSelected = 2;
								case 1:
									curSelected = 1;
								case 2:
									curSelected = 3;
								case 3:
									curSelected = 3;
							}
						case 1:
							switch(i){
								case 0:
									curSelected = 0;
								case 1:
									curSelected = 2;
								case 2:
									curSelected = 3;
								case 3:
									curSelected = 3;
							}
						case 2:
							switch(i){
								case 0:
									curSelected = 1;
								case 1:
									curSelected = 0;
								case 2:
									curSelected = 3;
								case 3:
									curSelected = 3;
							}
						case 3:
							switch(i){
								case 0:
									curSelected = 0;
								case 1:
									curSelected = 2;
								case 2:
									curSelected = 1;
								case 3:
									curSelected = 1;
							}
					}
					if (curSelected < 0)
						curSelected = optionShit.length - 1;
					else if (curSelected >= optionShit.length)
						curSelected = 0;
				}
			}
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		else
		{
			// reset variables
			counterControl = 0;
		}
		switch(curSelected){
			case 0:
				menuItems.members[0].alpha = 1;
				menuItems.members[1].alpha = 0;
				menuItems.members[0].x = 133;
			case 1:
				menuItems.members[0].alpha = 1;
				menuItems.members[1].alpha = 0;
				menuItems.members[0].x = 465.5;
			case 2:
				menuItems.members[0].alpha = 1;
				menuItems.members[1].alpha = 0;
				menuItems.members[0].x = 798;
			case 3:
				menuItems.members[0].alpha = 0;
				menuItems.members[1].alpha = 1;
		}
		if ((controls.ACCEPT) && (!selectedSomethin))
		{
			//
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));

			FlxFlicker.flicker(magenta, 0.8, 0.1, false);
			
			var curMenuNum:Int = 0;
			if(menuItems.members[1].alpha == 1){
				curMenuNum = 1;
			}
			
			FlxFlicker.flicker(menuItems.members[curMenuNum], 1, 0.06, true, false, function(flick:FlxFlicker)
			{
				var daChoice:String = optionShit[Math.floor(curSelected)];
				switch (daChoice)
				{
					case 'story mode':
						Main.switchState(this, new StoryMenuState());
					case 'freeplay':
						Main.switchState(this, new FreeplayState());
					case 'options':
						transIn = FlxTransitionableState.defaultTransIn;
						transOut = FlxTransitionableState.defaultTransOut;
						Main.switchState(this, new OptionsMenuState());
					case 'twitter':
						FlxG.openURL("https://twitter.com/FNFCrystal");
						trace("Opening Twitter Page!");
						selectedSomethin = false;
				}
			});
		}
		super.update(elapsed);
	}

	var lastCurSelected:Int = 0;

	private function updateSelection()
	{
		// reset all selections
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();
		});

		// set the sprites and all of the current selection
		camFollow.setPosition(menuItems.members[Math.floor(curSelected)].getGraphicMidpoint().x,
			menuItems.members[Math.floor(curSelected)].getGraphicMidpoint().y);

		if (menuItems.members[Math.floor(curSelected)].animation.curAnim.name == 'idle')
			menuItems.members[Math.floor(curSelected)].animation.play('selected');

		menuItems.members[Math.floor(curSelected)].updateHitbox();

		lastCurSelected = Math.floor(curSelected);
	}
}
