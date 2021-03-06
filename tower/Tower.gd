extends KinematicBody2D

# 2019-12-7 acodemia.pl

var health = 100
var on_scene = false
# var motion_speed = 50
var motion_speed = 0
var shooting = false
var my_target
var target_reference

var tower_rotation = 0
var distance_to_target = 0
var target_position = Vector2(0, 0)
var bullet_vector = Vector2(0, 0)
var bullet_data = preload("res://tower/BulletTower.tscn")

export (float) var created_bullet_speed = 200
export (float) var created_bullet_scale_factor = 0.5
export (float) var bullet_caliber = 2
export (float) var tower_shot_range = 200


func _ready():
	set_physics_process(true)
	#set_process(true)
	pass
	
	
#func _process(delta):
#	pass
	
	
func _physics_process(delta):
	
	var motion = Vector2()
	motion += Vector2(0, 1)
	motion = motion.normalized() * motion_speed * delta
	motion = move_and_collide(motion)
	
	
	if(health <= 0):
		self.queue_free()
		pass
		
		
	if(my_target):
		if (target_reference.get_ref()):
			if(target_reference.get_ref().on_scene):
				target_position = target_reference.get_ref().global_position
				tower_rotation = atan2(( global_position.x - target_position.x ),
						( global_position.y - target_position.y ))
				
				distance_to_target = global_position.distance_to(target_position)
				
				if(distance_to_target <= tower_shot_range):
					rotation_degrees = -rad2deg(tower_rotation)
					if(shooting):
						create_bullet()
	
	
func create_bullet():
	# tworzymy pocisk
	var bullet = bullet_data.instance()
	# ustawiamy pocisk na pozycji startowej
	bullet.position = $BulletStartPosition2D.global_position
	# ustawiamy skalę
	bullet.global_scale = global_scale * created_bullet_scale_factor
	# prędkość pocisku
	bullet.bullet_speed = created_bullet_speed
	# znormalizowany wektor kierunku pocisku
	bullet_vector = (target_position - global_position).normalized()
	bullet.bullet_direction = Vector2(bullet_vector)
	# obrót pocisku
	bullet.global_rotation_degrees = rotation_degrees
	# kaliber - siła rażenia
	bullet.caliber = bullet_caliber
	# dodajemy pocisk do sceny
	get_parent().add_child(bullet)
	# blokujemy strzelanie - timer je odblokuje
	shooting = false
	pass
	
	
func setTarget( target ):
	my_target = target
	target_reference = weakref(my_target)
	pass
	
	
func update_health(damage):
	health -= damage
	print(health)
	pass
	
	
func _on_TimerShoot_timeout():
	shooting = true
	pass
	
	
func _on_VisibilityNotifier2D_screen_exited():
	on_scene = false
	pass
	
	
func _on_VisibilityNotifier2D_screen_entered():
	on_scene = true
	pass
	
	
