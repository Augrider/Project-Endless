##A type of modifier that applies to projectiles one time at the moment of gun fire
class_name WeaponModifier extends Resource

@export var power:float=1


func apply(spaceObject:SpaceObject, weapon:Weapon, projectiles:Array)->bool:
	return false
