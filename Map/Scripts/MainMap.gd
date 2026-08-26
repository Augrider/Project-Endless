extends Node2D

@export var navmesh: NavigationRegion2D

@export var tilemap_ground: TileMapLayer

@export var chunk_test: PackedScene
@export var chunk_size: Vector2i

@export var map_size: Vector2i
var chunks: Dictionary[Vector2i, MapChunk]


func _ready() -> void:
	for i in range(-map_size.x, map_size.x):
		for j in range(-map_size.y, map_size.y):
			var new_chunk: MapChunk = chunk_test.instantiate()
			
			var offset = Vector2i(i*chunk_size.x, j*chunk_size.y)
			new_chunk.place_on_map(tilemap_ground, offset)
			
			#new_chunk.position = Vector2(i*chunk_size.x, j*chunk_size.y)
			#tilemap_ground.call_deferred("add_child", new_chunk)
#TODO: When new turn started:
#Spawn new resources. If nothing is placed on tile - randomly place new object, based on biome

#When game requests randomized map generation:
#Create new map from chunks

#Support save/load from files, both map and placed objects with their state
#Support map modification
