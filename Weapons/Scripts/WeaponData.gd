class_name WeaponData extends Resource

@export var weaponPrefab:PackedScene
@export var projectilePrefab:PackedScene

@export var fireRate:float

@export var bulletAmount:int
@export var spreadMax:float

#TODO: Simplify curves into some bullet parameters, behaving in predictable manner

@export var bulletPower:float
@export var bulletSpeed:float
@export var bulletLifetime:float

@export var weaponModifiers:Array

#drag? size? weight? power?
#all bullets deal damage, some can also combine their power together
#lasers follow player gun
#bullets slow down and become weaker as their lifetime diminishes
#does rate of reduction matter? Add single parameter for that?
#some projectiles inherit some or all player speed
#enemy should use the same system, even if weapon data is not shared

#power, speed, lifetime, drag, inertia
#additional movement parameters should be independent or depend on those
