@abstract class_name EnemyAbility extends Node2D

var active: bool = false

@abstract
func perform(arena: Arena)

@abstract
func stop()
