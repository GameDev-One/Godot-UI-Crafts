extends HBoxContainer


onready var folder: BattlechipFolder = preload("res://Crafts/MMBNBattleChips/Completed/BattlechipFolder/battlechip_folder.tres")
onready var battlechip_info = $BattleChipInfo
onready var battlechips: VBoxContainer = $VBoxContainer/List/Battlechips


func _ready():
	folder.connect("battlechips_changed", self, "_on_battlechips_changed")
	update_battlechip_folder_display()
	
	for battlechip_display in battlechips.get_children():
		battlechip_display.connect("selected", self, "update_battlechip_data_display")
		


func update_battlechip_folder_display():
	for battlechip_index in folder.battlechips.size():
		 update_battlechip_data_display(battlechip_index)


func update_battlechip_data_display(battlechip_index: int):
	var battlechip_display: Control = battlechips.get_child(battlechip_index)
	var battlechip_data: BattleChip = folder.battlechips[battlechip_index]
	battlechip_display.display_battlechip(battlechip_data)
	battlechip_info.display_battlechip(battlechip_data)


func _on_battlechips_changed(indexes: Array):
	for battlechip_index in indexes:
		update_battlechip_data_display(battlechip_index)
		


func _on_NameSort_pressed():
	folder.sort_by_name()
	update_battlechip_folder_display()


func _on_ElementSort_pressed():
	folder.sort_by_element()
	update_battlechip_folder_display()


func _on_CodeSort_pressed():
	folder.sort_by_rank()
	update_battlechip_folder_display()
