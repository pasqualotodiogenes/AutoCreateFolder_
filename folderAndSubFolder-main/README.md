# Criador de Pastas Automático

Este script em PowerShell cria automaticamente uma pasta com a data atual e subpastas dentro dela. Caso a pasta do dia já exista, o script encerra a execução.

## 📂 Estrutura das Pastas Criadas
O script cria uma pasta com o nome da data atual no formato `DD.MM.AA` e, dentro dela, adiciona as seguintes subpastas:

- `Pista de Ski e Snow`
- `Tubing`
- `Vilarejo`
- `Termometro`
- `Ensaio`

Além disso, é possível adicionar subpastas personalizadas via parâmetros.

## 🚀 Como Usar

### 1️⃣ Executar o Script Diretamente
Abra o PowerShell e navegue até a pasta onde o script está salvo. Em seguida, execute o comando:

```powershell
.\create_folderAndSubFolder.ps1
```

Se quiser adicionar subpastas personalizadas ao executá-lo, utilize:

```powershell
.\create_folderAndSubFolder.ps1 -customFolders "Fotos Noturnas", "Time-lapse"
```

### 2️⃣ Configuração da Execução de Scripts
Caso o script não rode devido a restrições de execução, libere-o com:

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process
```

## 🔄 Lógica de Funcionamento
1. O script verifica se já existe uma pasta para o dia atual.
2. Se não existir, cria a pasta e as subpastas padrão.
3. Caso já exista, exibe uma mensagem informando que a pasta do dia já foi criada e encerra a execução.
4. Se forem passadas subpastas personalizadas, elas também são criadas dentro da pasta do dia.

## 🛠 Requisitos
- Windows
- PowerShell 5.1 ou superior

---

Qualquer dúvida ou sugestão, fique à vontade para contribuir! 🚀
