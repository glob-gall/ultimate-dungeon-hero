class_name TileManager
extends Node

#@onready var player: Player
@onready var level_manager: LevelManager = $"../LevelManager"

var current_tile:Vector2i
var last_tile:Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#player = get_tree().get_first_node_in_group("player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_floor()

func check_floor() -> void:
	current_tile = level_manager.get_current_tile()
	
	if last_tile and current_tile != last_tile:
		print("tile change")
		level_manager.current_level.map.replace_tile(last_tile)
	
	last_tile = current_tile

func level_changed():
	last_tile= Vector2i(99999,99999)
