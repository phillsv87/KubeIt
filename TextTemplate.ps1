param(
    [string]$tmpl=(throw "-tmpl required ")
)

$ErrorActionPreference="Stop"

$templatePath=$tmpl

if(!(Test-Path $templatePath)){
    $templatePath="$PSScriptRoot/templates/$($tmpl).yml"
}

if(!(Test-Path $templatePath)){
    throw "No template found at $tmpl or $templatePath"
}

$vars=@{}
$args | ForEach-Object {
    if($_ -match '^-') {
        #New parameter
        $lastvar = $_ -replace '^-'
        $vars[$lastvar] = $null
    } else {
        #Value
        $vars[$lastvar] = $_
    }
}

$config=&$PSScriptRoot/GetConfig.ps1
$templateContent=Get-Content $templatePath -Raw
$ExecutionContext.InvokeCommand.ExpandString($templateContent)