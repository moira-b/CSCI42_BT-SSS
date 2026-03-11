extends Window

@onready var tend_wounds: CheckButton = $RestUI/RestActions/TendWounds
@onready var clear_stress: CheckButton = $RestUI/RestActions/ClearStress
@onready var repair_armor: CheckButton = $RestUI/RestActions/RepairArmor
@onready var prepare: CheckButton = $RestUI/RestActions/Prepare
@onready var project: CheckButton = $RestUI/RestActions/Project
@onready var confirm_button: Button = $RestUI/ConfirmButton

var selected: Array[CheckButton] = []
var rest_length: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enable_Project() -> void:
	project.visible = true
	selected = []
	tend_wounds.set_pressed_no_signal(false)
	clear_stress.set_pressed_no_signal(false)
	repair_armor.set_pressed_no_signal(false)
	prepare.set_pressed_no_signal(false)
	project.set_pressed_no_signal(false)


func disable_Project() -> void:
	project.visible = false
	

func set_rest_Length(length) -> void:
	rest_length = length
	


func _on_tend_wounds_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(tend_wounds)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(tend_wounds)
	


func _on_clear_stress_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(clear_stress)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(clear_stress)
	


func _on_repair_armor_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(repair_armor)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(repair_armor)


func _on_prepare_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(prepare)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(prepare)


func _on_project_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected.append(project)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(project)


func _on_confirm_button_pressed() -> void:
	if rest_length == "short":
		for s in selected:
			var clear: int
			if s != prepare:
				clear = randi_range(1,4)
				if s == tend_wounds:
					print("Recovered " + str(clear) + " HP")
				if s == clear_stress:
					print("Recovered " + str(clear) + " stress" )
				if s == repair_armor:
					print("Recovered " + str(clear) + " armor")
			else:
				print("Recovered 2 Hope")
	else:
		for s in selected:
			if s == tend_wounds:
				print("Recovered all HP")
			if s == clear_stress:
				print("Recovered all stress")
			if s == repair_armor:
				print("Recovered all armor")
			if s == prepare:
				print("Recovered 2 Hope")
			if s == project:
				print("Worked on a project")
			
