// parseText.cpp : Defines the exported functions for the DLL.
//

#include "pch.h"
#include "framework.h"
#include "parseText.h"
#include <ctime>
#include <string>
#include <vector>
#include <map>
#include <sstream>

using namespace std;

static thread_local string returnV;

void replace_text(string& source, const string& find, const string& replace) {
    size_t pos = 0;
    while ((pos = source.find(find, pos)) != string::npos) {
        source.replace(pos, find.length(), replace);
        pos += replace.length();
    }
}

const char* StripColors(int argc, const char* argv[]) {
    static const vector<string> colors = {
        "{y", "{Y", "{c", "{C", "{m", "{M", "{r", "{R", "{b", "{B}", "{g", "{G}", "{d", "{D}", "{w", "{W}", "{o}", "{x}",
        "^d", "^r", "^g", "^y", "^b", "^m", "^c", "^w", "^u", "^7", ""
    };

    returnV = argv[0];
    for (const auto& color : colors) {
        replace_text(returnV, color, "");
    }

    return returnV.c_str();
}

const char* ByondColors(int argc, const char* argv[]) {
    static const map<string, string> colorMap = {
        {"{y", "<font color=#cfcf00>"}, {"{Y", "<font color=#ffff00>"},
        {"{c", "<font color=#008080>"}, {"{C", "<font color=#00ffff>"},
        {"{m", "<font color=#cf00cf>"}, {"{M", "<font color=#ff00ff>"},
        {"{r", "<font color=#cf0000>"}, {"{R", "<font color=#ff0000>"},
        {"{b", "<font color=#0000cf>"}, {"{B", "<font color=#0000ff>"},
        {"{g", "<font color=#008000>"}, {"{G", "<font color=#00ff00>"},
        {"{d", "<font color=#000000>"}, {"{D", "<font color=#909090>"},
        {"{w", "<font color=#cfcfcf>"}, {"{W", "<font color=#ffffff>"},
        {"{o", "<font color=#CC3300>"}, {"{x", "</font>"},
        {"^d", "<font color=#909090>"}, {"^r", "<font color=#cf0000>"},
        {"^g", "<font color=#008000>"}, {"^y", "<font color=#ffff00>"},
        {"^b", "<font color=#0000cf>"}, {"^m", "<font color=#cf00cf>"},
        {"^c", "<font color=#008080>"}, {"^w", "<font color=#cfcfcf>"},
        {"^u", "<u>"}, {"^n", "</u>"}, {"^7", "<font color=#cfcf00>"},
        {"", ""}
    };

    returnV = argv[0];
    for (const auto& entry : colorMap) {
        replace_text(returnV, entry.first, entry.second);
    }

    return returnV.c_str();
}

const char* ParseColors(int argc, const char* argv[]) {
    static const map<string, string> colorMap = {
        {"{y", "\x1b[0;33m"}, {"{Y", "\x1b[1;33m"}, {"{c", "\x1b[0;36m"}, {"{C", "\x1b[1;36m"},
        {"{m", "\x1b[0;35m"}, {"{M", "\x1b[1;35m"}, {"{r", "\x1b[0;31m"}, {"{R", "\x1b[1;31m"},
        {"{b", "\x1b[0;34m"}, {"{B", "\x1b[1;34m"}, {"{g", "\x1b[0;32m"}, {"{G", "\x1b[1;32m"},
        {"{d", "\x1b[0;30m"}, {"{D", "\x1b[1;30m"}, {"{w", "\x1b[0;37m"}, {"{W", "\x1b[1;37m"},
        {"{o", "\x1b[38;5;166m"}, {"{x", "\x1b[0m"}, {"^d", "\x1b[40m"}, {"^r", "\x1b[41m"},
        {"^g", "\x1b[42m"}, {"^y", "\x1b[43m"}, {"^b", "\x1b[44m"}, {"^m", "\x1b[45m"},
        {"^c", "\x1b[46m"}, {"^w", "\x1b[47m"}, {"^u", "\x1b[4m"}, {"^n", ""},
        {"^7", "\x1b[7m"}
    };

    returnV = argv[0];
    for (const auto& entry : colorMap) {
        replace_text(returnV, entry.first, entry.second);
    }

    return returnV.c_str();
}

string timeTranslate(const tm* timeptr) {
    char buffer[26];
    strftime(buffer, sizeof(buffer), "%a %b %d %H:%M:%S %Y", timeptr);
    return string(buffer);
}

const char* systemTime() {
    time_t now = time(nullptr);
    tm timePtr;
    localtime_s(&timePtr, &now);  // Use localtime_s for safety
    returnV = timeTranslate(&timePtr);
    return returnV.c_str();
}

