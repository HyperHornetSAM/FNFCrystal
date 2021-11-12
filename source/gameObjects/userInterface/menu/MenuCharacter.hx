package gameObjects.userInterface.menu;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite
{
	public var character:String = '';

	var curCharacterMap:Map<String, Array<Dynamic>> = [
		// the format is currently
		// name of character => id in atlas, fps, loop, scale, offsetx, offsety
		'bf' => ["bf normal", 24, true, 1, 30, 0],
		//'bfConfirm' => ["bf normal", 24, true, 1, 0, 0],
		'xmas-bf' => ["bf christmas", 24, true, 1, 0, 0],
		'beta-bf' => ['beta bf0', 24, true, 1, 0, 0],
		'xmas-beta-bf' => ['beta bf xmas', 24, true, 1, 0, 0],
		'mean-bf' => ['mean bf0', 24, true, 1, 0, 0],
		'xmas-mean-bf' => ['mean bf xmas', 24, true, 1, 0, 0],
		'chef-bf' => ['cheffriend0', 24, true, 1, 0, 0],
		'xmas-chef-bf' => ['cheffriend xmas', 24, true, 1, 0, 0],
		'gf' => ["gf", 24, true, 1, -100, 155],
		'dad' => ["dad", 24, true, 1.5, -150, 50],
		'spooky' => ["spooky kids", 24, true, 1, -50, 40],
		'pico' => ["pico", 24, true, 1.5, -165, 75],
		'mom' => ["mom", 24, true, 1, -100, 55],
		'parents-christmas' => ["parents", 24, true, 1.5, -150, 60],
		'senpai' => ["senpai", 24, true, 1, -100, 42]
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
		var tex = Paths.getSparrowAtlas('menus/base/storymenu/crystal_menu_characters');
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
