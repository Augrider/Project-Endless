extends ProjectileComponent

#Push should be dependant on size of enemy. 
#Small and medium enemies are turned into projectile
#Bigger enemies push you instead

#TODO: on any other object type hit - push owner away

func _on_unit_hit(unit_hitbox:UnitHitbox):
	# Player push is not dependant on class, only power
	# Enemy push is based on size
	# If enemy is not bigger than big, then push enemy
	# If enemy is bigger than small, then push player
	#TODO: Only player projectiles will move player
	
	print_debug('Trying push with '+str(owner_projectile.power))
	var unit = unit_hitbox.owner_unit
	
	if unit is Player:
		_push(unit, owner_projectile.global_position, owner_projectile.power)
	else:
		var player = Players.get_player()
		var enemy: Enemy = unit
		
		if enemy.size_class <= Enemy.SizeClass.BIG:
			_push(enemy, player.global_position, owner_projectile.power/enemy.size_class)
		
		if enemy.size_class > Enemy.SizeClass.SMALL:
			_push(player, enemy.global_position, owner_projectile.power*enemy.size_class/2)


func _push(unit:Unit, origin: Vector2, power: float):
	var impulse = power * (unit.global_position - origin).normalized()
	unit.set_pushed(impulse)
