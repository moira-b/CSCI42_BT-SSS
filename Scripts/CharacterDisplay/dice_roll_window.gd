extends Window

@onready var sum_display = $ResultsContainer/Sum
@onready var individual_rolls_display = $ResultsContainer/IndividualRolls
@onready var roll_button = $RollButtonContainer/RollButton
@onready var dice = $DiceRollUI/Dice

var dice_2d_array = [
	[4, null],
	[6, null],
	[8, null],
	[10, null],
	[12, null],
	[20, null],
	[100, null]
]

var dice_quantity_fields: Array[SpinBox]

func _ready() -> void:
	var dice_types = dice.get_children()
	for i in range(len(dice_types)):
		dice_2d_array[i][1] = dice_types[i].get_child(0).get_node("SpinBox")
	
func _on_roll_button_pressed() -> void:
	var num_dice: int = 0
	var sum: int = 0
	var roll: int
	var results_array: Array
	
	for die in dice_2d_array:
		var dice_type = die[0]
		var quantity_rolled = die[1].value
		
		for i in range(quantity_rolled):
			roll = randi_range(1, dice_type)
			results_array.append(roll)
			sum += roll
		
		# reset spinbox back to 0
		die[1].value = 0
	
	#for dice_type in dice_array:
		#for i in range(dice_type.count):
			#roll = randi_range(1, dice_type.num_sides)
			#results_array.append(roll)
			#sum += roll
		##print("DEBUG: " + str(dice_type.count) + "d" + str(dice_type.num_sides))
		#dice_type.count = 0
		#dice_type.value_label.text = str(0)
	#
	##print("DEBUG: DICE ROLL RESULT " + str(sum))
	print(results_array)

	sum_display.text = "Sum: " + str(sum)
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
