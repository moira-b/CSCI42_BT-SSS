extends Control

@onready var domain_card_list: ItemList = $ToSelectContainer/DomainCardList
@onready var select_card_list: ItemList = $"CardInfo/SelectedCardsList"
@onready var domain_card_display: DomainCard = $"CardInfo/SelectionDisplay/DomainCard"
@onready var select_button: Button = $CardInfo/SelectionDisplay/Buttons/SelectButton
@onready var swap_button: Button = $CardInfo/SelectionDisplay/Buttons/SwapButton
@onready var confirm_button: Button = $CardInfo/SelectionDisplay/Buttons/Confirm

var character: Character
var existing_cards: Array[String] = []

var domain_association_file = "res://Resources/Cards/domain_card_association.json"
var association_as_text: String
var association_as_dict: Dictionary

var domain_cards_file = "res://Resources/Cards/domain_cards.json"
var cards_as_text: String
var cards_as_dict: Dictionary

var display_domain_card_array = []
var current_selected_index: int = -1
var current_existing_selected_index: int = -1

var swapped_card = ""

func _process(delta: float) -> void:
	if(character and select_card_list.item_count == character.max_domain_cards):
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true


func _ready() -> void:
	domain_card_display.visible = false
	
	domain_card_list.item_selected.connect(_on_option_selected)
	select_card_list.item_selected.connect(_on_selected_option_selected)
	select_button.pressed.connect(_on_card_select)
	select_card_list.item_activated.connect(_on_card_remove)
	confirm_button.pressed.connect(_on_confirm)
	swap_button.pressed.connect(_on_swap)
	
	_load_json_files()
	
	if get_parent().get_parent(): #Only really shows up in character creation
		character = get_tree().current_scene.get_node("Character")
	else:
		level_up_selector_setup()
	
	
func get_item_list_items(items: ItemList) -> Array[String]:
	var output: Array[String] = []
	for i in range(items.item_count):
		output.append(items.get_item_text(i))
	return output
	
	
func level_up_selector_setup() -> void:
	character = self.get_node("Character")
	swap_button.visible=true
	confirm_button.visible=true
	confirm_button.disabled=true
	clear_screen()
	_fill_select_card_list()
	fill_domain_card_list()


func fill_domain_card_list() -> void:
	for domain in character.character_class.domains:
		var cards_in_domain = association_as_dict.get(domain.name)
		for card in cards_in_domain:
			var card_check = cards_as_dict.get(card)
			if card_check:
				if card_check.get("level") <= character.level and not (card in get_item_list_items(select_card_list)):
					display_domain_card_array.append(card)
					domain_card_list.add_item(card)


func clear_screen() -> void:
	domain_card_list.clear()
	domain_card_display.visible = false
	current_selected_index = -1
	current_existing_selected_index = -1
	select_button.disabled = true
	


func clear_selected_cards() -> void:
	var to_clear = false
	var passable_cards = []
	for domain in character.character_class.domains:
		passable_cards.append_array(association_as_dict.get(domain.name))
	for card in get_item_list_items(select_card_list):
		if not card in passable_cards:
			to_clear = true
			break
			
	if(to_clear):
		select_card_list.clear()

func _fill_select_card_list() -> void:
	for active_card in character.active_cards:
		select_card_list.add_item(active_card)
		existing_cards.append(active_card)
	for vaulted_card in character.vaulted_cards:
		select_card_list.add_item(vaulted_card)
		existing_cards.append(vaulted_card)


func _load_json_files() -> void:
	association_as_text = FileAccess.get_file_as_string(domain_association_file)
	association_as_dict = JSON.parse_string(association_as_text)
	
	cards_as_text = FileAccess.get_file_as_string(domain_cards_file)
	cards_as_dict = JSON.parse_string(cards_as_text)


func _on_option_selected(index: int) -> void:
	domain_card_display.visible = true	
	domain_card_display.change_card(domain_card_list.get_item_text(index))
	current_selected_index = index
	if(select_card_list.item_count < character.max_domain_cards):
		select_button.disabled = false


func _on_selected_option_selected(index: int) -> void:
	domain_card_display.visible = true	
	domain_card_display.change_card(select_card_list.get_item_text(index))
	select_button.disabled = true
	current_existing_selected_index = index


func _on_card_select() -> void:
	select_card_list.add_item(domain_card_list.get_item_text(current_selected_index))
	domain_card_list.remove_item(current_selected_index)
	current_selected_index = -1
	select_button.disabled = true


func _on_card_remove(index) -> void:
	var card = select_card_list.get_item_text(index)
	if(index >= existing_cards.size()):	
		select_card_list.remove_item(index)
		clear_screen()
		fill_domain_card_list()
		domain_card_display.visible = true	
		domain_card_display.change_card(card)
		
func _on_confirm() -> void:
	for card in get_item_list_items(select_card_list):
		if not card in existing_cards:
			if(character.active_cards.size() < 5):
				character.active_cards.append(card)
			else:
				character.vaulted_cards.append(card)
	
	var new_scene = load("res://Scenes/CharacterDisplay/character_sheet.tscn").instantiate()
	character.reparent(new_scene)
	get_tree().root.add_child(new_scene)
	new_scene.enter()
	self.queue_free()
	

func _on_swap()->void:
	if (swapped_card == ""):
		swapped_card = domain_card_list.get_item_text(current_selected_index)
		domain_card_list.set_item_text(current_selected_index, select_card_list.get_item_text(current_existing_selected_index))
		select_card_list.set_item_text(current_existing_selected_index, swapped_card)
		swapped_card = domain_card_list.get_item_text(current_selected_index)
	elif (swapped_card == domain_card_list.get_item_text(current_selected_index)):
		swapped_card = domain_card_list.get_item_text(current_selected_index)
		domain_card_list.set_item_text(current_selected_index, select_card_list.get_item_text(current_existing_selected_index))
		select_card_list.set_item_text(current_existing_selected_index, swapped_card)
		swapped_card = ""
	
	swap_button.disabled = true
