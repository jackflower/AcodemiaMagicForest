extends KinematicBody2D

# 2019-11-23 acodemia.pl

var shuriken_speed = 200 # Pixels/seconds
var shuriken_direction = Vector2(0, 0)
var caliber = 1

#var test = preload("res://wanderer/explosion/Explosion.tscn")

func _ready():
	set_physics_process(true)
	pass
	
	
func _physics_process(delta):
	
	var motion = Vector2()
	motion += Vector2(shuriken_direction)
	
	motion = motion.normalized() * shuriken_speed * delta
	motion = move_and_collide(motion)
	
	if(motion):
		# sprawdzamy z jakim obiektem koliduje shuriken
		var entity = motion.collider
		# nazwa obiektu, z którym koliduje shuriken
		var napis = "Shuriken collides with: "
		print (napis + entity.get_name())
		# aktualizacja życia obiektu, w który trafił shuriken
		if(entity.has_method("update_health")):
			entity.update_health(int(caliber))
			pass
		# eksplozja shuriken przy trafieniu
		explode()
		# obiekt - shuriken zostaje zniszczony
		queue_free()
	pass
	
	
# eksplozja shuriken przy trafieniu
func explode():
	#var explosion = preload("res://wanderer/explosion/Explosion.tscn").instance()
	#var explosion = preload("../explosion/Explosion.tscn").instance()
	var explosion = preload("res://wanderer/explosion/Explosion.tscn").instance()
	
	explosion.global_position = global_position
	explosion.global_scale = self.global_scale
	get_parent().add_child(explosion)
	pass
	
	
# jeśli shuriken opuszcza okno gry - obiekt - shuriken zostaje zniszczony
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass
	
