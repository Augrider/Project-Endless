@abstract
class_name EnemyAttackStrategy extends Resource

@export var preferred_duration: float = 0.5

@abstract
func perform(formation: CircleFormation2D, intensity: float)
