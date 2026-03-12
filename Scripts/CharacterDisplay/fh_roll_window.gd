extends Window

const MINIMUM: int = 1
const MAXIMUM: int = 12

@onready var fear_display = $HBoxContainer/FearDie/VBoxContainer/ResultLabel
@onready var hope_display = $HBoxContainer/HopeDie/VBoxContainer/ResultLabel
@onready var result_display = $ResultDisplay
var fear_result: int = 0
var hope_result: int = 0

func _ready() -> void:
	self.visible = true
	fear_result = randi_range(MINIMUM, MAXIMUM)
	hope_result = randi_range(MINIMUM, MAXIMUM)
	fear_display.text = str(fear_result)
	hope_display.text = str(hope_result)
	
	interpret_rolls()

func interpret_rolls() -> void:
	print("DEBUG: Hope: " + str(hope_result) + " | Fear: " + str(fear_result))
	
	if hope_result > fear_result:
		result_display.text = "Roll with Hope"
	elif hope_result==fear_result:
		result_display.text = "Critical Success!"
	else:
		result_display.text = "Roll with Fear"
		
func _on_roll_again_button_pressed() -> void:
	fear_result = randi_range(MINIMUM, MAXIMUM)
	hope_result = randi_range(MINIMUM, MAXIMUM)
	fear_display.text = str(fear_result)
	hope_display.text = str(hope_result)
	
	interpret_rolls()

func _on_close_requested() -> void:
	self.visible = false
