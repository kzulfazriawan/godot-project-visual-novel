extends Node


const scenes = {
	"main_menu": preload("res://src/v1/MainMenu.tscn"),
	"dialogues": preload("res://src/v1/UIDialogues.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu = scenes["main_menu"].instance()
	add_child(main_menu)


func _on_start_game():
	var game = scenes["dialogues"].instance()
	
	for item in get_children():
		if item.name != "BackgroundTexture":
			remove_child(item)
	
	add_child(game)
