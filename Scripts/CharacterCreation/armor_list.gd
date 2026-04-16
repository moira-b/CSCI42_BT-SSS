extends ItemList

var character: Character
var armor_dict: Dictionary
var armor_array: Array
var selected_armor: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/armor.json", FileAccess.READ)
	var json = JSON.new()
	var armor_list = file.get_as_text()
	file.close()
	armor_dict = json.parse_string(armor_list)
	armor_array = armor_dict.keys()
	
	for item in armor_dict:
		if armor_dict[item].tier == 1:
			add_item(item)
	
	self.item_selected.connect(_on_item_selected)
	
	
func _on_item_selected(_index: int) -> void:
	selected_armor = armor_array[_index]
	

func get_selected_armor():
	return selected_armor
