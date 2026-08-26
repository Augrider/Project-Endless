class_name MapChunk extends TileMapLayer

@export var chunk_size: Vector2i

func place_on_map(map: TileMapLayer, offset: Vector2i):
	#print_debug("Placing tiles")
	for i in range(-chunk_size.x / 2 , chunk_size.x / 2):
		for j in range(-chunk_size.y / 2, chunk_size.y / 2):
			var cell := Vector2i(i, j)
			
			var source_id = get_cell_source_id(cell)
			var atlas_coords = get_cell_atlas_coords(cell)
			var alter_tile = get_cell_alternative_tile(cell)
			
			#print_debug(alter_tile)
			
			map.set_cell(cell+offset, source_id, atlas_coords, alter_tile)
