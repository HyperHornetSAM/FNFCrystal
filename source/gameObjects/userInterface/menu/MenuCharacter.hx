package gameObjects.userInterface.menu;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class MenuCharacter extends FlxSprite
{
	public var character:String = '';

	var curCharacterMap:Map<String, Array<Dynamic>> = [
		// the format is currently
		// name of character => id in atlas, fps, loop, scale, offsetx, offsety
		'bf' => ["bf normal", 24, true, 1, 1500, 0],
		//'bfConfirm' => ["bf normal", 24, true, 1, 0, 0],
		'xmasbf' => ['bf christmas', 24, true, 1, 0, 0],
		'gf' => ["gf", 24, true, 1, -100, 100],
		'dad' => ["dad", 24, true, 1.25, -50, 100],
		'spooky' => ["spooky kids", 24, true, 1, 0, 40],
		'pico' => ["pico", 24, true, 1, -50, 150],
		'mom' => ["mom", 24, true, .75, -50, 25],
		'parents-christmas' => ["parents", 24, true, 1.25, -100, 60],
		'senpai' => ["senpai", 24, true, .75, -50, 0]
	];

	var baseX:Float = 0;
	var baseY:Float = 0;

	public function new(x:Float, newCharacter:String = 'bf')
	{
		super(x);
		y += 70;
		if(newCharacter == 'bf' || newCharacter == 'xmasbf'){
			y += 150;
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
