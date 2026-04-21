extends Window

signal closing(exp_num: int)

#@onready var experience1_label = $ExperiencesVBox/Experience1/ExperienceHBox/ExperienceLabel
#@onready var experience1_button = $ExperiencesVBox/Experience1/ExperienceHBox/CheckBox
#@onready var experience2_label = $ExperiencesVBox/Experience2/ExperienceHBox/ExperienceLabel
#@onready var experience2_button = $ExperiencesVBox/Experience2/ExperienceHBox/CheckBox

@onready var experience1_button = $ExperiencesVBox/Experience1CheckBox
@onready var experience2_button = $ExperiencesVBox/Experience2CheckBox

@onready var confirm_button: Button = $ButtonsContainer/ConfirmButton
@onready var cancel_button: Button = $ButtonsContainer/CancelButton

var experience1: String
var experience2: String
var chosen_experience: int = -1

func showWindow(exp1: String, exp2: String):
	experience1_button.text = exp1
	experience2_button.text = exp2
	
	#experience1_label.text = exp1
	#experience2_label.text = exp2
	
	confirm_button.disabled = true
	connect_signals()
	self.show()
	
func _on_option_toggled(exp_num: int):
	print("PRESSED OPTION " + str(exp_num))
	if exp_num==1:
		if experience1_button.is_pressed():
			chosen_experience = 1
			experience2_button.set_pressed_no_signal(false)
		else:
			chosen_experience = -1
	elif exp_num==2:
		if experience2_button.is_pressed():
			chosen_experience = 2
			experience1_button.set_pressed_no_signal(false)
		else:
			chosen_experience = -1
	
	confirm_button.disabled = (chosen_experience==-1)
	
func _on_confirm_button_pressed():
	print("PRESSED CONFIRM")
	closing.emit(chosen_experience)
	self.hide()
	disconnect_signals()

func _on_cancel_button_pressed():
	print("PRESSED CANCEL")
	closing.emit(chosen_experience)
	self.hide()
	disconnect_signals()
	
func connect_signals():
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	experience1_button.pressed.connect(_on_option_toggled.bind(1))
	experience2_button.pressed.connect(_on_option_toggled.bind(2))
	
func disconnect_signals():
	confirm_button.pressed.disconnect(_on_confirm_button_pressed)
	cancel_button.pressed.disconnect(_on_cancel_button_pressed)
	experience1_button.pressed.disconnect(_on_option_toggled)
	experience2_button.pressed.disconnect(_on_option_toggled)
