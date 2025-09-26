/// @@arg {Any} msg
/// @arg {Any} scr*
/// @arg {Any} name*
/// @arg {Any} portrait*
/// @arg {Any} expression*
function create_msg(_msg){
msg[page_number] = _msg;
if argument_count > 1
{
	msg_scr[page_number] = argument[1];
}
else msg_scr[page_number] = noone;
if argument_count > 2
{
	msg_name[page_number] = argument[2];
}
else msg_name[page_number] = noone;
if argument_count > 3
{
	msg_portrait[page_number] = argument[3];
}
else msg_portrait[page_number] = noone;
if argument_count > 4
{
	msg_portrait_expre[page_number] = argument[4];
}
else msg_portrait_expre[page_number] = 0;

page_number++;
}

/// @param option
/// @param link_id
function msg_option(_option,_link_id){
	option[option_num] = _option;
	option_link_id[option_num] = _link_id;
	option_num++;
}

/// @param msg_id
function create_msg_box(_msg_id){
with(instance_create_layer(x,y,"Instances",obj_msgbox))
{
	scr_msg_game(_msg_id);
}
}