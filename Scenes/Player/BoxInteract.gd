tool
extends State

var player : Player

func _on_enter(_args):
	player = target as Player

func _on_update(_delta):
	var input_dir = player.get_input()
	if input_dir == player.direction or input_dir == -player.direction:
		player.emit_signal("interact", player.interacting_with, {"speed": input_dir.normalized() * player.speed})
		player.move_and_collide(input_dir.normalized() * player.speed * _delta)
	return
