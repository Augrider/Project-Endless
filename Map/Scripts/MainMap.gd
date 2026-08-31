class_name MainMap extends Node2D

@export var tilemap_ground: TileMapLayer

@export var chunk_test: PackedScene
@export var chunk_size: Vector2i

@export var map_size: Vector2i
var chunks: Dictionary[Vector2i, MapChunk]
var object_cells: Dictionary[Vector2i, MapObject]

@export var biome_objects: Dictionary[Enums.BiomeType, BiomeObjects]


func _ready() -> void:
	for i in range(-map_size.x, map_size.x):
		for j in range(-map_size.y, map_size.y):
			var new_chunk: MapChunk = chunk_test.instantiate()
			
			var offset = Vector2i(i*chunk_size.x, j*chunk_size.y)
			new_chunk.place_map_tiles(tilemap_ground, offset)
			new_chunk.place_objects(self, offset)
	
	tilemap_ground.set_cells_terrain_connect(tilemap_ground.get_used_cells(), 0, 0)
	
	spawn_biome_objects()


func place_object(object_copy: MapObject, cell:Vector2i):
	var rect = object_copy.get_size_rect(cell)
	
	var start := tilemap_ground.map_to_local(rect.position)
	
	object_copy.global_position = to_global(start)
	add_child(object_copy)
	
	for x in range(cell.x, rect.end.x - 1):
		for y in range(cell.y, rect.end.y - 1):
			object_cells.set(Vector2i(x, y), object_copy)


func spawn_biome_objects():
	var cells = tilemap_ground.get_used_cells()
	cells.shuffle()
	
	for cell in cells:
		if object_cells.has(cell):
			continue
		
		#Check the chance to spawn
		var spawn_rand = randf()
		if spawn_rand > tilemap_ground.get_cell_tile_data(cell).get_custom_data("object_chance"):
			continue
		
		var biome: Enums.BiomeType = tilemap_ground.get_cell_tile_data(cell).get_custom_data("biome")
		if biome_objects.has(biome):
			var prefab = biome_objects[biome].objects.pick_random()
			place_object(prefab.instantiate(), cell)
		
		await get_tree().create_timer(0.05 * spawn_rand).timeout

#TODO: When new turn started:
#Spawn new resources. If nothing is placed on tile - randomly place new object, based on biome

#When game requests randomized map generation:
#Create new map from chunks

#Support save/load from files, both map and placed objects with their state
#Support map modification

#Chunks should have corridors for connection. Either generate or rotate chunks
