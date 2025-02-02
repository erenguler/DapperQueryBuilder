rmdir /s /q "%HOMEDRIVE%%HOMEPATH%\.nuget\packages\Dapper-QueryBuilder"

if not exist packages-local mkdir packages-local

dotnet clean
dotnet build -c release DapperQueryBuilder\DapperQueryBuilder.csproj
dotnet test  DapperQueryBuilder.Tests\DapperQueryBuilder.Tests.csproj

REM dotnet pack DapperQueryBuilder\DapperQueryBuilder.csproj -c release -o .\packages-local\ /p:ContinuousIntegrationBuild=true --include-symbols -p:SymbolPackageFormat=snupkg
REM Why with dotnet pack we can't get deterministic builds?

"C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe" /t:Pack DapperQueryBuilder\ /p:targetFrameworks="netstandard2.0;net472" /p:Configuration=Release /p:IncludeSymbols=true /p:SymbolPackageFormat=snupkg /p:PackageOutputPath=..\packages-local\ /verbosity:minimal /p:ContinuousIntegrationBuild=true