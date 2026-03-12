extends Window

@onready var sum_display = $ResultsContainer/Sum
@onready var individual_rolls_display = $ResultsContainer/IndividualRolls
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
	var results_array: Array
	
	for dice_type in dice_array:
		for i in range(dice_type.count):
			roll = randi_range(0, dice_type.num_sides)
			results_array.append(roll)
			sum += roll
		#print("DEBUG: " + str(dice_type.count) + "d" + str(dice_type.num_sides))
		dice_type.count = 0
		dice_type.value_label.text = str(0)
	
	#print("DEBUG: DICE ROLL RESULT " + str(sum))
	print(results_array)

	sum_display.text = str(sum)
	if (0 < results_array.size() && results_array.size() <= 20):
		individual_rolls_display.text = array_to_string(results_array)
	else:
		individual_rolls_display.text = ""

func array_to_string(arr: Array) -> String:
	var return_me: String = ""
	
	var i: int = 0
	while i < (arr.size() -1):
		return_me += str(arr[i]) + ", "
		i += 1
	return_me += str(arr[arr.size()-1])
	
	return return_me


func _on_close_requested() -> void:
	self.visible = false
