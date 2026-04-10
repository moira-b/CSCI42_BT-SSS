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
@onready var multiclass: CheckButton = $ObjectContainer/MulticlassPanel/Multiclassing
@onready var object_container = $ObjectContainer
@onready var multiclass_container = $MulticlassChoiceContainer
@onready var domain_card_selector = $DomainCardSelContainer
@onready var confirm_button: Button = $ConfirmButton

@onready var allButtons: Array[CheckButton] = [agility, strength, finesse, instinct, presence,
knowledge, health, stress, evasion, proficiency, exp_1, exp_2, exp_3, exp_4, exp_5, domain_card, multiclass]

var selected: Array[CheckButton]
@onready var container_array = [object_container, multiclass_container, domain_card_selector]
var active_container: Container
var character: Character
var card_selector_scene: PackedScene = load("res://Scenes/Cards/domain_card_sel_container.tscn")
signal advancements_confirmed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiclass.disabled = true
	for button in allButtons:
		button.toggled.connect(_on_checkButton_toggled.bind(button))
	confirm_button.pressed.connect(_on_confirm_pressed)
	set_active_container(0)
	self.add_theme_icon_override("close", Texture2D.new())

func set_active_container(n: int) -> void:
	active_container = container_array[n]
	active_container.visible = true
	for container in container_array:
		if container != active_container:
			container.visible = false
	
	if active_container == container_array[2]: 
		confirm_button.visible = false
		domain_card_selector.level_up_selector_setup()
	else:
		confirm_button.visible = true

func _on_checkButton_toggled(toggled_on: bool, toggled_button: CheckButton) -> void:
	if active_container == container_array[0]:
		if toggled_on:
			if toggled_button == proficiency:
				if selected.size() > 0:
					for s in selected:
						s.set_pressed_no_signal(false)
					selected.clear()
			elif proficiency in selected:
				selected[0].set_pressed_no_signal(false)
				selected.clear()
			
			if toggled_button == multiclass:
				if selected.size() > 0:
					for s in selected:
						s.set_pressed_no_signal(false)
					selected.clear()
			elif multiclass in selected:
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
	_update_buttons()

func _update_fields() -> void:
	exp_1.text = character.experiences[0]
	exp_2.text = character.experiences[1]
	exp_3.text = character.experiences[2]
	exp_4.text = character.experiences[3]
	exp_5.text = character.experiences[4]
	
	if character.level == 2:
		exp_3.text = "New Experience"
		exp_3.show()
		
		character.button_enabler = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
	elif character.level == 5:
		exp_4.text = "New Experience"
		exp_4.show()
		multiclass.disabled = false
		
		character.button_enabler = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
	elif character.level == 8:
		exp_5.text = "New Experience"
		exp_5.show()
		
		character.button_enabler = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]

func _on_confirm_pressed() -> void:
	if active_container==container_array[0]: _handle_object_container_confirm()

func _handle_object_container_confirm() -> void:
	var is_multiclassing: bool = false
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
			if s == multiclass: is_multiclassing = true
		for s in selected:
			var index = allButtons.find(s)
			character.button_enabler[index] = true
		if is_multiclassing:
			multiclass_container.get_character(character)
			multiclass_container.initialize()
			set_active_container(1)
		else:
			set_active_container(2)
		
		character.max_domain_cards += 1

func update_sheet_fields():
	advancements_confirmed.emit()

func confirm_all_advancements():
	selected.clear()
	set_active_container(0)
	update_sheet_fields()
	self.hide()

func _update_buttons():
	var i=0
	for button in allButtons:
		button.set_pressed_no_signal(character.button_enabler[i])
		button.disabled = character.button_enabler[i]
		i+=1
		if button == multiclass && character.level < 5:
			button.disabled = true
