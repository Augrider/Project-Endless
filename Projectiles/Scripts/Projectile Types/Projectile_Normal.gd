class_name NormalProjectile extends Projectile

#TODO: connect lifetime to color, size - to relative power
#TODO: still change power based on lifetime somehow? Decay?
const SCALE_LOWEST:float = 0.5
const SCALE_HIGHEST:float = 1.5

#Damage, lifetime left, speed
@export var base_power:float
@export var base_speed:float
@export var base_lifetime:float

@export var speed_curve:Curve
@export var destroy_at_stop:bool = true

var speed_current:float


func on_init()->void:
	scale=Vector2.ZERO
	
	_set_scale(1)
	
	power = base_power
	speed = base_speed
	lifetime = base_lifetime
	
	%Hitbox.monitoring = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	var lifetime_multiplier = speed_curve.sample(lifeLeftNormalized)
	speed_current = speed * lifetime_multiplier
	# Power changes based on current
	#reduce_power(base_power * delta/lifetime)
	#_set_scale(power/base_power * (SCALE_LOWEST + lifetime_multiplier * (1 - SCALE_LOWEST)))
	
	translate(delta * speed_current * transform.x)
	
	if destroy_at_stop && speed_current <= 0:
		destroy()


func destroy()->void:
	power = 0
	active = false
	%Hitbox.set_deferred("monitoring", false)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
	tween.tween_callback(Callable(self, "queue_free"))
	tween.play()


func on_power_changed(value:float):
	power += value
	
	if power <= 0:
		power = 0
		destroy()
	else:
		_set_scale(power/base_power)


func apply_effects_to(projectile: Projectile):
	if %Hitbox.collided_with(projectile):
		return
	
	%Hitbox.add_to_collided(projectile)
	%Hitbox.apply_effects_to(projectile)


func _set_scale(value:float):
	var normalized = clampf(value, SCALE_LOWEST, SCALE_HIGHEST)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", normalized * Vector2.ONE, 0.1)
	tween.play()
