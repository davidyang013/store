//建立一个弹出窗口
var popPage = window.createPopup();
document
		.write("<DIV onkeydown=\"onkey_down()\" id=idCalendar style='position:absolute;top:100px;left:100px;width:300px;border: #000000 1px solid;background-color: #ffffff;display:none;'></DIV>");

/* 基本参数 */
var InputBox; // 要输入日期的文本对象
var Now_Year; // 当前日期(年)
var Now_Month; // 当前日期(月)
var Now_Day; // 当前日期(天)

/* 初始化日历 */
function initCalendar(_year, _month, _day) {
	str = "";
	Now_Year = (_year == null ? 2004 : _year);
	Now_Month = (_month == null ? 1 : _month);
	Now_Day = (_day == null ? 1 : _day);

	var fw = GetFirstWeek(Now_Year, Now_Month);
	var ld = GetLastDays(Now_Year, Now_Month);
	var td = GetThisDays(Now_Year, Now_Month);
	var isnd = false; // 是否是下个月的日期
	var d = 1;
	var w = 1;

	// 显示日历内容
	str += "<table cellpadding=0 cellspacing=0 width=100% height=20 bgcolor=#CED8F7 style='font-size:14px' style='border: 1px solid #84A2CE outset;border-bottom: 0px solid #84A2CE;'>"
			+ " <tr align=center height='20'>"
			+ "     <td width=12% onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.subYear()'><a title='减小年份' style='cursor:hand;'> << </a></td>"
			+ "     <td width=12% onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.subMonth()'><a title='减小月份' style='cursor:hand;'> < </a></td>"
			+ "     <td width=52%><b>"
			+ Now_Year
			+ "年"
			+ Now_Month
			+ "月"
			+ "</b></td>"
			+ "     <td width=12% onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.addMonth()'><a title='增加月份' style='cursor:hand;'> > </a></td>"
			+ "     <td width=12% onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.addYear()'><a title='增加年份' style='cursor:hand;'> >> </a></td>"
			+ " </tr>"
			+ " </table>"

			+ " <table cellpadding=0 cellspacing=0 border='1' width=100% bgcolor=#EEEEEE bordercolor='#FFFFFF' bordercolorlight='silver' style='font-size:12px' style='border-left: 1px solid #84A2CE outset;border-right: 1px solid #84A2CE outset;'>"
			+ " <tr align=center bgcolor='#EDEBF7'>"
			+ "     <td><center><font color='#FF0000'>星期日</font></center></td>"
			+ "     <td><center>星期一</center></td>"
			+ "     <td><center>星期二</center></td>"
			+ "     <td><center>星期三</center></td>"
			+ "     <td><center>星期四</center></td>"
			+ "     <td><center>星期五</center></td>"
			+ "     <td><center><font color='#FF0000'>星期六</font></center></td>"
			+ " </tr>";

	// 如果本月第一天是星期一或星期天.应加上七.保证可以看到上个月的日期

	if (fw < 1)
		tf = fw + 7;
	else
		tf = fw;

	str += "<tr bgcolor='#FFFFFF'>";
	// 第一行上月日期
	for ( var l = (ld - tf + 1); l <= ld; l++) {
		str += "<td onClick=\"parent.SetChooseDate(" + Now_Year + ","
				+ Now_Month + "," + l
				+ ", -1);\" style='cursor:hand'><center><font color='#BBBBBB'>"
				+ l + "</font></center></td>";
		w++;
	}

	// 第一行本月日期
	for ( var f = tf; f <= 6; f++) {
		// 星期六,天但非输入日期
		if (((w % 7) == 0) && (d != Now_Day))
			str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
					+ "onClick=\"parent.SetChooseDate("
					+ Now_Year
					+ ","
					+ Now_Month
					+ ","
					+ d
					+ ", 0);\" style='cursor:hand'><center>"
					+ "<font color='#FF0000'>" + d + "</font></center></td>";
		else if ((((w - 1) % 7) == 0) && (d != Now_Day))
			str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
					+ "onClick=\"parent.SetChooseDate("
					+ Now_Year
					+ ","
					+ Now_Month
					+ ","
					+ d
					+ ", 0);\" style='cursor:hand'><center>"
					+ "<font color='#FF0000'>" + d + "</font></center></td>";
		// 日期为输入日期
		else if (d == Now_Day)
			str += "<td style=\"background:#8CB6FF;cursor:hand\" onClick=\"parent.SetChooseDate("
					+ Now_Year
					+ ","
					+ Now_Month
					+ ","
					+ d
					+ ", 0);\"><center>"
					+ d + "</center></td>";
		// 其它
		else
			str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
					+ "onClick=\"parent.SetChooseDate("
					+ Now_Year
					+ ","
					+ Now_Month
					+ ","
					+ d
					+ ", 0);\" style='cursor:hand'><center>"
					+ d
					+ "</center></td>";

		d++;
		w++;
	}
	str += "</tr>";
	w = 1;

	for ( var i = 2; i < 7; i++) {
		str += "<tr bgcolor='#FFFFFF'>";
		for ( var j = 1; j < 8; j++) {
			if (isnd) // 下个月的日期
				str += "<td onClick=\"parent.SetChooseDate("
						+ Now_Year
						+ ","
						+ Now_Month
						+ ","
						+ d
						+ ", 1);\" style='cursor:hand'><center><font color='#BBBBBB'>"
						+ d + "</font></center></td>";
			else // 本月的日期
			{
				// 星期六,天但非输入日期
				if (((w % 7) == 0) && (d != Now_Day))
					str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
							+ "onClick=\"parent.SetChooseDate("
							+ Now_Year
							+ ","
							+ Now_Month
							+ ","
							+ d
							+ ", 0);\" style='cursor:hand'><center>"
							+ "<font color='#FF0000'>"
							+ d
							+ "</font></center></td>";
				else if ((((w - 1) % 7) == 0) && (d != Now_Day))
					str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
							+ "onClick=\"parent.SetChooseDate("
							+ Now_Year
							+ ","
							+ Now_Month
							+ ","
							+ d
							+ ", 0);\" style='cursor:hand'><center>"
							+ "<font color='#FF0000'>"
							+ d
							+ "</font></center></td>";
				// 日期为输入日期
				else if (d == Now_Day)
					str += "<td style=\"background:#8CB6FF;cursor:hand\" onClick=\"parent.SetChooseDate("
							+ Now_Year
							+ ","
							+ Now_Month
							+ ","
							+ d
							+ ", 0);\"><center>" + d + "</center></td>";
				// 其它
				else
					str += "<td onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#FFFFFF\'\" "
							+ "onClick=\"parent.SetChooseDate("
							+ Now_Year
							+ ","
							+ Now_Month
							+ ","
							+ d
							+ ", 0);\" style='cursor:hand'><center>"
							+ d
							+ "</center></td>";
			}
			// 判断是否为本月的日期
			if (d == td) {
				isnd = true;
				d = 0;
			}
			w++;
			d++;
		}
		str += "</tr>";
	}
	str += "</table>"
			+ "<table cellpadding=0 cellspacing=0 width=100% height=20 bgcolor=#CED8F7 style='font-size:13px' style='font-size:14px' style='border: 1px solid #84A2CE outset;border-top: 0px solid #84A2CE;'>"
			+ " <tr height='18'>"
			+ "     <td width=130 nowrap onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.SetTodayDate()'>"
			+ "         <a title='今日:"
			+ GetTodayDate()
			+ "' style='cursor:hand;'>&nbsp;"
			+ "         <font color='#FF0000'>今日:</font>"
			+ GetTodayDate()
			+ "</a></td>"
			+ "     <td width='50' align=center onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.clear_all()'><a title='清空' style='cursor:hand;'> [清空]</td>"
			+ "     <td width=30%>&nbsp;</td>"
			+ "     <td width=30 align=center onMouseOver=\"this.style.background=\'#7F98DD\'\" onMouseOut=\"this.style.background=\'#CED8F7\'\" onclick='parent.popPage.hide();'><a title='关闭' style='cursor:hand;'> × </a></td>"
			+ " </tr>" + " </table>";
	return str;
}

