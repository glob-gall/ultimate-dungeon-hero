class_name Fire extends Area2D

@onready var fire_collision: CollisionShape2D = $FireCollision
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.stop()
	animated_sprite_2d.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	
	
func play() -> void:
	animated_sprite_2d.show()
	animated_sprite_2d.play("default")
	_apply_fire_damage()
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.stop()
	animated_sprite_2d.hide()
	



func _apply_fire_damage() ->void :
	for area in get_overlapping_areas():
		if area.is_in_group("arrow"):
			area.remove()
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			body.die()
	

	
