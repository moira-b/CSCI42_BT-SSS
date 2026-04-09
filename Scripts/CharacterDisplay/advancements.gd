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
@onready var domain_card: CheckButton = $ObjectContainer/DomainCardPanel/ExtraDomainCard
@onready var classes: Button = $ObjectContainer/Classes
@onready var confirm_button: Button = $ConfirmButton

@onready var allButtons: Array[CheckButton] = [agility, strength, finesse, instinct, presence,
knowledge, health, stress, evasion, proficiency, exp_1, exp_2, exp_3, exp_4, exp_5, domain_card]
var selected: Array[CheckButton]
var character: Character
var card_selector_scene: PackedScene = load("res://Scenes/Cards/domain_card_sel_container.tscn")
signal advancements_confirmed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	classes.disabled = true
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
	_update_fields()

func _update_fields() -> void:
	exp_1.text = character.experiences[0]
	exp_2.text = character.experiences[1]
	exp_3.text = character.experiences[2]
	exp_4.text = character.experiences[3]
	exp_5.text = character.experiences[4]
	
	if character.level == 2:
		exp_3.text = "New Experience"
		exp_3.show()
		
		for b in allButtons:
			b.disabled = false
	elif character.level == 5:
		exp_4.text = "New Experience"
		exp_4.show()
		classes.disabled = false
		
		for b in allButtons:
			b.disabled = false
	elif character.level == 8:
		exp_5.text = "New Experience"
		exp_5.show()
		
		for b in allButtons:
			b.disabled = false

	
func _on_confirm_pressed() -> void:
	if !selected.size() >= 2 && !proficiency in selected:
		print("No advancements selected")
	else:
		for s in selected:
			if s == agility: character.agility += 1
			if s == strength: character.strength += 1
			if s == finesse: character.finesse += 1
			if s == instinct: character.instinct += 1
			if s == presence: character.presence += 1
			if s == knowledge: character.knowledge += 1
			if s == proficiency: character.proficiency += 1
			if s == health: character.max_hp += 1
			if s == stress: character.max_stress += 1
			if s == exp_1: character.experience_levels[0] += 1
			if s == exp_2: character.experience_levels[1] += 1
			if s == exp_3: character.experience_levels[2] += 1
			if s == exp_4: character.experience_levels[3] += 1
			if s == exp_5: character.experience_levels[4] += 1
			if s == domain_card: character.max_domain_cards += 1
		for s in selected:
			s.set_pressed_no_signal(false)
			s.disabled = true
		selected.clear()
		update_sheet_fields()
		self.hide()
		character.max_domain_cards += 1
		_load_domain_card_selector()


func update_sheet_fields():
	advancements_confirmed.emit()


func _load_domain_card_selector():
	var new_scene = card_selector_scene.instantiate()
	character.reparent(new_scene)
	get_tree().root.add_child(new_scene)
	self.get_parent().queue_free()
