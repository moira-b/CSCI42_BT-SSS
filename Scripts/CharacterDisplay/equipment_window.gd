extends Window

@onready var armor_list: ItemList = $EquipmentList/ArmorContainer/ArmorList
@onready var p_wep_list: ItemList = $EquipmentList/PWepContainer/PWepList
@onready var s_wep_list: ItemList = $EquipmentList/SWepContainer/SWepList

@onready var confirm_button = $ButtonsContainer/ConfirmButton
@onready var cancel_button = $ButtonsContainer/CancelButton
@onready var character: Character

var selected_equipment: Array[String]

func showWindow(character: Character):
	
	if !character:
		print("ERROR. No character was passed to the equipment manager window.")
		return
	
	connect_signals()
	self.character = character
	
	selected_equipment = [character.items[0], character.items[1], character.items[2]]
	print(selected_equipment)
	var tier = -1
	if character.level < 2:
		tier = 1
	elif character.level <5:
		tier = 2
	elif character.level <8:
		tier = 3
	else:
		tier = 4
		
	armor_list.populate_list(tier)
	p_wep_list.populate_list(tier)
	s_wep_list.populate_list(tier)
	
	# preselect current equipment
	preselect_current_equipment(character.items)
	
	self.show()

func _on_confirm_button_pressed():
	# pass selected equipment to the character
	character.update_equipment(selected_equipment)
	disconnect_signals()
	get_parent().update_equipment_display()
	self.hide()
	
func _on_cancel_button_pressed():
	disconnect_signals()
	self.hide()

func _on_item_selected():
	selected_equipment[0] = armor_list.get_selected_armor()
	selected_equipment[1] = p_wep_list.get_selected_primary()
	selected_equipment[2] = s_wep_list.get_selected_secondary()
	
	# if the selected equipment is valid, allow confirm button to be clicked
	# else, do not allow confirm button to be clicked
	confirm_button.disabled = !is_selection_valid()
	
	print("DEBUG. "
		+ "Armor: " + armor_list.get_selected_armor() + " | "
		+ "Primary: " + p_wep_list.get_selected_primary() + " | "
		+ "Secondary: " + s_wep_list.get_selected_secondary()
	)

func preselect_current_equipment(current_equipment: Array[String]):
	armor_list.selected_armor = current_equipment[0]
	p_wep_list.selected_primary = current_equipment[1]
	s_wep_list.selected_secondary = current_equipment[2]
	
func is_selection_valid() -> bool:
	var primary_burden: String = p_wep_list.get_burden()
	
	if primary_burden=="One-Handed":
		s_wep_list.disable_selection(false)
		if selected_equipment.count("")==0:
			"DEBUG: One-handed primary selected. Equipment choices are valid."
			return true
		else:
			"DEBUG: Insufficient equipment selected. Equipment choices are invalid."
			return false
	elif primary_burden=="Two-Handed":
		s_wep_list.deselect_all()
		s_wep_list.disable_selection(true)
		selected_equipment[2] = ""
		if selected_equipment[0]=="":
			print("DEBUG: Armor not selected. Equipment choices are invalid.")
			return false
		else:
			print("DEBUG: Two-Handed primary selected. Equipment choices are valid.")
			return true
	else:
		print("DEBUG: Unexpected behaviour in is_selection_valid() of equipment_window.gd")
		return false
	
func connect_signals():
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	armor_list.armor_item_selected.connect(_on_item_selected)
	p_wep_list.primary_item_selected.connect(_on_item_selected)
	s_wep_list.secondary_item_selected.connect(_on_item_selected)
	
func disconnect_signals():
	confirm_button.pressed.disconnect(_on_confirm_button_pressed)
	cancel_button.pressed.disconnect(_on_cancel_button_pressed)
	armor_list.armor_item_selected.disconnect(_on_item_selected)
	p_wep_list.primary_item_selected.disconnect(_on_item_selected)
	s_wep_list.secondary_item_selected.disconnect(_on_item_selected)
