extends StaticBody2D

var switch_on = preload("res://Assets/switch-on.png")
var switch_off = preload("res://Assets/switch-off.png")
var handle_on = preload("res://Assets/handle-on.png")
var handle_off = preload("res://Assets/handle-off.png")

export var id : int
export var color = Color(1.0, 1.0, 1.0, 1.0)

export var is_on = true

signal flipped_switch

func _ready():
	add_to_group("Switches")
	add_to_group("Interactable")
	for player in get_tree().get_nodes_in_group("Player"):
		player.connect("interact", self, "on_interaction")
	for light in get_tree().get_nodes_in_group("Lights"):
		connect("flipped_switch", light, "change_light")
	$HandleSprite.modulate = color

func _process(delta):
	if is_on:
		$SwitchSprite.texture = switch_on
		$HandleSprite.texture = handle_on
	else:
		$SwitchSprite.texture = switch_off
		$HandleSprite.texture = handle_off

func on_interaction(object, _args):
	if self == object:
		is_on = not is_on
		emit_signal("flipped_switch", id)
