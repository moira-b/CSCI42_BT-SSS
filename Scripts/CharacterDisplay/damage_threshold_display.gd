extends HBoxContainer

@onready var major_threshold_label = $MajorThreshold
@onready var severe_threshold_label = $SevereThreshold

func set_major_threshold(new: int):
	major_threshold_label.text = str(new)
	
func set_severe_threshold(new: int):
	severe_threshold_label.text = str(new)
	
func get_major_threshold() -> int:
	return int(major_threshold_label.text)
	
func get_severe_threshold() -> int:
	return int(severe_threshold_label.text)
