extends Window

func showFor(time: float = 1):
	self.show()
	await(get_tree().create_timer(time).timeout)
	self.hide()
