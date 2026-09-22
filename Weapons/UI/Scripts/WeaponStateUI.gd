class_name WeaponStateUI extends Control

@export var icon: TextureRect
@export var state: Label


func set_weapon(weapon_icon: Texture2D):
	self.icon.texture = weapon_icon

func set_state(cooldown_normalized: float, max_uses: int, uses_left: int):
	var format_string = "%.2f\n%3d / %3d"
	var actual_string = format_string % [(1 - cooldown_normalized), uses_left, max_uses]

	if max_uses <= 0:
		format_string = "%.2f"
		actual_string = format_string % [(1 - cooldown_normalized)]
	
	state.text = actual_string
