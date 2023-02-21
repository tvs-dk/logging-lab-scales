#This is the script that I am currently using:


$port = new-Object System.IO.Ports.SerialPort COM3,9600,None,8,one

#Open the serial port
$port.open()

#Ask the user for the factor
$factor = Read-Host "Enter the weight of the gel - e.g. if 120 g - enter 120 and press enter: "

#Infinite loop to continuously read data from the serial port
while ($true) {
# Read the data from the serial port
$data = $port.ReadLine()



# Get the current timestamp
$timestamp = Get-Date -Format yyyy-MM-dd_HH-mm-ss

# Extract the numerical part of the data
$numericalData = [float]::Parse($data -replace '[gS\s]')/100

# Multiply the numerical data by the factor
$calculatedData = $numericalData * ($factor/100)

# Append the data, timestamp and calculated data to the text file
Add-Content -Path "results_scale1.txt" -Value "$timestamp $numericalData $calculatedData"

# Print the value
Write-Host "$timestamp $numericalData $calculatedData $data"

$port.DiscardInBuffer()

# Wait for 10 seconds before reading the next data
Start-Sleep -Seconds 10
}

