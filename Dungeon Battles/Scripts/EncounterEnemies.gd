class_name EncounterEnemies extends Resource

@export var base_enemy_prefab: PackedScene
@export var base_enemy_amount: int = 10

@export var elite_enemies: Dictionary[PackedScene, int]
