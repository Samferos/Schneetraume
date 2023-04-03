@tool
extends Control
class_name SpriteSelector
signal texture_changed(texture, id)

var positionId : int
var texture

func _enter_tree():
	$MarginContainer/HBoxContainer/LeftPanel/Label.text = "Position " + str(positionId)
	UpdateSprite(texture)

func SearchFile():
	var window = FileDialog.new()
	window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	window.add_filter("*.png", "Transparent Images")
	window.connect("file_selected", Callable(self, "UpdateSprite"))
	get_node("/root").get_child(0).add_child(window)
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	window.size = Vector2(600, 400)
	window.visible = true

func ClearTexture():
	UpdateSprite(null)

func UpdateSprite(sprite):
	emit_signal("texture_changed", sprite, positionId)
	texture = sprite
	if not sprite == null:
		$MarginContainer/HBoxContainer/Texture.texture = load(sprite)
	else:
		$MarginContainer/HBoxContainer/Texture.texture = null
