class_name LevelManager
extends Node

@onready var main: Node2D = $".."

const BASE_LEVEL_PATH := "res://scenes/levels/level_" # 1.tscn
const MAX_LEVEL := 2
var current_level_number: int
var current_level: Level

var player_spawn_id: int = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level_number = 1
	render_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func render_level():
	if current_level:
		current_level.queue_free()
		current_level = null
	var level_path = BASE_LEVEL_PATH+ str(current_level_number)+".tscn"
	
	var scene: PackedScene = load(level_path)
	current_level = scene.instantiate() as Level
	print(current_level)
	add_child.call_deferred(current_level)
	current_level.level_change_request.connect(_on_level_change_requested)
	
	if player_spawn_id != -1:
		current_level.place_player_at_door.call_deferred(player_spawn_id)

	
func set_level(level:int,door_id:int):
	current_level_number = level
	player_spawn_id = door_id
	render_level()


func _on_level_change_requested(target_level: int, target_door_id:int) -> void:
	print("MANAGER _on_level_change_requested " + str(target_level)+"  " + str(target_door_id))
	# deferred, because we're inside a physics callback (body_entered)
	call_deferred("set_level", target_level,target_door_id)
