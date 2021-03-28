extends Control


onready var title: Label = $Title
onready var element: TextureRect = $Element
onready var rank: Label = $Rank
onready var damage: Label = $Damage
onready var image: TextureRect = $Image

func display_battlechip(battlechip: BattleChip):
	title.text = battlechip.name
	rank.text = battlechip.rank
	damage.text = str(battlechip.damage)
	image.texture = battlechip.full_image
	set_element(battlechip.element)
	

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
