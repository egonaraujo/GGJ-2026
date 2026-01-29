extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.switchMusic(MusicController.Music_Stream.MAIN_MENU, true)
	pass # Replace with function body.


func _on_Play_pressed():
	GameControllerSingleton.ResetScores()
	get_tree().change_scene_to_file("res://OldPlanta/Scenario/Tutorial/Tutorial.tscn")


func _on_Credits_pressed():
	get_tree().change_scene_to_file("res://Scenario/Credits/Credits.tscn")
