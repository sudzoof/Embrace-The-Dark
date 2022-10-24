tool
extends State

var player : Player

var target_box : Box

func _on_enter(from):
	player = target as Player
	target_box = player.interacting_with

func _on_update(_delta):
	var input_dir = player.get_input()
	if input_dir == player.direction:
		target_box.move_and_collide(input_dir.normalized() * player.speed * _delta)
		player.move_and_collide(input_dir.normalized() * player.speed * _delta)
	elif input_dir == -player.direction:
		player.move_and_slide(input_dir.normalized() * player.speed)
		target_box.move_and_collide(input_dir.normalized() * player.speed * _delta)
	return
