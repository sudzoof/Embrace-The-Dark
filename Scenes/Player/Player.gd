extends KinematicBody2D

class_name Player

export (int) var speed = 200

var velocity = Vector2()

func _ready():
	add_to_group("Player")
	for light in get_tree().get_nodes_in_group("Lights"):
		light.connect("player_in_light", self, "on_contact_with_light")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("game_right"):
		velocity.x += 1
	if Input.is_action_pressed("game_left"):
		velocity.x -= 1
	if Input.is_action_pressed("game_down"):
		velocity.y += 1
	if Input.is_action_pressed("game_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func on_contact_with_light():
	print("In Light")
