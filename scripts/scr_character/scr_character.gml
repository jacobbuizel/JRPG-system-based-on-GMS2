///@param id
function chara_id(_id){
var c_name = "???";
var race_id = 0;
var sub_race_id = 0;
var class_id = -1;
var sub_class_id = 0;
var xp = 0;
var str = 10;
var dex = 10;
var con = 10;
var int = 10;
var wis = 10;
var cha = 10;
var spd = 30;
var alignment_id = 0;
var HD = 8;
var HDN = 1;
var CR = 1;
var MP = 2;
var descr = "???";
var art = 0;
var portrait = 0;
switch _id
{
	default:
		break;
	case 1:
		c_name = "罗琳";
		race_id = 13;
		sub_race_id = 1;
		class_id = 4;
		sub_class_id = 1;
		xp = 0;
		str = 16;
		dex = 16;
		con = 13;
		int = 9;
		wis = 11;
		cha = 12;
		spd = 3;
		alignment_id = 1;
		HD = 10;
		HDN = 1;
		CR = -1;
		MP = 5;
		descr = "性格外向的阳光少女。";
		art = spr_rowling_i;
		portrait = spr_e_player2;
		break;
	case 2:
		c_name = "丝诺";
		race_id = 13;
		sub_race_id = 1;
		class_id = 11;
		sub_class_id = 0;
		xp = 0;
		str = 9;
		dex = 15;
		con = 10;
		int = 16;
		wis = 15;
		cha = 14;
		spd = 3;
		alignment_id = 2;
		HD = 6;
		HDN = 1;
		CR = -1;
		MP = 5;
		descr = "性格内向的天才少女。";
		art = spr_snow_i;
		portrait = 0;
		break;
}
var race = "";
var sub_race = "";
switch race_id
{
	case 0:
		race = "怪物";
		break;
	case 1:
		race = "异怪";
		break;
	case 2:
		race = "野兽";
		break;
	case 3:
		race = "天界生物";
		break;
	case 4:
		race = "构装体";
		break;
	case 5:
		race = "龙类";
		break;
	case 6:
		race = "元素生物";
		break;
	case 7:
		race = "精类";
		break;
	case 8:
		race = "邪魔";
		break;
	case 9:
		race = "巨人";
		break;
	case 10:
		race = "泥怪";
		break;
	case 11:
		race = "植物";
		break;
	case 12:
		race = "亡灵";
		break;
	case 13:
		race = "类人生物";
		switch sub_race_id
		{
			case 1:
				sub_race = "人类";
				break;
			case 2:
				sub_race = "矮人";
				break;
			case 3:
				sub_race = "精灵";
				break;
			case 4:
				sub_race = "半身人";
				break;
			case 5:
				sub_race = "侏儒";
				break;
			case 6:
				sub_race = "半精灵";
				break;
			case 7:
				sub_race = "提夫林";
				break;
		}
		break;
}
var class_name = "";
var sub_class_name = "";
switch class_id
{
	case -1:
		class_name = "";
		break;
	case 0:
		class_name = "野蛮人";
		break;
	case 1:
		class_name = "吟游诗人";
		break;
	case 2:
		class_name = "牧师";
		break;
	case 3:
		class_name = "德鲁伊";
		break;
	case 4:
		class_name = "战士";
		switch sub_class_id
		{
			case 1:
				sub_class_name = "战斗大师";
				break;
		}
		break;
	case 5:
		class_name = "武僧";
		break;
	case 6:
		class_name = "圣武士";
		break;
	case 7:
		class_name = "游侠";
		break;
	case 8:
		class_name = "游荡者";
		break;
	case 9:
		class_name = "术士";
		break;
	case 10:
		class_name = "契术士";
		break;
	case 11:
		class_name = "法师";
		switch sub_class_id
		{
			case 0:
				sub_class_name = "防护师";
				break;
		}
		break;
	case 12:
		class_name = "奇械师";
		break;
}
var str_m = (str div 2)-5;
var dex_m = (dex div 2)-5;
var con_m = (con div 2)-5;
var int_m = (int div 2)-5;
var wis_m = (wis div 2)-5;
var cha_m = (cha div 2)-5;
var alignment = "";
switch alignment_id
{
	default:
		alignment = "无阵营";
		break;
	case 1:
		alignment = "守序善良";
		break;
	case 2:
		alignment = "中立善良";
		break;
	case 3:
		alignment = "混乱善良";
		break;
	case 4:
		alignment = "守序中立";
		break;
	case 5:
		alignment = "绝对中立";
		break;
	case 6:
		alignment = "混乱中立";
		break;
	case 7:
		alignment = "守序邪恶";
		break;
	case 8:
		alignment = "中立邪恶";
		break;
	case 9:
		alignment = "混乱邪恶";
		break;
}

// 定义经验值阈值数组
var xpThresholds = [300, 900, 2700, 6500, 14000, 23000, 34000, 48000, 64000, 85000, 100000, 120000, 140000, 165000, 195000, 225000, 265000, 305000, 355000];

// 初始化等级
var level = 1;

// 使用循环来确定等级
for (var i = 0; i < array_length(xpThresholds); i++) {
	if (xp >= xpThresholds[i]) {
		level = i + 2;  // 数组索引从0开始，因此加2
	}
	else
	{
		break;  // 如果xp小于当前阈值，跳出循环
	}
}

var PRO_B = 0;
if CR<0
{
	PRO_B=(level div 5)+2;
	HDN=level;
}
else
{
	PRO_B=(CR div 5)+2;
}

var AC = 10+dex_m;
var AC_C = AC;
var HP = HD+((HD div 2)+1)*(HDN-1)+con_m*(HDN);
var HP_C = HP;
// 定义一个数组来映射等级和MP
var mpMapping = [0, 2, 3, 5, 6, 8, 9, 12, 15, 16, 20, 24, 25, 30, 35, 36, 42, 48, 49, 56, 63];

// 检查等级是否在有效范围内
if (level >= 1 && level <= array_length(mpMapping) - 1) {
    MP = mpMapping[level];
} else {
    //处理无效等级的情况
    MP = 2; //或者其他默认值
}

var MP_C = MP;

var main_h = 0 //主手
var sec_h = 0 //副手
var armor = 0 //护甲
var accessoryA = 0 //配饰a
var accessoryB = 0 //配饰b
var accessoryC = 0 //配饰c

return {
		c_name			: c_name,
		race_id			: race_id,
		sub_race_id		: sub_race_id,
		class_id		: class_id,
		sub_class_id	: sub_class_id,
		xp				: xp,
		str				: str,
		dex				: dex,
		con				: con,
		int				: int,
		wis				: wis,
		cha				: cha,
		spd				: spd,
		alignment_id	: alignment_id,
		HD				: HD,
		HDN				: HDN,
		CR				: CR,
		MP				: MP,
		race			: race,
		sub_race		: sub_race,
		class_name		: class_name,
		sub_class_name	: sub_class_name,
		str_m			: str_m,
		dex_m			: dex_m,
		con_m			: con_m,
		int_m			: int_m,
		wis_m			: wis_m,
		cha_m			: cha_m,
		alignment		: alignment,
		level			: level,
		PRO_B			: PRO_B,
		AC				: AC,
		AC_C			: AC_C,
		HP				: HP,
		HP_C			: HP_C,
		MP_C			: MP_C,
		descr			: descr,
		art				: art,
		portrait		: portrait,
		main_h			: main_h,
		sec_h			: sec_h,
		armor			: armor,
		accessoryA		: accessoryA,
		accessoryB		: accessoryB,
		accessoryC		: accessoryC,
};
}

