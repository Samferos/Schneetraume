@icon("res://addons/dialogarithm/editor/icons/toggleExpand.svg")
@tool
extends BaseButton
class_name ExpandButton

@export_node_path("Control") var toggled_node
func _init():
	toggled_node = true

func _toggled(button_pressed):
	get_node(toggled_node).visible = not button_pressed
