$configPath=$null;

if(Test-Path "$PSScriptRoot/config.json"){
    $configPath="$PSScriptRoot/config.json"
}elseif(Test-Path "$PSScriptRoot/../KubeItConfig.json"){
    $configPath="$PSScriptRoot/../KubeItConfig.json";
}else{
    throw "No KubeIt config file found. Looked for $PSScriptRoot/config.json and $PSScriptRoot/../KubeItConfig.json"
}

$config=Get-Content $configPath | ConvertFrom-json

return $config