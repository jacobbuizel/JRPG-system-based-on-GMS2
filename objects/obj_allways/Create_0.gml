//寻路格子设置
global.grid_solid = mp_grid_create(0,0,room_width / 32,room_height / 32,32,32);
global.grid_h_npc_solid = mp_grid_create(0,0,room_width / 32,room_height / 32,32,32);

//寻路格子添加
mp_grid_add_instances(global.grid_solid,obj_solid,false);

dice_r = 0;

roomgoto = false;

//时间计算
gamens = 0;
times = 0;

loding = false;