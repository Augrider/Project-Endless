extends ProjectileComponent

func _on_opponent_projectile_hit(projectile: Projectile) -> void:
	projectile.add_power(-owner_projectile.power)

func _on_unit_hit(unit_hitbox: UnitHitbox):
	unit_hitbox.apply_damage(owner_projectile.power)
	owner_projectile.destroy()

func _on_object_hit(object: MapObject):
	object.apply_damage(owner_projectile.power)
	owner_projectile.power *= 0.6
	#Penetration logic
