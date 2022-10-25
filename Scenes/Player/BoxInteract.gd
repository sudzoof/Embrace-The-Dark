tool
extends State

var player : Player

var target_box : Box

func _on_enter(_args):
	player = target as Player

func _on_update(_delta):
	var input_dir = player.get_input()
	if input_dir == player.direction:
		player.emit_signal("interact", player.interacting_with, {"speed": input_dir.normalized() * player.speed})
		player.move_and_collide(input_dir.normalized() * player.speed * _delta)
	elif input_dir == -player.direction:
		player.move_and_slide(input_dir.normalized() * player.speed)
		player.emit_signal("interact", player.interacting_with, {"speed": input_dir.normalized() * player.speed})
	return