/* 取某年某月第一天的星期值(月份-1) */
function GetFirstWeek(The_Year, The_Month) {
	return (new Date(The_Year, The_Month - 1, 1)).getDay();
}
/* 取某年某月中总天数 */
function GetThisDays(The_Year, The_Month) {
	return (new Date(The_Year, The_Month, 0)).getDate();
}
/* 取某年某月上个月中总天数 */
function GetLastDays(The_Year, The_Month) {
	return (new Date(The_Year, The_Month - 1, 0)).getDate();
}

/* 判断是否是闰年 */
function RunNian(The_Year) {
	if ((The_Year % 400 == 0) || ((The_Year % 4 == 0) && (The_Year % 100 != 0)))
		return true;
	else
		return false;
}

/* 判断日期(YYYY-MM-DD)的日期是否正确 */
function DateIsTrue(asDate) {
	var lsDate = asDate + "";
	var loDate = lsDate.split("-");

	if (loDate.length != 3)
		return false;

	var liYear = parseFloat(loDate[0]);
	var liMonth = parseFloat(loDate[1]);
	var liDay = parseFloat(loDate[2]);

	if ((loDate[0].length > 4) || (loDate[1].length > 2)
			|| (loDate[2].length > 2))
		return false;

	if (isNaN(liYear) || isNaN(liMonth) || isNaN(liDay))
		return false;

	if ((liYear < 1800) || (liYear > 2500))
		return false;

	if ((liMonth > 12) || (liMonth <= 0))
		return false;

	if (GetThisDays(liYear, liMonth) < liDay)
		return false;

	return !isNaN(Date.UTC(liYear, liMonth, liDay));
}

