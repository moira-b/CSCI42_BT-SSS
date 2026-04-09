extends PanelContainer

signal button_pressed(option: String, pk)

@onready var open_button = $ButtonsContainer/OpenButton
@onready var label_button = $ButtonsContainer/LabelButton
@onready var delete_button = $ButtonsContainer/DeleteButton

@onready var deletion_window = $DeletionWindow
@onready var del_confirm_button = $DeletionWindow/Buttons/ConfirmButton
@onready var del_cancel_button = $DeletionWindow/Buttons/CancelButton

var pk

func enable(pk, button_position):
	self.pk = pk
	open_button.pressed.connect(_on_open_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)
	
	set_panel_position(button_position)
	self.visible = true

func disable():
	hide()
	disconnect_signals()
	pk = null

func _on_open_button_pressed():
	button_pressed.emit("open", pk)
	print("pressed")
	disconnect_signals()
	self.visible = false
	
func _on_delete_button_pressed():
	del_confirm_button.pressed.connect(_on_confirm_deletion)
	del_cancel_button.pressed.connect(_on_cancel_deletion)
	deletion_window.show()
	self.hide()

func _on_confirm_deletion():
	button_pressed.emit("delete", pk)
	disconnect_signals()
	deletion_window.hide()
	
func _on_cancel_deletion():
	disconnect_signals()
	deletion_window.hide()

func disconnect_signals():
	open_button.pressed.disconnect(_on_open_button_pressed)
	delete_button.pressed.disconnect(_on_delete_button_pressed)
	del_confirm_button.pressed.disconnect(_on_confirm_deletion)
	del_cancel_button.pressed.disconnect(_on_cancel_deletion)

func set_panel_position(button_position):
	self.global_position = Vector2(
		button_position[0],
		button_position[1] + 60
	)
