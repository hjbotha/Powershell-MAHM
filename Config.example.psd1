@{
    ComputerName = 'my-pc' # Name of this system. Measurements will be stored in influxdb with host tag of this value
    MarsAddress  = 'http://localhost:82/mahm' # MSI Afterburner Remote Server web address
    MarsUser     = 'MSIAfterburner' # MSI Afterburner Remote Server credentials
    MarsPass     = 'password'
    InfluxServer = 'http://192.168.1.1:8086' # Influx Server HTTP Address
    InfluxDb     = "systemdata" # Influx database in which to put the data
    MsiAfterburnerLocation = "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
    MsiAfterburnerRemoteServerLocation = "C:\Program Files (x86)\MSI Afterburner Remote Server\MSIAfterburnerRemoteServer.exe"
    RTSSLocation = "C:\Program Files (x86)\RivaTuner Statistics Server\RTSS.exe"
    PauseBetweenRequestsInSeconds = 5
}