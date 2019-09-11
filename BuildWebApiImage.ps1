param(
    [string]$version=$(throw "-version required"),
    [string]$dir=$(throw "-dir required"),
    [switch]$noBuild,
    [switch]$noPush,
    [string]$repo,
    [string]$tag=$(throw "-tag required")
)

$config = &$PSScriptRoot/GetConfig.ps1

$useDefaultRepo = $False

if(!$repo){
    $useDefaultRepo = $True
    $arcName=$config.acrName
    if(!$arcName){
        throw "config.acrName not set and no repo set"
    }
    $repo="$($arcName.ToLower()).azurecr.io"
}

try{

    Push-Location $dir

    if(!(Test-Path './Dockerfile')){
        throw "No Dockerfile found at $dir"
    }

    $fullName="$repo/$($tag):$version"

    if(!$noBuild){
        Write-Host "Build $fullName"
        docker build -t $tag -f "Dockerfile" ".."
        if(!$?){
            throw "build failed"
        }

        docker tag $tag $fullName
        if(!$?){
            throw "tag failed"
        }
        Write-Host "Build Success - $fullName" -Foreground DarkGree
    }else{
        Write-Host "Skip build $fullName"
    }

    if(!$noPush){

        if($useDefaultRepo){
            Write-Host "Signing into default ACR"
            & $PSScriptRoot/SigninToACR.ps1
            Write-Host "Signed into default ACR" -ForegroundColor DarkGreen
        }

        Write-Host "Push $fullName"
        docker push $fullName
        if(!$?){
            throw "Push Failed - $fullName"
        }

        Write-Host "Push Success - $fullName" -Foreground DarkGree
    }else{
        Write-Host "Skip Push $fullName"
    }
}finally{
    Pop-Location
}