depth = -1000;
global.pause = true;
global.battle = true;

// 战斗棋盘的屏幕参数。x 方向远窄近宽，y 方向远矮近高。
grid_top_y = 170;
grid_far_cell_h = 70;
grid_near_cell_h = 120;
grid_top_left = 360;
grid_top_right = 1240;
grid_bottom_left = 120;
grid_bottom_right = 1480;

// 战斗日志/UI 框位置，使用 spr_msgbox 绘制。
log_x = 16;
log_y = 596;
log_w = 1568;
log_h = 288;

// size=1 的单位目标绘制宽度；size=2/3 会按这个宽度倍增。
unit_base_draw_w = 96;
