globalvar chara_status, chara_status_w, skill_w;
skill_w = 3;
chara_status_w = 2;
chara_status = ds_grid_create(chara_status_w,1);

add_chara_id(1);
add_chara_id(2);

global.player[0] = 1;
global.player[1] = 2;

add_skill_id(1,load_chara(global.player[0]));
add_skill_id(1,load_chara(global.player[1]));

global.totalchara = array_length(global.player);

load = false;