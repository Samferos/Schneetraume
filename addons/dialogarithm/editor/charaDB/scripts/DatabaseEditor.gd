extends Control

var ListView = $Margins/Separator/MainPanel/Splitter/ItemListPanel/Margin/List
var ItemView = $Margins/Separator/MainPanel/Splitter/ItemPanel/Margin/Scroll/ItemProps
var currentDB : Database

class Database:
	var name = "Unnamed Database"
	var items : List
	func _init(a):
		items = a
class List:
	var items : Array
	func _init(i : Array):
		for a in i:
			if a is Item:
				items = i
	class Item:
		var propreties : Dictionary
		func _init(props : Dictionary):
			propreties = props
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setupItemList(il = currentDB.items):
	pass
