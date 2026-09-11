class_name BattlePhaseUI extends Control

@export var battle_phase: BattlePhaseComponent

@export var intensity_bar: ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	intensity_bar.value = battle_phase.intensity_normalized
