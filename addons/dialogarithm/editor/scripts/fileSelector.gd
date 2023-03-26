@tool
extends Control

var positionId = 1

func _enter_tree():
	$LeftPanel/Label.text = "Position " + str(positionId)
	connect("gui_input", Callable(self, "Searchfile"), CONNECT_DEFERRED)

func SearchFile():
	var spriteFunc = Callable(self, "UpdateSprite")
	var window = FileDialog.new()
	window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	window.add_filter("*.png", "Transparent Images")
	window.connect("file_selected", spriteFunc)
	pass

func UpdateSprite(sprite):
	get_child(2).texture = sprite
	pass
