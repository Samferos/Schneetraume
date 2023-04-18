@tool
extends "res://addons/dialogarithm/editor/scripts/instructionBlock.gd"

@onready var speaker = $PanelContainer/MarginContainer/Contents/MarginContainer/PanelContainer/Speaker
@onready var dialog_text = $PanelContainer/MarginContainer/Contents/MarginContainer2/PanelContainer/DialogText

func _enter_tree():
	if not data.size() == 2:
		data.append({"speaker" : ""})
		data.append({"text" : ""})

func _ready():
	speaker.set_deferred("text", data[0]["speaker"])
	dialog_text.set_deferred("text", data[1]["text"])

func dataUpdate():
	data[0] = {"speaker" : speaker.text}
	data[1] = {"text" : dialog_text.text}
	print(data)
