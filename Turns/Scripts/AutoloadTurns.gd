extends Node

signal turn_passed
signal new_turn_started

var turn_count:int = 1

func pass_turn():
	turn_passed.emit()
	print_debug("Pass turn started")
	start_new_turn()
	#Multiple things are attached to turn pass:
	#Resources, weather cycle, waves
	#Most things should subscribe to turn pass and start

func start_new_turn():
	turn_count += 1
	new_turn_started.emit()
	
	print_debug("New turn")
	#Separate from passing turn, we need time to prepare (f.e. doors in DotE) and show changes
