// parseText.cpp : Defines the exported functions for the DLL application.
//
#include <string>
#include <time.h>
#include <stdio.h>

#ifdef WIN32
extern "C" __declspec(dllexport) const char * ParseColors(int argc, char *argv[]);
extern "C" __declspec(dllexport) const char * StripColors(int argc, char *argv[]);
extern "C" __declspec(dllexport) const char * ByondColors(int argc, char *argv[]);
extern "C" __declspec(dllexport) const char * systemTime();
#else
#include <cstring>
extern "C" const char * ParseColors(int argc, char *argv[]);
extern "C" const char * StripColors(int argc, char *argv[]);
extern "C" const char * ByondColors(int argc, char *argv[]);
extern "C" const char * systemTime();
#endif

using namespace std;
string returnV;

void replace_text(string& source, string const& find, string const& replace)
{
	for (std::string::size_type i = 0; (i = source.find(find, i)) != std::string::npos;)
	{
		source.replace(i, find.length(), replace);
		i += replace.length() - find.length() + 2;
	}
}

const char * StripColors(int argc, char *argv[]){
	returnV = argv[0];
	if (strstr(argv[0], "{y")){ replace_text(returnV, "{y", ""); }
	if (strstr(argv[0], "{Y")){ replace_text(returnV, "{Y", ""); }
	if (strstr(argv[0], "{c")){ replace_text(returnV, "{c", ""); }
	if (strstr(argv[0], "{C")){ replace_text(returnV, "{C", ""); }
	if (strstr(argv[0], "{m")){ replace_text(returnV, "{m", ""); }
	if (strstr(argv[0], "{M")){ replace_text(returnV, "{M", ""); }
	if (strstr(argv[0], "{r")){ replace_text(returnV, "{r", ""); }
	if (strstr(argv[0], "{R")){ replace_text(returnV, "{R", ""); }
	if (strstr(argv[0], "{b")){ replace_text(returnV, "{b", ""); }
	if (strstr(argv[0], "{B")){ replace_text(returnV, "{B", ""); }
	if (strstr(argv[0], "{g")){ replace_text(returnV, "{g", ""); }
	if (strstr(argv[0], "{G")){ replace_text(returnV, "{G", ""); }
	if (strstr(argv[0], "{d")){ replace_text(returnV, "{d", ""); }
	if (strstr(argv[0], "{D")){ replace_text(returnV, "{D", ""); }
	if (strstr(argv[0], "{w")){ replace_text(returnV, "{w", ""); }
	if (strstr(argv[0], "{W")){ replace_text(returnV, "{W", ""); }
	if (strstr(argv[0], "{o")){ replace_text(returnV, "{o", ""); }
	if (strstr(argv[0], "{x")){ replace_text(returnV, "{x", ""); }
	if (strstr(argv[0], "^d")){ replace_text(returnV, "^d", ""); }
	if (strstr(argv[0], "^r")){ replace_text(returnV, "^r", ""); }
	if (strstr(argv[0], "^g")){ replace_text(returnV, "^g", ""); }
	if (strstr(argv[0], "^y")){ replace_text(returnV, "^y", ""); }
	if (strstr(argv[0], "^b")){ replace_text(returnV, "^b", ""); }
	if (strstr(argv[0], "^m")){ replace_text(returnV, "^m", ""); }
	if (strstr(argv[0], "^c")){ replace_text(returnV, "^c", ""); }
	if (strstr(argv[0], "^w")){ replace_text(returnV, "^w", ""); }
	if (strstr(argv[0], "^u")){ replace_text(returnV, "^u", ""); }
	if (strstr(argv[0], "^7")){ replace_text(returnV, "^7", ""); }
	if (strstr(argv[0], "")){ replace_text(returnV, "", ""); }
	return returnV.c_str();
};

const char * ByondColors(int argc, char *argv[]){
	returnV = argv[0];
	if (strstr(argv[0], "{y")){ replace_text(returnV, "{y", "<font color=#cfcf00>"); }
	if (strstr(argv[0], "{Y")){ replace_text(returnV, "{Y", "<font color=#ffff00>"); }
	if (strstr(argv[0], "{c")){ replace_text(returnV, "{c", "<font color=#008080>"); }
	if (strstr(argv[0], "{C")){ replace_text(returnV, "{C", "<font color=#00ffff>"); }
	if (strstr(argv[0], "{m")){ replace_text(returnV, "{m", "<font color=#cf00cf>"); }
	if (strstr(argv[0], "{M")){ replace_text(returnV, "{M", "<font color=#ff00ff>"); }
	if (strstr(argv[0], "{r")){ replace_text(returnV, "{r", "<font color=#cf0000>"); }
	if (strstr(argv[0], "{R")){ replace_text(returnV, "{R", "<font color=#ff0000>"); }
	if (strstr(argv[0], "{b")){ replace_text(returnV, "{b", "<font color=#0000cf>"); }
	if (strstr(argv[0], "{B")){ replace_text(returnV, "{B", "<font color=#0000ff>"); }
	if (strstr(argv[0], "{g")){ replace_text(returnV, "{g", "<font color=#008000>"); }
	if (strstr(argv[0], "{G")){ replace_text(returnV, "{G", "<font color=#00ff00>"); }
	if (strstr(argv[0], "{d")){ replace_text(returnV, "{d", "<font color=#000000>"); }
	if (strstr(argv[0], "{D")){ replace_text(returnV, "{D", "<font color=#909090>"); }
	if (strstr(argv[0], "{w")){ replace_text(returnV, "{w", "<font color=#cfcfcf>"); }
	if (strstr(argv[0], "{W")){ replace_text(returnV, "{W", "<font color=#ffffff>"); }
	if (strstr(argv[0], "{o")){ replace_text(returnV, "{o", "<font color=#CC3300>"); }
	if (strstr(argv[0], "{x")){ replace_text(returnV, "{x", "</font>"); }
	if (strstr(argv[0], "^d")){ replace_text(returnV, "^d", "<font color=#909090>"); }
	if (strstr(argv[0], "^r")){ replace_text(returnV, "^r", "<font color=#cf0000>"); }
	if (strstr(argv[0], "^g")){ replace_text(returnV, "^g", "<font color=#008000>"); }
	if (strstr(argv[0], "^y")){ replace_text(returnV, "^y", "<font color=#ffff00>"); }
	if (strstr(argv[0], "^b")){ replace_text(returnV, "^b", "<font color=#0000cf>"); }
	if (strstr(argv[0], "^m")){ replace_text(returnV, "^m", "<font color=#cf00cf>"); }
	if (strstr(argv[0], "^c")){ replace_text(returnV, "^c", "<font color=#008080>"); }
	if (strstr(argv[0], "^w")){ replace_text(returnV, "^w", "<font color=#cfcfcf>"); }
	if (strstr(argv[0], "^u")){ replace_text(returnV, "^u", "<u>"); }
	if (strstr(argv[0], "^n")){ replace_text(returnV, "^n", "</u>"); }
	if (strstr(argv[0], "^7")){ replace_text(returnV, "^7", "<font color=#cfcf00>"); }
	if (strstr(argv[0], "")){ replace_text(returnV, "", ""); }
	return returnV.c_str();
};

