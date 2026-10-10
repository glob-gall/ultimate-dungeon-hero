class_name Player
extends CharacterBody2D

const ARROW = preload("res://scenes/arrow.tscn")

const SPEED = 450.0
var last_direction: Vector2 = Vector2.RIGHT
var direction_name = "right"
var current_action = "idle"
var arrow_qnt = 4

var is_aiming:bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var step: CollisionShape2D = $Step
@onready var arrow_marker: Marker2D = $ArrowMarker


func _physics_process(_delta: float) -> void:
	direction_name = _get_direction(last_direction)
	
	if Input.is_action_just_pressed("shoot"):
		print('SHOOT')
		aim_shoot()
	if Input.is_action_just_released("shoot"):
		shoot()
		
	if is_aiming:
		velocity = Vector2.ZERO
		return
	

		
	
	_handle_moviment()
	_play_animation(direction_name)
	move_and_slide()

func _handle_moviment() -> void:
	var direction:= Input.get_vector('left','right','up','down')	
	velocity = direction.normalized() * SPEED
	if direction != Vector2.ZERO:
		last_direction = direction
		current_action="run"
	else:
		current_action = "idle"

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

func aim_shoot() ->void:
	velocity = Vector2.ZERO
	is_aiming=true
	if arrow_qnt > 0:
		current_action='shooting'
	else:
		current_action = "no_arrow"
	
	_play_animation(direction_name)

func shoot() -> void:
	is_aiming=false
	if arrow_qnt == 0:
		return
	arrow_qnt-=1
	var arrow_instance:Arrow = ARROW.instantiate()
	get_tree().root.add_child(arrow_instance)
	match direction_name:
		"right":
			arrow_instance.setup(Vector2.RIGHT)
			arrow_marker.position = Vector2(18,5)
		"left":
			arrow_instance.setup(Vector2.LEFT)
			arrow_marker.position = Vector2(-18,5)
		"up":
			arrow_instance.setup(Vector2.UP)
			arrow_marker.position = Vector2(0,-17)
		"down":
			arrow_instance.setup(Vector2.DOWN)
			arrow_marker.position = Vector2(0,24)

	arrow_instance.global_position = arrow_marker.global_position


func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("arrow"):
		area.remove()
		arrow_qnt+=1
