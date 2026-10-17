extends CharacterBody2D


const SPEED = 100.0

@onready var enemy_movement_comp: EnemyMovementComp = $EnemyMovementComp

func _physics_process(delta: float) -> void:

	var direction = enemy_movement_comp.get_direction()
	velocity = direction
	move_and_slide()
