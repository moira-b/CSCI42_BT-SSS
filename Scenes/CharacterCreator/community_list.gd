extends ItemList

@export var community_array: Array[Community]

var character: Character

func _ready() -> void:
	for option in community_array:
		add_item(option.community_name)
		option.set_description()
	
	self.item_selected.connect(_on_item_selected)
	character = self.get_parent().get_parent().get_child(0)

func _on_item_selected(_index: int):
	var desc_of_selected: String = community_array[_index].description
	self.get_parent().get_parent().show_description(desc_of_selected)
	character.community = community_array[_index]
