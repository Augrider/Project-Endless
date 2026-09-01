extends Node2D

#Change attack and cooldown phases
#Move enemies to front to replace destroyed
#Loss at players death
#Victory at all enemies death

#Intensify attacks and duration with time?
#When small amount of enemies left - no cooldown phase anymore?
#When to move enemies to front? At cooldown? When places available?

#Better formations? One formation instead of multiple
enum BattlePhase { ATTACK, COOLDOWN }

@export var formation: CircleFormation2D
@export var timer: Timer

@export var enemy_prefab:PackedScene

@export var debug_strategy: EnemyAttackStrategy

@export var battle_start_cooldown: float = 0.5
@export var cooldown_phase_duration: float = 0.5

var phase: BattlePhase = BattlePhase.COOLDOWN
var intensity: float = 0.5

var player:Player


func _ready() -> void:
	player = Players.get_player()
	
	get_tree().create_timer(battle_start_cooldown).timeout.connect(start_battle)


func _on_reorder_timer_timeout() -> void:
	formation.reorder()


func start_battle() -> void:
	while formation.any_spot_available():
		var enemy = _spawn_new(enemy_prefab)
		enemy.global_position = formation.append(enemy)
	
	perform_attack_phase()

#func _process(delta:float) -> void:
	#start_battle()
	#if phase != BattlePhase.ATTACK:
		#perform_attack_phase()
	#Formation manages place arrangement, just spawn new when needed


func perform_attack_phase():
	phase = BattlePhase.ATTACK
	
	await get_tree().create_timer(0.5).timeout
	await debug_strategy.perform(formation, intensity)
	
	intensity += 0.1
	perform_cooldown_phase()
	#Choose attack strategy
	#Wait while performing
	#Strategy will use formation and enemies within
	#Some enemies might leave formation to actively engage enemies
	#Attack Phase continues until they die or strategy performed

func perform_cooldown_phase():
	phase = BattlePhase.COOLDOWN
	
	await debug_strategy.perform(formation, intensity / 2)
	
	perform_attack_phase()
	#await get_tree().create_timer(cooldown_phase_duration).timeout
	#Just some waiting
	#Maybe spawn enemies here
	#Or use alternate strategies with less intensity


func _spawn_new(enemy_prefab:PackedScene) -> Enemy:
	var enemy:Enemy = EnemyStorage.request_spawn(enemy_prefab)
	
	enemy.set_allegiance(1)
	enemy.look_at_target(player)
	
	return enemy
