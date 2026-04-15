extends ItemList

@onready var p_wep_list: ItemList = $"../../PWepContainer/PWepList"

var weapon_dict: Dictionary
var tier_1_dict: Dictionary
var secondaries: Array[String]
var selected_secondary: String
var character: Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/weapons.json", FileAccess.READ)
	var json = JSON.new()
	var weapon_list = file.get_as_text()
	file.close()
	weapon_dict = json.parse_string(weapon_list)
	character = $"../../../../Character"
	
	tier_1_dict = weapon_dict.duplicate(true)
	for q in weapon_dict:
		if weapon_dict[q].tier != 1:
			tier_1_dict.erase(q)
	for w in tier_1_dict:
		if tier_1_dict[w].category == "Secondary":
			secondaries.append(w)

	for item in secondaries:
		add_item(item)
	self.item_selected.connect(_on_item_selected)


func _on_item_selected(_index: int) -> void:
	if character.items.size() > 2:
		character.items[2] = secondaries[_index]
	else:
		character.items.append(secondaries[_index])
