extends Node2D


onready var goal = $Goal
onready var player = $Player

onready var main = get_node("/root/Main")

signal next_level
signal reset_level

# Called when the node enters the scene tree for the first time.
func _ready():
	goal.connect("player_entered", self, "next_level")
	player.connect("hit_by_light", self, "reset_level")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_reset"):
		reset_level()

func reset():
	get_tree().change_scene("res://path/to/scene.tscn")

func next_level():
	emit_signal("next_level")
	#main.next_level()

func reset_level():
	emit_signal("reset_level")
	#main.reset_level()

func set_signals(main):
	self.connect("next_level", main, "next_level")
	self.connect("reset_level", main, "reset_level")
