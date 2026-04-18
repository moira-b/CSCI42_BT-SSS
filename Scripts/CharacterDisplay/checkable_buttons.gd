extends HBoxContainer

const MAX_DIMENSIONS: Vector2 = Vector2(30, 30)

@export var num_columns: int = 6
@export var amount_pressed: int = 0
@export var amount_total: int = 12

@onready var checkables_vbox = $CheckablesVBox

var checked_texture: Texture2D
var unchecked_texture: Texture2D
var checkables_array: Array

func _ready() -> void:
	checked_texture = load("res://Assets/GUI_Icons/Stats/health_marked.png")
	unchecked_texture = load("res://Assets/GUI_Icons/Stats/health_unmarked.png")	
	_setup_checkables()
	_connect_signals()
	
func increment_pressed(increment_by: int=1):
	amount_pressed = clamp(amount_pressed+increment_by, 0, amount_total)
	print("increment!")
	
func decrement_pressed(decrement_by: int=1):
	amount_pressed = clamp(amount_pressed-decrement_by, 0, amount_total)
	print("decrement!")

func set_total(new: int):
	amount_total = new
	
func set_amount_pressed(new: int):
	amount_pressed = clamp(new, 0, amount_total)

func _on_checkable_pressed(was_clicked: TextureButton):
	var index: int = checkables_array.find(was_clicked)
	
	# if button is now checked (i.e. originally unchecked)
	if (was_clicked.is_pressed()==true):
		for i in range(index):
			checkables_array[i].set_pressed_no_signal(true)
	
	# elif button is now unchecked (i.e. originally checked)
	else:
		for i in range((amount_total-index)-1):
			checkables_array[(amount_total-1)-i].set_pressed_no_signal(false	)

func _setup_checkables():
	for i in range(int(amount_total/num_columns)):
		checkables_vbox.add_child(HBoxContainer.new())
	
	var hboxes_array = checkables_vbox.get_children()
	var checkables_instantiated: int = 0
	
	while (checkables_instantiated < amount_total):
		var new_checkable = TextureButton.new()
		checkables_array.append(new_checkable)
		new_checkable.set_texture_normal(unchecked_texture)
		new_checkable.set_texture_pressed(checked_texture)
		new_checkable.set_ignore_texture_size(true)
		new_checkable.set_stretch_mode(TextureButton.STRETCH_SCALE)
		new_checkable.set_custom_minimum_size(MAX_DIMENSIONS)	
		new_checkable.set_toggle_mode(true)
		new_checkable.pressed.connect(_on_checkable_pressed.bind(new_checkable))
		
		var hbox_index = int(checkables_instantiated/6)
		hboxes_array[hbox_index].add_child(new_checkable)
		checkables_instantiated += 1

func _connect_signals() -> void:
	var decrement_button = $DecrementButton
	decrement_button.pressed.connect(decrement_pressed)
	var increment_button = $IncrementButton
	increment_button.pressed.connect(increment_pressed)
