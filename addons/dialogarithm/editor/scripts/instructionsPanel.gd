@tool
extends "res://addons/dialogarithm/editor/scripts/editorMain.gd"

func addBlock(id):
	var wantedBlock = Blocks[id].instantiate()
	%DialogueBlocksList.add_child(wantedBlock)
