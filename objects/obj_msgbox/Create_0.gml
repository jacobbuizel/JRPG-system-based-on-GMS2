depth = -1005;

border = 32;

msg_w = display_get_gui_width();
msg_h = display_get_gui_height()-border*2-512;
msgb_spr = spr_msgbox;
msgb_img = 0;

line_sep = 32;
line_w = msg_w - border * 2;

page = 0;
page_number = 0;
msg[0] = "...";
msg_l[0] = string_length(msg[0]);
draw_char = 0;

option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_num = 0;
op_space = 32;
wait_time = 120;

wait_akey = 2;

msg_name[0] = noone;

msg_portrait[0] = noone;

msg_scr = 0;

setup = false;
global.talking = true;