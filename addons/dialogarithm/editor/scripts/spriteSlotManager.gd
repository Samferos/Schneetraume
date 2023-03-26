@tool
extends Control

var slots = {position1 = false, position2 = false, position3 = false, position4 = false}
const textureSlot = "res://addons/dialogarithm/editor/sprite_selector.tscn"

func _enter_tree():
	SetSlots()

func SetSlots():
	for i in get_child_count():
		if i > 1:
			get_child(i).queue_free()
	if slots.find_key(true) == null:
		var emptytext = Label.new()
		emptytext.text = "brain empty no thoughts"
		emptytext.add_theme_color_override("font_color", Color.DARK_GRAY)
		add_child(emptytext)
	else:
		for i in range(4):
			var slotname = "position" + str(i + 1)
			if slots[slotname]:
				var NewSlot = preload("res://addons/dialogarithm/editor/sprite_selector.tscn").instantiate()
				NewSlot.positionId = i + 1
				add_child(NewSlot)

func TogglePosition(state, id):
	var slotname = "position" + str(id)
	slots[slotname] = state
	SetSlots()
