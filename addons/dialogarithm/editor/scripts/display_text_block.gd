@tool
extends InstructionBlock

var SpeakerBox = $PanelContainer/MarginContainer/Contents/MarginContainer/PanelContainer/Speaker
var TextBox = $PanelContainer/MarginContainer/Contents/MarginContainer2/PanelContainer/DialogText

func dataUpdate():
	data[0] = {"speaker" : SpeakerBox.text}
	data[1] = {"text" : TextBox.text}
