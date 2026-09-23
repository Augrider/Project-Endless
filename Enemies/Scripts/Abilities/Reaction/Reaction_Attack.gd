class_name AttackReaction extends ReactionArea2D

@export var attack_units: bool
@export var attack_projectiles: bool

@export var projectile_prefab: PackedScene
@export var launcher: WeaponLauncher

@export var spread_variance: float = 3
@export var cooldown: float = 0.5

var active: bool = false
var _current_target: Node2D = null


func _ready() -> void:
	start()
	
	if attack_units:
		opponent_unit_enter.connect(set_target)
	if attack_projectiles:
		opponent_projectile_enter.connect(set_target)
	
	node_exited.connect(reset_target)


func _process(delta: float) -> void:
	if !active && _current_target != null:
		perform(_current_target)
	
	#if _current_target.global_position.distance_squared_to(global_position) > 10:
		#_current_target = null


func perform(target: Node2D):
	active = true
	
	await get_tree().create_timer(0.3 * randf()).timeout
	
	var spread: float = _calculate_spread()
	
	launcher.look_at(target.global_position)
	var projectile = launcher.spawn_one(projectile_prefab)
	
	projectile.rotation_degrees += spread
	projectile.init(owner_node.allegiance)
	
	await get_tree().create_timer(cooldown).timeout
	active = false


func set_target(target: Node2D):
	print_debug("Reaction Target Set")
	_current_target = target

func reset_target(target: Node2D):
	if target == _current_target:
		_current_target = null


func _calculate_spread() -> float:
	return randf_range(-spread_variance, spread_variance)
