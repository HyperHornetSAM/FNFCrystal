package meta.state.menus;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
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

	var optionShit:Array<String> = ['story mode', 'freeplay', 'options', 'changeskin', 'credits', 'soundtrack', 'twitter'];
	var canSnap:Array<Float> = [];
	
	var storyMenuItem:FlxSprite;
	var storyMenuItem_2:FlxSprite;
	var storyMenuItem_3:FlxSprite;
	var storyMenuItem_4:FlxSprite;
	var freeplayMenuItem:FlxSprite;
	var freeplayMenuItem_2:FlxSprite;
	var freeplayMenuItem_3:FlxSprite;
	var freeplayMenuItem_4:FlxSprite;
	var changeskinMenuItem_1:FlxSprite;
	var changeskinMenuItem_2:FlxSprite;
	var changeskinMenuItem_3:FlxSprite;
	var changeskinMenuItem_4:FlxSprite;
	// the create 'state'
	override function create()
	{
		super.create();

		// set the transitions to the previously set ones
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		// make sure the music is playing
		ForeverTools.resetMenuMusic();

		#if desktop
		Discord.changePresence('MENU SCREEN', 'Main Menu');
		#end

		// uh
		persistentUpdate = persistentDraw = true;

		// background
		bg = new FlxSprite(-85);
		//bg.loadGraphic(Paths.image('menus/base/menuBG'));
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

		magenta = new FlxSprite(-85);
		switch(Init.trueSettings.get('BF Skin')){
			case 'Beta':
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-betaDesat'));
			case 'Mean':
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-meanDesat'));
			case 'Cheffriend':
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-chefDesat'));
			default:
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-bfDesat'));
		}
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
		
		storyMenuItem = new FlxSprite(150, 50).loadGraphic(Paths.image('menus/base/crystalmenu/story'));
		storyMenuItem_2 = new FlxSprite(150, 50).loadGraphic(Paths.image('menus/base/crystalmenu/story_beta'));
		storyMenuItem_3 = new FlxSprite(150, 50).loadGraphic(Paths.image('menus/base/crystalmenu/story_mean'));
		storyMenuItem_4 = new FlxSprite(150, 50).loadGraphic(Paths.image('menus/base/crystalmenu/story_chef'));
		freeplayMenuItem = new FlxSprite(482.5, 50).loadGraphic(Paths.image('menus/base/crystalmenu/freeplay'));
		freeplayMenuItem_2 = new FlxSprite(482.5, 50).loadGraphic(Paths.image('menus/base/crystalmenu/freeplay_proto'));
		freeplayMenuItem_3 = new FlxSprite(482.5, 50).loadGraphic(Paths.image('menus/base/crystalmenu/freeplay_smug'));
		freeplayMenuItem_4 = new FlxSprite(482.5, 50).loadGraphic(Paths.image('menus/base/crystalmenu/freeplay_chef'));
		var optionsMenuItem:FlxSprite = new FlxSprite(815, 50).loadGraphic(Paths.image('menus/base/crystalmenu/options'));
		var selectorMenuItem_1:FlxSprite = new FlxSprite(133, 24).loadGraphic(Paths.image('menus/base/crystalmenu/selector1'));
		var selectorMenuItem_2:FlxSprite = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/thin_selector'));
		var newtwitterMenuItem:FlxSprite =  new FlxSprite(680, 620).loadGraphic(Paths.image('menus/base/crystalmenu/twitter_yuck_shorter'));
		changeskinMenuItem_1 = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/change_skin_beta'));
		changeskinMenuItem_2 = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/change_skin_mean'));
		changeskinMenuItem_3 = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/change_skin_chef'));
		changeskinMenuItem_4 = new FlxSprite(150, 520).loadGraphic(Paths.image('menus/base/crystalmenu/change_skin_normal'));
		var creditsMenuItem:FlxSprite = new FlxSprite(680, 520).loadGraphic(Paths.image('menus/base/crystalmenu/credits'));
		var soundtrackMenuItem:FlxSprite = new FlxSprite(150, 620).loadGraphic(Paths.image('menus/base/crystalmenu/soundtrack'));
		
		storyMenuItem.antialiasing = true;
		storyMenuItem_2.antialiasing = true;
		storyMenuItem_3.antialiasing = true;
		storyMenuItem_4.antialiasing = true;
		freeplayMenuItem.antialiasing = true;
		freeplayMenuItem_2.antialiasing = true;
		freeplayMenuItem_3.antialiasing = true;
		freeplayMenuItem_4.antialiasing = true;
		optionsMenuItem.antialiasing = true;
		selectorMenuItem_1.antialiasing = true;
		selectorMenuItem_2.antialiasing = true;
		newtwitterMenuItem.antialiasing = true;
		changeskinMenuItem_1.antialiasing = true;
		changeskinMenuItem_2.antialiasing = true;
		changeskinMenuItem_3.antialiasing = true;
		changeskinMenuItem_4.antialiasing = true;
		creditsMenuItem.antialiasing = true;
		soundtrackMenuItem.antialiasing = true;
		
		storyMenuItem.alpha = 0;
		storyMenuItem_2.alpha = 0;
		storyMenuItem_3.alpha = 0;
		storyMenuItem_4.alpha = 0;
		
		freeplayMenuItem.alpha = 0;
		freeplayMenuItem_2.alpha = 0;
		freeplayMenuItem_3.alpha = 0;
		freeplayMenuItem_4.alpha = 0;
		
		changeskinMenuItem_1.alpha = 0;
		changeskinMenuItem_2.alpha = 0;
		changeskinMenuItem_3.alpha = 0;
		changeskinMenuItem_4.alpha = 0;
		
		switch(Init.trueSettings.get('BF Skin')){
			case 'Beta':
				storyMenuItem_2.alpha = 1;
				freeplayMenuItem_2.alpha = 1;
				changeskinMenuItem_2.alpha = 1;
			case 'Mean':
				storyMenuItem_3.alpha = 1;
				freeplayMenuItem_3.alpha = 1;
				changeskinMenuItem_3.alpha = 1;
			case 'Cheffriend':
				storyMenuItem_4.alpha = 1;
				freeplayMenuItem_4.alpha = 1;
				changeskinMenuItem_4.alpha = 1;
			default:
				storyMenuItem.alpha = 1;
				freeplayMenuItem.alpha = 1;
				changeskinMenuItem_1.alpha = 1;
		}
		
		add(storyMenuItem);
		add(storyMenuItem_2);
		add(storyMenuItem_3);
		add(storyMenuItem_4);
		add(freeplayMenuItem);
		add(freeplayMenuItem_2);
		add(freeplayMenuItem_3);
		add(freeplayMenuItem_4);
		add(optionsMenuItem);
		add(newtwitterMenuItem);
		add(changeskinMenuItem_1);
		add(changeskinMenuItem_2);
		add(changeskinMenuItem_3);
		add(changeskinMenuItem_4);
		add(creditsMenuItem);
		add(soundtrackMenuItem);
		selectorMenuItem_1.ID = 0;
		selectorMenuItem_2.ID = 1;
		menuItems.add(selectorMenuItem_1);
		menuItems.add(selectorMenuItem_2);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Forever Engine v" + Main.gameVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		#if mobile
		addVirtualPad(LEFT_FULL, A);
		virtualPad.y -= 18;
		#end
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
									curSelected = 5;
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
									curSelected = 5;
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
									curSelected = 6;
								case 3:
									curSelected = 4;
							}
						case 3:
							switch(i){
								case 0:
									curSelected = 4;
								case 1:
									curSelected = 4;
								case 2:
									curSelected = 0;
								case 3:
									curSelected = 5;
							}
						case 4:
							switch(i){
								case 0:
									curSelected = 3;
								case 1:
									curSelected = 3;
								case 2:
									curSelected = 2;
								case 3:
									curSelected = 6;
							}
						case 5:
							switch(i){
								case 0:
									curSelected = 6;
								case 1:
									curSelected = 6;
								case 2:
									curSelected = 3;
								case 3:
									curSelected = 0;
							}
						case 6:
							switch(i){
								case 0:
									curSelected = 5;
								case 1:
									curSelected = 5;
								case 2:
									curSelected = 4;
								case 3:
									curSelected = 2;
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
				menuItems.members[0].x = 465;
			case 2:
				menuItems.members[0].alpha = 1;
				menuItems.members[1].alpha = 0;
				menuItems.members[0].x = 798;
			case 3:
				menuItems.members[0].alpha = 0;
				menuItems.members[1].alpha = 1;
				menuItems.members[1].x = 140;
				menuItems.members[1].y = 512.5;
			case 4:
				menuItems.members[0].alpha = 0;
				menuItems.members[1].alpha = 1;
				menuItems.members[1].x = 670;
				menuItems.members[1].y = 512.5;
			case 5:
				menuItems.members[0].alpha = 0;
				menuItems.members[1].alpha = 1;
				menuItems.members[1].x = 140;
				menuItems.members[1].y = 612.5;
			case 6:
				menuItems.members[0].alpha = 0;
				menuItems.members[1].alpha = 1;
				menuItems.members[1].x = 670;
				menuItems.members[1].y = 612.5;
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
					case 'changeskin':
						transIn = FlxTransitionableState.defaultTransIn;
						transOut = FlxTransitionableState.defaultTransOut;
						selectedSomethin = false;
						new FlxTimer().start(0.2, function(tmr:FlxTimer){changeSkinInMenu();});
						Main.switchState(this, new MainMenuState());
					case 'credits':
						transIn = FlxTransitionableState.defaultTransIn;
						transOut = FlxTransitionableState.defaultTransOut;
						Main.switchState(this, new CreditsMenuState());
					case 'soundtrack':
						FlxG.openURL("https://youtube.com/playlist?list=PLuY8MeN5tU5_USkdzd-ZZwUDW7jYfQ24f");
						trace("Opening Playlist!");
						selectedSomethin = false;
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

	private function changeSkinInMenu(){
		switch(Init.trueSettings.get('BF Skin')){
			case 'Beta':
				Init.trueSettings.set('BF Skin', 'Mean');
				storyMenuItem_2.alpha = 0;
				freeplayMenuItem_2.alpha = 0;
				changeskinMenuItem_2.alpha = 0;
				storyMenuItem_3.alpha = 1;
				freeplayMenuItem_3.alpha = 1;
				changeskinMenuItem_3.alpha = 1;
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-mean'));
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-meanDesat'));
			case 'Mean':
				Init.trueSettings.set('BF Skin', 'Cheffriend');
				storyMenuItem_3.alpha = 0;
				freeplayMenuItem_3.alpha = 0;
				changeskinMenuItem_3.alpha = 0;
				storyMenuItem_4.alpha = 1;
				freeplayMenuItem_4.alpha = 1;
				changeskinMenuItem_4.alpha = 1;
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-chef'));
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-chefDesat'));
			case 'Cheffriend':
				Init.trueSettings.set('BF Skin', 'Normal');
				storyMenuItem_4.alpha = 0;
				freeplayMenuItem_4.alpha = 0;
				changeskinMenuItem_4.alpha = 0;
				storyMenuItem.alpha = 1;
				freeplayMenuItem.alpha = 1;
				changeskinMenuItem_1.alpha = 1;
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-bf'));
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-bfDesat'));
			default:
				Init.trueSettings.set('BF Skin', 'Beta');
				storyMenuItem.alpha = 0;
				freeplayMenuItem.alpha = 0;
				changeskinMenuItem_1.alpha = 0;
				storyMenuItem_2.alpha = 1;
				freeplayMenuItem_2.alpha = 1;
				changeskinMenuItem_2.alpha = 1;
				bg.loadGraphic(Paths.image('menus/base/menucards/menu-beta'));
				magenta.loadGraphic(Paths.image('menus/base/menucards/menu-betaDesat'));
		}
	}
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
