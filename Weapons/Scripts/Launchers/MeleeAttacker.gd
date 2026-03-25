class_name MeleeAttacker extends Node2D

#plays blade animation and checks for clashes. If clashing - call event
signal ClashOccured(object)

@export var animatorPath:NodePath
@onready var animator:AnimationPlayer=get_node(animatorPath)

@export var animationPath:Resource
@onready var animation:Animation=animationPath


func Perform(attackDuration:float)->void:
	var speed=clamp(animation.length/attackDuration, 1, 999999999)
	
#	animator.play(animation)
