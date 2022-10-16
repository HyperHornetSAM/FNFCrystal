package gameObjects.userInterface;

import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	// rewrite using da new icon system as ninjamuffin would say it
	public var sprTracker:FlxSprite;
	public var exclusions:Array<String> = ['pixel', 'christmas', 'opera', 'popstar', 'inverted', 'alt'];

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		updateIcon(char, isPlayer);
	}

	public function updateIcon(char:String = 'bf', isPlayer:Bool = false)
	{
		if (char.contains('-'))
		{
			if (!exclusions.contains(char.substring(char.indexOf('-') + 1, char.length)))
				char = char.substring(0, char.indexOf('-'));
		}

		antialiasing = true;
		
		if(char == 'bf' || char == 'bf-pixel' || char == 'bf-christmas'){
			switch(Init.trueSettings.get('BF Skin')){
				case 'Beta':
					loadGraphic(Paths.image('icons/icon-beta-' + char), true, 150, 150);
				case 'Mean':
					loadGraphic(Paths.image('icons/icon-mean-' + char), true, 150, 150);
				case 'Cheffriend':
					loadGraphic(Paths.image('icons/icon-chef-' + char), true, 150, 150);
				default:
					loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
			}
		}
		else if(char == 'bf-alt'){
			switch(Init.trueSettings.get('BF Skin')){
				case 'Beta':
					loadGraphic(Paths.image('icons/icon-beta-bf'), true, 150, 150);
				case 'Mean':
					loadGraphic(Paths.image('icons/icon-mean-bf'), true, 150, 150);
				case 'Cheffriend':
					loadGraphic(Paths.image('icons/icon-chef-bf'), true, 150, 150);
				default:
					loadGraphic(Paths.image('icons/icon-bf'), true, 150, 150);
			}
		}
		else if(char == 'gf'){
			switch(Init.trueSettings.get('BF Skin')){
				case 'Beta':
					loadGraphic(Paths.image('icons/icon-proto-' + char), true, 150, 150);
				case 'Mean':
					loadGraphic(Paths.image('icons/icon-smug-' + char), true, 150, 150);
				case 'Cheffriend':
					loadGraphic(Paths.image('icons/icon-chef-' + char), true, 150, 150);
				default:
					loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
			}
		}
		else{
			loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
		}
		animation.add('icon', [0, 1], 0, false, isPlayer);
		animation.play('icon');
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
