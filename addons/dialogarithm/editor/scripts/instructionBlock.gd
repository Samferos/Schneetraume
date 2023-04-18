@tool
extends Control
@export var instructionTitle = "Block Instruction"
@export var instructionId = 0
var data : Array

func _ready():
	%Header.get_node("Title").text = instructionTitle

func moveUp():
	get_parent().move_child(self, get_index() - 1)

func moveDown():
	get_parent().move_child(self, get_index() + 1)

func duplicateBlock():
	var newBlock = duplicate()
	newBlock.data = data
	get_parent().add_child(newBlock)

func delete():
	queue_free()

func Initialize(newData = null):
	pass
