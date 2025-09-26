/*
此代码已废弃，被scr_charater取代
function create_character(_c_name,_race_id,_class_id,_sub_class_id,_xp,_str,_dex,_con,_int,_wis,_cha,_spd,_alignment_id,_HD) constructor{
c_name = _c_name;
race_id = _race_id;
race = "";
class_id = _class_id;
class_name = "";
sub_class_id = _sub_class_id;
sub_class_name = "";
xp = _xp;
str = _str;
dex = _dex;
con = _con;
int = _int;
wis = _wis;
cha = _cha;
spd = _spd;
str_m = 0;
dex_m = 0;
con_m = 0;
int_m = 0;
wis_m = 0;
cha_m = 0;
alignment_id = _alignment_id;
alignment = "无阵营";
HD = _HD
HDN = 1;
level = 1;
PRO_B = 2;
AC = 10;
HP = 1;
HP_C = 1;
spells_1 = 0;
spells_2 = 0;
spells_3 = 0;
spells_4 = 0;
spells_5 = 0;
spells_6 = 0;
spells_7 = 0;
spells_8 = 0;
spells_9 = 0;
spells_1_C = 0;
spells_2_C = 0;
spells_3_C = 0;
spells_4_C = 0;
spells_5_C = 0;
spells_6_C = 0;
spells_7_C = 0;
spells_8_C = 0;
spells_9_C = 0;
}

function character_status(_chara){
_chara.level = 1;
if _chara.xp>=300{_chara.level = 2;}
if _chara.xp>=900{_chara.level = 3;}
if _chara.xp>=2700{_chara.level = 4;}
if _chara.xp>=6500{_chara.level = 5;}
if _chara.xp>=14000{_chara.level = 6;}
if _chara.xp>=23000{_chara.level = 7;}
if _chara.xp>=34000{_chara.level = 8;}
if _chara.xp>=48000{_chara.level = 9;}
if _chara.xp>=64000{_chara.level = 10;}
if _chara.xp>=85000{_chara.level = 11;}
if _chara.xp>=100000{_chara.level = 12;}
if _chara.xp>=120000{_chara.level = 13;}
if _chara.xp>=140000{_chara.level = 14;}
if _chara.xp>=165000{_chara.level = 15;}
if _chara.xp>=195000{_chara.level = 16;}
if _chara.xp>=225000{_chara.level = 17;}
if _chara.xp>=265000{_chara.level = 18;}
if _chara.xp>=305000{_chara.level = 19;}
if _chara.xp>=355000{_chara.level = 20;}

_chara.PRO_B=(_chara.level div 5)+2;
_chara.HDN=_chara.level;

_chara.str_m = (_chara.str div 2)-5;
_chara.dex_m = (_chara.dex div 2)-5;
_chara.con_m = (_chara.con div 2)-5;
_chara.int_m = (_chara.int div 2)-5;
_chara.wis_m = (_chara.wis div 2)-5;
_chara.cha_m = (_chara.cha div 2)-5;

_chara.AC = 10+_chara.dex_m;
_chara.HP = _chara.HD+((_chara.HD/2)+1)*(_chara.HDN-1)+_chara.con_m*(_chara.HDN);

switch _chara.race_id
{
	case 0:
		_chara.race = "怪物";
		break;
	case 1:
		_chara.race = "异怪";
		break;
	case 2:
		_chara.race = "野兽";
		break;
	case 3:
		_chara.race = "天界生物";
		break;
	case 4:
		_chara.race = "构装体";
		break;
	case 5:
		_chara.race = "龙类";
		break;
	case 6:
		_chara.race = "元素生物";
		break;
	case 7:
		_chara.race = "精类";
		break;
	case 8:
		_chara.race = "邪魔";
		break;
	case 9:
		_chara.race = "巨人";
		break;
	case 10:
		_chara.race = "泥怪";
		break;
	case 11:
		_chara.race = "植物";
		break;
	case 12:
		_chara.race = "亡灵";
		break;
	case 13:
		_chara.race = "类人生物";
		switch _chara.sub_race_id
		{
			case 1:
				_chara.race = "人类"
				break;
			case 2:
				_chara.race = "矮人";
				break;
			case 3:
				_chara.race = "精灵";
				break;
			case 4:
				_chara.race = "半身人";
				break;
			case 5:
				_chara.race = "侏儒";
				break;
			case 6:
				_chara.race = "半精灵";
				break;
			case 7:
				_chara.race = "提夫林";
				break;
		}
		break;
}

switch _chara.alignment_id
{
	case 0:
		_chara.alignment = "无阵营";
		break;
	case 1:
		_chara.alignment = "守序善良";
		break;
	case 2:
		_chara.alignment = "中立善良";
		break;
	case 3:
		_chara.alignment = "混乱善良";
		break;
	case 4:
		_chara.alignment = "守序中立";
		break;
	case 5:
		_chara.alignment = "绝对中立";
		break;
	case 6:
		_chara.alignment = "混乱中立";
		break;
	case 7:
		_chara.alignment = "守序邪恶";
		break;
	case 8:
		_chara.alignment = "中立邪恶";
		break;
	case 9:
		_chara.alignment = "混乱邪恶";
		break;
}

switch _chara.class_id
{
	case -1:
		_chara.class_name = "";
		break;
	case 0:
		_chara.class_name = "野蛮人";
		break;
	case 1:
		_chara.class_name = "吟游诗人";
		break;
	case 2:
		_chara.class_name = "牧师";
		break;
	case 3:
		_chara.class_name = "德鲁伊";
		break;
	case 4:
		_chara.class_name = "战士";
		switch _chara.sub_class_id
		{
			case 1:
				_chara.sub_class_name = "战斗大师";
				break;
		}
		break;
	case 5:
		_chara.class_name = "武僧";
		break;
	case 6:
		_chara.class_name = "圣武士";
		break;
	case 7:
		_chara.class_name = "游侠";
		break;
	case 8:
		_chara.class_name = "游荡者";
		break;
	case 9:
		_chara.class_name = "术士";
		break;
	case 10:
		_chara.class_name = "契术士";
		break;
	case 11:
		_chara.class_name = "法师";
		switch _chara.sub_class_id
		{
			case 0:
				_chara.sub_class_name = "防护师";
				break;
		}
		break;
	case 12:
		_chara.class_name = "奇械师";
		break;
}

if _chara.class_id == 11
{
	_chara.spells_1 = 2;
	_chara.spells_2 = 0;
	_chara.spells_3 = 0;
	_chara.spells_4 = 0;
	_chara.spells_5 = 0;
	_chara.spells_6 = 0;
	_chara.spells_7 = 0;
	_chara.spells_8 = 0;
	_chara.spells_9 = 0;
	if _chara.level>1{_chara.spells_1++;}
	if _chara.level>2{_chara.spells_1++;_chara.spells_2=2;}
	if _chara.level>3{_chara.spells_2++;}
	if _chara.level>4{_chara.spells_3=2;}
	if _chara.level>5{_chara.spells_3++;}
	if _chara.level>6{_chara.spells_4=1;}
	if _chara.level>7{_chara.spells_4++;}
	if _chara.level>8{_chara.spells_4++;_chara.spells_5=1;}
	if _chara.level>9{_chara.spells_5++;}
	if _chara.level>10{_chara.spells_6=1;}
	if _chara.level>12{_chara.spells_7=1;}
	if _chara.level>14{_chara.spells_8=1;}
	if _chara.level>16{_chara.spells_9=1;}
	if _chara.level>17{_chara.spells_5++;}
	if _chara.level>18{_chara.spells_6++;}
	if _chara.level>19{_chara.spells_7++;}
}
}

function character_set_up(_chara){
_chara.HP_C = _chara.HP;
_chara.spells_1_C = _chara.spells_1;
_chara.spells_2_C = _chara.spells_2;
_chara.spells_3_C = _chara.spells_3;
_chara.spells_4_C = _chara.spells_4;
_chara.spells_5_C = _chara.spells_5;
_chara.spells_6_C = _chara.spells_6;
_chara.spells_7_C = _chara.spells_7;
_chara.spells_8_C = _chara.spells_8;
_chara.spells_9_C = _chara.spells_9;
}