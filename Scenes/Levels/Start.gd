extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_interact"):
		emit_signal("start")

func set_signals(main):
	self.connect("start", main, "start_first_level")
