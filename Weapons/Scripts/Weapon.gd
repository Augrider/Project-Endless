@abstract
class_name Weapon extends Node2D

signal weapon_fired

var trigger_pressed = false

@export var weapon_name: String
@export var weapon_icon: Texture2D

@export var max_uses: int = -1
var uses_left: int = -1

var cooldown_normalized: float = 0
var cooldown: float = 0
var _current_max_cooldown: float = 0


func press_trigger() -> void:
	if trigger_pressed:
		return
	
	trigger_pressed = true
	
	on_trigger_pressed()

func release_trigger() -> void:
	if !trigger_pressed:
		return
	
	trigger_pressed = false
	
	on_trigger_released()


func on_trigger_pressed() -> void:
	pass

func on_trigger_released() -> void:
	pass


func set_cooldown(value: float):
	cooldown_normalized = 1
	cooldown = value
	_current_max_cooldown = value

func process_cooldown(delta: float):
	cooldown = clamp(cooldown - delta, 0, _current_max_cooldown)
	cooldown_normalized = clamp(cooldown / _current_max_cooldown, 0, 1)
