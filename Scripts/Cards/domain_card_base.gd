class_name DomainCard
extends Card

signal selected(card: DomainCard)

var level: int
var type: String
var domain: String
var recall_cost: int

# Display details
@onready var level_label: Label = $Level
@onready var domain_label: Label = $Domain
@onready var recall_cost_label: Label = $RecallCost
@onready var type_label: Label = $Type

func set_details() -> void:
	super.set_details()
	level = selected_card.get("level")
	type = selected_card.get("type")
	domain = selected_card.get("domain")
	recall_cost = selected_card.get("recall_cost")

func display_details() -> void:
	super.display_details()
	level_label.text = str(level)
	domain_label.text = domain
	recall_cost_label.text = str(recall_cost)
	type_label.text = type
	
func change_card(name: String):
	card_name = name
	set_details()
	display_details()
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			selected.emit(self)
			print("Card Clicked")
