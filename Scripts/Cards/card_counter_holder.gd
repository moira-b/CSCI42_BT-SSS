extends Control

@onready var domain_card = $VBoxContainer/DomainCard
@onready var counter: SpinBox = $VBoxContainer/CounterPanel/HBoxContainer/Counters/SpinBox
var character: Character
var array_index: int

func initialize(c: Character)->void:
	counter.value_changed.connect(_on_value_changed)
	self.character = c
	self.array_index = domain_card.array_index
	counter.value = character.active_domain_card_counters[array_index]

func _on_value_changed(value: float):
	character.active_domain_card_counters[array_index] = value
