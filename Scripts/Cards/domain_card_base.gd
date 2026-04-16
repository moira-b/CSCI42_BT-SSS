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
@onready var domain_color_box: ColorRect = $CardBG/DomainColor

const DomainColor = {
	DC_ARCANA = Color(0.492, 0.313, 0.559),
	DC_BLADE = Color(0.695, 0.234, 0.207),
	DC_BONE = Color(0.824, 0.863, 0.883),
	DC_CODEX = Color(0.184, 0.367, 0.586),
	DC_GRACE = Color(0.797, 0.313, 0.566),
	DC_MIDNIGHT = Color(0.270, 0.281, 0.289),
	DC_SAGE = Color(0.125, 0.480, 0.273),
	DC_SPLENDOR = Color(0.867, 0.746, 0.140),
	DC_VALOR = Color(0.844, 0.457, 0.148)
}

var colors_dict = {
	"Arcana":DomainColor.DC_ARCANA,
	"Blade":DomainColor.DC_BLADE,
	"Bone":DomainColor.DC_BONE,
	"Codex":DomainColor.DC_CODEX,
	"Grace":DomainColor.DC_GRACE,
	"Midnight":DomainColor.DC_MIDNIGHT,
	"Sage":DomainColor.DC_SAGE,
	"Splendor":DomainColor.DC_SPLENDOR,
	"Valor":DomainColor.DC_VALOR
}

func set_details() -> void:
	super.set_details()
	level = selected_card.get("level")
	type = selected_card.get("type")
	domain = selected_card.get("domain")
	_set_color(domain)
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


func _set_color(domain: String):
	var color_to = colors_dict.get(domain)
	domain_color_box.color = color_to

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
