class_name PlayerStats extends Node

#stores player stats
#Just data, no processors and other effects yet

#separate weapon data modifiers for each weapon and both
#movement data modifiers

#save/load stats

#save list of upgrades?
#


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func get_actual_weapon_stats(weaponIndex:int, gunData:WeaponData)->WeaponData:
	return gunData
