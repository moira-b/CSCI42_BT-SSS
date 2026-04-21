extends PanelContainer
@onready var label = $ScrollContainer/DescriptionLabel

func display_message(message: String) -> void:
	'''
	Sets the display to the inputted message.
	'''
	label.text = message;

func clear_message() -> void:
	'''
	Clears the text in the description box.
	'''
	label.text = ""