/* 取某年某月的周值 */
function GetCountWeeks(The_Year, The_Month) {
	var Allday;
	Allday = 0;
	if (The_Year > 2000) {

		for ( var i = 2000; i < The_Year; i++)
			if (RunNian(i))
				Allday += 366;
			else
				Allday += 365;

		for ( var i = 2; i <= The_Month; i++) {
			switch (i) {
			case 2:
				if (RunNian(The_Year))
					Allday += 29;
				else
					Allday += 28;
				break;
			case 3:
				Allday += 31;
				break;
			case 4:
				Allday += 30;
				break;
			case 5:
				Allday += 31;
				break;
			case 6:
				Allday += 30;
				break;
			case 7:
				Allday += 31;
				break;
			case 8:
				Allday += 31;
				break;
			case 9:
				Allday += 30;
				break;
			case 10:
				Allday += 31;
				break;
			case 11:
				Allday += 30;
				break;
			case 12:
				Allday += 31;
				break;
			}
		}
	}
	return (Allday + 6) % 7;
}

function subYear() // 减小年份
{
	popPage.document.body.innerHTML = initCalendar(parseInt(Now_Year) - 1,
			Now_Month, Now_Day);
}

function subMonth() // 减小年份
{
	Now_Month = parseInt(Now_Month) - 1;

	if (Now_Month == 0) {
		Now_Month = 12;
		subYear();
	} else
		popPage.document.body.innerHTML = initCalendar(Now_Year, Now_Month,
				Now_Day);
}

function addYear() // 减小年份
{
	popPage.document.body.innerHTML = initCalendar(parseInt(Now_Year) + 1,
			Now_Month, Now_Day);
}

function addMonth() // 减小年份
{
	Now_Month = parseInt(Now_Month) + 1;

	if (Now_Month == 13) {
		Now_Month = 1;
		addYear();
	} else
		popPage.document.body.innerHTML = initCalendar(Now_Year, Now_Month,
				Now_Day);
}

