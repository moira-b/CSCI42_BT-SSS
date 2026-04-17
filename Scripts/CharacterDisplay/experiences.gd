extends VBoxContainer

signal exp_level_changed(which_exp: int, new_val: int)

@onready var level_fields: Array = [
	$Experience1/SpinBox,
	$Experience2/SpinBox,
	$Experience3/SpinBox,
	$Experience4/SpinBox,
	$Experience5/SpinBox,
]

func _ready() -> void:
	for i in range(len(level_fields)):
		var spinbox: SpinBox = level_fields[i]
		spinbox.value_changed.connect(_on_exp_level_changed.bind(i+1))

func set_visible_experiences(character: Character):
	var character_experiences = character.experiences
	for i in range(len(level_fields)):
		if (character_experiences[i]==""):
			level_fields[i].visible = false

func set_level_values(character: Character):
	var character_exp_levels = character.experience_levels
	print(character_exp_levels)
	for i in range(len(level_fields)):
		level_fields[i].value = character_exp_levels[i]

func _on_exp_level_changed(new_val: int, which_exp: int):
	exp_level_changed.emit(which_exp, new_val)
