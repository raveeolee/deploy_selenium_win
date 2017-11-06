# This can be started:
# 1 start powershell, run this
# 2 command line: `Powershell.exe -File clean.ps1`

$sTemp = "scoped_dir" # file mask, files with those names will be searched for deletion
$sTimeout = 15        # time to allowed lifetime of temp files, minutes
$sEverySeconds = 180  # run every, seconds
$sFolder = $env:TEMP
$sProfile = $env:userprofile

# Timestamp now func for loggin purposes
function Get-TimeStamp {
    $timeStamp = "[" + (Get-Date).ToShortDateString() + " " + ((Get-Date).ToShortTimeString()) + "]"
    Return $timeStamp
}

# Indefinite loop to check files
for(;;) {
 try {
    Write-Host "$(Get-TimeStamp) Checking temp files in $sFolder with name $sTemp older then $sTimeout minutes. Profile: $sProfile"
    Get-ChildItem $sFolder |

    # file name template
    Where {$_.name -Match $sTemp} |

    # older then $sTimeout
    Where-Object {$_.CreationTime -lt (date).addminutes(-$sTimeout)} | 

    # Delete
    % { 
      ForEach-Object { 
        Write-Host "Deleting: $_" 
        Remove-Item -Force -Recurse $_.fullname
      }       
    }

 } catch [Exception] {
    Write-Host "$(Get-TimeStamp) Some exception on deleting files"
 }

 # wait for a minute
 Write-Host "$(Get-TimeStamp) Sleeping for $sEverySeconds seconds"
 Start-Sleep $sEverySeconds
}