const char * ParseColors(int argc, char *argv[])
{
	returnV = argv[0];
	if (strstr(argv[0], "{y")){ replace_text(returnV, "{y", "[0;33m"); }
	if (strstr(argv[0], "{Y")){ replace_text(returnV, "{Y", "[1;33m"); }
	if (strstr(argv[0], "{c")){ replace_text(returnV, "{c", "[0;36m"); }
	if (strstr(argv[0], "{C")){ replace_text(returnV, "{C", "[1;36m"); }
	if (strstr(argv[0], "{m")){ replace_text(returnV, "{m", "[0;35m"); }
	if (strstr(argv[0], "{M")){ replace_text(returnV, "{M", "[1;35m"); }
	if (strstr(argv[0], "{r")){ replace_text(returnV, "{r", "[0;31m"); }
	if (strstr(argv[0], "{R")){ replace_text(returnV, "{R", "[1;31m"); }
	if (strstr(argv[0], "{b")){ replace_text(returnV, "{b", "[0;34m"); }
	if (strstr(argv[0], "{B")){ replace_text(returnV, "{B", "[1;34m"); }
	if (strstr(argv[0], "{g")){ replace_text(returnV, "{g", "[0;32m"); }
	if (strstr(argv[0], "{G")){ replace_text(returnV, "{G", "[1;32m"); }
	if (strstr(argv[0], "{d")){ replace_text(returnV, "{d", "[0;30m"); }
	if (strstr(argv[0], "{D")){ replace_text(returnV, "{D", "[1;30m"); }
	if (strstr(argv[0], "{w")){ replace_text(returnV, "{w", "[0;37m"); }
	if (strstr(argv[0], "{W")){ replace_text(returnV, "{W", "[1;37m"); }
	if (strstr(argv[0], "{o")){ replace_text(returnV, "{o", "[38;5;166m"); }
	if (strstr(argv[0], "{x")){ replace_text(returnV, "{x", "[0m"); }
	if (strstr(argv[0], "^d")){ replace_text(returnV, "^d", "[40m"); }
	if (strstr(argv[0], "^r")){ replace_text(returnV, "^r", "[41m"); }
	if (strstr(argv[0], "^g")){ replace_text(returnV, "^g", "[42m"); }
	if (strstr(argv[0], "^y")){ replace_text(returnV, "^y", "[43m"); }
	if (strstr(argv[0], "^b")){ replace_text(returnV, "^b", "[44m"); }
	if (strstr(argv[0], "^m")){ replace_text(returnV, "^m", "[45m"); }
	if (strstr(argv[0], "^c")){ replace_text(returnV, "^c", "[46m"); }
	if (strstr(argv[0], "^w")){ replace_text(returnV, "^w", "[47m"); }
	if (strstr(argv[0], "^u")){ replace_text(returnV, "^u", "[4m"); }
	if (strstr(argv[0], "^n")){ replace_text(returnV, "^n", ""); }
	if (strstr(argv[0], "^7")){ replace_text(returnV, "^7", "[7m"); }
	return returnV.c_str();
}

char* timeTranslate(const struct tm *timeptr)
{
	static const char wday_name[][4] = {
		"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
	};
	static const char mon_name[][4] = {
		"Jan", "Feb", "Mar", "Apr", "May", "Jun",
		"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
	};
	static char result[26];
	sprintf(result, "%.3s %.3s%3d %.2d:%.2d:%.2d %d",
		wday_name[timeptr->tm_wday],
		mon_name[timeptr->tm_mon],
		timeptr->tm_mday, timeptr->tm_hour,
		timeptr->tm_min, timeptr->tm_sec,
		1900 + timeptr->tm_year);
	return result;
}

const char * systemTime(){
	const time_t ctt = time(0);
	return timeTranslate(localtime(&ctt));
}