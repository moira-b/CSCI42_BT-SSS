extends Control

var character: Character
var sheet_scene: PackedScene = load("res://Scenes/CharacterDisplay/character_sheet.tscn")
@onready var vault = $Vault
@onready var displayed_card = $DisplayedCard
@onready var active_card_container = $ActiveCardContainer
@onready var swap_button = $SwapButton
@onready var stress = $VBoxContainer/StressValue
@onready var health = $VBoxContainer/HealthValue

var card_selected: bool = false
var selected: DomainCard
var selected_active_index : int
var selected_vaulted_index : int


func enter():
	character= $Character
	vault = $Vault
	displayed_card = $DisplayedCard
	active_card_container = $ActiveCardContainer
	swap_button = $SwapButton
	stress = $VBoxContainer/StressValue
	health = $VBoxContainer/HealthValue
	display_cards()
	stress.text = (str(character.current_stress) + "/" + str(character.max_stress))
	health.text = (str(character.current_hp) + "/" + str(character.max_hp))
	_enable_highlighting()

func _process(_delta):
	if(card_selected and displayed_card.get_child(0).visible):
		swap_button.disabled=false
	else:
		swap_button.disabled=true

func display_cards():
	print("active")
	var i:int=0
	for card in character.active_cards:
		active_card_container.get_child(i).visible=true
		active_card_container.get_child(i).domain_card.change_card(card)
		print(card)
		i+=1
		
	print("vaulted")
	for card in character.vaulted_cards:
		vault.add_item(card)
		print(card)


func _on_sheet_button_pressed() -> void:
	var new_scene = sheet_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()


func _on_vault_item_selected(index: int) -> void:
	displayed_card.get_child(0).visible=true
	displayed_card.get_child(0).change_card(character.vaulted_cards[index])
	selected_vaulted_index = index


func _enable_highlighting() -> void:
	for card_container in active_card_container.get_children():
		var active_card = card_container.domain_card
		active_card.can_highlight = true
		active_card.mouse_default_cursor_shape = 2


func _on_domain_card_selected(card: DomainCard) -> void:
	card_selected = true
	selected = card
	selected_active_index = selected.get_index()
	_handle_selected_highlight()

func _on_swap_button_pressed() -> void:
	selected.toggle_highlight(false)
	swap()
	
func swap():
	selected.is_selected = false
	character.mark_stress($DisplayedCard/DomainCard.recall_cost)
	var selected_active_name = selected.card_name
	var selected_vaulted_name = $DisplayedCard/DomainCard.card_name
	$DisplayedCard/DomainCard.change_card(selected_active_name)
	character.vaulted_cards[selected_vaulted_index]=selected_active_name
	
	active_card_container.domain_card.get_child(selected_active_index).change_card(selected_vaulted_name)
	character.active_cards[selected_active_index] = selected_vaulted_name
	
	vault.set_item_text(selected_vaulted_index, selected_active_name)
	stress.text = (str(character.current_stress) + "/" + str(character.max_stress))
	health.text = (str(character.current_hp) + "/" + str(character.max_hp)) 
	
	_handle_selected_highlight()
 
func _handle_selected_highlight() -> void:
	selected.toggle_highlight(true)
	for container in active_card_container.get_children():
		var card = container.domain_card
		if card != selected:
			card.toggle_highlight(false)
