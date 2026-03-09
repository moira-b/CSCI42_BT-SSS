extends VBoxContainer

@onready var experience1 : LineEdit = $Experience1/LineEdit
@onready var experience2 : LineEdit = $Experience2/LineEdit
@onready var experience3 : LineEdit = $Experience3/LineEdit
@onready var experience4 : LineEdit = $Experience4/LineEdit
@onready var experience5 : LineEdit = $Experience5/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func check_level(lvl: int):
	if (lvl < 2):
		experience3.hide()
	if (lvl < 5):
		experience4.hide()
	if (lvl < 8):
		experience5.hide()
