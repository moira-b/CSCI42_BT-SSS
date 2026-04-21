extends VBoxContainer

const UNLOCK_THIRD_EXP: int = 2
const UNLOCK_FOURTH_EXP: int = 5
const UNLOCK_FIFTH_EXP: int = 8

signal exp_level_changed(which_exp: int, new_val: int)

@onready var experiences: Array = [
	$Experience1,
	$Experience2,
	$Experience3,
	$Experience4,
	$Experience5,
]

#@onready var experience_fields: Array = [
	#$Experience1/Experience1,
	#$Experience2/Experience2,
	#$Experience3/Experience3,
	#$Experience4/Experience4,
	#$Experience5/Experience5,
#]
#
#@onready var level_fields: Array = [
	#$Experience1/SpinBox,
	#$Experience2/SpinBox,
	#$Experience3/SpinBox,
	#$Experience4/SpinBox,
	#$Experience5/SpinBox,
#]

func _ready() -> void:
	for i in range(len(experiences)):
		var spinbox: SpinBox = experiences[i].get_node("SpinBox")
		spinbox.value_changed.connect(_on_exp_level_changed.bind(i+1))

func set_experience_visibility(which_experience: int, is_visible: bool=true):
	var experience_index = which_experience-1
	experiences[experience_index].visible = is_visible

func set_visible_experiences(character: Character):
	for i in range(len(experiences)):
		if character.level < 2:
			set_experience_visibility(1, true)
			set_experience_visibility(2, true)
			set_experience_visibility(3, false)
			set_experience_visibility(4, false)
			set_experience_visibility(5, false)
		elif character.level >= 2 && character.level < 5:
			set_experience_visibility(1, true)
			set_experience_visibility(2, true)
			set_experience_visibility(3, true)
			set_experience_visibility(4, false)
			set_experience_visibility(5, false)
		elif character.level >= 5 && character.level < 8:
			set_experience_visibility(1, true)
			set_experience_visibility(2, true)
			set_experience_visibility(3, true)
			set_experience_visibility(4, true)
			set_experience_visibility(5, false)
		else:
			for j in range(len(experiences)):
				set_experience_visibility(j, true)

func set_level_values(character: Character):
	var character_exp_levels: Array = character.experience_levels
	print(character_exp_levels)
	for i in range(len(experiences)):
		var spinbox: SpinBox = experiences[i].get_node("SpinBox")
		spinbox.value = character_exp_levels[i]

func _on_exp_level_changed(new_val: int, which_exp: int):
	exp_level_changed.emit(which_exp, new_val)
