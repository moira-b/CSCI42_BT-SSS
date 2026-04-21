extends HBoxContainer

@onready var armor_list: ItemList = $ArmorContainer/ArmorList
@onready var p_wep_list: ItemList = $PWepContainer/PWepList
@onready var s_wep_list: ItemList = $SWepContainer/SWepList

var starting_inventory: Array[String] = ["", "", ""]
var primary_burden: String
var character: Character
var s_disabled = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character = self.get_parent().get_parent().get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	starting_inventory[0] = armor_list.get_selected_armor()
	starting_inventory[1] = p_wep_list.get_selected_primary()
	starting_inventory[2] = s_wep_list.get_selected_secondary()
	
	if starting_inventory[1] != "":
		primary_burden = p_wep_list.get_burden()
	if primary_burden == "Two-Handed":
		s_wep_list.deselect_all()
		if s_disabled:
			s_wep_list.disable_selection(s_disabled)
			s_disabled = false
		starting_inventory[2] = ""
	else:
		if not s_disabled:
			s_wep_list.disable_selection(s_disabled)
			s_disabled = true
		
		
	if starting_inventory.size() >= 3:
		character.items = starting_inventory

		
func is_equipment_valid() -> bool:
	if starting_inventory.count("") < 1:
		return true
	elif primary_burden == "Two-Handed" && starting_inventory[2] == "":
		return true
	else:
		return false
