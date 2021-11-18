package gameObjects.userInterface.menu;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite
{
	public var character:String = '';

	var curCharacterMap:Map<String, Array<Dynamic>> = [
		// the format is currently
		// name of character => id in atlas, fps, loop, scale, offsetx, offsety
		//'bf' => ["bf normal", 24, true, .8, -240, 0],
		//'bfConfirm' => ["bf normal", 24, true, .8, -240, -60],
		//'xmas-bf' => ["bf christmas", 24, true, .8, -260, -60],
		'gf' => ["BF STORY MENU0000", 24, true, .8, -220, -75],
		'dad' => ["BF STORY MENU0001", 24, true, .8, -220, -75],
		'spooky' => ["BF STORY MENU0002", 24, true, .8, -220, -75],
		'pico' => ["BF STORY MENU0003", 24, true, .8, -220, -75],
		'mom' => ["BF STORY MENU0004", 24, true, .8, -220, -75],
		'parents-christmas' => ["BF STORY MENU0005", 24, true, .8, -220, -75],
		'senpai' => ["BF STORY MENU0006", 24, true, .8, -220, -75]
	];

	var baseX:Float = 0;
	var baseY:Float = 0;

	public function new(x:Float, newCharacter:String = 'bf')
	{
		super(x);
		y += 70;
		if(newCharacter == 'bf' || newCharacter == 'xmas-bf'
		|| newCharacter == 'beta-bf' || newCharacter == 'xmas-beta-bf' 
		|| newCharacter == 'mean-bf' || newCharacter == 'xmas-mean-bf'
		|| newCharacter == 'chef-bf' || newCharacter == 'xmas-chef-bf'){
			y += 170;
		}
		baseX = x;
		baseY = y;
		createCharacter(newCharacter);
		updateHitbox();
	}

	public function createCharacter(newCharacter:String, canChange:Bool = false)
	{
		var tex = Paths.getSparrowAtlas('menus/base/storymenu/MENU_NORMAL');
		switch(Init.trueSettings.get('BF Skin')){
			case 'Beta':
				tex = Paths.getSparrowAtlas('menus/base/storymenu/MENU_BETA');
			case 'Mean':
				tex = Paths.getSparrowAtlas('menus/base/storymenu/MENU_MEAN');
			case 'Cheffriend':
				tex = Paths.getSparrowAtlas('menus/base/storymenu/MENU_CHEF');
			default:
				tex = Paths.getSparrowAtlas('menus/base/storymenu/MENU_NORMAL');
		}
		frames = tex;
		var assortedValues = curCharacterMap.get(newCharacter);
		if (assortedValues != null)
		{
			if (!visible)
				visible = true;

			// animation
			animation.addByPrefix(newCharacter, assortedValues[0], assortedValues[1], assortedValues[2]);
			// if (character != newCharacter)
			animation.play(newCharacter);

			if (canChange)
			{
				// offset
				setGraphicSize(Std.int(width * assortedValues[3]));
				updateHitbox();
				setPosition(baseX + assortedValues[4], baseY + assortedValues[5]);

				/*if (newCharacter == 'pico')
					flipX = true;
				else
					flipX = false;*/
			}
		}
		else
			visible = false;

		character = newCharacter;
	}
}
