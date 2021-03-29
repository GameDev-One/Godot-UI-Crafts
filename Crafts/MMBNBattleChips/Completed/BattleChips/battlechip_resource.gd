extends Resource
class_name BattleChip

enum Element{
	AQUA,
	ELEC,
	FIRE,
	NORMAL,
	WOOD,
}

export(String) var name = ""
export(Element) var element = Element.NORMAL
export(int, 0, 1000, 10) var damage = 0
export(Texture) var full_image = null
export(Texture) var icon_image = null
export(String) var rank = ''
export(String, MULTILINE) var description = ""
