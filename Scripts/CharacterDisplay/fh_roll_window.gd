extends Window

const MINIMUM: int = 1
const MAXIMUM: int = 12

@onready var fear_display = $HBoxContainer/FearDie/VBoxContainer/ResultLabel
@onready var hope_display = $HBoxContainer/HopeDie/VBoxContainer/ResultLabel
@onready var sum_display = $ResultsContainer/Sum
@onready var interpretation_display = $ResultsContainer/Interpretation
@onready var consequences_display = $ResultsContainer/Consequences
var fear_result: int = 0
var hope_result: int = 0

func _ready() -> void:
	self.visible = false
	fear_result = randi_range(MINIMUM, MAXIMUM)
	hope_result = randi_range(MINIMUM, MAXIMUM)
	fear_display.text = str(fear_result)
	hope_display.text = str(hope_result)
	
	interpret_rolls()

func interpret_rolls() -> void:
	print("DEBUG: Hope: " + str(hope_result) + " | Fear: " + str(fear_result))
	
	if hope_result > fear_result:
		interpretation_display.text = "Roll with Hope"
		consequences_display.text = "You gain 1 Hope."
	elif hope_result==fear_result:
		interpretation_display.text = "Critical Success!"
		consequences_display.text = "You gain 1 Hope and lose 1 Stress."
	else:
		interpretation_display.text = "Roll with Fear"
		consequences_display.text = "The GM gain 1 Fear."
	sum_display.text = "Sum: " + str(hope_result + fear_result)
		
func _on_roll_again_button_pressed() -> void:
	fear_result = randi_range(MINIMUM, MAXIMUM)
	hope_result = randi_range(MINIMUM, MAXIMUM)
	fear_display.text = str(fear_result)
	hope_display.text = str(hope_result)
	
	interpret_rolls()
