extends Control


onready var parent = get_parent()


func _on_StartGame_pressed():
	parent._on_start_game()
	


func _on_QuitGame_pressed():
	get_tree().quit()
