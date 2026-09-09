class_name BattlePhaseComponent extends Node

#Keep intensity here
#When in attack phase - intensity is max level
#After attack phase - go into cooldown phase, increase default level
#While in cooldown phase - gradually increase intensity up to max level
#Also increase intensity on enemy death
#When max level reached - enable attack phase

enum BattlePhase { COOLDOWN = 0, ATTACK = 1, }

signal phase_changed(phase: BattlePhase)

var intensity_normalized: float = 0
var intensity_multiplier: float = 1

var intensity: float:
	get:
		return intensity_multiplier * (_starting_level + (_max_level - _starting_level) * (intensity_normalized + _attack_phase_multiplier * phase))

var phase: BattlePhase = BattlePhase.COOLDOWN
var phase_cycle: int = 1

@export var attack_phase_timer: Timer

@export var _starting_level: float = 1
@export var _max_level: float = 2
@export var _phase_cycle_multiplier: float = 0.1
@export var _attack_phase_multiplier: float = 0.1

@export var _cooldown_phase_duration: float = 1.0
@export var _attack_phase_duration: float = 1.0


func _ready() -> void:
	attack_phase_timer.timeout.connect(_on_attack_phase_completed)

func _process(delta: float) -> void:
	match phase:
		BattlePhase.COOLDOWN: process_cooldown_phase(delta)
		#BattlePhase.ATTACK: process_attack_phase(delta)
	
	#TODO: Get all enemies and set their intensity


func process_cooldown_phase(delta:float):
	intensity_normalized = clampf(intensity_normalized + delta / _cooldown_phase_duration, 0, 1)
	
	if intensity_normalized >= 1:
		_set_phase(BattlePhase.ATTACK)
		attack_phase_timer.start(_attack_phase_duration)
		#Start timer

#func process_attack_phase(delta:float):
	#pass #Do nothing for this phase, just wait for the timer


func _on_attack_phase_completed():
	intensity_normalized = 0
	phase_cycle += 1
	intensity_multiplier += _phase_cycle_multiplier
	_set_phase(BattlePhase.COOLDOWN)


func _set_phase(value: BattlePhase):
	phase = value
	phase_changed.emit(phase)
