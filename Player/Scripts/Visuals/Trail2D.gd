extends Line2D


var line:Line2D

var pointsWorld:PackedVector2Array
@export var maxPointsCount:int


func _ready() -> void:
	line = self.duplicate(0)
	line.global_position=Vector2.ZERO
	
	get_tree().root.call_deferred("add_child", line)
	line.clear_points()

func _exit_tree() -> void:
	line.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	add_position(global_position)
	draw_trail()


func add_position(global_position:Vector2)->void:
	var copy=pointsWorld
	
	if copy.size() >= maxPointsCount:
		copy.remove_at(0)

	copy.append(global_position)
	
	pointsWorld=copy

#TODO: Optimize
func draw_trail()->void:
	line.clear_points()

	for i in pointsWorld.size():
		line.add_point(pointsWorld[i])
