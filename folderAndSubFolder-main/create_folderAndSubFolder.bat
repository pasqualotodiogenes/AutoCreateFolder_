param (
    [string]$folderDate = $(Get-Date -Format "dd.MM.yy"),
    [string[]]$customFolders = @()
)

# Define o diretório base como o local onde o script está sendo executado
$baseDir = $PSScriptRoot
$targetFolder = Join-Path -Path $baseDir -ChildPath $folderDate

# Criar a pasta principal se não existir
if (!(Test-Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder | Out-Null
}

# Criar subpastas padrão
$subfolders = @("Pista de Ski e Snow", "Tubing", "Vilarejo", "Termometro", "Ensaio")
foreach ($subfolder in $subfolders) {
    $subfolderPath = Join-Path -Path $targetFolder -ChildPath $subfolder
    if (!(Test-Path $subfolderPath)) {
        New-Item -ItemType Directory -Path $subfolderPath | Out-Null
    }
}

# Criar subpastas personalizadas passadas pelo HTA
foreach ($customFolder in $customFolders) {
    if ($customFolder -ne "") {
        $customPath = Join-Path -Path $targetFolder -ChildPath $customFolder
        if (!(Test-Path $customPath)) {
            New-Item -ItemType Directory -Path $customPath | Out-Null
        }
    }
}

Write-Host "Pastas criadas com sucesso dentro de '$targetFolder'!"
