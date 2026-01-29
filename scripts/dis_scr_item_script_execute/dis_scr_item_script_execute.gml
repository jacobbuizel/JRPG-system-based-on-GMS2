/*已经弃用
/// scr_item_script_execute(_scr)
/// _scr 函数名
function scr_item_script_execute(_scr) {
	//解析函数和参数
	var _func = undefined;
	var _args_array = [];

	if (is_array(_scr))
	{
		var _len_all = array_length(_scr);
		if (_len_all < 1)
		{
			show_debug_message("scr_item_script_execute: 空数组 _scr");
			return undefined;
		}
		_func = _scr[0];
		if (_len_all > 1)
		{
			_args_array = array_create(_len_all - 1);
			for (var i = 1; i < _len_all; i++)
			{
				_args_array[i - 1] = _scr[i];
			}
		}
	}
	else
	{
		//可能是字符串脚本名或脚本索引
		_func = _scr;
		_args_array = [];
	}

	// --- 把字符串脚本名转换为索引（如果需要） ---
	var _fn_index = _func;
	if (is_string(_func))
	{
		_fn_index = asset_get_index(_func);
		if (_fn_index == -1)
		{
			show_debug_message("scr_item_script_execute: 未找到脚本 '" + string(_func) + "'");
			return undefined;
		}
	}
	*/
	// 确保现在 _fn_index 是数字
	/*if (!is_real(_fn_index)) //这段代码目前弃用了，理由是新Runtime中asset_get_index()返回的不是Number或者String了。
	{
        show_debug_message("scr_item_script_execute: 无效的脚本标识，类型不是 Number 或 String");
        return undefined;
    }*/
	/*
	// --- 根据参数数量调用 script_execute（支持 0..10 个参数） ---
	var n = array_length(_args_array);
	switch (n) {
		case 0: return script_execute(_fn_index);
		case 1: return script_execute(_fn_index, _args_array[0]);
		case 2: return script_execute(_fn_index, _args_array[0], _args_array[1]);
		case 3: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2]);
		case 4: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3]);
		case 5: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4]);
		case 6: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4], _args_array[5]);
		case 7: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4], _args_array[5], _args_array[6]);
		case 8: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4], _args_array[5], _args_array[6], _args_array[7]);
		case 9: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4], _args_array[5], _args_array[6], _args_array[7], _args_array[8]);
		case 10: return script_execute(_fn_index, _args_array[0], _args_array[1], _args_array[2], _args_array[3], _args_array[4], _args_array[5], _args_array[6], _args_array[7], _args_array[8], _args_array[9]);
		default:
			show_debug_message("scr_item_script_execute: 参数太多 (" + string(n) + ")");
			return undefined;
	}
}
*/