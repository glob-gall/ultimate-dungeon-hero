class_name LevelMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass

func get_tile(at:Vector2) -> Vector2i:
	return local_to_map(to_local(at))

func replace_tile(at:Vector2i) ->void:
	if get_cell_atlas_coords(at) == Vector2i(3,0):
		set_cell(at, 0, Vector2i(3, 1)) 

		
