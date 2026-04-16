extends Control

@onready var option_lists = $OptionLists
@onready var confirm_button = $ButtonContainer/ConfirmButton
@onready var complete_button = $ButtonContainer/CompleteButton
@onready var back_button = $ButtonContainer/BackButton
@onready var description_display = $DescriptionContainer
@onready var card_selector = $OptionLists/DomainCardSelContainer
@onready var character = $Character
@onready var notif_window = $NotifWindow
@onready var tab_container = $TabButtons
@onready var tab_buttons: Array[Node] = tab_container.get_children()
@onready var armor_list: ItemList = $OptionLists/EquipmentList/ArmorContainer/ArmorList
@onready var p_wep_list: ItemList = $OptionLists/EquipmentList/PWepContainer/PWepList
@onready var s_wep_list: ItemList = $OptionLists/EquipmentList/SWepContainer/SWepList
@onready var pd_window = $PurposefulDesignWindow

var option_tab_array: Array[Control]
var option_tab_index: int
var active_option_tab: Control
var sheet_scene: PackedScene = preload("res://Scenes/CharacterDisplay/character_sheet.tscn")
var domain: PackedScene = load("res://Scenes/Cards/domain_card_base.tscn")
var purposeful_design_chosen: int = -1

func _ready() -> void:
	option_tab_index = 0
	confirm_button.disabled = true
	back_button.disabled = true
	back_button.visible = false
	complete_button.disabled = true
	complete_button.visible = false
	_load_option_tabs()
	_set_active_option_tab(0)
	for button in tab_buttons:
		button.pressed.connect(_on_tab_button_pressed.bind(button))

	pd_window.hide()
	pd_window.closing.connect(_on_pd_window_closing)

func _process(_delta: float) -> void:
	_handle_back_button_visibility()
	
	if active_option_tab is ItemList && active_option_tab.is_anything_selected():
		confirm_button.disabled = false
	elif active_option_tab.name == "DomainCardSelContainer":
		if active_option_tab.select_card_list.item_count == 2:
			confirm_button.disabled = false
		else:
			confirm_button.disabled = true
	elif active_option_tab.name == "TraitAssignmentContainer":
		if active_option_tab.get_child(1).is_all_items_complete():
			confirm_button.disabled = false
	elif active_option_tab.name == "EquipmentList":
		if active_option_tab.is_equipment_valid():
			confirm_button.disabled = false
		else:
			confirm_button.disabled = true
	elif active_option_tab.name == "ExperiencesContainer" and active_option_tab.is_all_textboxes_filled():
			confirm_button.disabled = false
	elif active_option_tab.name == "NamePronounContainer" and active_option_tab.is_all_textboxes_filled():
			complete_button.disabled = false
			

func _set_active_option_tab(_index: int):
	'''
		Sets active item list by hiding or showing visibility of given item lists
	'''
	if active_option_tab and active_option_tab.name == "DomainCardSelContainer":
		active_option_tab.clear_screen()
		

	if option_tab_array[_index]:
		active_option_tab = option_tab_array[_index]
		active_option_tab.visible = true

	for option_tab in option_tab_array:
		if option_tab != active_option_tab:
			option_tab.visible = false
	
	if active_option_tab.name == "NamePronounContainer":
		confirm_button.visible = false
		complete_button.disabled = true
		complete_button.visible = true
	elif active_option_tab.name == "DomainCardSelContainer":
		description_display.visible = false
		active_option_tab.fill_domain_card_list()
		active_option_tab.clear_selected_cards()
	else:
		confirm_button.visible = true
		complete_button.disabled = true
		complete_button.visible = false


func _load_option_tabs():
	'''
		Initializes item list by loading each child of
		OptionLists into an array
	'''
	for child in option_lists.get_children():
		option_tab_array.append(child)


func _handle_back_button_visibility():
	if option_tab_index > 0:
		back_button.disabled = false
		back_button.visible = true
	else:
		back_button.disabled = true
		back_button.visible = false


func _on_confirm_button_pressed() -> void:
	if !(needs_purposeful_design_window() && option_tab_index==6):
		option_tab_index += 1
		_set_active_option_tab(option_tab_index)
		confirm_button.disabled = true
		description_display.clear_message()

func _on_back_button_pressed() -> void:
	option_tab_index -= 1
	_set_active_option_tab(option_tab_index)


func show_description(message: String) -> void:
	description_display.display_message(message)


func _on_complete_button_pressed() -> void:
	if !needs_purposeful_design_window():
		if (_is_character_data_valid() == true):
			add_domain_cards()
			var new_scene = sheet_scene.instantiate()
			character.set_maximum_health()
			character.set_maximum_stress()
			character.set_maximum_armor_slots()
			character.implement_ancestry_features()
			character.set_base_evasion()
			character.equip_armor(character.items[0])
			character.equip_primary(character.items[1])
			character.equip_secondary(character.items[2])
			character.reparent(new_scene)
			self.get_parent().add_child(new_scene)
			new_scene.enter()
			self.queue_free()
		#get_tree().change_scene_to_packed(sheet_scene)


func add_domain_cards():
	for index in range(card_selector.select_card_list.item_count):
		var card = card_selector.select_card_list.get_item_text(index)
		character.active_cards.append(card)


func _on_tab_button_pressed(tab: Button) -> void:
	if tab.name == "Class": 
		_set_active_option_tab(0)
		option_tab_index = 0
		character.subclass = null
	if tab.name == "Subclass": 
		_set_active_option_tab(1)
		option_tab_index = 1
	if tab.name == "Heritage": 
		_set_active_option_tab(2)
		option_tab_index = 2
	if tab.name == "Community": 
		_set_active_option_tab(3)
		option_tab_index = 3
	if tab.name == "DomainCards": 
		if character.character_class != null:
			_set_active_option_tab(4)
			option_tab_index = 4
	if tab.name == "Traits": 
		_set_active_option_tab(5)
		option_tab_index = 5
	if tab.name == "Experiences": 
		_set_active_option_tab(6)
		option_tab_index = 6
	if tab.name == "Equipment": 
		_set_active_option_tab(7)
		option_tab_index = 7
	if tab.name == "Name":
		_set_active_option_tab(8)
		option_tab_index = 8

func _is_character_data_valid() -> bool:
	if (character.character_class == null || character.subclass == null ||
		character.ancestry == null || character.community == null):
		_raise_error()
		return false
	else:
		return true
		

func _raise_error() -> void:
	notif_window.show()
	await(get_tree().create_timer(1.0).timeout)
	notif_window.hide()

func needs_purposeful_design_window() -> bool:
	# pd window can only show up when confirming experiences
	# or when confirming entire character creation process
	if (option_tab_index!=6 && option_tab_index!=8):
		return false
	
	# pd will only show up if needed for Clank feature
	if (character.ancestry && character.ancestry.ancestry_name=="Clank"):
		if (purposeful_design_chosen!=1 && purposeful_design_chosen!=2):
			var pd_window = $PurposefulDesignWindow
			pd_window.showWindow()
			return true
	
	return false

func _on_pd_window_closing(exp_num: int):
	purposeful_design_chosen = exp_num
	if purposeful_design_chosen==1:
		#TODO: set +1 to chosen experience
		pass
	elif purposeful_design_chosen==2:
		#TODO: set +1 to chosen experience
		pass
