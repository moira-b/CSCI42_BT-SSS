extends ItemList

@export var ancestry_array: Array[Ancestry]

var character: Character

func _ready() -> void:
	for option in ancestry_array:
		add_item(option.ancestry_name)
		option.set_description()
	
	self.item_selected.connect(_on_item_selected)
	character = self.get_parent().get_parent().get_child(0)
	
func _on_item_selected(_index: int):
	var desc_of_selected: String = ancestry_array[_index].description
	self.get_parent().get_parent().show_description(desc_of_selected)
	character.ancestry = ancestry_array[_index]
