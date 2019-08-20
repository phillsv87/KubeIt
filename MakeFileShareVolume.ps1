param(
    [string]$name=$(throw "-name required"),
    [int]$storageAccountName=$(throw "-storageAccountName required"),
    [string]$shareName=$(throw "-shareName required")
    [int]$sizeGB=$(throw "-sizeGB requirede")
)

& $PSScriptRoot/TextTemplate.ps1 -tmpl persistent-volume-and-claim `
    -sizeGB $sizeGB `
    -storageAccountName $storageAccountName `
    -shareName $shareName `
    -out "$PSScriptRoot/../$($name)-pv.yml"