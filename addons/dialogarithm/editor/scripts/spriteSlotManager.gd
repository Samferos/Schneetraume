@tool
extends Control

const textureSlot = "res://addons/dialogarithm/editor/sprite_selector.tscn"
@export var positionTypes := 5
var slots = {"position1" = false, "position2" = false, "position3" = false, "position4" = false, "position5" = false}

func _enter_tree():
	#Slots Values Dictionnary Init
	for i in positionTypes:
		slots["position" + str(i + 1)] = false
	for i in positionTypes:
		if $VBoxContainer/Positions.get_child(i) is CheckButton:
			#Slots Values Get from existing CheckButton
			slots["position" + str(i + 1)] = $VBoxContainer/Positions.get_child(i).button_pressed
		else:
			var switch = CheckButton.new()
			switch.text = "Position " + str(i + 1)
			switch.button_pressed = slots["position" + str(i+1)]
			$VBoxContainer/Positions.add_child(switch)
	SetSlots()
	print(slots)

func SetSlots():
	for i in $VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.get_children():
		if i is Label:
			i.queue_free()
		elif slots["position" + str(i.positionId)]:
			i.queue_free()
	if slots.find_key(true) == null:
		var emptytext = Label.new()
		emptytext.text = "brain empty no thoughts"
		emptytext.add_theme_color_override("font_color", Color.DARK_GRAY)
		$VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.add_child(emptytext)
	else:
		for i in range(positionTypes):
			var slotname = "position" + str(i + 1)
			if slots[slotname]:
				var NewSlot = preload("res://addons/dialogarithm/editor/sprite_selector.tscn").instantiate()
				NewSlot.positionId = i + 1
				$VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.add_child(NewSlot)

func TogglePosition(state, id):
	var slotname = "position" + str(id)
	slots[slotname] = state
	SetSlots()
