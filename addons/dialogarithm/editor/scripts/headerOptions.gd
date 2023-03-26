@tool
extends Control

func moveUp():
	get_parent().move_child(self, self.get_index() - 1)

func moveDown():
	get_parent().move_child(self, self.get_index() + 1)
