$Config = Import-PowerShellDataFile $PSScriptRoot\Config.psd1

$InfluxUri = $Config.InfluxServer + "/write?db=" + $Config.InfluxDb
$auth = "$($Config.MarsUser):$($Config.MarsPass)"
$encodedAuth = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($auth))
$basicAuthValue = "Basic $encodedAuth"

$Headers = @{
    Authorization = $basicAuthValue
}

while ($true) {
    $result = Invoke-WebRequest -Uri $Config.MarsAddress -Headers $Headers -UseBasicParsing -TimeoutSec 2
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
        Invoke-WebRequest -Uri $InfluxUri -Method POST -Body $Body -UseBasicParsing | out-null
    }
    else {
        Write-Host "Request Failed"
        exit 1
    }
    Start-Sleep -Seconds 5
}
