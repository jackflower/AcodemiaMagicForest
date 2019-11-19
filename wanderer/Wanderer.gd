extends KinematicBody2D

# 2019-11-23 acodemia.pl

var health = 100
var speed = 200
var rot_speed = 1.5
var velocity = Vector2()
var rot_dir = 0
var shooting = false
var backwards = false

#const MOTION_SPEED = 120 # Pixels/seconds
#var health = 100
var on_scene = false


var shuriken_data = preload("res://wanderer/shuriken/Shuriken.tscn")
var direction = Vector2()
export  (float) var created_bullet_scale_factor = 1
export  (float) var created_bullet_speed = 400
export  (float) var created_bullet_caliber = 2


func _ready():
	set_physics_process(true)
	shooting = false
	on_scene = true
	pass
	
	
func get_input():
	
	rot_dir = 0
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		rot_dir += 1
	if Input.is_action_pressed("ui_left"):
		rot_dir -= 1
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
		backwards = true
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
		backwards = false
	if Input.is_action_pressed("ui_select"):
		if(shooting):
			Shot()
			shooting = false
	pass
		
		
func _physics_process(delta):
	
	get_input()
	rotation += rot_dir * rot_speed * delta
	move_and_slide(velocity)
		
	if(not velocity):
		$AnimationPlayer.play("wanderer_walk")
		pass
		
	# obiekt ginie...
	if(health <= 0):
		self.queue_free()
		pass
		
	pass
		
		
func update_health(damage):
	health -= damage
	print(health)
	pass
	
func update_item( item ):
	print (self.name + ": znalazłem " + item)
	pass
	
func regenerate_health( regeneration_value ):
	health = health + regeneration_value
	print(health)
	pass
		
	
func Shot():
	
	var shuriken = shuriken_data.instance()
	
	if(velocity.length() == 0):
		shuriken.shuriken_direction = Vector2(speed, 0).rotated(rotation)
	else:
		direction = velocity.normalized()
		shuriken.shuriken_direction = direction
		
		if(backwards):
			shuriken.shuriken_direction = -shuriken.shuriken_direction
	pass
		
	shuriken.global_scale = global_scale * created_bullet_scale_factor
	shuriken.global_position  = $ShotPosition2D.global_position
	shuriken.global_rotation_degrees = global_rotation_degrees + 90
	shuriken.shuriken_speed = created_bullet_speed
	shuriken.caliber = created_bullet_caliber
	get_parent().add_child(shuriken)
	pass
	
	
func _on_TimerShot_timeout():
	shooting = true
	pass
	
