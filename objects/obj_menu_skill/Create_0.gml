depth = -1001;

//高和宽
width = 1168;
height = 700;

//上边框和字符上下间距
op_border = 32;
op_space = 32;

//角色选框
pos = 0;

//菜单动画
menu_anm = 800;
menu_cloes = false;

global.pause = true;
global.sub_menu = 1;

op_length = 2;
menu_level = 0;

//列表模式: 0 = 技能, 1 = 法术书
skill_tab = 0;

//技能列表状态
skill_pos = 0;
skill_scroll_a = 0;
skillEND = 0;
wait_time = 30;
skill_empty = false;

//技能确认菜单
op_skill_option = ["施展", "取消"];
op_skill_length = array_length(op_skill_option);
pos_skill = 0;

//获取当前角色的技能列表
var _chara = load_chara(global.player[menu_level]);
var _grid = _chara.skill_list;
if (ds_grid_get(_grid, 0, 0) != 0)
{
	skillEND = min(ds_grid_height(_grid), 10);
	skill_empty = false;
}
else
{
	skillEND = 0;
	skill_empty = true;
}