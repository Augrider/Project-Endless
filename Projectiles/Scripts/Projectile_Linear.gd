extends Projectile

@export var speed_curve:Curve
var speed_current:float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifeLeftNormalized -= delta/lifetime
	
	if(lifeLeftNormalized <= 0):
		destroy()
	
	speed_current = speed * speed_curve.sample(lifeLeftNormalized)
	
	translate(delta*speed_current*transform.x)
	
	if speed_current <= 0:
		destroy()


func on_init()->void:
	scale=Vector2.ZERO
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
	tween.play()

func destroy()->void:
	power=0
	#TODO: disable ability to trigger destroy again while it performs
	#also disable area 2D
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
	tween.tween_callback(Callable(self, "queue_free"))
	tween.play()
