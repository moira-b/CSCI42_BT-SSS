extends Window

@onready var agility: CheckButton = $ObjectContainer/Traits/VBoxContainer/Agility
@onready var strength: CheckButton = $ObjectContainer/Traits/VBoxContainer/Strength
@onready var finesse: CheckButton = $ObjectContainer/Traits/VBoxContainer/Finesse
@onready var instinct: CheckButton = $ObjectContainer/Traits/VBoxContainer/Instinct
@onready var presence: CheckButton = $ObjectContainer/Traits/VBoxContainer/Presence
@onready var knowledge: CheckButton = $ObjectContainer/Traits/VBoxContainer/Knowledge
@onready var health: CheckButton = $ObjectContainer/Markables/HealthPanel/Health
@onready var stress: CheckButton = $ObjectContainer/Markables/StressPanel/Stress
@onready var evasion: CheckButton = $ObjectContainer/Markables/EvasionPanel/Evasion
@onready var proficiency: CheckButton = $ObjectContainer/Markables/ProficiencyPanel/Proficiency
@onready var exp_1: CheckButton = $ObjectContainer/Experiences/VBoxContainer/Exp1
@onready var exp_2: CheckButton = $ObjectContainer/Experiences/VBoxContainer/Exp2
@onready var exp_3: CheckButton = $ObjectContainer/Experiences/VBoxContainer/Exp3
@onready var exp_4: CheckButton = $ObjectContainer/Experiences/VBoxContainer/Exp4
@onready var exp_5: CheckButton = $ObjectContainer/Experiences/VBoxContainer/Exp5
@onready var confirm_button: Button = $ConfirmButton

@onready var allButtons: Array[CheckButton] = [agility, strength, finesse, instinct, presence,
knowledge, health, stress, evasion, proficiency]
var selected: Array[CheckButton]
var character: Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in allButtons:
		button.toggled.connect(_on_checkButton_toggled.bind(button))
	confirm_button.pressed.connect(_on_confirm_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_checkButton_toggled(toggled_on: bool, toggled_button: CheckButton) -> void:
	if toggled_on:
		if toggled_button == proficiency:
			if selected.size() > 0:
				for s in selected:
					s.set_pressed_no_signal(false)
				selected.clear()
		elif proficiency in selected:
			selected[0].set_pressed_no_signal(false)
			selected.clear()
		
		selected.append(toggled_button)
		
		if selected.size() > 2:
			var oldest = selected.pop_front()
			oldest.set_pressed_no_signal(false)
	else:
		selected.erase(toggled_button)
		

func get_character(c: Character):
	character = c
	

func _update_fields() -> void:
	if character.level < 2:
		exp_3.show()
	if character.level < 5:
		exp_4.show()
	if character.level < 8:
		exp_5.show()

	
func _on_confirm_pressed() -> void:
	self.hide()
