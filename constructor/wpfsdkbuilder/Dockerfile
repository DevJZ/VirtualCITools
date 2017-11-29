FROM dcdevjbz/msbuild15:ver15.4.8.50001_wincore1709

ADD https://download.microsoft.com/download/E/0/0/E0032698-8F1F-497D-B7BD-35275E1EB6FC/BlendWPFSDK_en.msi C:\\blendsdk_net4.msi
RUN powershell Start-Process -filepath C:\blendsdk_net4.msi -ArgumentList "/qn" -PassThru -Wait & \
    del C:\blendsdk_net4.msi

ADD https://download.visualstudio.microsoft.com/download/pr/10770745/9529454812c9b386ee1ad47e1042dd3f/BlendWPFSDK.msi C:\\blends_net45.msi
RUN powershell Start-Process -filepath C:\blends_net45.msi -ArgumentList "/qn" -PassThru -Wait & \
    del C:\blends_net45.msi

ADD https://download.microsoft.com/download/C/5/5/C55807F5-601C-49B1-B9BB-1BE03EB83E0A/dotnet-dev-win-x86.1.1.5.exe C:\\dotnet-dev-win-x86.1.1.5.exe
RUN C:\dotnet-dev-win-x86.1.1.5.exe /q /n & \
    del C:\dotnet-dev-win-x86.1.1.5.exe

ADD https://download.microsoft.com/download/C/5/5/C55807F5-601C-49B1-B9BB-1BE03EB83E0A/dotnet-dev-win-x64.1.1.5.exe  C:\\dotnet-dev-win-x64.1.1.5.exe
RUN C:\dotnet-dev-win-x64.1.1.5.exe /q /n & \
    del C:\dotnet-dev-win-x64.1.1.5.exe

ADD https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-win-x86.exe C:\\dotnet-sdk-2.0.3-win-x86.exe
RUN C:\dotnet-sdk-2.0.3-win-x86.exe /q /n & \
    del C:\dotnet-sdk-2.0.3-win-x86.exe

ADD https://download.microsoft.com/download/D/7/2/D725E47F-A4F1-4285-8935-A91AE2FCC06A/dotnet-sdk-2.0.3-win-x64.exe C:\\dotnet-sdk-2.0.3-win-x64.exe
RUN C:\dotnet-sdk-2.0.3-win-x64.exe /q /n & \
    del C:\dotnet-sdk-2.0.3-win-x64.exe

ADD ./msbuild15.4.8.50001_netcoresdk.zip C:\\msbuild.zip
RUN powershell Expand-Archive -Path C:\msbuild.zip -DestinationPath C:\msbuild
RUN powershell Remove-Item C:\msbuild.zip
RUN C:\msbuild\vs_setup.exe --noweb --passive --norestart --wait