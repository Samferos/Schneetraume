@tool
extends EditorPlugin

var DialogTab
func _enter_tree():
	DialogTab = preload("res://addons/dialogarithm/DialogueEditor.tscn").instantiate()
	add_control_to_bottom_panel(DialogTab, "Dialogues Editor")
	pass


func _exit_tree():
	remove_control_from_bottom_panel(DialogTab)
	pass
