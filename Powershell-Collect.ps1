$Config = Import-PowerShellDataFile $PSScriptRoot\Config.psd1

Start-Process $Config.RTSSLocation
Start-Process $Config.MsiAfterburnerLocation
Start-Process $Config.MsiAfterburnerRemoteServerLocation

$InfluxUri = $Config.InfluxServer + "/write?db=" + $Config.InfluxDb
$auth = "$($Config.MarsUser):$($Config.MarsPass)"
$encodedAuth = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($auth))
$basicAuthValue = "Basic $encodedAuth"

$Headers = @{
    Authorization = $basicAuthValue
}

while ($true) {
    $result = Invoke-WebRequest -Uri $Config.MarsAddress -Headers $Headers -UseBasicParsing -TimeoutSec 2 -ErrorAction Continue
    $Metrics = @{ }
    $BodyArray = @()
    if ($result.StatusCode -eq 200) {
        $content = [xml]([System.Text.Encoding]::UTF8.GetString($result.content))
        $content.HardwareMonitor.HardwareMonitorEntries.HardwareMonitorEntry | % {
            $metric = $_.srcName
            $value = [decimal]$_.data
            if ($value -gt 0) {
                $BodyArray += "System,host=" + $Config.ComputerName + ",metric=" + $metric.Replace(" ", "\ ") + " value=" + $value
            }
        }
        $Metrics | % {
        }
        $Body = $BodyArray -join "`n"
        Write-Host "Sending to InfluxDB"
        Write-Host "$Body"
        Invoke-WebRequest -Uri $InfluxUri -Method POST -Body $Body -UseBasicParsing -ErrorAction Continue | out-null 
    }
    else {
        Write-Host "Request Failed"
    }
    Start-Sleep -Seconds $Config.PauseBetweenRequestsInSeconds
}
