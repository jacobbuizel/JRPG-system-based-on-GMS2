/// @function string_wrap(_str, _max_width)
/// @param _str        要换行的字符串
/// @param _max_width  每行的最大像素宽度
/// @return 换好行的字符串（带\n）
function string_wrap(_str, _max_width)
{
    var _lines = string_split(_str, "\n"); // 先按手动换行切分
    var _result = "";

    // 遍历每一行，单独处理
    for (var l = 0; l < array_length(_lines); l++)
    {
        var _line = _lines[l];
        var _out_line = "";
        var _cur = "";

        var _last_space = -1;
        var _len = string_length(_line);

        for (var i = 1; i <= _len; i++)
        {
            var _ch = string_char_at(_line, i);
            _cur += _ch;

            // 记录最后的空格位置（用于英文断行）
            if (_ch == " ")
			{
                _last_space = string_length(_cur);
            }

            // 超过最大宽度
            if (string_width(_cur) > _max_width)
            {
                if (_last_space > 0)
				{
                    // 回溯到空格处换行（英文）
                    _out_line += string_copy(_cur, 1, _last_space - 1) + "\n";
                    _cur = string_delete(_cur, 1, _last_space);
                    _last_space = -1;
                }
				else
				{
                    // 中文/日文/韩文，直接在当前字前换行
                    _out_line += string_copy(_cur, 1, string_length(_cur) - 1) + "\n";
                    _cur = _ch;
                }
            }
        }

        _out_line += _cur;

        // 把这一行结果加到总结果里
        _result += _out_line;

        // 如果不是最后一段，加上手动换行
        if (l < array_length(_lines) - 1) {
            _result += "\n";
        }
    }

    return _result;
}
