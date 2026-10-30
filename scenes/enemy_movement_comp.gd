class_name EnemyMovementComp extends Node2D

signal side_reached()
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var side_1: Vector2
@onready var side_2: Vector2
@onready var current_side: Vector2

@export var SPEED: float = 100.0


#var current_side: Marker2D

var body: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	side_1 = $Side1.global_position
	side_2 = $Side2.global_position
	current_side = $Side1.global_position
	body = owner
	if !body:
		set_physics_process(false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
	
func get_direction() -> Vector2:
	if _side_reached():
		side_reached.emit()
		_change_side()
	var direction = (current_side - body.global_position).normalized()
	var body_position = direction * SPEED
	
	return body_position

func _side_reached() -> bool:
	var distance_from_target = body.global_position.distance_to(current_side)
	if distance_from_target < 18:
		return true
	return false
	
func _change_side() ->void:
	if current_side == side_1:
		current_side = side_2
	else:
		current_side = side_1
