class_name Arrow
extends Node2D

const SPEED: int = 300
@export var hit: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !hit:
		position += transform.x * SPEED * delta

func setup(dir:Vector2) -> void:
	rotation = dir.angle()

func remove() -> void:
	if hit == true:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	hit=true
