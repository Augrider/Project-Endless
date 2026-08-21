@abstract class_name Projectile extends AlliedNode2D

var power:float
var speed:float
var lifetime:float

var lifeLeftNormalized:float = 1


func init(allegiance:int)->void:
	lifeLeftNormalized = 1
	set_allegiance(allegiance)
	
	on_init()


@abstract func add_power(value:float)->void
@abstract func reduce_power(value:float)->void

@abstract func on_init()->void
@abstract func destroy()->void
