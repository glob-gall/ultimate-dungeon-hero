extends CharacterBody2D

enum STATE {WALKING,WONDERING,DEAD}
var state:STATE = STATE.WALKING 

@onready var enemy_movement_comp: EnemyMovementComp = $EnemyMovementComp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox


func _physics_process(delta: float) -> void:
	if state == STATE.WONDERING:
		velocity = Vector2.ZERO
	elif state == STATE.WALKING:
		var direction = enemy_movement_comp.get_direction()
		velocity = direction
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	


func _die():
	state = STATE.DEAD
	animated_sprite_2d.play("die")
	set_physics_process(false)
	hurtbox.set_deferred("disabled",true)
	await animated_sprite_2d.animation_finished
	queue_free()
	

func hit_by_arrow() -> void:
	_die()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("arrow"):
		area.hit_enemy()
		hit_by_arrow()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
