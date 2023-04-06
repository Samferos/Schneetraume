@tool
extends Control

var title = "Dialog Title"
var description = "A Example Dialog"

func _enter_tree():
	$PanelContainer/HBoxContainer/File.get_popup().connect("id_pressed", Callable(self, "FileSubMenu"))

func FileSubMenu(id):
	match id:
		0: #Save
			print("Saving")
			var savedData = [{"information": {"title": title,"description": description},"contents": {}}]
			for i in %DialogueBlocksList.get_child_count():
				savedData[0]["contents"][i]
		1: #Load
			print("Loading")
		3: #Clear
			print("Clearing")

