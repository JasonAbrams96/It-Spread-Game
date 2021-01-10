extends Area

func add_to_inventory_and_kill_this(inventory, name_of_item: String):
	if(check_inventory(inventory, name_of_item)):
		inventory.append(name_of_item)
		self.queue_free()
		return true
	else:
		print("item already in Inventory")
		return false
	
func check_inventory(inventory, item):
	for i in inventory:
		if i == item:
			return false
	return true
