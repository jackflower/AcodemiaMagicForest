extends Camera2D

# january 21, 2022
# Camera usage:
# 
# 1. Editor:
# z poziomu węzła rodzica (main), w którym jest
# węzeł Camera - child - wybrać dla kamery obiekt,
# który będzie śledziła kamera
#
# 2. Script:
# wskazać obiekt, który będzie śledziła kamera
# [ np. $Camera.setTarget($Wanderer) ]
# [ np. $Camera.setTarget($Mech) ] 
#
# 3. Scene (node):
# dodać do sceny obiektu, którym ma być śledzony
# węzeł (scenę) Camera
#
# Description:
# W obrębie sceny (węzła) może być wiele kamer, jakkolwiek
# zawsze jedna z nich jest kamerą (current), która renderuje
# swój widok (widok w oku kamery) na to, co w danej chwili
# widzi Player - rendering na ekran urządzenia, które
# wyśwwitla daną klatkę renderingu gry...


# 2020-01-11 acodemia.pl

# jak szybko ustają wstrząsy [0, 1].
export var decay = 0.8
# maksymalna amplituda wstrząsówy poziomo/pionowo w pikselach.
export var max_offset = Vector2(100, 75)
# maksymalny obrót w radianach (używać oszczędnie).
export var max_roll = 0.1
# pzypisanie węzeła, za którym podąża ta kamera;
# można wybrać z poziomu edytora - inspektor obiektów
export (NodePath) var target

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
	# Camera - tagert - from Editor
	update_node_path(delta)
	
	# Camera - tagert - in code
	# update_reference(delta)
	#
	# optymalizacja procesu - jedna z metod aktualizacji
	# funkcjonalności kamery
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
