extends PanelContainer

signal stat_increment_pressed(stat_name: String)
signal stat_decrement_pressed(stat_name: String)

@onready var value_label = $FieldContainer/Labels/FieldValue
@onready var increment_button = $FieldContainer/Buttons/IncrementButton
@onready var decrement_button = $FieldContainer/Buttons/DecrementButton

func _ready():
	increment_button.pressed.connect(_on_increment_button_pressed)
	decrement_button.pressed.connect(_on_decrement_button_pressed)

func set_current_value(new_value: String) -> void:
	self.value_label.text = new_value
	print("DEBUG: changed display of the " + self.name + " stat's current value.")
	
func set_maximum_value(new_value: String) -> void:
	self.value_label.text = new_value
	print("DEBUG: changed display of the " + self.name + " stat's maximum value.")
	
func _on_increment_button_pressed() -> void:
	stat_increment_pressed.emit(self.name)
	print("DEBUG: Pressed increment button of the " + self.name + " stat.")
	
func _on_decrement_button_pressed() -> void:
	stat_decrement_pressed.emit(self.name)
	print("DEBUG: Pressed decrement button of the " + self.name + " stat.")
