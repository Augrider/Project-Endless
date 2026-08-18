@abstract class_name EnemyAbility extends Node2D

var durationLeft:float
var intensity:float = 1

@abstract
func perform(enemy:Enemy, duration:float, intensity:float = 1)
