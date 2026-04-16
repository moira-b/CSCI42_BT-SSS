class_name DomainCard
extends Card

signal selected(card: DomainCard)

var level: int
var type: String
var domain: String
var recall_cost: int
var is_selected: bool
var array_index: int
@export var can_highlight: bool = false

# Display details
@onready var level_label: Label = $Level
@onready var domain_label: Label = $Domain
@onready var recall_cost_label: Label = $RecallCost
@onready var type_label: Label = $Type
@onready var highlight_panel: Panel = $HighlightPanel


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


func toggle_highlight(option: bool):
	is_selected = option
	highlight_panel.visible = option


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			selected.emit(self)
			print("Card Clicked")


func _on_mouse_entered() -> void:
	if can_highlight:
		highlight_panel.visible = true


func _on_mouse_exited() -> void:
	if !is_selected:
		highlight_panel.visible = false
