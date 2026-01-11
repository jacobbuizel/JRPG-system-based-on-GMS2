//绘制属性值
function draw_menu_chara_attr(_x,_y,_name,_base,_mod)
{
    var _s = _name + ":" + string(_base);
    if (_mod >= 0) _s += "(+" + string(_mod) + ")";
    else           _s += "("  + string(_mod) + ")";
    draw_text(_x,_y,_s);
}