extends Button

onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Title: Label = $VBoxContainer/Title
onready var Content: RichTextLabel = $VBoxContainer/HBoxContainer/Contents

export(String) var title_text: String = "Your Title Goes Here"
export(String, MULTILINE) var content_text: String = "Lorem ipsum dolor sit amet"

func _ready():
	Title.text = title_text
	Content.text = content_text


func _on_CardUI_mouse_entered():
	Anim.play("hover")


func _on_CardUI_mouse_exited():
	Anim.play_backwards("hover")
