extends ProjectileComponent

func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	projectile.add_power(-owner_projectile.power)

func _on_unit_hit(unit:Unit):
	unit.deal_damage(owner_projectile.power)
	owner_projectile.destroy()

func _on_object_hit(object: MapObject):
	object.apply_damage(owner_projectile.power)
	owner_projectile.power *= 0.6
	#Penetration logic
