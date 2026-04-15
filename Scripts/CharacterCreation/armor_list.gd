extends ItemList

var character: Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/armor.json", FileAccess.READ)
	var json = JSON.new()
	var armor_list = file.get_as_text()
	file.close
	var armor_dict = json.parse_string(armor_list)
	character = $"../../../../Character"
	for item in armor_dict:
		if armor_dict[item].tier == 1:
			add_item(item)
	
