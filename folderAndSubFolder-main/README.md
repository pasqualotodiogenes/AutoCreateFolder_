param (
    [string]$folderDate = $(Get-Date -Format "dd.MM.yy"),
    [string[]]$customFolders = @()
)

# Define o diretório base como o local onde o script está sendo executado
$baseDir = $PSScriptRoot
$targetFolder = Join-Path -Path $baseDir -ChildPath $folderDate

# Se a pasta do dia já existir, encerrar o script
if (Test-Path $targetFolder) {
    Write-Host "A pasta '$folderDate' já foi criada anteriormente. Nenhuma nova ação necessária."
    exit
}

# Criar a pasta principal
New-Item -ItemType Directory -Path $targetFolder | Out-Null

# Criar subpastas padrão
$subfolders = @("Pista de Ski e Snow", "Tubing", "Vilarejo", "Termometro", "Ensaio")
foreach ($subfolder in $subfolders) {
    $subfolderPath = Join-Path -Path $targetFolder -ChildPath $subfolder
    New-Item -ItemType Directory -Path $subfolderPath | Out-Null
}

# Criar subpastas personalizadas passadas pelo usuário
foreach ($customFolder in $customFolders) {
    if ($customFolder -ne "") {
        $customPath = Join-Path -Path $targetFolder -ChildPath $customFolder
        New-Item -ItemType Directory -Path $customPath | Out-Null
    }
}

Write-Host "As pastas foram criadas com sucesso dentro de '$targetFolder'!"
