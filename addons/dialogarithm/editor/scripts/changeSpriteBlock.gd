@tool
extends InstructionBlock

@export var Npositions := 5
var slots : Array

func Initialize():
	#Slots Values Dictionnary Init
	slots.clear()
	for i in %Positions.get_children():
		i.queue_free()
	for i in %Slots.get_children():
		i.queue_free()
	for i in Npositions:
		slots.append({("position" + str(i + 1)) : false, "texture" : null}) 
		var switch = CheckButton.new()
		switch.text = "Position " + str(i + 1)
		switch.button_pressed = slots[i]["position" + str(i + 1)]
		switch.connect("toggled", Callable(self, "TogglePosition").bind(i + 1))
		%Positions.add_child(switch)
	SetSlots()

func SetSlots():
	var presentSlots : PackedInt32Array
	print(slots)
	#Deleting no longer desired position slots or the none label
	#and list those that are still desired and present.
	for i in %Slots.get_children():
		if i is Label:
			i.queue_free()
		elif slots[i.positionId]["position" + str(i.positionId)] == false:
			i.queue_free()
		elif slots[i.positionId]["position" + str(i.positionId)]:
			presentSlots.append(i.positionId)
	#Instancing position slots based on those desired and still
	#not present.
	for i in range(Npositions):
		var slotname = "position" + str(i + 1)
		if slots[i][slotname] and not presentSlots.has(i + 1):
			%Slots.add_child(SpriteSelector.new(i + 1))
	#Adding empty notifier label if no position slot is desired.
	var emptiness
	for i in slots:
		if i["position" + str(i + 1)] == true:
			emptiness += 1
	if emptiness >= Npositions:
		var emptytext = Label.new()
		emptytext.text = "brain empty no thoughts"
		emptytext.add_theme_color_override("font_color", Color.DARK_GRAY)
		%Slots.add_child(emptytext)

func TogglePosition(state, id):
	var slotname = "position" + str(id)
	slots[id - 1]["position" + str(id)] = state
	SetSlots()
