extends GutTest

var MainMenu = preload("res://Scripts/SheetManagement/main_menu.gd")
var mainmenu

func before_each():
	mainmenu = autofree(MainMenu.new())
	add_child(mainmenu)
	await get_tree().process_frame

func after_each():
	pass

func test_pass():
	assert(1==1, "uhh, what?")
