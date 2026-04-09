extends GutTest

var save_manager = preload("res://Scripts/SheetManagement/save_manager.gd")

func before_each():
	pass

func after_each():
	pass

func test_placeholder():
	assert_eq(1, 1)
