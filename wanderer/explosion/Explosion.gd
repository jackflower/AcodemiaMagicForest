extends Area2D

# 2019-11-23 acodemia.pl

func _on_AnimationPlayer_animation_finished( anim_name ):
	self.queue_free()
	pass
