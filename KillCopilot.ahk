#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook
A_MenuMaskKey := "vkE8" ; Prevents the Start Menu from flashing when modifiers are released

; State variable to track if the Copilot key is physically held down
global CopilotActive := false

; --- TRIGGER (Hardware Macro: Win + Shift + F23) ---
; The Copilot key actually sends these three keys simultaneously.
*F23::
{
    global CopilotActive := true
    ; CRITICAL FIX: Use {Blind} to prevent AHK from "restoring" the LWin key state.
    ; This forces the OS to register a logical "Key Up" for LWin and LShift immediately,
    ; preventing "leakage" where shortcuts like Win+R or Win+1 would accidentally trigger.
    SendInput "{Blind}{LWin Up}{LShift Up}"
}

*F23 Up::
{
    global CopilotActive := false
    ; Safety measure: Ensure modifiers are released logically when the physical key is released.
    SendInput "{Blind}{LWin Up}{LShift Up}"
}

; --- SANDBOX MODE (Only active while holding Copilot) ---
#HotIf CopilotActive

    ; --- 1. REMAPPED CHARACTERS (AltGr Emulation) ---
    ; Using {Text} ensures the characters are sent cleanly without modifier interference.
    
    *7::Send "{Blind}{Text}{"
    *8::Send "{Blind}{Text}["
    *9::Send "{Blind}{Text}]"
    *0::Send "{Blind}{Text}}"
    *2::Send "{Blind}{Text}@"
    *4::Send "{Blind}{Text}$"
    *e::Send "{Blind}{Text}€"
    *SC00C::Send "{Blind}{Text}\"  ; The key typically to the right of '0' (+/?)
    *SC056::Send "{Blind}{Text}|"  ; The key typically to the left of 'Z' (<)

    ; --- 2. KILL SWITCH (Block Windows Shortcuts) ---
    ; Explicitly return nothing for keys that usually trigger Windows shortcuts.
    ; This prevents Win+R, Win+L, Win+1, etc., from firing if the timing is slightly off.
    
    *1::return
    *3::return
    *5::return
    *6::return
    *r::return
    *s::return
    *l::return
    *a::return
    *d::return
    *f::return
    *Space::return
    *Tab::return
    *Enter::return
    *LWin::return
    *LShift::return

#HotIf