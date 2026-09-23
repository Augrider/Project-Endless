@abstract class_name EnemyAbility extends Node2D

@export var enemy: Enemy

var active: bool = false

@abstract
func perform(arena: Arena)

@abstract
func stop()
