@tool
extends Control
class_name SpriteSelector
const _selector = preload("res://addons/dialogarithm/editor/sprite_selector.tscn")
signal texture_changed

var positionId : int

func _init(id):
	positionId = id
	add_child(_selector.instantiate())

func Initialization():
	$HBoxContainer/LeftPanel/Label.text = "Position " + str(positionId)
	$HBoxContainer/LeftPanel/Button.connect("pressed", Callable(self, "SearchFile"))

func SearchFile():
	var window = FileDialog.new()
	window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	window.add_filter("*.png", "Transparent Images")
	window.connect("file_selected", Callable(self, "UpdateSprite"))
	get_node("/root").get_child(0).add_child(window)
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	window.size = Vector2(600, 400)
	window.visible = true

func UpdateSprite(sprite):
	emit_signal("texture_changed")
	$HBoxContainer/Texture.texture = load(sprite)
