extends ItemList

signal primary_item_selected()

@onready var s_wep_list: ItemList = $"../../SWepContainer/SWepList"

var weapon_dict: Dictionary
var tier_1_dict: Dictionary
var primaries: Array[String]
var selected_primary: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://Resources/Equipment/weapons.json", FileAccess.READ)
	var json = JSON.new()
	var weapon_list = file.get_as_text()
	file.close()
	weapon_dict = json.parse_string(weapon_list)
	
	tier_1_dict = weapon_dict.duplicate(true)
	for q in weapon_dict:
		if tier_1_dict[q].category == "Primary":
			primaries.append(q)

	for item in primaries:
		if weapon_dict[item].tier ==1:
			add_item(item)
	self.item_selected.connect(_on_item_selected)

func populate_list(tier: int):
	clear()
	
	for item in weapon_dict:
		if weapon_dict[item].tier <= tier and weapon_dict[item].category == "Primary":
			add_item(item)
	
	self.item_selected.connect(_on_item_selected)
func _on_item_selected(_index: int) -> void:
	selected_primary = primaries[_index]
	primary_item_selected.emit()
	
func get_selected_primary():
	return selected_primary
	
	
func get_burden():
	return tier_1_dict[selected_primary].burden
