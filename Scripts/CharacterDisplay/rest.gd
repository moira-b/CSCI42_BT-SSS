extends Window

@onready var tend_wounds: CheckButton = $RestUI/RestActions/TendWounds
@onready var clear_stress: CheckButton = $RestUI/RestActions/ClearStress
@onready var repair_armor: CheckButton = $RestUI/RestActions/RepairArmor
@onready var prepare: CheckButton = $RestUI/RestActions/Prepare
@onready var project: CheckButton = $RestUI/RestActions/Project
@onready var confirm_button: Button = $RestUI/ConfirmButton

var selected: Array[CheckButton] = []
var rest_length: String = ""
var character: Character
var num_moves: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	confirm_button.disabled = true
	
	# connect signals
	tend_wounds.toggled.connect(_on_tend_wounds_toggled)
	clear_stress.toggled.connect(_on_clear_stress_toggled)
	repair_armor.toggled.connect(_on_repair_armor_toggled)
	prepare.toggled.connect(_on_prepare_toggled)
	project.toggled.connect(_on_project_toggled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_Project() -> void:
	project.visible = true
	selected.clear()
	tend_wounds.set_pressed_no_signal(false)
	clear_stress.set_pressed_no_signal(false)
	repair_armor.set_pressed_no_signal(false)
	prepare.set_pressed_no_signal(false)
	project.set_pressed_no_signal(false)


func disable_Project() -> void:
	project.visible = false
	


func set_rest_Length(length) -> void:
	rest_length = length
	


func get_character(pc) -> void:
	character = pc
	num_moves = character.num_downtime_moves

func _on_tend_wounds_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(tend_wounds)
		
		if selected.size() > num_moves:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(tend_wounds)
	if selected.size() >= num_moves:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true
	


func _on_clear_stress_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(clear_stress)
		
		if selected.size() > num_moves:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(clear_stress)
	if selected.size() >= num_moves:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true
	


func _on_repair_armor_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(repair_armor)
		
		if selected.size() > num_moves:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(repair_armor)
	if selected.size() >= num_moves:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true


func _on_prepare_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(prepare)
		
		if selected.size() > num_moves:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(prepare)
	if selected.size() >= num_moves:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true


func _on_project_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(project)
		
		if selected.size() > num_moves:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(project)
	if selected.size() >= num_moves:
		confirm_button.disabled = false
	else:
		confirm_button.disabled = true


func confirm_selection() -> void:
	self.hide()
	if rest_length == "short":
		for s in selected:
			var dice: int
			if s != prepare:
				dice = randi_range(1,4)
				if s == tend_wounds:
					#print("Recovered " + str(dice) + " HP")
					character.set_current_health(character.current_hp + dice)
				if s == clear_stress:
					#print("Recovered " + str(dice) + " stress")
					character.set_current_stress(character.current_stress - dice)
				if s == repair_armor:
					#print("Recovered " + str(dice) + " armor")
					character.used_armor_slots = clamp(character.used_armor_slots - dice,
					0, character.max_armor_slots)
			else:
				#print("Recovered 2 Hope")
				character.current_hope = clamp(character.current_hope + 2,
				0, character.max_hope)
	else:
		for s in selected:
			if s == tend_wounds:
				#print("Recovered all HP")
				character.current_hp = character.max_hp
			if s == clear_stress:
				#print("Recovered all stress")
				character.current_stress = 0
			if s == repair_armor:
				#print("Recovered all armor")
				character.used_armor_slots = 0
			if s == prepare:
				#print("Recovered 2 Hope")
				character.current_hope = clamp(character.current_hope + 2,
				0, character.max_hope)
			#if s == project:
				#print("Worked on a project")
	selected.clear()
	confirm_button.disabled = true

func set_buttons_down()  -> void:
	tend_wounds.button_pressed = false
	clear_stress.button_pressed = false
	repair_armor.button_pressed = false
	prepare.button_pressed = false
	project.button_pressed = false
	
