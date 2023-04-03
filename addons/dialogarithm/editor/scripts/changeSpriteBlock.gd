@tool
extends InstructionBlock

@export var Npositions := 5
var aaaa

func duplicateBlock(data = null):
	var newNode = preload("res://addons/dialogarithm/editor/change_sprite_block.tscn").instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	newNode.aaaa = data
	get_parent().add_child(newNode)

func _enter_tree():
	for i in %Slots.get_children():
		i.queue_free()
	for i in range(Npositions):
		data.append({"position" : i, "texture" : ""})
		var newSlot = preload("res://addons/dialogarithm/editor/sprite_selector.tscn").instantiate()
		newSlot.positionId = data[i]["position"]
		newSlot.texture = data[i]["texture"]
		newSlot.connect("texture_changed", Callable(self, "TextureChange"))
		%Slots.add_child(newSlot)

func TextureChange(texture = null, id = 1):
	data[id - 1]["texture"] = texture
	print(data)
