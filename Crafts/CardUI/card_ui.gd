extends Button


"""
# file        card_ui.gd
# author(s)   Devone Reynolds
# par         email: gamedevone1@gmail.com
# date        13 MAR 2021
# copyright   Copyright (c) 2021 GameDevone
# brief       Card displays title then will show contents thru sliding animation
			  when hovered over or interacted with.
"""


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
	Title.text = title_text
	Content.text = content_text


"""
# brief		Display the contents of the card when mouse hovers over.
"""
func _on_CardUI_mouse_entered():
	Anim.play("hover")


"""
# brief		Display the title when mouse leaves the area of the card.
"""
func _on_CardUI_mouse_exited():
	Anim.play_backwards("hover")
