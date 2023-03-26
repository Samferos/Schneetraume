@tool
extends EditorPlugin

var DialogTab
func _enter_tree():
	DialogTab = Button.new()
	DialogTab.set("text", "Hello World!")
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, DialogTab)
	pass


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, DialogTab)
	pass
