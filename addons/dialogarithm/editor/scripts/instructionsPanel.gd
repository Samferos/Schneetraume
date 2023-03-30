@tool
extends Control

func addBlock(id):
	var wantedBlock
	match(id):
		0:
			wantedBlock = preload("res://addons/dialogarithm/editor/display_text_block.tscn").instantiate()
		1:
			wantedBlock = preload("res://addons/dialogarithm/editor/change_sprite_block.tscn").instantiate()
	wantedBlock.Initialize()
	%DialogueBlocksList.add_child(wantedBlock)
