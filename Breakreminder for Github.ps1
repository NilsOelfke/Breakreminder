# Pfad zur Datei, in der die verbleibende Zeit gespeichert wird
$timeFile = "C:\path\to\your\remaining_time.txt"
$pauseDuration = 1800 # 30 Minuten in Sekunden (1800 Sekunden)

# Funktion, um zu überprüfen, ob der Arbeitsplatz gesperrt ist
function IsWorkstationLocked {
    $locked = Get-Process -Name "LogonUI" -ErrorAction SilentlyContinue
    return $locked -ne $null
}

# Unendliche Schleife, damit das Skript immer weiterläuft
while ($true) {
    $remainingTime = $pauseDuration

    # Prüfen, ob bereits verbleibende Zeit existiert
    if (Test-Path $timeFile) {
        $remainingTime = Get-Content $timeFile
    }

    # Timer laufen lassen und verbleibende Zeit speichern
    while ($remainingTime -gt 0) {
        Start-Sleep -Seconds 60 # Jede Minute warten
        $remainingTime -= 60    # 60 Sekunden abziehen
        
        # Überprüfen, ob der Arbeitsplatz gesperrt ist
        if (IsWorkstationLocked) {
            exit
        }

        # Verbleibende Zeit in die Datei schreiben
        Set-Content -Path $timeFile -Value $remainingTime
    }

    # Wenn die 30 Minuten erreicht sind, Nachricht anzeigen und Ton abspielen

    # Erforderliches Assembly laden
    Add-Type -AssemblyName PresentationFramework

    # Fenster im Vordergrund öffnen und Nachricht anzeigen
    $window = New-Object -TypeName System.Windows.MessageBox
    $windowOptions = [System.Windows.MessageBoxOptions]::ServiceNotification # Dies erzwingt den Vordergrund
    [System.Windows.MessageBox]::Show('Mach eine Pause!', 'Erinnerung', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information, [System.Windows.MessageBoxResult]::OK, $windowOptions)

    # Systemton abspielen
    [System.Media.SystemSounds]::Beep.Play()

    # Datei nach der Erinnerung zurücksetzen
    Remove-Item $timeFile
}
