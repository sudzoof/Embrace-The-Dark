extends KinematicBody2D

class_name Player

export (int) var speed = 100

var velocity = Vector2()
var direction = Vector2()

var interacting_with : Object

signal interact(object, _msg)
signal hit_by_light

func _ready():
	add_to_group("Player")
	for light in get_tree().get_nodes_in_group("Lights"):
		light.connect("player_in_light", self, "on_contact_with_light")
	for box in get_tree().get_nodes_in_group("Interactable"):
		connect("interact", box, "on_interaction")
	$XSM.change_state("Idle")

func get_input() -> Vector2:
	var velocity = Vector2()
	if Input.is_action_pressed("game_right"):
		velocity.x += 1
	if Input.is_action_pressed("game_left"):
		velocity.x -= 1
	if Input.is_action_pressed("game_down"):
		velocity.y += 1
	if Input.is_action_pressed("game_up"):
		velocity.y -= 1
	return velocity

func _physics_process(delta):
	# TODO just make a state machine or smth
	return
	get_input()
	#box_collision()
	var object = get_object_in_front()
	if object and Input.is_action_pressed("game_interact"):
		interacting_with = object
		
	if interacting_with:
		interacting_with.interacted = true
		if interacting_with is Box:
			emit_signal("interacting_with_box", velocity, interacting_with)
	move_and_slide(velocity)
	
	
		
	interacting_with = null
	
	#var collision_object = move_and_collide(velocity * delta)

func get_object_in_front() -> Object:
	print(direction)
	var ray_cast : RayCast2D
	if direction == Vector2(1, 0):
		ray_cast = $RayCastRight
	elif direction == Vector2(-1, 0):
		ray_cast = $RayCastLeft
	elif direction == Vector2(0, 1):
		ray_cast = $RayCastDown
	elif direction == Vector2(0, -1):
		ray_cast = $RayCastUp
	else:
		return null
	print("getting_raycast")
	ray_cast.force_raycast_update()
	return ray_cast.get_collider()

func on_contact_with_light():
	emit_signal("hit_by_light")

func colliding_with(object: Object) -> bool:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == object:
			return true
	return false
