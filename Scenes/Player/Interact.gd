tool
extends State

var player: Player
var interact_object: Object

func _on_enter(_args):
	print("Interacting")
	player = target as Player
	if not player.is_on_wall():
		change_state("Movement")
		return
	player.interacting_with = player.get_object_in_front()
	change_to_sub_state(player.interacting_with)

func _on_update(_delta):
	if not (Input.is_action_pressed("game_interact") and player.interacting_with == player.get_object_in_front()):
		change_state("Movement")

func change_to_sub_state(object):
	if not object:
		change_state("Movement")
	elif object.is_in_group("Boxes"):
		change_state("BoxInteract")
		return
	elif object.is_in_group("Switches"):
		change_state("SwitchInteract")
		return
	else:
		change_state("Movement")

func _on_exit(_args):
	player.interacting_with = null
