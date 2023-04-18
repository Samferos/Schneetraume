@tool
extends "res://addons/dialogarithm/editor/scripts/instructionBlock.gd"

@export var Npositions := 5

func duplicateBlock():
	var newNode = preload("res://addons/dialogarithm/editor/blocks/change_sprite_block.tscn").instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
	newNode.set("data", data)
	get_parent().add_child(newNode)

func _enter_tree():
	for i in %Slots.get_children():
		i.queue_free()
	for i in range(Npositions):
		if data.size() == i:
			data.append({"position" : i + 1, "texture" : null, "highlighted" : false})
		elif not data[i].has("position"):
			data[i] = {"position" : i + 1, "texture" : null, "highlighted" : false}
		var newSlot = preload("res://addons/dialogarithm/editor/sprite_selector.tscn").instantiate()
		newSlot.positionId = data[i]["position"]
		newSlot.texture = data[i]["texture"]
		newSlot.highlighted = data[i]["highlighted"]
		newSlot.connect("data_changed", Callable(self, "DataChange"))
		%Slots.add_child(newSlot)

func DataChange(texture = null, highlight = false, id = 1):
	data[id - 1]["texture"] = texture
	data[id - 1]["highlighted"] = highlight
