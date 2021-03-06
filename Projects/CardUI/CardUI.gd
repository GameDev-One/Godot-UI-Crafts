extends Button

onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Title: Label = $VBoxContainer/Title
onready var Content: RichTextLabel = $VBoxContainer/HBoxContainer/Contents

export(String) var TitleText: String = "Your Title Goes Here"
export(String, MULTILINE) var ContentText: String = "Lorem ipsum dolor sit amet"

func _ready():
	Title.text = TitleText
	Content.text = ContentText


func _on_CardUI_mouse_entered():
	Anim.play("hover")


func _on_CardUI_mouse_exited():
	Anim.play_backwards("hover")
