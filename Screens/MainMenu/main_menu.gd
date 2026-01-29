extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.switchMusic(MusicController.Music_Stream.MAIN_MENU, true)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/Game/GameScene.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/Credits/Credits.tscn")

func _on_enciclopedia_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/Enciclopedia/Enciclopedia.tscn")
