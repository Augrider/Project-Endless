extends Weapon

var melee:MeleeAttacker


func _process(delta: float) -> void:
	if triggerPressed && cooldown <= 0:
		try_fire(weaponData)


func try_fire(stats:WeaponData)->bool:
	if(cooldown > 0):
		return false
	
	weaponData=stats
	fire(stats)
	
	cooldown=1/stats.fireRate
	return true


func fire(stats:WeaponData)->void:
	#If something in front of hitbox - perform clash and return
	#Shoot projectile and enable blade
	#If something collided with blade (works as a projectile) - deal damage
	#return
	#Projectile modifiers applied only to shot
	melee.Perform(1/stats.fireRate)
	
	var projectiles:Array=launcher.spawn(stats.projectilePrefab, stats.spreadMax, stats.bulletAmount)
	
	for i in projectiles:
		var projectile:Projectile = i
		projectile.init(allegiance, stats.bulletPower, stats.bulletSpeed, stats.bulletLifetime)
	
	for mod in stats.weaponModifiers:
		var modifier:WeaponModifier = mod
		modifier.apply(spaceObject, self, projectiles)
