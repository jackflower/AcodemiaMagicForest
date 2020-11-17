extends Node2D

# 2020-01-11 acodemia.pl

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
	
	$DefensiveTowerAlpha.setTarget($Mech)
	$DefensiveTowerBeta.setTarget($Mech)
	$DefensiveTowerGamma.setTarget($Mech)
	$DefensiveTowerDelta.setTarget($Mech)
	
	# reference solution
	#$Camera.setTarget($Wanderer)
	pass
