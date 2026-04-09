class_name MainMenu
extends Control

@onready var create_new_character_button : Button = $Header/Button
@onready var create_new_character_confirm: Button = $CreateCharacterConfirm/VBoxContainer/ConfirmButton
@onready var create_new_character_cancel: Button = $CreateCharacterConfirm/VBoxContainer/CancelButton
@onready var confirm_window: PanelContainer = $CreateCharacterConfirm
@onready var char_creation_scene: PackedScene = preload("res://Scenes/CharacterCreator/character_creator_interface.tscn")
@onready var test_button: Button = $Button
@onready var save_manager = $SaveManager
@onready var grid_container = $ScrollContainer/GridContainer
@onready var options_popup = $OptionsPopupMenu

var panel_scene: PackedScene = preload("res://Scenes/SheetManagement/character_select_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	enter()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enter():
	confirm_window.visible = false
	connect_signals()
	create_character_panels()

func connect_signals():
	create_new_character_button.pressed.connect(_on_createcharacter_button_pressed)
	test_button.pressed.connect(_on_test_button_pressed)
	options_popup.button_pressed.connect(_on_popup_option_selected)

func create_character_panels():
	if(save_manager.save_file_exists()):
		var data = save_manager._get_character_data()
		for key in data:
			if(key != "pk_count"):
				var new_scene = panel_scene.instantiate()
				grid_container.add_child(new_scene)
				new_scene.enter(key)
				new_scene.settings_button_pressed.connect(_on_settings_button_pressed)

func _on_createcharacter_button_pressed() -> void:
	create_new_character_confirm.pressed.connect(_on_creatercharacter_confirm_pressed)
	create_new_character_cancel.pressed.connect(_on_creatercharacter_cancel_pressed)
	confirm_window.visible = true

func _on_creatercharacter_confirm_pressed() -> void:
	var new_scene = char_creation_scene.instantiate()
	self.get_parent().add_child(new_scene)
	self.queue_free()

func _on_creatercharacter_cancel_pressed() -> void:
	create_new_character_confirm.pressed.disconnect(_on_creatercharacter_confirm_pressed)
	create_new_character_cancel.pressed.disconnect(_on_creatercharacter_cancel_pressed)
	confirm_window.visible = false

func _on_test_button_pressed() -> void:
	pass
	#do smth

func _on_settings_button_pressed(pk) -> void:
	print("bananas! the pk of pressed is " + pk)
	options_popup.enable(pk)

func _on_popup_option_selected(option: String, pk):
	if (option=="open"):
		print("want to open pk " + pk)
	elif (option=="label"):
		print("want to label pk " + pk)
	elif (option=="delete"):
		save_manager.delete_character_with_pk(pk)
		remove_character_panel(pk)

func remove_character_panel(pk):
	for panel in grid_container.get_children():
		if (panel.char_primary_key==pk):
			panel.queue_free()
