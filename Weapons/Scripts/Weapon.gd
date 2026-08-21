class_name Weapon extends Node2D

signal weapon_fired

#export var allegiance:Allegiance

var trigger_pressed = false


func press_trigger()->void:
	if trigger_pressed:
		return
	
	trigger_pressed = true
	
	on_trigger_pressed()

func release_trigger()->void:
	if !trigger_pressed:
		return
	
	trigger_pressed = false
	
	on_trigger_released()


func on_trigger_pressed()->void:
	pass

func on_trigger_released()->void:
	pass
