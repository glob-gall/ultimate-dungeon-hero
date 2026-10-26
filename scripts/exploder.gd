class_name Exploder extends CharacterBody2D


#@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var hurtbox: Area2D = $Hurtbox

@onready var enemy_movement_comp: EnemyMovementComp = $EnemyMovementComp
@onready var wondering_timer: Timer = $WonderingTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var explosion_area: Area2D = $ExplosionArea

enum STATE {WALKING,WONDERING,DEAD}
var state:STATE = STATE.WALKING 

func _ready() -> void:
	print("EXPLODER READY")
	enemy_movement_comp.side_reached.connect(start_wondering)

func _physics_process(delta: float) -> void:
	if state == STATE.WONDERING:
		velocity = Vector2.ZERO
	elif state == STATE.WALKING:
		var direction = enemy_movement_comp.get_direction()
		velocity = direction
	else:
		velocity = Vector2.ZERO
	move_and_slide()

 
func _on_wondering_timer_timeout() -> void:
	if state == STATE.WONDERING:
		state = STATE.WALKING
		play_animation()
	
func start_wondering():
	if state == STATE.WALKING:
		state = STATE.WONDERING
		play_animation()
		wondering_timer.start()
	
func play_animation():
	if state == STATE.WALKING:
		animated_sprite_2d.play("run")
	elif state == STATE.WONDERING:
		animated_sprite_2d.play("idle")

	

func hit_by_arrow() -> void:
	_explode()

func _explode() -> void:
	state = STATE.DEAD
	animated_sprite_2d.play("explode")
	
	set_physics_process(false)
	hurtbox.set_deferred("disabled",true)
	await animated_sprite_2d.animation_finished
	_apply_explosion_damage()
	queue_free()
	
	
func _apply_explosion_damage() ->void :
	for area in explosion_area.get_overlapping_areas():
		print(area)

		if area.is_in_group("arrow"):
			area.remove()
	for body in explosion_area.get_overlapping_bodies():
		print(body)
		if body.is_in_group("player"):
			body.die()
	
	
	
	


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("arrow"):
		area.hit_enemy()
		hit_by_arrow()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_explode()
