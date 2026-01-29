//绘制属性值，通用
function draw_menu_chara_attr(_x,_y,_name,_base,_mod){
var _s = _name + ":" + string(_base);
if (_mod >= 0) _s += "(+" + string(_mod) + ")";
else		   _s += "("  + string(_mod) + ")";
draw_text(_x,_y,_s);
}

//绘制角色选项，通用
function draw_chara_block(_chara, _x, _y,_op_border){
//头像
if (_chara.portrait)
{
	draw_sprite_ext(_chara.portrait, 0, _x, _y, 0.25, 0.25, 0, c_white, 1);
}
else draw_rectangle_color(_x,_y,_x+128,_y+128,c_black,c_black,c_black,c_black,false);
//边框
draw_sprite_ext(spr_msge, image_index, _x, _y, 0.25, 0.25, 0, c_white, 1);
var _tx = _x + 128 + _op_border * 0.5;
var _ty = _y;

//文本信息
draw_text(_tx, _ty,string(_chara.c_name));
_ty += _op_border;
draw_text(_tx, _ty,
	"等级"+string(_chara.level)
	+" "+string(_chara.class_name)
	+":"+string(_chara.sub_class_name)
);
_ty += _op_border;
draw_text(_tx, _ty,"AC:"+string(_chara.AC));
_ty += _op_border;
draw_text(_tx, _ty,
	"HP:"+string(_chara.HP_C)+"/"+string(_chara.HP)
	+" MP:"+string(_chara.MP_C)+"/"+string(_chara.MP)
);
}

//obj_menu_equipment选项枚举
enum MENU_EQUIPMENT_SLOT
{
	UNEQUIP,
	SWITCH,
	DISCARD
}
enum MENU_EQUIPMENT_INTERFACE
{
	EQUIP,
	DISCARD
}

//绘制装备槽位，仅obj_menu_equipment使用
function draw_eq_slot(_x,_y,_label,_equip,_disabled){
draw_text(_x,_y,_label);

if (_disabled)
{
	draw_line_width(_x+op_border*2,_y+op_border/2-1,_x+op_border*7-8,_y+op_border/2-1,4);
	return;
}

if (_equip == 0)
	draw_text(_x+op_border*4,_y,"空");
else
	draw_text(_x+op_border*2,_y,_equip.e_name);
}

//绘制装备选项，仅obj_menu_equipment使用
function menu_eq_slot_op_string(_op){
switch (_op)
{
	case MENU_EQUIPMENT_SLOT.UNEQUIP: return "卸下";
	case MENU_EQUIPMENT_SLOT.SWITCH: return "切换";
	case MENU_EQUIPMENT_SLOT.DISCARD: return "丢弃";
}
return "???";
}
function menu_eq_interface_op_string(_op){
switch (_op)
{
	case MENU_EQUIPMENT_INTERFACE.EQUIP: return "着装";
	case MENU_EQUIPMENT_INTERFACE.DISCARD: return "丢弃";
}
return "???";
}

//绘制属性值差值版本，仅obj_menu_equipment使用
function draw_menu_chara_attr_preview(_x,_y,_name,_base,_mod,_delta){
//绘制名字
draw_set_color(c_white);
draw_text(_x,_y,_name + ":");

//计算最终属性值和修正值
var val = _base + (_delta != 0 ? _delta : 0);
var val_m = (val div 2) - 5;

//数值显示颜色
var col = c_white;
if (_delta > 0) col = c_lime;
else if (_delta < 0) col = c_red;

//绘制数值
var s = string(val) + "(" + (val_m >= 0 ? "+" : "") + string(val_m) + ")";
var x_val = _x + string_width(_name + ":") + 4;
draw_text_color(x_val,_y,s,col,col,col,col,1);
draw_set_color(c_white);
}
