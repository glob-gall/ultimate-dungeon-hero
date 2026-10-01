class_name Door
extends Area2D

signal door_entered(target_level_number: int, target_door_id:int)


@onready var spawn_point: Marker2D = $spawn_point

@export var door_id: int = 0
@export var target_door_id: int = 0
@export_range(1, 3) var target_level_number: int 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # body_entered.connect(_on_body_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		door_entered.emit(target_level_number,target_door_id)

func get_spawn_position() -> Vector2:
	return spawn_point.global_position
