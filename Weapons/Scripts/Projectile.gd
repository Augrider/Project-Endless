class_name Projectile extends Node2D

var allegiance:int

#Damage, lifetime left, speed
@export var power:float
@export var speed:float
@export var lifetime:float

@export var lifeLeftNormalized:float=1

var addedImpulse:Vector2


func init(allegiance:int, power:float, speed:float, lifetime:float)->void:
	self.allegiance=allegiance
	
	self.power=power
	self.speed=speed
	self.lifetime=lifetime
	
	lifeLeftNormalized=1
	
	on_init()

#TODO: Add impulse to projectiles, lasers should only deviate from input direction
func add_impulse(value:Vector2)->void:
	addedImpulse=value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifeLeftNormalized -= delta/lifetime
	
	if(lifeLeftNormalized <= 0):
		destroy()


func is_allied_with(value:int)->bool:
	return allegiance==value

func reduce_power(value:float)->void:
#	scale *= 1-value/power
	power = clamp(power-value, 0, power)
	
	if power<=0:
		destroy()

func add_power(value:float)->void:
#	scale *= 1+value/power
	power += value
	

func on_init()->void:
	pass

func destroy()->void:
	pass
