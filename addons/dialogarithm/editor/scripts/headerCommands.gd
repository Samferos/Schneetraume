@tool
extends Control

var title = "Dialog Title"
var description = "A Example Dialog"
const Block0 = preload("res://addons/dialogarithm/editor/display_text_block.tscn")
const Block1 = preload("res://addons/dialogarithm/editor/change_sprite_block.tscn")

func _enter_tree():
	$PanelContainer/HBoxContainer/File.get_popup().connect("id_pressed", Callable(self, "FileSubMenu"))

func FileSubMenu(id):
	match id:
		0: #Save
			print("Saving")
			var window = FileDialog.new()
			window.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			window.add_filter("*.json", "this one will be valid")
			window.connect("file_selected", Callable(self, "Save"))
			get_node("/root").get_child(0).add_child(window)
			window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
			window.size = Vector2(600, 400)
			window.visible = true
		1: #Load
			print("Loading")
			var window = FileDialog.new()
			window.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			window.add_filter("*.json", "a usable dialog file not any json file you smartass")
			window.connect("file_selected", Callable(self, "Load"))
			get_node("/root").get_child(0).add_child(window)
			window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
			window.size = Vector2(600, 400)
			window.visible = true
		3: #Clear
			print("Clearing")
			Clear()

func Load(newData):
	var file = FileAccess.open(newData, FileAccess.READ)
	newData = JSON.parse_string(file.get_as_text())
	for i in newData[0]["contents"]:
		var newBlock
		newBlock = get("Block" + str(i["id"])).instantiate()
		newBlock.data = i["data"]
		%DialogueBlocksList.add_child(newBlock)
	file.close()

func Save(newData):
	var savedData = [{"information": {"title": title,"description": description},"contents":[]}]
	for i in %DialogueBlocksList.get_child_count():
		var selectedBlock = %DialogueBlocksList.get_child(i)
		savedData[0]["contents"].append({"id" : selectedBlock.instructionId, "data" : selectedBlock.data})
	var file = FileAccess.open(newData, FileAccess.WRITE)
	file.store_string(JSON.stringify(savedData, " ", false, true))
	file.close()

func Clear():
	for i in %DialogueBlocksList.get_children():
		i.queue_free()
