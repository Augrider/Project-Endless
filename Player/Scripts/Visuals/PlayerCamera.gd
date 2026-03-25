extends Camera2D
#
#@export var inputPath: NodePath
#var input:PlayerInput
#
#@onready var movement:Movement=get_parent().get_movement_or_null()
#
#@export var mouseMultiplier:float
#
#@export var speedMultiplier:float
#@export var boostMultiplier:float
#@export var maxOffset:Vector2
#
#@export var zoomMultiplier:float
#@export var maxZoom:float
#
#
## TODO: calculate offset based on speed, acceleration
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#input=get_node(inputPath)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	## Get offsets and zoom
	#set_cam_offset(get_global_mouse_position(), movement.get_velocity(), input.boostInput)
##	set_zoom(movement.speed)
#
#
## Get offset based on speed and mouse position
## If boosting - only speed, but reverse?
#func set_cam_offset(mouse_position:Vector2, speed:Vector2, boostInput:bool)->void:
	#var speedOffset:Vector2=speed
	#
##	if(boostInput):
##		speedOffset*=boostMultiplier
##		offset=speedOffset
##		return
		#
	#var camOffset:Vector2=mouse_position-global_position
	#camOffset*=mouseMultiplier
	#
	#offset=camOffset#-speedOffset*speedMultiplier
	#offset.x=clamp(offset.x, -maxOffset.x, maxOffset.x)
	#offset.y=clamp(offset.y, -maxOffset.y, maxOffset.y)
#
##Set zoom based on speed
#func set_zoom(speed:Vector2)->void:
	#var zoomValue = clamp(speed.length()*zoomMultiplier, -maxZoom, maxZoom)
	#
	#zoom=(1+zoomValue)*Vector2.ONE
