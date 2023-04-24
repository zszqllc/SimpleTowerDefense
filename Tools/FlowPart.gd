extends PathFollow2D

func _process(delta):
	progress -= delta * 750
	if progress <= 50:
		self.queue_free()
