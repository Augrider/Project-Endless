extends Projectile

@export var drag:float

var speedVector:Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(delta*speedVector)
#	look_at(global_position+speedVector)
	
	speedVector -= drag*delta*speedVector.normalized()
	speedVector += addedImpulse
	speed=clamp(speed - drag*delta, 0, speed)
	
	addedImpulse=Vector2.ZERO
	
	if speed <= 0:
		destroy()


func on_init()->void:
	speedVector = speed*global_transform.x
	
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



func _on_Area2D_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	
	if parent is Projectile:
		var projectile:Projectile = parent
		
		if !projectile.is_allied_with(allegiance):
			var projectilePower = projectile.power
			projectile.reduce_power(power)
			reduce_power(projectilePower)
	
	if area is Destructible:
		var destructible:Destructible = area
		
		if !destructible.is_allied_with(allegiance):
			destructible.apply_damage(power)
			destroy()
