extends Node2D

signal player_entered

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("player_entered")
