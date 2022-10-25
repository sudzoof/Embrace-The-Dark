tool
extends State

var player : Player

func _on_enter(_args):
	player = target as Player
	player.emit_signal("interact", player.interacting_with, {})
	change_state("Movement")
