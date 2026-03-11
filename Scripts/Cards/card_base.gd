class_name Card
extends Node

@export var card_name: String
var description: String
var num_counters: int = 0
var selected_card: Dictionary

var json_to_parse_file
var json_as_text: String
var json_as_dict: Dictionary

# Display details
@onready var name_label: Label = $Name
@onready var description_label: Label = $Description


func _ready() -> void:
	if self is DomainCard:
		json_to_parse_file = "res://Resources/Cards/domain_cards.json"
	
	json_as_text = FileAccess.get_file_as_string(json_to_parse_file)
	json_as_dict = JSON.parse_string(json_as_text)
	
	if json_as_dict:
		set_details()
		display_details()

func set_details() -> void:
	selected_card = json_as_dict.get(card_name)
	description = selected_card.get("description")

func display_details() -> void:
	name_label.text = card_name
	description_label.text = description
