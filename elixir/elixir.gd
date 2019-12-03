extends Area2D

# 2019-12-7 acodemia.pl

var item
export (float) var health_regeneration = 1

#func _ready():
#	#set_physics_process(true)
#	#set_process(true)
#	pass
	
	
#func _physics_process(delta):
#	pass
	
	
#func _process(delta):
#	pass
	
	
func _on_Elixir_body_entered( body ):
	print (self.name + ": znalazł mnie " + body.name)
	if(body.has_method("update_item")):
		item = self.name
		body.update_item( item )
	if(body.has_method("regenerate_health")):
		body.regenerate_health(health_regeneration)
		pass
	queue_free()
	pass
	
