class_name Player
extends CharacterBody2D


const SPEED = 450.0
var last_direction: Vector2 = Vector2.RIGHT
var direction_name = "right"
var current_action = "idle"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var step: CollisionShape2D = $Step


func _physics_process(_delta: float) -> void:
	var direction:= Input.get_vector('left','right','up','down')	
	velocity = direction.normalized() * SPEED
	if direction != Vector2.ZERO:
		last_direction = direction
		current_action="run"
	else:
		current_action = "idle"
		
	direction_name = _get_direction(last_direction)
	_play_animation(direction_name)
	move_and_slide()

func _get_direction(vec:Vector2) -> String:
	if vec.x != 0:
		if vec.x < 0:
			return "left"
		return "right"
	if vec.y < 0:
		return "up"
	return "down"
	
func _play_animation(dir:String):
	if dir == "left":
		animated_sprite_2d.play(current_action+"_"+"right")
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play(current_action+"_"+dir)

func get_step_position() -> Vector2:
	return Vector2i(step.global_position)
