class_name Card
extends Control

@export var card_name: String
var description: String
var num_counters: int = 0

var domain_cards_file = "res://Resources/Cards/domain_cards.json"
var json_as_text: String
var json_as_dict: Dictionary

func _ready() -> void:
	if self is DomainCard:
		domain_cards_file = "res://Resources/Cards/domain_cards.json"
	
	json_as_text = FileAccess.get_file_as_string(domain_cards_file)
	json_as_dict = JSON.parse_string(json_as_text)
