@echo off
title Autoclicker (F8 - stop)
echo press ENTER, to start clicking.
echo for stop press F8.
pause > nul

set "PSFILE=%TEMP%\autoclicker.ps1"

> "%PSFILE%" echo Add-Type -TypeDefinition @'
>> "%PSFILE%" echo using System;
>> "%PSFILE%" echo using System.Runtime.InteropServices;
>> "%PSFILE%" echo public class Mouse {
>> "%PSFILE%" echo     [DllImport^("user32.dll"^)]
>> "%PSFILE%" echo     public static extern void mouse_event^(uint dwFlags, uint dx, uint dy, uint dwData, UIntPtr dwExtraInfo^);
>> "%PSFILE%" echo     [DllImport^("user32.dll"^)]
>> "%PSFILE%" echo     public static extern short GetAsyncKeyState^(int vKey^);
>> "%PSFILE%" echo     public const uint LEFTDOWN = 0x0002;
>> "%PSFILE%" echo     public const uint LEFTUP = 0x0004;
>> "%PSFILE%" echo     public static void LeftClick^(^) {
>> "%PSFILE%" echo         mouse_event^(LEFTDOWN, 0, 0, 0, UIntPtr.Zero^);
>> "%PSFILE%" echo         mouse_event^(LEFTUP, 0, 0, 0, UIntPtr.Zero^);
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo     public static bool IsKeyDown^(int vKey^) {
>> "%PSFILE%" echo         return GetAsyncKeyState^(vKey^) ^< 0;
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo }
>> "%PSFILE%" echo '@
>> "%PSFILE%" echo Write-Host "Clicking! Press F8 to stop." -ForegroundColor Yellow
>> "%PSFILE%" echo while ^($true^) {
>> "%PSFILE%" echo     if ^([Mouse]::IsKeyDown^(0x77^)^) { break }
>> "%PSFILE%" echo     [Mouse]::LeftClick^(^)
>> "%PSFILE%" echo     Start-Sleep -Milliseconds 1
>> "%PSFILE%" echo }
>> "%PSFILE%" echo Write-Host "Stopped." -ForegroundColor Red

powershell -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%"