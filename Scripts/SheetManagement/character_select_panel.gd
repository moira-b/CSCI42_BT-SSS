extends PanelContainer

const FILE_PATH = "user://character_data"

@onready var select_button: Button = $Button
@onready var char_primary_key: String
@onready var char_name: String
@onready var char_class: String
@onready var name_label: Label = $ContentContainer/VBoxContainer/Name
@onready var class_label: Label = $ContentContainer/VBoxContainer/Class
@onready var tags: Array = []
@onready var settings_button: Button = $ContentContainer/SettingsButton
@onready var char_dict: Variant
@onready var character: Character = $Character

var sheet_scene: PackedScene = preload("res://Scenes/CharacterDisplay/character_sheet.tscn")
var save_manager

# Called when the node enters the scene tree for the first time.
func enter(pk: String):
	save_manager = get_tree().root.get_child(0).get_child(0)
	set_primary_key(pk)
	load_character_details(pk)
	update_all_fields()
	connect_signals()

func load_character_details(pk: String):
	var save_file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	var current_contents = save_file.get_as_text()
	var json = JSON.new()
	
	# Check that the file contents can be parsed by JSON
	var parse_result = json.parse(current_contents)
	if !(parse_result==OK):
		print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return
		
	# Check that the file contents can be made into a dictionary
	var json_data = json.data
	char_dict = json_data[pk]
	char_name = char_dict["character_name"]
	char_class = load(char_dict["class"]).name

func set_primary_key(pk: String):
	char_primary_key = pk

func update_all_fields():
	name_label.set_text(char_name)
	class_label.set_text(char_class)

func connect_signals():
	select_button.pressed.connect(_on_select_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	
func _on_select_button_pressed():
	var new_scene = sheet_scene.instantiate()
	char_dict = save_manager._get_character_dictionary(char_primary_key)
	character.load_data(char_dict)
	character.reparent(new_scene)
	get_tree().root.add_child(new_scene)
	new_scene.enter()
	print("hi")
	get_tree().root.get_child(0).queue_free()

func _on_settings_button_pressed():
	pass
