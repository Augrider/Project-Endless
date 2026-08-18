class_name Projectile extends Node2D

var allegiance:int

#Damage, lifetime left, speed
@export var power:float
@export var speed:float
@export var lifetime:float

@export var lifeLeftNormalized:float=1


func init()->void:
	lifeLeftNormalized=1
	
	on_init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifeLeftNormalized -= delta/lifetime
	
	if(lifeLeftNormalized <= 0):
		destroy()


func set_allegiance(allegiance:int):
	self.allegiance = allegiance
	#Change collision mask values

func is_allied_with(value:int)->bool:
	return allegiance==value

func reduce_power(value:float)->void:
	power = clamp(power-value, 0, power)
	
	if power<=0:
		destroy()

func add_power(value:float)->void:
	power += value
	

func on_init()->void:
	pass

func destroy()->void:
	pass
