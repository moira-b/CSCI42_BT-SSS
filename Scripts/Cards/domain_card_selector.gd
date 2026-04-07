extends Control

@onready var domain_card_list: ItemList = $ToSelectContainer/DomainCardList
@onready var select_card_list: ItemList = $"Card Info/SelectedCardsList"
@onready var domain_card_display: DomainCard = $"CardInfo/SelectionDisplay/DomainCard"
@onready var select_button: Button = $CardInfo/SelectionDisplay/SelectButton
@onready var character: Character = $"../../Character"

var domain_association_file = "res://Resources/Cards/domain_card_association.json"
var association_as_text: String
var association_as_dict: Dictionary

var domain_cards_file = "res://Resources/Cards/domain_cards.json"
var cards_as_text: String
var cards_as_dict: Dictionary

var display_domain_card_array = []

func _ready() -> void:
	domain_card_display.visible = false
	
	_load_json_files()

func _load_json_files() -> void:
	association_as_text = FileAccess.get_file_as_string(domain_association_file)
	association_as_dict = JSON.parse_string(association_as_text)
	
	cards_as_text = FileAccess.get_file_as_string(domain_cards_file)
	cards_as_dict = JSON.parse_string(cards_as_text)

func fill_domain_card_list() -> void:
	for domain in character.character_class.domains:
		# It's gonna be O(n^2) but idk if there's a better way to do it
		var cards_in_domain = association_as_dict.get(domain.name)
		for card in cards_in_domain:
			var card_check = cards_as_dict.get(card)
			if card_check:
				if card_check.get("level") == 1:
					display_domain_card_array.append(card)
			else:
				display_domain_card_array.append("Card not yet encoded")
		pass
