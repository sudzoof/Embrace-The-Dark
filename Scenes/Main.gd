extends Node

var current_scene = null

var level_path_list = Array()

var current_level = 0

var debug_level = 0

func _ready():
	var root = get_tree().root
	#current_scene = root.get_child(root.get_child_count() - 1)
	for i in 6:
		level_path_list.append("res://Scenes/Levels/Level %d.tscn" % (i + 1))
	if debug_level:
		current_level = debug_level
		go_to_level(debug_level)
		# call_deferred("set_signals")
	else:
		goto_scene("res://Scenes/Levels/Start.tscn")
		# goto_scene("res://Scenes/Levels/You Win.tscn")

func goto_scene(path):
	#This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.
	
	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	call_deferred("_deferred_goto_scene", path)

func reset_level():
	print("reset")
	go_to_level(current_level)

func next_level():
	if current_level < level_path_list.size() - 1:
		current_level += 1
		go_to_level(current_level)
	else:
		goto_scene("res://Scenes/Levels/You Win.tscn")

func go_to_level(num: int) -> void:
	goto_scene(level_path_list[num])

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	# current_scene.free()
	# current_scene.queue_free()
	if current_scene:
		current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().current_scene = current_scene
	
	current_scene.set_signals(self)

func start_first_level():
	current_level = 0
	go_to_level(0)
