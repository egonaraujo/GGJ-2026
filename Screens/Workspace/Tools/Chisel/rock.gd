extends Node2D

const maxLife = 4
var life = maxLife

const timeBetweenLife := 0.4
var activeTimeFocused = 0

const timeBetweenAnimation := 0.125
var activeTimeAnimating : float = 0

var hasFocus := false
var counterDisplace := Vector2.ZERO

func _process(delta: float) -> void:
	if(!hasFocus):
		return
	
	activeTimeAnimating += delta
	if(activeTimeAnimating > timeBetweenAnimation):
		activeTimeAnimating -= timeBetweenAnimation
		# counter displace used on next cycle to avoid the rock going too far
		var displace = Vector2(randf_range(-1,1), randf_range(-1,1)) - counterDisplace
		counterDisplace = displace
		self.position += displace
	
	activeTimeFocused += delta
	if(activeTimeFocused < timeBetweenLife):
		return
	
	activeTimeFocused -= timeBetweenLife
	
	life -= 1
	if(life <= 0):
		queue_free()
	($Sprite2D as Sprite2D).frame = life - 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name) != "CollisionDetection":
		return
	hasFocus = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.name) != "CollisionDetection":
		return
	hasFocus = false
