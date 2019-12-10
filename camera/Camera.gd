extends Camera2D

# 2020-01-11 acodemia.pl

# jak szybko ustają wstrząsy [0, 1].
export var decay = 0.8
# maksymalna amplituda wstrząsówy poziomo/pionowo w pikselach.
export var max_offset = Vector2(100, 75)
# maksymalny obrót w radianach (używać oszczędnie).
export var max_roll = 0.1
# pzypisanie węzeła, za którym podąża ta kamera.
export (NodePath) var target  # Assign the node this camera will follow.

# rozwiązanie wykorzystujące referencję
# wywołanie:
# $Camera.setTarget($Wanderer)

var my_target
var target_reference

var trauma = 0.0  # aktualna siła wstrząsania
var trauma_power = 2 # wykładnik potęgi obliczającej uraz (wstrząs) - użyj [2, 3]

var follow_target = true


func _ready():
	randomize()

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func _physics_process(delta):
	update_node_path(delta)
	#update_reference(delta)
	pass
	
	
func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
	
	
func setTarget( target ):
	my_target = target
	target_reference = weakref(my_target)
	pass
	
	
func update_node_path(delta):
	if(follow_target):
		if target:
			if (get_node(target)):
				global_position = get_node(target).global_position
			else:
				follow_target = false
			if trauma:
				trauma = max(trauma - decay * delta, 0)
				shake()
	pass
	
	
func update_reference(delta):
	if(my_target):
		if (target_reference.get_ref()):
			global_position = target_reference.get_ref().global_position
			if trauma:
				trauma = max(trauma - decay * delta, 0)
				shake()
	pass
