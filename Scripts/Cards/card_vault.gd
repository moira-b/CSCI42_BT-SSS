extends Control

var character: Character
var sheet_scene: PackedScene = load("res://Scenes/CharacterDisplay/character_sheet.tscn")
@onready var vault = $Vault
@onready var displayed_card = $DisplayedCard
@onready var active_cards = $ActiveCards

func enter():
	character= $Character
	display_cards()
	
func display_cards():
	print("active")
	for card in character.get_child(0).get_children() :
		active_cards.get_child(card.get_index()).get_child(0).visible=true
		active_cards.get_child(card.get_index()).get_child(0).change_card(card.card_name)
		print(card.card_name)
		
	print("vaulted")
	for card in character.get_child(1).get_children():
		vault.add_item(card.card_name)
		print(card.card_name)


func _on_sheet_button_pressed() -> void:
	var new_scene = sheet_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()


func _on_vault_item_selected(index: int) -> void:
	displayed_card.get_child(0).visible=true
	displayed_card.get_child(0).change_card(character.get_child(1).get_child(index).card_name)
	
