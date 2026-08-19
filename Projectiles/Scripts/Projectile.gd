class_name Projectile extends AlliedNode2D

#Damage, lifetime left, speed
@export var power:float
@export var speed:float
@export var lifetime:float

@export var lifeLeftNormalized:float=1


func init(allegiance:int)->void:
	lifeLeftNormalized=1
	set_allegiance(allegiance)
	
	%Hitbox.monitoring = true
	
	on_init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifeLeftNormalized -= delta/lifetime
	
	if(lifeLeftNormalized <= 0):
		destroy()


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
