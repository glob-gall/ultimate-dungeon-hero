class_name EndScreen extends CanvasLayer

signal start_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
#s	pass


func _on_start_pressed() -> void:
	start_game.emit()


func _on_quit_pressed() -> void:
	get_tree().quit()
