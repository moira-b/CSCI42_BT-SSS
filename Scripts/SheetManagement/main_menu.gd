class_name MainMenu
extends Control

@onready var create_new_character_button : Button = $Header/Button
@onready var create_new_character_confirm: Button = $CreateCharacterConfirm/VBoxContainer/ConfirmButton
@onready var create_new_character_cancel: Button = $CreateCharacterConfirm/VBoxContainer/CancelButton
@onready var confirm_window: PanelContainer = $CreateCharacterConfirm
@onready var char_creation_scene: PackedScene = preload("res://Scenes/CharacterCreator/character_creator_interface.tscn")
@onready var test_button: Button = $Button
@onready var save_manager = $SaveManager

# Called when the node enters the scene tree for the first time.
func _ready():
	enter()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enter():
	confirm_window.visible = false
	connect_signals()


func connect_signals():
	create_new_character_button.pressed.connect(_on_createcharacter_button_pressed)
	test_button.pressed.connect(_on_test_button_pressed)

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
