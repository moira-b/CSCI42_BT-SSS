extends ItemList

var character: Character
var armor_dict: Dictionary
var armor_array: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/armor.json", FileAccess.READ)
	var json = JSON.new()
	var armor_list = file.get_as_text()
	file.close()
	armor_dict = json.parse_string(armor_list)
	armor_array = armor_dict.keys()
	character = $"../../../../Character"
	for item in armor_dict:
		if armor_dict[item].tier == 1:
			add_item(item)
	
	self.item_selected.connect(_on_item_selected)
	
	
func _on_item_selected(_index: int) -> void:
	if character.items.size() >= 1:
		character.items[0] = armor_array[_index]
	else:
		character.items.append(armor_array[_index])
