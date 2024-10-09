# Breakreminder: Description

This PowerShell script is designed to remind you to take a break after 30 minutes of active screen time. The timer counts only when you are actively working at your computer. If the workstation is locked (e.g., when you step away), the timer stops and resumes when you return. The script tracks the remaining time and saves it to a file, allowing the timer to persist between sessions. When 30 minutes of active time have passed, a pop-up reminder appears, and a system sound is played to signal that it's time to take a break.

To ensure the PowerShell window does not briefly appear when the script runs, it's recommended to use a VBScript wrapper that runs the PowerShell script in hidden mode. The script can be set to run automatically at system startup using the Task Scheduler, with the VBScript handling the execution invisibly in the background.

---

## Features

- **Tracks only active screen time**: The timer runs only when you are actively using your computer.
- **Pauses when the computer is locked** and resumes when unlocked.
- Shows a pop-up reminder after 30 minutes of active use.
- Plays a system sound when the reminder is triggered.
- Saves remaining time to a file, ensuring it persists between sessions.
- **Runs in the background without showing the PowerShell window**, using a VBScript wrapper.
- Can be set to run automatically via the Task Scheduler at system startup.

---

## Usage

1. **Download or clone the script** to your local machine.
2. **Edit the path** in the `$timeFile` variable to set the correct location for storing the remaining time.
3. **Run the script using the VBScript wrapper** (see the next section) to hide the PowerShell window.
4. You can modify the `$pauseDuration` variable to set a different time interval if needed (time is in seconds).

---

## Running the Script in the Background

To prevent the PowerShell window from appearing while the script runs, you can use the following VBScript (`.vbs`) file. This will execute the PowerShell script in hidden mode:

```vbscript
Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -WindowStyle Hidden -File ""C:\path\to\your\script.ps1""", 0, False
```

1. Save the above code as a `.vbs` file (e.g., `RunInBackground.vbs`).
2. Update the path to your `Pausenreminder.ps1` script in the VBScript.
3. Use the `.vbs` file to run the PowerShell script in the background, avoiding the PowerShell window popup.

---

## Setting Up Task Scheduler

To automate the script (via the VBScript wrapper) so that it runs every time you log in:

1. Open the Task Scheduler on your computer.
2. Create a new task:
   - **General Tab**: Name your task (e.g., "Break Reminder").
   - **Triggers Tab**: Create a new trigger and set it to "At logon" so the script runs whenever the user logs in.
   - **Actions Tab**: Add a new action to start the VBScript.
     - In the "Program/script" field, enter: `wscript.exe`
     - In the "Add arguments" field, enter the full path to your `.vbs` file (e.g., `"C:\path\to\RunInBackground.vbs"`).
   - **Conditions Tab**: Make sure to uncheck "Start the task only if the computer is on AC power" if you're on a laptop.
3. Save the task and ensure it is enabled.

Now, every time you log in, the script will automatically run in the background, tracking your active screen time and reminding you to take breaks after 30 minutes of work without showing the PowerShell window.

---

This version ensures that the user runs the PowerShell script through the VBScript to prevent any visible popups, and the Task Scheduler is configured accordingly.
