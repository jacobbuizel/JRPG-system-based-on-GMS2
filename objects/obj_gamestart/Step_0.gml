//设置全局变量
if !global.gamestart
{
	global.gamestart = true;
	
	if !global.gameload
	{
		instance_create_layer(0,0,"Instances",obj_charsatus);
		instance_create_layer(0,0,"Instances",obj_item_manager);
		instance_create_layer(0,0,"Instances",obj_allways);
		instance_create_layer(playerX,playerY,"Instances",obj_player);
		instance_create_layer(partnerX,partnerY,"Instances",obj_partner);
	}
	else
	{
		with(instance_create_layer(0,0,"Instances",obj_charsatus))
		{
			load = true;
		}
		with(instance_create_layer(0,0,"Instances",obj_item_manager))
		{
			load = true;
		}
		instance_create_layer(0,0,"Instances",obj_allways)
		instance_create_layer(global.saveDATA.playerSX,global.saveDATA.playerSY,"Instances",obj_player);
		instance_create_layer(global.saveDATA.partnerSX,global.saveDATA.partnerSY,"Instances",obj_partner);
	}
}
instance_destroy();