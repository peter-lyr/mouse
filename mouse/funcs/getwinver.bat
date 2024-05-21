@echo off
for /f "tokens=2 delims=[]" %%a in ('ver') do for /f "tokens=2-4 delims=. " %%b in ("%%a") do set "ver=%%b%%c" && set "verbuild=%%d"
if %ver% EQU 51 echo;Windows XP
if %ver% EQU 60 echo;Windows Vista
if %ver% EQU 61 echo;Windows 7
if %ver% EQU 62 echo;Windows 8
if %ver% EQU 63 echo;Windows 8.1
if %ver% EQU 100 (
  if %verbuild% LSS 22000 (
    echo;Windows 10
  ) else (
    echo;Windows 11
  )
)
