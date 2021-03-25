extends Resource
class_name BattlechipFolder

signal battlechips_changed(indexes)

export(Array, Resource) var battlechips = [
	null, null, null, null, null, 
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null
	]

func set_battlechip(index: int, battlechip: BattleChip) -> BattleChip:
	var previous_battlechip = battlechips[index]
	battlechips[index] = battlechip
	emit_signal("battlechips_changed", [index])
	return previous_battlechip

func remove_battlechip(index: int) -> BattleChip:
	var previous_battlechip = battlechips[index]
	battlechips[index] = null
	emit_signal("battlechips_changed", [index])
	return previous_battlechip
	
func swap_battlechips(index, target_index) -> void:
	var target_battlechip = battlechips[target_index]
	var battlechip = battlechips[index]
	battlechips[target_index] = battlechip
	battlechips[index] = target_battlechip
	emit_signal("battlechips_changed",[index, target_index])
