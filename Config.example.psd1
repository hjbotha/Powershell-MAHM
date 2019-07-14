@{
    ComputerName = 'my-pc' # Name of this system. Measurements will be stored in influxdb with host tag of this value
    MarsAddress  = 'http://localhost:82/mahm' # MSI Afterburner Remote Server web address
    MarsUser     = 'MSIAfterburner' # MSI Afterburner Remote Server credentials
    MarsPass     = 'password'
    InfluxServer = 'http://192.168.1.1:8086' # Influx Server HTTP Address
    InfluxDb     = "systemdata" # Influx database in which to put the data
}