extends TextureButton

class_name UpgradeCard

func buy_card():
	var par: CardContainer = get_parent()
	par.select_me(self)

func perform_upgrade():
	pass
