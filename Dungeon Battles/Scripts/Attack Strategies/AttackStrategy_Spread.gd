class_name SpreadAttackStrategy extends EnemyAttackStrategy

@export var spreader_count: int = 1
#TODO: How this strategy picks units for attack

@export var duration: float = 1
@export var attack_duration: float = 1
@export var return_immediately: bool


func perform(formation: CircleFormation2D, timers: TimerProvider, battle_phase: BattlePhaseComponent):
	active = true
	
	print_debug("Starting Spreading")
	var spreaders: EnemyGroup = EnemyGroup.new()
	
	if return_immediately:
		spreaders = _pick_enemies(spreaders, formation)
		_perform_spread(spreaders, battle_phase.intensity)
		return
	
	timers.do_after(stop, duration)
	
	while active:
		spreaders = _pick_enemies(spreaders, formation)
		_perform_spread(spreaders, battle_phase.intensity)
		
		await timers.get_oneshot(attack_duration).timeout
	
	active = false


func stop():
	active = false


func _pick_enemies(group: EnemyGroup, formation: CircleFormation2D) -> EnemyGroup:
	group.clear()
	
	var enemies = formation.get_inner_enemies()
	if enemies.size() <= 0:
		return group
	
	for i in range(spreader_count):
		group.append(enemies.pick_random())
	
	return group

func _perform_spread(spreaders: EnemyGroup, intensity: float):
	#print_debug("Spreading")
	var enemies = spreaders.get_enemies()
	if enemies.size() <= 0:
		return

	for enemy in enemies:
		enemy.perform_ability_targeted(attack_duration)
