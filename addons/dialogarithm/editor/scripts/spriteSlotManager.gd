@tool
extends DataManager

const textureSlot = "res://addons/dialogarithm/editor/sprite_selector.tscn"
@export var positionTypes := 5
var slots : Array

func _enter_tree():
	print($VBoxContainer/Positions.get_child(0).is_connected("toggled", Callable(self, "TogglePosition")))

func Initialization():
	#Slots Values Dictionnary Init
	for i in positionTypes:
		slots.append({("position" + str(i + 1)) : false}) 
		var switch = CheckButton.new()
		switch.text = "Position " + str(i + 1)
		switch.button_pressed = slots[i]["position" + str(i + 1)]
		switch.connect("toggled", Callable(self, "TogglePosition").bind(i + 1))
		$VBoxContainer/Positions.add_child(switch)
	SetSlots()

func GetData() -> Dictionary:
	var data : Array
	for i in positionTypes:
		if slots["position" + str(i + 1)]:
			data.append(["position" + str(i + 1), ])

func SetSlots():
	var presentSlots : PackedInt32Array
	#Deleting no longer desired position slots or the none label
	#and list those that are still desired and present.
	for i in $VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.get_children():
		if i is Label:
			i.queue_free()
		elif slots["position" + str(i.positionId)] == false:
			i.queue_free()
		elif slots["position" + str(i.positionId)]:
			presentSlots.append(i.positionId)
	#Instancing position slots based on those desired and still
	#not present.
	for i in range(positionTypes):
		var slotname = "position" + str(i + 1)
		if slots[slotname] and not presentSlots.has(i + 1):
			var NewSlot = preload("res://addons/dialogarithm/editor/sprite_selector.tscn").instantiate()
			NewSlot.positionId = i + 1
			NewSlot.Initialization()
			$VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.add_child(NewSlot)
	#Adding empty notifier label if no position slot is desired.
	if slots.find_key(true) == null:
		var emptytext = Label.new()
		emptytext.text = "brain empty no thoughts"
		emptytext.add_theme_color_override("font_color", Color.DARK_GRAY)
		$VBoxContainer/PanelContainer/VBoxContainer/Panel/Slots.add_child(emptytext)

func TogglePosition(state, id):
	var slotname = "position" + str(id)
	slots[slotname] = state
	SetSlots()
