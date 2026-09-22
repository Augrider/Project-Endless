class_name WeaponDisplayUI extends Control

@export var weapon1_display: WeaponStateUI
@export var weapon2_display: WeaponStateUI


func _process(delta: float) -> void:
	var player = Players.get_player()
	
	if player == null:
		return
	
	_display_weapons_state(player)


func _display_weapons_state(player: Player):
	var weapons := player.get_held_weapons()
	
	_show_weapon_state(weapons[0], weapon1_display)
	_show_weapon_state(weapons[1], weapon2_display)


func _show_weapon_state(weapon: Weapon, weapon_display: WeaponStateUI):
	if weapon == null:
		return
	
	weapon_display.set_weapon(weapon.weapon_icon)
	weapon_display.set_state(weapon.cooldown_normalized, weapon.max_uses, weapon.uses_left)
