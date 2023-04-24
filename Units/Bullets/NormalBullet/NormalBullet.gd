extends PathFollow2D

var DM
var BULLET_SPEED = 2

func _process(delta):
	progress += BULLET_SPEED* delta * 500
	if progress + 20 >= self.get_parent().curve.get_baked_length():
		self.queue_free()

func on_hit():
	queue_free()
