extends Sprite2D

@export var startPos: Vector2

var endPos
var endScale

func _ready():
	endPos = $".".position
	endScale = $".".scale
	resetAnim()

func setAnimPercent(percent):
	if(percent < 1):
		#this line ensures that the final stage will be different from
		#the last one
		percent*=0.7
	
	if (percent < 0.05):
		$".".hide()
	else:
		$".".show()
	
	$".".position = startPos + (percent*(endPos - startPos))
	$".".scale = percent * endScale


func resetAnim():
	setAnimPercent(0)
