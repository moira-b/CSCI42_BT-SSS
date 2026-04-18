extends HBoxContainer

signal amount_toggled_updated(new_amount_toggled)

@export var checkable_max_dimensions: Vector2 = Vector2(30, 30)
@export var num_columns: int = 6
@export var maximum_toggled: int
@onready var checkables_vbox = $CheckablesVBox

var amount_toggled: int = 0
var checked_texture: Texture2D = load("res://Assets/GUI_Icons/Stats/hope_marked.png")
var unchecked_texture: Texture2D = load("res://Assets/GUI_Icons/Stats/hope_unmarked.png")
var checkables_array: Array

func initialize(attribute: String, maximum_toggled: int) -> void:
	self.maximum_toggled = maximum_toggled
	
	var attribute_label = $AttributeLabel
	attribute_label.text = attribute + ": "
	
	set_type(attribute)
	_setup_checkables()
	_connect_signals()
	
	print("max toggled: " + str(maximum_toggled))

func set_type(which_texture: String) -> void:
	if (which_texture=="Health"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/health_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/health_unmarked.png")
	elif (which_texture=="Stress"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/stress_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/stress_unmarked.png")
	elif (which_texture=="Hope"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/hope_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/hope_unmarked.png")
	elif (which_texture=="Armor"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/armor_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/armor_unmarked.png")
	elif (which_texture=="Proficiency"):
		checked_texture = load("res://Assets/GUI_Icons/Stats/proficiency_marked.png")
		unchecked_texture = load("res://Assets/GUI_Icons/Stats/proficiency_unmarked.png")
	else:
		print("Error in checkable_buttons.gd. Attempting to set type to unsupported type " + which_texture + ".")
	
func increment_pressed(increment_by: int=1):
	var old_amount = amount_toggled
	amount_toggled = clamp(amount_toggled+increment_by, 0, maximum_toggled)
	
	if old_amount != amount_toggled:
		amount_toggled_updated.emit(amount_toggled)
	
	for i in range(amount_toggled-old_amount):
		checkables_array[old_amount+i].set_pressed_no_signal(true)
	
func decrement_pressed(decrement_by: int=1):
	var old_amount = amount_toggled
	amount_toggled = clamp(amount_toggled-decrement_by, 0, maximum_toggled)

	if old_amount != amount_toggled:
		amount_toggled_updated.emit(amount_toggled)

	while old_amount > amount_toggled:
		checkables_array[old_amount-1].set_pressed_no_signal(false)
		old_amount -= 1

func set_maximum_toggled(new: int):
	var old_max = maximum_toggled
	maximum_toggled = clamp(new, 0, 100)
	
	if old_max < maximum_toggled:
		while old_max < maximum_toggled:
			var hboxes_array = checkables_vbox.get_children()
			var current_num_rows = len(hboxes_array)
			
			# check if you need to make a new row
			if(maximum_toggled > (current_num_rows * num_columns)):
				checkables_vbox.add_child(HBoxContainer.new())
			
			# add a new checkable to the last row
			var new_checkable = _create_new_checkable()
			checkables_array.append(new_checkable)
			hboxes_array[current_num_rows-1].add_child(new_checkable)
			old_max += 1
	elif old_max==maximum_toggled:
		print("DEBUG: No change in maximum_toggled.")
	else:
		print("DEBUG: There should NOT be a scenario in which an attribut's max threshold decreases. (checkable_buttons.gd)")
	
	update_display()
	
func set_amount_toggled(new: int):
	amount_toggled = clamp(new, 0, maximum_toggled)
	update_display()

func update_display():
	for i in range(maximum_toggled):
		if i < amount_toggled:
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
		for i in range((maximum_toggled-index)-1):
			checkables_array[(maximum_toggled-1)-i].set_pressed_no_signal(false	)
	amount_toggled = index+1
	amount_toggled_updated.emit(amount_toggled)

func _setup_checkables():
	print("DEBUG: reached _setup_checkables")
	
	var num_rows = (int(maximum_toggled/num_columns))+1
	for i in range(num_rows):
		checkables_vbox.add_child(HBoxContainer.new())
	
	var hboxes_array = checkables_vbox.get_children()
	var checkables_instantiated: int = 0
	
	while (checkables_instantiated < maximum_toggled):
		var new_checkable = _create_new_checkable()
		
		checkables_array.append(new_checkable)
		var hbox_index = int(checkables_instantiated/num_columns)
		hboxes_array[hbox_index].add_child(new_checkable)
		checkables_instantiated += 1

	print("size of hboxes array: " + str(len(hboxes_array)))
	print("size of checkables_array: " + str(len(checkables_array)))	

func _create_new_checkable() -> TextureButton:
	var new_checkable = TextureButton.new()
	new_checkable.set_texture_normal(unchecked_texture)
	new_checkable.set_texture_pressed(checked_texture)
	new_checkable.set_ignore_texture_size(true)
	new_checkable.set_stretch_mode(TextureButton.STRETCH_SCALE)
	new_checkable.set_custom_minimum_size(checkable_max_dimensions)	
	new_checkable.set_toggle_mode(true)
	new_checkable.pressed.connect(_on_checkable_pressed.bind(new_checkable))

	return new_checkable

func _connect_signals() -> void:
	var decrement_button = $DecrementButton
	decrement_button.pressed.connect(decrement_pressed)
	var increment_button = $IncrementButton
	increment_button.pressed.connect(increment_pressed)
