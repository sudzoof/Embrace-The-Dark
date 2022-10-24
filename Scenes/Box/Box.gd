extends KinematicBody2D

class_name Box

var velocity = Vector2()

var interacted = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Boxes")
	for player in get_tree().get_nodes_in_group("Player"):
		player.connect("interacting_with_box", self, "on_interaction")
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if interacted:
		interacted = false
		move_and_collide(velocity * delta)
		#

func on_interaction(player_velocity, box):
	if box == self:
		print("Interacting with Box")
		interacted = true
		velocity = player_velocity
	return
