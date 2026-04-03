class_name PlayerInput extends Node

enum InputDevice {MOUSE, JOYPAD}

signal movement_input_updated(new_value:Vector2)
signal device_changed(input_device:InputDevice)

@export var movementInput:Vector2 = Vector2.ZERO

var inputDevice: InputDevice = InputDevice.MOUSE;

#TODO: Add ability to turn on and off
#TODO: Find how to pause


func _unhandled_input(event: InputEvent)->void:
	if event is InputEventMouse:
		return
	
	var movementInput = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	print_debug("Movement "+str(movementInput))

	if movementInput != self.movementInput:
		self.movementInput = movementInput
		emit_signal("movement_input_updated", movementInput)
		print_debug("Movement changed "+str(movementInput))
