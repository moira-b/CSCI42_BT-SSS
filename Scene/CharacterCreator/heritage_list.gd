extends ItemList

@export var heritage_array: Array[Ancestry]

var character: Character

func _ready() -> void:
	for option in heritage_array:
		add_item(option.ancestry_name)
	
	self.item_selected.connect(_on_item_selected)
	character = self.get_parent().get_parent().get_child(0)
	
func _on_item_selected(_index: int):
	character.ancestry = heritage_array[_index]
