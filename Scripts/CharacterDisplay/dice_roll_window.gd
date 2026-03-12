extends Window

@onready var result_field = $ResultContainer/Result
@onready var roll_button = $RollButtonContainer/RollButton
@onready var dice = $DiceRollUI/Dice

var dice_array: Array

func _ready() -> void:
	self.visible = true
	dice_array = dice.get_children()
	
func _on_roll_button_pressed() -> void:
	var num_dice: int = 0
	var sum: int = 0
	var roll: int
	var results_array: Array[int] 
	
	for dice_type in dice_array:
		for i in range(dice_type.count):
			roll = randi_range(0, dice_type.num_sides)
			results_array.append(roll)
			sum += roll
		dice_type.count = 0
		dice_type.value_label.text = str(0)
	
	print("DICE ROLL RESULT: " + str(sum))
	print(results_array)
	
	result_field.text = str(sum)
