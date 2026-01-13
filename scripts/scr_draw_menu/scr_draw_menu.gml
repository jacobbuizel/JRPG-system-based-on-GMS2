//绘制属性值，通用
function draw_menu_chara_attr(_x,_y,_name,_base,_mod)
{
    var _s = _name + ":" + string(_base);
    if (_mod >= 0) _s += "(+" + string(_mod) + ")";
    else           _s += "("  + string(_mod) + ")";
    draw_text(_x,_y,_s);
}

//绘制装备槽位，仅obj_menu_equipment使用
function draw_eq_slot(_x,_y,_label,_equip,_disabled)
{
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
function menu_eq_slot_op_string(_op)
{
    switch (_op)
    {
        case MENU_EQUIPMENT_SLOT.UNEQUIP: return "卸下";
        case MENU_EQUIPMENT_SLOT.SWITCH: return "切换";
        case MENU_EQUIPMENT_SLOT.DISCARD: return "丢弃";
    }
    return "???";
}
function menu_eq_interface_op_string(_op)
{
    switch (_op)
    {
        case MENU_EQUIPMENT_INTERFACE.EQUIP: return "着装";
        case MENU_EQUIPMENT_INTERFACE.DISCARD: return "丢弃";
    }
    return "???";
}