class_name Weapon extends Node2D

signal weapon_fired

#export var allegiance:Allegiance

var cooldown:float = 0
var triggerPressed = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown=clamp(cooldown-delta, 0, cooldown)


func press_trigger()->void:
	if triggerPressed:
		return
	
	triggerPressed = true
	
	on_trigger_pressed()

func release_trigger()->void:
	if !triggerPressed:
		return
	
	triggerPressed = false
	
	on_trigger_released()


func on_trigger_pressed()->void:
	pass

func on_trigger_released()->void:
	pass


func try_fire()->bool:
	return false
