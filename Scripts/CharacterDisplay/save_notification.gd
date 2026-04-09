extends Window

func showFor(time: int = 2):
	self.show()
	await(get_tree().create_timer(time).timeout)
	self.hide()
