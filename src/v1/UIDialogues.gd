extends Dialogues


onready var text_label: RichTextLabel  = $UI/TextBox/Label
onready var animation: AnimationPlayer = $AnimationPlayer
onready var next_image: TextureRect    = $UI/NextImage

const characters = {
	"character_a": {
		"scene": preload("res://src/v1/characters/CharacterA.tscn"),
		"name": "Character A"
	},
	"character_b": {
		"scene": preload("res://src/v1/characters/CharacterB.tscn"),
		"name": "Character B"
	}
}

const scenario = {
	"example": [
		"*start*",
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non magna ligula. Donec neque risus, congue mollis nunc nec, tempor efficitur tellus. Etiam facilisis erat eu magna accumsan, faucibus sagittis ipsum venenatis.",
		"Fusce vitae pretium augue, sed sollicitudin arcu. Sed ornare, ante eget sodales ornare, neque risus interdum ante, ut aliquam velit felis vel risus.",
		["Suspendisse vitae erat porta, porttitor eros in, egestas metus. Mauris consectetur hendrerit interdum. Etiam a erat vel sem tempus semper id non ex.", {"block1": "character_a"}],
		["Vestibulum tortor magna, egestas a augue eu, efficitur dictum mi.", {"block2": "character_b"}],
		"Pellentesque pretium finibus turpis eget accumsan. Ut egestas iaculis vulputate. Morbi in justo ut diam faucibus efficitur a ac magna.",
		["Morbi vestibulum malesuada condimentum. Quisque in interdum risus. Morbi ut justo sit amet neque egestas sollicitudin. Nam sagittis massa porttitor, tristique arcu at, maximus metus. Vestibulum sed pretium leo.", {"block1": "character_a"}],
		["Aenean fermentum convallis congue. Aenean et nisl a enim vestibulum consequat vel et metus.", {"block2": "character_b"}],
		"*end*"
	]
}

var states


func _ready():
	states = StatesLog.new(
		text_label,
		animation,
		{
			"block1": [$UI/Names/BlockName1, $UI/Actor1],
			"block2": [$UI/Names/BlockName2, $UI/Actor2]
		},
		characters
	)
	states.run(scenario, "example")


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		states.next()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "text":
		next_image.visible = true


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "text":
		next_image.visible = false
