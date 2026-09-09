extends Node2D

#Change attack and cooldown phases
#Move enemies to front to replace destroyed
#Loss at players death
#Victory at all enemies death

#Intensify attacks and duration with time?
#When small amount of enemies left - no cooldown phase anymore?
#When to move enemies to front? At cooldown? When places available?

@export var formation: CircleFormation2D
@export var timers: TimerProvider
@export var battle_phase: BattlePhaseComponent

@export var attack_strategies: Array[EnemyAttackStrategy]
@export var cooldown_strategies: Array[EnemyAttackStrategy]

@export var battle_start_cooldown: float = 0.5

var current_strategy: EnemyAttackStrategy


func _ready() -> void:
	battle_phase.phase_changed.connect(_on_battle_phase_changed)
	
	timers.get_oneshot(battle_start_cooldown).timeout.connect(start_battle)


func start_battle() -> void:
	pass

func _process(delta:float) -> void:
	if current_strategy != null:
		return
	
	match battle_phase.phase:
		BattlePhaseComponent.BattlePhase.ATTACK:
			perform_attack_phase()
		BattlePhaseComponent.BattlePhase.COOLDOWN:
			perform_cooldown_phase()


#TODO: Looks like duration of phases is dependant on new intensity mechanic
func perform_attack_phase():
	#print_debug("Performing Attack")
	_perform_attack_strategy(attack_strategies.pick_random())

func perform_cooldown_phase():
	#print_debug("Performing Cooldown")
	_perform_attack_strategy(cooldown_strategies.pick_random())


func _on_battle_phase_changed(value: BattlePhaseComponent.BattlePhase):
	print_debug("Phase change detected")
	if current_strategy != null:
		current_strategy.stop()
		current_strategy = null


func _perform_attack_strategy(strategy: EnemyAttackStrategy):
	current_strategy = strategy
	
	await strategy.perform(formation, timers, battle_phase)
	
	print_debug("Strategy finished")
	if current_strategy == strategy && !current_strategy.active:
		current_strategy = null
