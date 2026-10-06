extends Node2D

@onready var tile_manager: TileManager = $TileManager
@onready var level_manager: LevelManager = $LevelManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	level_manager.level_change.connect(tile_manager.level_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
