extends Button


# Text displayed for the title
export(String) var title_text: String = "Your Title Goes Here"

# Text displayed when the card is interacted with
export(String, MULTILINE) var content_text: String = "Lorem ipsum dolor sit."

# References to child nodes
onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Title: Label = $VBoxContainer/Title
onready var Content: RichTextLabel = $VBoxContainer/HBoxContainer/Contents


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready():
	pass


"""
# brief		Display the contents of the card when mouse hovers over.
"""
func _on_CardUI_mouse_entered():
	pass


"""
# brief		Display the title when mouse leaves the area of the card.
"""
func _on_CardUI_mouse_exited():
	pass
