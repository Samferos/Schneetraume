@tool
extends Control

func moveUp():
	get_parent().move_child(self, get_index() - 1)

func moveDown():
	get_parent().move_child(self, get_index() + 1)

func duplicateBlock():
	get_parent().add_child(duplicate(8))

func delete():
	queue_free()
