extends Control

var step = 0
var currentDialog

func StartDialog(dialogFile : String):
	var file = FileAccess.open(dialogFile, FileAccess.READ)
	currentDialog = Dialog.new()
	var data = JSON.parse_string(file.get_as_text())

class Dialog:
	var data
	
	func nextBlock():
		pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
