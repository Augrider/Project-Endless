class_name TimerProvider extends Node

var _timers: Array[Timer]


func get_oneshot(seconds:float) -> SceneTreeTimer:
	return get_tree().create_timer(seconds)

func get_timer() -> Timer:
	var free_index = _timers.find_custom(_is_free_timer)
	
	if free_index > -1:
		#Remove all subs from timeout
		for dict in _timers[free_index].timeout.get_connections():
			_timers[free_index].timeout.disconnect(dict.callable)
		
		return _timers[free_index]
	
	var timer = Timer.new()
	add_child(timer)
	
	_timers.append(timer)
	
	return timer


func _is_free_timer(timer) -> bool:
	return timer.is_stopped()
