extends PanelContainer

signal stat_increment_pressed(stat_name: String)
signal stat_decrement_pressed(stat_name: String)

var count: int
const MAXIMUM: int = 99 # maximum rollable die
const MINIMUM: int = 0 # minimum rollable die
@export var num_sides: int = 0
@onready var value_label = $FieldContainer/Labels/FieldValue
@onready var increment_button = $FieldContainer/Buttons/IncrementButton
@onready var decrement_button = $FieldContainer/Buttons/DecrementButton

func _ready():
	increment_button.pressed.connect(_on_increment_button_pressed)
	decrement_button.pressed.connect(_on_decrement_button_pressed)
	value_label.text_submitted.connect(_on_value_edited)
	
func _on_increment_button_pressed() -> void:
	count = clamp(int(value_label.text)+1, MINIMUM, MAXIMUM)
	value_label.text = str(count)
	#print("DEBUG: Pressed increment button of the " + self.name + " die.")
	
func _on_decrement_button_pressed() -> void:
	count = clamp(int(value_label.text)-1, MINIMUM, MAXIMUM)
	value_label.text = str(count)
	#print("DEBUG: Pressed decrement button of the " + self.name + " die.")
	
func _on_value_edited(new: String) -> void:
	var current_value: int = int(value_label.text)
	if new.is_empty():
		count = 0
	elif new.is_valid_int():
		count = clamp(int(new), MINIMUM, MAXIMUM)
		value_label.text = str(count)
	else:
		value_label.text = str(count)
