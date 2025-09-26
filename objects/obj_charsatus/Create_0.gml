globalvar chara_status, chara_status_w;
chara_status_w = 2;
chara_status = ds_grid_create(chara_status_w,1);

add_chara_id(0);
add_chara_id(1);
add_chara_id(2);

global.player1 = 1;
global.player2 = 2;

global.totalchara = 2;

load = false;