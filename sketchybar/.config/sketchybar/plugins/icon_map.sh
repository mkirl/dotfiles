#!/bin/bash

__icon_map() {
  case "$1" in
    "Arc")                    icon_result="󰞍";;
    "Code" | "Code - Insiders") icon_result="󰨞";;
    "Finder" | "访达")        icon_result="󰀶";;
    "Firefox")                icon_result="";;
    "Ghostty")                icon_result="👻";;
    "Terminal" | "终端")      icon_result="";;
    "kitty")                  icon_result="";;
    "Safari" | "Safari浏览器") icon_result="";;
    "System Settings" | "System Preferences") icon_result="󰒓";;
    "Chromium" | "Google Chrome") icon_result="";;
    "Discord")                icon_result="󰙯";;
    "Spotify")                icon_result="";;
    "Messages" | "信息")      icon_result="";;
    "Mail" | "邮件")          icon_result="";;
    "Notes" | "备忘录")       icon_result="";;
    "Preview" | "预览")       icon_result="";;
    "Cursor")                 icon_result="󰘦";;
    "Zen Browser")            icon_result="󰨇";;
    *)                        icon_result="󰏃";;
  esac
} 