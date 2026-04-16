extends Window

@onready var confirm_button = $ButtonsContainer/ConfirmButton
@onready var cancel_button = $ButtonsContainer/CancelButton

func showWindow(character: Character):
	connect_signals()
	
	var current_equipment: Array[String] = character.items
	self.show()

func _on_confirm_button_pressed():
	pass
	
func _on_cancel_button_pressed():
	disconnect_signals()
	self.hide()

func connect_signals():
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	
func disconnect_signals():
	confirm_button.pressed.disconnect(_on_confirm_button_pressed)
	cancel_button.pressed.disconnect(_on_cancel_button_pressed)
