extends ItemList

var character: Character
var subclass_array: Array[CharacterSubclass]

func _ready() -> void:
	self.item_selected.connect(_on_item_selected)
	character = self.get_parent().get_parent().get_child(0)

func _on_item_selected(_index: int):
	var option_selected = subclass_array[_index].description
	
	subclass_array = character.character_class.character_subclasses
	character.subclass = subclass_array[_index]
	self.get_parent().get_parent().show_description(option_selected)

func populate_subclass(subclass: CharacterSubclass):
	subclass_array.append(subclass)
