extends HBoxContainer

@export var checkable_max_dimensions: Vector2 = Vector2(30, 30)
@export var num_columns: int
@export var amount_total: int = 12

@onready var checkables_vbox = $CheckablesVBox

var amount_pressed: int = 0
var checked_texture: Texture2D
var unchecked_texture: Texture2D
var checkables_array: Array

func _ready() -> void:
	checked_texture = load("res://Assets/GUI_Icons/Stats/health_marked.png")
	unchecked_texture = load("res://Assets/GUI_Icons/Stats/health_unmarked.png")	
	_setup_checkables()
	_connect_signals()
	
func increment_pressed(increment_by: int=1):
	var old_amount = amount_pressed
	amount_pressed = clamp(amount_pressed+increment_by, 0, amount_total)
	print(amount_pressed)
	
	for i in range(amount_pressed-old_amount):
		checkables_array[old_amount+i].set_pressed_no_signal(true)
	
func decrement_pressed(decrement_by: int=1):
	var old_amount = amount_pressed
	amount_pressed = clamp(amount_pressed-decrement_by, 0, amount_total)
	print(amount_pressed)

	while old_amount > amount_pressed:
		checkables_array[old_amount-1].set_pressed_no_signal(false)
		old_amount -= 1

func set_total(new: int):
	amount_total = new
	
func set_amount_pressed(new: int):
	amount_pressed = clamp(new, 0, amount_total)

func update_display():
	for i in range(amount_total):
		if i < amount_pressed:
			checkables_array[i].set_pressed_no_signal(true)
		else:
			checkables_array[i].set_pressed_no_signal(false)

func _on_checkable_pressed(was_clicked: TextureButton):
	var index: int = checkables_array.find(was_clicked)
	
	# if button is now checked (i.e. originally unchecked)
	if (was_clicked.is_pressed()==true):
		for i in range(index):
			checkables_array[i].set_pressed_no_signal(true)
	
	# elif button is now unchecked (i.e. originally checked)
	else:
		checkables_array[index].set_pressed_no_signal(true)
		for i in range((amount_total-index)-1):
			checkables_array[(amount_total-1)-i].set_pressed_no_signal(false	)
	amount_pressed = index+1
	print(amount_pressed)

func _setup_checkables():
	var num_rows = (int(amount_total/num_columns))+1
	for i in range(num_rows):
		checkables_vbox.add_child(HBoxContainer.new())
		print(i)
	
	var hboxes_array = checkables_vbox.get_children()
	var checkables_instantiated: int = 0
	
	while (checkables_instantiated < amount_total):
		var new_checkable = TextureButton.new()
		checkables_array.append(new_checkable)
		new_checkable.set_texture_normal(unchecked_texture)
		new_checkable.set_texture_pressed(checked_texture)
		new_checkable.set_ignore_texture_size(true)
		new_checkable.set_stretch_mode(TextureButton.STRETCH_SCALE)
		new_checkable.set_custom_minimum_size(checkable_max_dimensions)	
		new_checkable.set_toggle_mode(true)
		new_checkable.pressed.connect(_on_checkable_pressed.bind(new_checkable))
		
		var hbox_index = int(checkables_instantiated/num_columns)
		hboxes_array[hbox_index].add_child(new_checkable)
		checkables_instantiated += 1

func _connect_signals() -> void:
	var decrement_button = $DecrementButton
	decrement_button.pressed.connect(decrement_pressed)
	var increment_button = $IncrementButton
	increment_button.pressed.connect(increment_pressed)
