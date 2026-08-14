extends Sprite2D

var _is_looking: bool = false
var _look_target: Node2D
var _look_position: Vector2


func _process(delta: float) -> void:
	if !_is_looking:
		return #TODO: if not looking - align with movement
	
	if _look_target!=null:
		_look_position = _look_target.position
	
	look_at(_look_position)


func look_at_target(target:Node2D):
	_is_looking=true
	_look_target=target

func look_at_position(position:Vector2):
	_is_looking=true
	_look_position=position

func stop_looking():
	_is_looking=false
	rotation=0
