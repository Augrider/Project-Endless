#TODO: this should check if mouse working, if gamepad putting in direction
#Based on those parameters - calculate if character looks left/right and look direction/position
class_name PlayerDirection extends Node2D

#enum DirectionDevice {MOUSE, JOYPAD}

signal look_point_changed(value:Vector2)

var directionDevice: PlayerInput.InputDevice = PlayerInput.InputDevice.MOUSE;
var lookPointRelative:Vector2

@export var joypadDirectionMultiplier: float
@export var lookPoint:Vector2

	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		process_joypad(event as InputEventJoypadMotion)
	elif event is InputEventMouseMotion:
		process_mouse(event as InputEventMouseMotion)
	
	#print_debug("Relative Look Point "+str(lookPointRelative))

func _process(delta: float) -> void:
	lookPoint = global_position + lookPointRelative


func process_joypad(event: InputEventJoypadMotion)->void:
	#directionDevice=DirectionDevice.JOYPAD
	
	var direction = Input.get_vector("aim_left", "aim_right", "aim_down", "aim_up")
	lookPoint = joypadDirectionMultiplier * direction
	lookPointRelative=lookPoint-global_position
	
	emit_signal("look_point_changed", lookPoint)

func process_mouse(event: InputEventMouseMotion)->void:
	#directionDevice=DirectionDevice.MOUSE
	
	lookPoint = get_global_mouse_position()
	lookPointRelative=lookPoint-global_position
	
	emit_signal("look_point_changed", lookPoint)
