extends PanelContainer

@onready var select_button: Button = $Button
@onready var char_name: Label = $ContentContainer/VBoxContainer/Name
@onready var char_class: Label = $ContentContainer/VBoxContainer/Class
@onready var tags: Array = []
@onready var settings_button: Button = $ContentContainer/SettingsButton

# Called when the node enters the scene tree for the first time.
func _ready():
	update_all_fields()

func update_all_fields():
	pass

func connect_signals():
	select_button.pressed.connect(_on_select_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)

func set_character_details(char_dict: Variant):
	char_name = char_dict["Character_Name"]
	
func _on_select_button_pressed():
	pass

func _on_settings_button_pressed():
	pass
