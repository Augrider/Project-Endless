@abstract
class_name EnemyAttackStrategy extends Resource

#@export var preferred_duration: float = 0.5
var active: bool = false

@abstract
func perform(formation: CircleFormation2D, timers: TimerProvider, battle_phase: BattlePhaseComponent)
@abstract
func stop()