///@param id
function add_chara_id(_id) {
    var _chara = chara_id(_id);
	
    //如果表格有内容，就扩展一行
    if (ds_grid_get(chara_status, 0, 0) != 0)
	{
        ds_grid_resize(chara_status, chara_status_w, ds_grid_height(chara_status) + 1);
    }
    var new_row = ds_grid_height(chara_status) - 1;

    //把struct的字段写入grid
	ds_grid_set(chara_status, 0, new_row, _id);
    ds_grid_set(chara_status, 1, new_row, _chara);
	
    return true;
}

//加载角色数据
function load_chara(_id){
	//查找chara_status列表
	var _row = -1;
	for (var i=0;i<ds_grid_height(chara_status);i++)
	{
        if (ds_grid_get(chara_status, 0, i) == _id)
		{
            _row = i;
            break;
        }
    }
	if (_row == -1) return undefined;
	
	var _chara = ds_grid_get(chara_status, 1, _row);
	
	//修正运行时的数据（如当前HP、属性调整值的刷新等）
	_chara.str_m = (_chara.str div 2) - 5;
	_chara.dex_m = (_chara.dex div 2) - 5;
	_chara.con_m = (_chara.con div 2) - 5;
	_chara.int_m = (_chara.int div 2) - 5;
	_chara.wis_m = (_chara.wis div 2) - 5;
	_chara.cha_m = (_chara.cha div 2) - 5;
	_chara.PRO_B = (_chara.level div 5) + 2;
	_chara.HP_C = clamp(_chara.HP_C, 0, _chara.HP);
	_chara.MP_C = clamp(_chara.MP_C, 0, _chara.MP);
	return _chara;
}