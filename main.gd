extends Node2D

# 2019-12-7 acodemia.pl

# TO DO
# Elixir - losowanie health vs poison
# Tower - BulletTower - losowanie rodzaju pocisku
# albo tekstura, albo scena...

func _ready():
	$Tower_01.setTarget($Wanderer)
	$Tower_02.setTarget($Wanderer)
	$Tower_03.setTarget($Wanderer)
	$Tower_04.setTarget($Wanderer)
	$Tower_05.setTarget($Wanderer)
	$Tower_06.setTarget($Wanderer)
	$Tower_07.setTarget($Wanderer)
	$Tower_08.setTarget($Wanderer)
	$Tower_09.setTarget($Wanderer)
	$Tower_10.setTarget($Wanderer)
	pass

#func _process(delta):
#	pass
