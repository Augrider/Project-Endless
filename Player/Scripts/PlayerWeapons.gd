class_name PlayerWeapons extends Node2D

@export var weapon1: Weapon
@export var weapon2: Weapon


#func _process(delta: float) -> void:
	#if Input.get_action_strength("weapon_1"):
		#press_trigger(weapon1)
	#else:
		#release_trigger(weapon1)
