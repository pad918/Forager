extends HBoxContainer

class_name CardContainer
var selected: UpgradeCard = null

func select_me(card: UpgradeCard):
	if(selected != null):
		printerr("SELECTED A SECOND CARD IS NOT ALLOWED!")
	else:
		card.perform_upgrade()
		selected = card
		for child:Control in get_children():
			if(child == card):
				continue
			child.self_modulate.r = 0.6
			child.self_modulate.g = 0.6
			child.self_modulate.b = 0.6
		# make all the other cards dark
		
