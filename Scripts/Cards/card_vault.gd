extends Control

var character: Character
var sheet_scene: PackedScene = load("res://Scenes/CharacterDisplay/character_sheet.tscn")
@onready var vault = $Vault
@onready var displayed_card = $DisplayedCard
@onready var active_cards = $ActiveCards
@onready var swap_button = $SwapButton

var card_selected: bool = false
var selected: DomainCard
var selected_active_index : int
var selected_vaulted_index : int
func enter():
	character= $Character
	display_cards()

func _process(_delta):
	if(card_selected and displayed_card.get_child(0).visible):
		swap_button.disabled=false
	else:
		swap_button.disabled=true

func display_cards():
	print("active")
	for card in character.get_child(0).get_children() :
		active_cards.get_child(card.get_index()).visible=true
		active_cards.get_child(card.get_index()).change_card(card.card_name)
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
	selected_vaulted_index = index


func _on_domain_card_selected(card: DomainCard) -> void:
	card_selected = true
	selected = card
	selected_active_index = selected.get_index()

func _on_swap_button_pressed() -> void:
	swap()
	
func swap():
	character.mark_stress($DisplayedCard/DomainCard.recall_cost)
	var selected_active_name = selected.card_name
	var selected_vaulted_name = $DisplayedCard/DomainCard.card_name
	$DisplayedCard/DomainCard.change_card(selected_active_name)
	character.get_child(1).get_child(selected_vaulted_index).change_card(selected_active_name)
	
	active_cards.get_child(selected_active_index).change_card(selected_vaulted_name)
	character.get_child(0).get_child(selected_active_index).change_card(selected_vaulted_name)
	
	vault.set_item_text(selected_vaulted_index, selected_active_name)