/* 取得今日日期 */
function GetTodayDate() {
	var today = new Date();
	var y = today.getYear();
	var m = (today.getMonth() + 1);
	var d = today.getDate();

	if (m < 10)
		m = '0' + m;

	if (d < 10)
		d = '0' + d;

	return y + '-' + m + '-' + d;
}

function clear_all() {
	InputBox.value = "";
	popPage.hide();
}

function SetChooseDate(_y, _m, _d, ex) {
	var yy = _y;
	var mm = parseInt(_m) + ex; // ex表示偏移量，用于选择上个月份和下个月份的日期

	if (mm < 1) // 判断月份，并进行对应的处理
	{

		yy--;
		mm = 12 + mm;
	} else if (mm > 12) {
		yy++;
		mm = mm - 12;
	}

	if (mm < 10)
		mm = "0" + mm;

	if (_d < 10)
		_d = '0' + _d;

	InputBox.value = yy + '-' + mm + '-' + _d; // 注：在这里你可以输出改成你想要的格式
	popPage.hide();
}

/* 输入今天日期 */
function SetTodayDate() {
	InputBox.value = GetTodayDate();
	popPage.hide();
}

/* 输入框显示 */
function InputValue(InputBox, Year, Month, Day) {
	if (Month < 10)
		Month = '0' + Month;

	if (Day < 10)
		Day = '0' + Day;

	InputBox.value = Year + "-" + Month + "-" + Day;
	popPage.hide();
}

/* 打开日历窗口 */
function pop(tobj) {
	var objParent = tobj.offsetParent;
	var left = tobj.offsetLeft;
	var top = tobj.offsetTop;
	while (objParent.tagName.toUpperCase() != "BODY") {
		left += objParent.offsetLeft;
		top += objParent.offsetTop;
		objParent = objParent.offsetParent;
	}

	/* 根据输入框中的日期显示日历 */
	// var Box_Name = InputBox.name;
	var Box_value = InputBox.value;
	var s = "";
	if (DateIsTrue(Box_value)) {
		var loDate = Box_value.split("-");
		s = initCalendar(loDate[0], parseFloat(loDate[1]),
				parseFloat(loDate[2]));
	} else {
		var today = new Date();
		s = initCalendar(today.getYear(), today.getMonth() + 1, today.getDate());
	}

	top += tobj.offsetHeight;
	var temp = tobj.name.size;
	temp = temp ? temp : 24;

	idCalendar.innerHTML = s;
	popPage.document.body.innerHTML = s;

	if (parseInt(left) + parseInt(idCalendar.style.width) > parseInt(document.body.clientWidth))
		idCalendar.style.left = parseInt(document.body.clientWidth)
				- parseInt(idCalendar.style.width);
	else
		idCalendar.style.left = left;

	idCalendar.style.display = "";
	if (parseInt(top + 1 + document.body.style.marginTop)
			+ parseInt(idCalendar.clientHeight) > parseInt(document.body.clientWidth))
		idCalendar.style.top = parseInt(document.body.clientWidth)
				- parseInt(idCalendar.clientHeight);
	else
		idCalendar.style.top = top + 1 + document.body.style.marginTop;

	caleX = parseInt(idCalendar.style.left);
	caleY = parseInt(idCalendar.style.top);
	//alert(window.dialogArguments.document.getElementById("curPage").innerHTML);
	popPage.show(0, 22, idCalendar.clientWidth,
			idCalendar.clientHeight + 15, tobj);
	idCalendar.style.display = "none";
}

/* 打开日历窗口接口函数 */
function OpenDate(objFiled) {
	InputBox = objFiled;
	pop(objFiled);
}

/* 打开日历窗口接口函数 */
function getDate(objFiled) {
	InputBox = objFiled;
	pop(objFiled);
}

/* 打开日历窗口接口函数 */
function Calendar(objFiled) {
	InputBox = objFiled;
	pop(objFiled);
}