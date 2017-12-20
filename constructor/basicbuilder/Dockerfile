ARG tagarg=3.5-windowsservercore-1709 
FROM microsoft/dotnet-framework:${tagarg} AS installednuget

ADD https://github.com/git-for-windows/git/releases/download/v2.15.1.windows.2/Git-2.15.1.2-64-bit.exe C:\\Git-2.15.1.2-64-bit.exe
RUN powershell Start-Process C:\Git-2.15.1.2-64-bit.exe -ArgumentList '/VERYSILENT', '/SUPPRESSMSGBOXES','/CLOSEAPPLICATIONS', '/DIR=C:\\Program Files\\git' -Wait
RUN del C:\Git-2.15.1.2-64-bit.exe

ADD https://dist.nuget.org/win-x86-commandline/v4.4.1/nuget.exe C:\\nuget\\v4.4.1\\nuget.exe
RUN SETX /M GIT_BIN_PATH "C:\Program Files\git\bin"
RUN SETX /M NUGET441_BIN_PaTH "C:\nuget\v4.4.1"
RUN SETX /M Path "%Path%;%NUGET441_BIN_PaTH%;%GIT_BIN_PATH%"

FROM installednuget AS msbuild15

ADD https://download.microsoft.com/download/C/5/5/C55807F5-601C-49B1-B9BB-1BE03EB83E0A/dotnet-dev-win-x64.1.1.5.exe  C:\\dotnet-dev-win-x64.1.1.5.exe
RUN powershell Start-Process -filepath C:\dotnet-dev-win-x64.1.1.5.exe -ArgumentList '/q','/n' -PassThru -Wait & \
    del C:\dotnet-dev-win-x64.1.1.5.exe & \
    powershell Remove-Item "$ENV:TEMP\." -Recurse -Force

ADD https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-win-x64.exe C:\\dotnet-sdk-2.0.3-win-x64.exe
RUN powershell Start-Process -filepath C:\dotnet-sdk-2.0.3-win-x64.exe -ArgumentList '/q','/n' -PassThru -Wait & \
    del C:\dotnet-sdk-2.0.3-win-x64.exe & \
    powershell Remove-Item "$ENV:TEMP\." -Recurse -Force

ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\msbuild15\\vs_buildtools.exe
RUN C:\msbuild15\vs_buildtools.exe --layout C:\msbuild15\ --lang en-US --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.NetCoreBuildTools --add Microsoft.VisualStudio.Workload.WebBuildTools --includeRecommended --includeOptional  --passive --wait

RUN powershell Import-PfxCertificate -FilePath C:\msbuild15\certificates\manifestCounterSignCertificates.p12 -CertStoreLocation Cert:\LocalMachine\Root
RUN powershell Import-PfxCertificate -FilePath C:\msbuild15\certificates\manifestSignCertificates.p12 -CertStoreLocation Cert:\LocalMachine\Root
RUN powershell Import-PfxCertificate -FilePath C:\msbuild15\certificates\vs_installer_opc.SignCertificates.p12 -CertStoreLocation Cert:\LocalMachine\Root

RUN powershell Start-Process -filepath C:\msbuild15\vs_setup.exe -ArgumentList '--noWeb','--passive','--norestart','--wait' -Wait -PassThru
RUN powershell Remove-Item C:\msbuild15 -Recurse -Force
RUN powershell Remove-Item "$ENV:TEMP\." -Recurse -Force

ADD http://download.microsoft.com/download/6/c/e/6cebcf8f-6a01-4c00-8745-cdb5f6591d48/vs14-kb3165756.exe C:\\VS2015_update3\\vs14_update.exe
RUN C:\VS2015_update3\vs14_update.exe /Layout C:\VS2015_update3 /Quiet
RUN powershell Start-Process -filepath C:\VS2015_update3\packages\PortableLibrary\PortableLibrary_DTP.msi -ArgumentList 'EXTUI=1' -Wait -PassThru
RUN powershell Remove-Item C:\VS2015_update3 -Recurse -Force
RUN powershell Remove-Item "$ENV:TEMP\." -Recurse -Force

FROM msbuild15 AS wpfmsbuild15
ADD https://download.microsoft.com/download/E/0/0/E0032698-8F1F-497D-B7BD-35275E1EB6FC/BlendWPFSDK_en.msi C:\\blendsdk_net4.msi
RUN powershell Start-Process -filepath C:\blendsdk_net4.msi -ArgumentList "/qn" -PassThru -Wait & \
    del C:\blendsdk_net4.msi

ADD https://download.visualstudio.microsoft.com/download/pr/10770745/9529454812c9b386ee1ad47e1042dd3f/BlendWPFSDK.msi C:\\blends_net45.msi
RUN powershell Start-Process -filepath C:\blends_net45.msi -ArgumentList "/qn" -PassThru -Wait & \
    del C:\blends_net45.msi

ADD https://xamarin.azureedge.net/GTKforWindows/Windows/gtk-sharp-2.12.45.msi C:\\gtk-sharp-2.12.45.msi
RUN powershell Start-Process -filepath C:\gtk-sharp-2.12.45.msi -ArgumentList '/q','/n' -PassThru -Wait & \
    del C:\gtk-sharp-2.12.45.msi

RUN powershell Remove-Item "$ENV:TEMP\." -Recurse -Force

RUN SETX /M BuildTools_COMMON7_Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7"
RUN SETX /M BuildTools_TOOL_Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools"
RUN SETX /M MSBuild_Bin_Path "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
RUN SETX /M Path "%Path%;%BuildTools_COMMON7_Path%;%MSBuild_Bin_Path%;%BuildTools_TOOL_Path%"
RUN SETX /M DisableOutOfProcTaskHost 1

CMD ["cmd", "/k vsdevcmd.bat"]