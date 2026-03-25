class_name Stopwatch extends Node

@export var autostart:bool

var ticking:bool=false;
var time:float=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(autostart):
		ticking=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(ticking):
		time+=delta


func start()->void:
	ticking=true

func stop()->void:
	ticking=false

func reset()->void:
	time=0

func set_time(value:float)->void:
	time = clamp(value, 0, 9999)
