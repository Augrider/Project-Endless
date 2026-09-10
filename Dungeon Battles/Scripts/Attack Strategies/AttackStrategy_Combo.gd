class_name ComboAttackStrategy extends EnemyAttackStrategy

@export var strategies: Array[EnemyAttackStrategy]
@export var restart_inactive: bool


func perform(formation: CircleFormation2D, timers: TimerProvider, battle_phase: BattlePhaseComponent):
	active = true
	
	print_debug("Starting Combo")
	_start_inactive(formation, timers, battle_phase)
	
	while active:
		if restart_inactive:
			_start_inactive(formation, timers, battle_phase)
		elif !_any_active():
			active = false
			break
		
		await timers.get_oneshot(0.5).timeout
	
	_stop_active()
	
	active = false


func stop():
	active = false
	
	_stop_active()


func _start_inactive(formation: CircleFormation2D, timers: TimerProvider, battle_phase: BattlePhaseComponent):
	for strategy in strategies:
		if !strategy.active:
			strategy.perform(formation, timers, battle_phase)

func _any_active() -> bool:
	return strategies.any(func(strategy): return strategy.active)

func _stop_active():
	for strategy in strategies:
		if !strategy.active:
			strategy.stop()
