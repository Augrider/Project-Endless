class_name ComboAttackStrategy extends EnemyAttackStrategy

@export var strategies: Array[EnemyAttackStrategy]
@export var restart_inactive: bool


func perform(arena: Arena):
	active = true
	
	print_debug("Starting Combo")
	_start_inactive(arena)
	
	while active:
		if restart_inactive:
			_start_inactive(arena)
		elif !_any_active():
			active = false
			break
		
		await Timers.get_oneshot(0.5).timeout
	
	_stop_active()
	
	active = false


func stop():
	active = false
	
	_stop_active()


func _start_inactive(arena: Arena):
	for strategy in strategies:
		if !strategy.active:
			strategy.perform(arena)

func _any_active() -> bool:
	return strategies.any(func(strategy): return strategy.active)

func _stop_active():
	for strategy in strategies:
		if !strategy.active:
			strategy.stop()
