extends Control

var character: Character
var sheet_scene: PackedScene = load("res://Scenes/CharacterDisplay/character_sheet.tscn")

func enter():
	character= $Character
	display_cards()
	
func _ready():
	enter()
	
func display_cards():
	print("active")
	for card in character.get_child(0).get_children() :
		print(card.card_name)
		
	print("vaulted")
	for card in character.get_child(1).get_children() :
		print(card.card_name)


func _on_sheet_button_pressed() -> void:
	var new_scene = sheet_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()
