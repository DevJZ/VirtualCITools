if ( (docker images -q ${env:WPFBUILDER_NAME}) -eq $null ) `
{ docker build -f ${PWD}\\constructor\\wpfsdkbuilder\\Dockerfile -t ${env:WPFBUILDER_NAME} ${PWD}\\constructor\\wpfsdkbuilder } `
else {Write-Output "found ${env:WPFBUILDER_NAME}"}