extends Control

@onready var domain_card_list: ItemList = $ToSelectContainer/DomainCardList
@onready var select_card_list: ItemList = $"CardInfo/SelectedCardsList"
@onready var domain_card_display: DomainCard = $"CardInfo/SelectionDisplay/DomainCard"
@onready var select_button: Button = $CardInfo/SelectionDisplay/SelectButton

var character: Character

var domain_association_file = "res://Resources/Cards/domain_card_association.json"
var association_as_text: String
var association_as_dict: Dictionary

var domain_cards_file = "res://Resources/Cards/domain_cards.json"
var cards_as_text: String
var cards_as_dict: Dictionary

var display_domain_card_array = []
var current_selected_index: int = -1

func _ready() -> void:
	domain_card_display.visible = false
	
	
	domain_card_list.item_selected.connect(_on_option_selected)
	select_card_list.item_selected.connect(_on_selected_option_selected)
	select_button.pressed.connect(_on_card_select)
	select_card_list.item_activated.connect(_on_card_remove)
	
	character = get_tree().current_scene.get_node("Character")
	
	_load_json_files()

func _load_json_files() -> void:
	association_as_text = FileAccess.get_file_as_string(domain_association_file)
	association_as_dict = JSON.parse_string(association_as_text)
	
	cards_as_text = FileAccess.get_file_as_string(domain_cards_file)
	cards_as_dict = JSON.parse_string(cards_as_text)

func fill_domain_card_list() -> void:
	for domain in character.character_class.domains:
		var cards_in_domain = association_as_dict.get(domain.name)
		for card in cards_in_domain:
			var card_check = cards_as_dict.get(card)
			if card_check:
				if card_check.get("level") <= character.level and not (card in select_card_list):
					display_domain_card_array.append(card)
					domain_card_list.add_item(card)

func clear_screen() -> void:
	domain_card_list.clear()
	domain_card_display.visible = false
	current_selected_index = -1
	select_button.disabled = true

func clear_selected_cards() -> void:
	select_card_list.clear()

func _on_option_selected(index: int) -> void:
	domain_card_display.visible = true	
	domain_card_display.change_card(domain_card_list.get_item_text(index))
	current_selected_index = index
	if(select_card_list.item_count < 2):
		select_button.disabled = false

func _on_selected_option_selected(index: int) -> void:
	domain_card_display.visible = true	
	domain_card_display.change_card(select_card_list.get_item_text(index))

func _on_card_select() -> void:
	select_card_list.add_item(domain_card_list.get_item_text(current_selected_index))
	domain_card_list.remove_item(current_selected_index)
	current_selected_index = -1
	select_button.disabled = true

func _on_card_remove(index) -> void:
	var card = select_card_list.get_item_text(index)
	select_card_list.remove_item(index)
	clear_screen()
	fill_domain_card_list()
	domain_card_display.visible = true	
	domain_card_display.change_card(card)
