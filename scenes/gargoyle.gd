class_name Gargoyle extends Node2D


const FIRE = preload("uid://dqhipt3e60c3k")

@onready var marker_right: Marker2D = $MarkerRight
@onready var marker_left: Marker2D = $MarkerLeft
@onready var marker_up: Marker2D = $MarkerUp
@onready var marker_down: Marker2D = $MarkerDown
@onready var markers = [marker_right,marker_down,marker_left,marker_up]
@onready var timer: Timer = $Timer
@onready var fires: Array[Fire] = []

@export var fire_timer: float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rotation = 0
	timer.wait_time = fire_timer
	for marker in markers:
		var fire_instance:Fire = FIRE.instantiate()	
		get_tree().root.add_child(fire_instance)
		fire_instance.global_position = marker.global_position
		fire_instance.rotation = deg_to_rad(rotation)
		rotation+=90
		fires.append(fire_instance)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	for fire in fires:
		fire.play()
		
	
