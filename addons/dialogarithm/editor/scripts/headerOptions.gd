@tool
extends Control
class_name DialogBlock
@export var managerNode : NodePath
@export var instructionTitle = "Block Instruction"
var data : Array

func _enter_tree():
	$PanelContainer/MarginContainer/VBoxContainer/Header/Title.text = instructionTitle

func moveUp():
	get_parent().move_child(self, get_index() - 1)

func moveDown():
	get_parent().move_child(self, get_index() + 1)

func duplicateBlock():
	get_parent().add_child(duplicate())
	Initialize()

func delete():
	queue_free()

func Initialize():
	get_node(managerNode).call("Initialization")

func StoreData():
	data = get_node(managerNode).call("GetData")
