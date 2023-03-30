@tool
extends Control
class_name InstructionBlock
@export var instructionTitle = "Block Instruction"
var data : Array

func _enter_tree():
	%Header.get_node("Title").text = instructionTitle

func moveUp():
	get_parent().move_child(self, get_index() - 1)

func moveDown():
	get_parent().move_child(self, get_index() + 1)

func duplicateBlock():
	get_parent().add_child(duplicate())

func delete():
	queue_free()

func Initialize():
	pass
