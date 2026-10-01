class_name Level
extends Node2D

signal level_change_request(target_level_number: int)
@onready var player: Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for door:Door in find_children("*","Door",true,false):
		door.door_entered.connect(_on_door_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_door_entered(target_level_number:int, target_door_id:int) -> void:
	level_change_request.emit(target_level_number,target_door_id)

func place_player_at_door(door_id:int) -> void:
	print("place_player_at_door")
		
	for door:Door in find_children("*","Door",true,false):
		if door.door_id == door_id:
			print("door_id:  " + str(door.door_id))
			player.global_position = door.get_spawn_position()
			return
	
