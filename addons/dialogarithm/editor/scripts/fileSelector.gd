@tool
extends HBoxContainer

var positionId = 1

func _enter_tree():
	$LeftPanel/Label.text = "Position " + str(positionId)
	$LeftPanel/Button.connect("pressed", Callable(self, "SearchFile"))

func SearchFile():
	var window = FileDialog.new()
	window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	window.add_filter("*.png", "Transparent Images")
	window.connect("file_selected", Callable(self, "UpdateSprite"))
	EditorPlugin.new().get_editor_interface().get_base_control().add_child(window)

func UpdateSprite(sprite):
	get_child(2).texture = sprite
