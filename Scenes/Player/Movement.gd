tool
extends State

var player: Player


func _on_enter(_args):
	player = target as Player

func _on_update(_delta):
	var input_dir = player.get_input()
	player.velocity = input_dir.normalized() * player.speed
	
	if input_dir != Vector2.ZERO:
		player.direction = input_dir
	
	if Input.is_action_just_pressed("game_interact"):
		var _s = change_state("Interact")
	
	player.move_and_slide(player.velocity)
