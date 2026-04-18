extends HBoxContainer

signal currently_checked_updated(currently_checked)

@export var checkable_max_dimensions: Vector2 = Vector2(30, 30)
@export var num_columns: int
@export var amount_total: int = 12
@onready var checkables_vbox = $CheckablesVBox

var currently_checked: int = 0
var checked_texture: Texture2D = load("res://Assets/GUI_Icons/Stats/hope_marked.png")
var unchecked_texture: Texture2D = load("res://Assets/GUI_Icons/Stats/hope_unmarked.png")
var checkables_array: Array

func _ready() -> void:
	_setup_checkables()
	_connect_signals()

func set_type(which_texture: String) -> void:
	if (which_texture=="health"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/health_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/health_unmarked.png")
	elif (which_texture=="stress"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/stress_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/stress_unmarked.png")
	elif (which_texture=="hope"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/hope_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/hope_unmarked.png")
	else:
		print("Error in checkable_buttons.gd. Attempting to set type to unsupported type " + which_texture + ".")
	
func increment_pressed(increment_by: int=1):
	var old_amount = currently_checked
	currently_checked = clamp(currently_checked+increment_by, 0, amount_total)
	
	for i in range(currently_checked-old_amount):
		checkables_array[old_amount+i].set_pressed_no_signal(true)
	
func decrement_pressed(decrement_by: int=1):
	var old_amount = currently_checked
	currently_checked = clamp(currently_checked-decrement_by, 0, amount_total)

	while old_amount > currently_checked:
		checkables_array[old_amount-1].set_pressed_no_signal(false)
		old_amount -= 1

func set_total(new: int):
	amount_total = clamp(new, 0, 100)
	update_display()
	
func set_currently_checked(new: int):
	currently_checked = clamp(new, 0, amount_total)
	update_display()

func update_display():
	for i in range(amount_total):
		if i < currently_checked:
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
	currently_checked = index+1

func _setup_checkables():
	var num_rows = (int(amount_total/num_columns))+1
	for i in range(num_rows):
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
