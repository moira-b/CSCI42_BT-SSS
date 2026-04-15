extends ItemList

var character: Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/weapons.json", FileAccess.READ)
	var json = JSON.new()
	var weapon_list = file.get_as_text()
	file.close()
	var weapon_dict = json.parse_string(weapon_list)
	character = $"../../../../Character"
	for item in weapon_dict:
		if self.name == "PWepList":
			if weapon_dict[item].category == "Primary" && weapon_dict[item].tier == 1:
				add_item(item)
		if self.name == "SWepList":
			if weapon_dict[item].category == "Secondary" && weapon_dict[item].tier == 1:
				add_item(item)
