extends Light2D

onready var collisionAreas : Array
onready var rayCast2D = $LightPlayerRay

signal player_in_light

func _ready():
	add_to_group("Lights")
	set_collision_areas()

func _physics_process(delta):
	if enabled:
		for body in get_overlapping_union_bodies(collisionAreas):
			if body.is_in_group("Player"):
				check_cast_on_player(body)

func check_cast_on_player(player):
	# get distance from this to player
	var direction_to_player = player.global_position - global_position
	rayCast2D.cast_to = direction_to_player
	rayCast2D.force_raycast_update()
	# Gets closest collision object in direction to player
	var collision_object = rayCast2D.get_collider()
	if collision_object == player:
		# emit_signal("player_in_light")
		collision_object.on_contact_with_light()

func set_collision_areas():
	collisionAreas = Array()
	for child in get_children():
		if child is Area2D:
			collisionAreas.append(child)

func get_overlapping_union_bodies(array):
	var output = Array()
	var bodies = Array()
	var first_iter = true
	for area2d in array:
		if first_iter:
			output = area2d.get_overlapping_bodies()
			first_iter = false
		else:
			output = Array()
			for body in area2d.get_overlapping_bodies():
				if bodies.has(body):
					output.append(body)
		bodies = output
	return output
