lstx = gamepad_axis_value(0, gp_axislh);
lsty = gamepad_axis_value(0, gp_axislv);

lkey = keyboard_check(vk_left) || gamepad_button_check(0, gp_padl);
rkey = keyboard_check(vk_right) || gamepad_button_check(0, gp_padr);
ukey = keyboard_check(vk_up) || gamepad_button_check(0, gp_padu);
dkey = keyboard_check(vk_down) || gamepad_button_check(0, gp_padd);

lpkey = keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl);
rpkey = keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr);
upkey = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu);
dpkey = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd);

if abs(lstx) >= 0.9
{
	if lstx < 0
	{
		lkey = 1;
	}
	else
	{
		rkey = 1;
	}
}
if abs(lsty) >= 0.9
{
	if lsty < 0
	{
		ukey = 1;
	}
	else
	{
		dkey = 1;
	}
}

if (!stick_moved && (abs(lstx) >= 0.9 || abs(lsty) >= 0.9))
{   
	if abs(lstx) >= 0.9
	{
		if lstx < 0
		{
			lpkey = 1;
		}
		else
		{
			rpkey = 1;
		}
	}
	if abs(lsty) >= 0.9
	{
		if lsty < 0
		{
			upkey = 1;
		}
		else
		{
			dpkey = 1;
		}
	}
	stick_moved = true;
}
if (abs(lstx) <= 0.2 && abs(lsty) <= 0.2)
{
	stick_moved = false;
}

lrkey = keyboard_check_released(vk_left) || gamepad_button_check_released(0, gp_padl);
rrkey = keyboard_check_released(vk_right) || gamepad_button_check_released(0, gp_padr);
urkey = keyboard_check_released(vk_up) || gamepad_button_check_released(0, gp_padu);
drkey = keyboard_check_released(vk_down) || gamepad_button_check_released(0, gp_padd);

akey = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
bkey = keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face2);
xkey = keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(0, gp_face3);
ykey = keyboard_check_pressed(ord("V")) || gamepad_button_check_pressed(0, gp_face4);
esckey = keyboard_check_pressed(vk_escape);
f1key = keyboard_check_pressed(vk_f1);
f2key = keyboard_check_pressed(vk_f2);
f3key = keyboard_check_pressed(vk_f3);
f4key = keyboard_check_pressed(vk_f4);
f5key = keyboard_check_pressed(vk_f5);
f6key = keyboard_check_pressed(vk_f6);
f12key = keyboard_check_pressed(vk_f12);

ackey = keyboard_check(ord("Z")) || gamepad_button_check(0, gp_face1);
bckey = keyboard_check(ord("X")) || gamepad_button_check(0, gp_face2);
xckey = keyboard_check(ord("C")) || gamepad_button_check(0, gp_face3);
yckey = keyboard_check(ord("V")) || gamepad_button_check(0, gp_face4);
escckey = keyboard_check(vk_escape);
f5ckey = keyboard_check(vk_f5);
shfckey = keyboard_check(vk_shift);

for(var _i = 0;_i < array_length(key_cooldown);_i++)
{
	key_cooldown[_i]--;
	key_cooldown[_i] = max(0,key_cooldown[_i]);
}