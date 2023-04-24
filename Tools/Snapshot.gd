extends Light2D

func _ready():
	self.hide()

func light_on():
	self.show()
	$Timer.start()

func _on_Timer_timeout():
	$Timer.stop()
	self.hide()
