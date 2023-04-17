@tool
extends Control
class_name SpriteSelector
signal data_changed(texture, highlight, id)

var positionId : int
var texture
var highlighted : bool

func _enter_tree():
	$MarginContainer/HBoxContainer/LeftPanel/Label.text = "Position " + str(positionId)
	Update(texture, highlighted)

func SearchFile():
	var window = FileDialog.new()
	window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	window.add_filter("*.png", "Transparent Images")
	window.connect("file_selected", Callable(self, "Update"))
	get_node("/root").get_child(0).add_child(window)
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	window.size = Vector2(600, 400)
	window.visible = true

func ClearTexture():
	Update(null)

func Update(sprite = $MarginContainer/HBoxContainer/Texture.texture, highlight = $MarginContainer/HBoxContainer/LeftPanel/Highlight.button_pressed):
	if sprite is String:
		sprite = load(sprite)
	texture = sprite
	if not sprite == null:
		$MarginContainer/HBoxContainer/Texture.texture = sprite
		$MarginContainer/HBoxContainer/LeftPanel/Highlight.disabled = false
		$MarginContainer/HBoxContainer/LeftPanel/Highlight.button_pressed = highlight
	else:
		$MarginContainer/HBoxContainer/Texture.texture = null
		$MarginContainer/HBoxContainer/LeftPanel/Highlight.disabled = true
		$MarginContainer/HBoxContainer/LeftPanel/Highlight.button_pressed = false
		highlighted = false
	emit_signal("data_changed", sprite, highlight, positionId)
