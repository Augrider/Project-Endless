class_name ComboAbility extends EnemyAbility

enum RepeatMode {ON_STOP, ON_ALL_STOP}

@export var abilities: Array[EnemyAbility]

@export var cooldown: float

@export var repeat_until_stopped: bool
@export var repeat_mode: RepeatMode

var _current_arena: Arena


func perform(arena: Arena):
	active = true
	_current_arena = arena
	
	_start_all_inactive()
	
	if !repeat_until_stopped:
		await get_tree().create_timer(cooldown).timeout
		stop()


func stop():
	active = false
	_stop_all_active()


func _process(delta: float) -> void:
	if !active || !repeat_until_stopped:
		return
	
	match repeat_mode:
		RepeatMode.ON_STOP:
			_start_all_inactive()
		RepeatMode.ON_ALL_STOP:
			_start_if_all_inactive()


func _start_all_inactive():
	for ability in abilities:
		if !ability.active:
			ability.perform(_current_arena)

func _start_if_all_inactive():
	if _any_active():
		return
	
	_start_all_inactive()

func _stop_all_active():
	for ability in abilities:
		ability.stop()


func _any_active() -> bool:
	for ability in abilities:
		if ability.active:
			return true
	
	return false
