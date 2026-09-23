@abstract
class_name EnemyAttackStrategy extends Resource

#@export var preferred_duration: float = 0.5
var active: bool = false

@abstract
func perform(arena: Arena)
@abstract
func stop()
