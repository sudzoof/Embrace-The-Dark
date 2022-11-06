tool
extends State

var player: Player


func _on_enter(_args):
	player = target as Player

func _on_update(_delta):
	var input_dir = player.get_input()
	
	if input_dir != Vector2.ZERO:
		var _s = change_state("Movement")
	
	if Input.is_action_just_pressed("game_interact"):
		var _s = change_state("Interact")
