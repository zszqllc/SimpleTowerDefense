extends PathFollow2D

var DM
var BULLET_SPEED = 5

func _process(delta):
	progress += BULLET_SPEED* delta * 500
	if progress + 20 >= self.get_parent().curve.get_baked_length():
		self.queue_free()

func on_hit():
	$Boooommm.show()
	$FadeTimer.start()
	BULLET_SPEED = 0
	for area in $Boom.get_overlapping_areas():
		if "Enemy" in area.get_parent().name:
			area.get_parent().be_hit(DM)
	DM = 0
	
func _on_FadeTimer_timeout():
	queue_free()
