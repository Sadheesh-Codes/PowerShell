# Author Name: Sadheesh 

$Date = '01/16/2019'
$servers = @('Server 1','Server 2')

$Result = @()

foreach($Server in $Servers)
    {
    Write-Host $Server -ForegroundColor Yellow
    
    $LastBoot = Get-CimInstance -ClassName CIM_OperatingSystem -ComputerName $Server -Property * | select CSName,LastBootUpTime
    $Hotfix = get-hotfix -ComputerName $Server  | ?{$_.InstalledOn -gt $Date}

    foreach ($hot in $Hotfix)
            {
            $custom = [PSCustomObject]@{
                    ServerName = $LastBoot.CSName
                    LastBoot = $LastBoot.LastBootUpTime
                    HotfixID = [string]$hot.HotFixID
                    Installedon = [string]$hot.InstalledOn
                    }
            $Result += $custom
            }
    }
 $Result
 $Result | Export-Csv c:\temp\AD_Patching_Result.csv -NoClobber -NoTypeInformation
    