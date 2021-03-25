extends Resource
class_name BattleChip

enum Element{
	ELEC,
	FIRE,
	NORMAL,
	WATER,
	WOOD,
}

export(String) var name = ""
export(Element) var element = Element.NORMAL
export(int, 0, 1000, 10) var damage = 0
export(Texture) var full_image = null
export(Texture) var icon_image = null
export(String, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
				'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 
				'Z') var rank = 'A'
