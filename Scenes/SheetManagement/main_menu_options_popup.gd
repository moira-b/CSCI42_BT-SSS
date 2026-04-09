extends PanelContainer

signal button_pressed(option: String, pk)

@onready var open_button = $ButtonsContainer/OpenButton
@onready var label_button = $ButtonsContainer/LabelButton
@onready var delete_button = $ButtonsContainer/DeleteButton

var pk

func enable(pk):
	self.pk = pk
	open_button.pressed.connect(_on_open_button_pressed)
	label_button.pressed.connect(_on_label_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)
	
	# TODO: set position
	self.visible = true

func _on_open_button_pressed():
	button_pressed.emit("open", pk)
	print("pressed")
	disconnect_signals()
	
func _on_label_button_pressed():
	print("pressed")
	button_pressed.emit("label", pk)
	
func _on_delete_button_pressed():
	print("pressed")
	button_pressed.emit("delete", pk)

func disconnect_signals():
	open_button.pressed.disconnect(_on_open_button_pressed)
	label_button.pressed.disconnect(_on_label_button_pressed)
	delete_button.pressed.disconnect(_on_delete_button_pressed)
