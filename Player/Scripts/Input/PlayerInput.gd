class_name PlayerInput extends Node

enum InputDevice {MOUSE, JOYPAD}

signal device_changed(input_device:InputDevice)

signal movement_input_updated(new_value:Vector2)

signal fire_01_pressed
signal fire_01_released

signal fire_02_pressed
signal fire_02_released

@export var movementInput:Vector2 = Vector2.ZERO
@export var fire_01:bool = false

var inputDevice: InputDevice = InputDevice.MOUSE;

#TODO: Add ability to turn on and off
#TODO: Find how to pause


func _unhandled_input(event: InputEvent)->void:
	#if event is InputEventMouse:
		#return
	
	var movementInput = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	#print_debug("Movement "+str(movementInput))

	if movementInput != self.movementInput:
		self.movementInput = movementInput
		emit_signal("movement_input_updated", movementInput)
		#print_debug("Movement changed "+str(movementInput))
	
	if event.is_action_released("weapon_1"):
		self.fire_01 = false
		emit_signal("fire_01_released")
	elif event.is_action_pressed("weapon_1"):
		self.fire_01 = true
		emit_signal("fire_01_pressed")
	
	if event.is_action_released("weapon_2"):
		self.fire_01 = false
		emit_signal("fire_02_released")
	elif event.is_action_pressed("weapon_2"):
		self.fire_01 = true
		emit_signal("fire_02_pressed")
