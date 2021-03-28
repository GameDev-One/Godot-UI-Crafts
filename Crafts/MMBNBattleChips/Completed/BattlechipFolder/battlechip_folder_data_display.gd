extends Control

signal selected(index)

onready var icon: TextureRect = $Info/Icon
onready var title: Label = $Info/Title
onready var element: TextureRect = $Info/Element
onready var rank: Label = $Info/Rank

var index: int = -1

func display_battlechip(battlechip: BattleChip):
	set_element(battlechip.element)
	icon.texture = battlechip.icon_image
	title.text = battlechip.name
	rank.text = battlechip.rank

func set_element(element_type: int):
	match element_type:
		BattleChip.Element.ELEC:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/electric.png")
		BattleChip.Element.FIRE:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/fire.png")
		BattleChip.Element.NORMAL:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/normal.png")
		BattleChip.Element.AQUA:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/aqua.png")
		BattleChip.Element.WOOD:
			element.texture = load("res://Crafts/MMBNBattleChips/Assets/Elements/wood.png")
		

func _on_Battlechip_mouse_entered():
	$Selection.show()


func _on_Battlechip_mouse_exited():
	$Selection.hide()


func _on_Battlechip_focus_entered():
	$Selection.show()


func _on_Battlechip_focus_exited():
	$Selection.hide()


func _on_Battlechip_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("selected", get_index())
