param(
    [string]$name
)

# Bucle para solicitar el nombre si no se ha proporcionado
while (-not $name) {
    $name = Read-Host "Por favor, proporciona un nombre para el Module"
}

# Definir las rutas principales y secundarias
$rootPath = Get-Location
$nameRoot = Join-Path -Path $rootPath -ChildPath $($name)
$nameLower = $name.Substring(0, 1).ToLower() + $name.Substring(1)

# Archivos a crear
$files = @(
    #application useCases
    "$nameRoot\application\useCases\index.ts",
    "$nameRoot\application\useCases\$($nameLower).usecase.ts",
    #application dtos
    "$nameRoot\application\dtos\index.ts",
    "$nameRoot\application\dtos\$($nameLower).dto.ts",
    #domain models
    "$nameRoot\domain\models\index.ts",
    "$nameRoot\domain\models\$($nameLower).model.ts",
    #domain interfaces
    "$nameRoot\domain\interfaces\index.ts",
    "$nameRoot\domain\interfaces\$($nameLower)Repository.interface.ts",
    #infrastructure api
    "$nameRoot\infrastructure\api\index.ts",
    "$nameRoot\infrastructure\api\$($nameLower)Api.service.ts",
    #infrastructure services
    "$nameRoot\infrastructure\services\index.ts",
    "$nameRoot\infrastructure\services\$($nameLower).service.ts",
    #infrastructure config
    "$nameRoot\infrastructure\config\index.ts",
    "$nameRoot\infrastructure\config\env.config.ts",
    #UI components
    "$nameRoot\UI\components\index.ts",
    "$nameRoot\UI\components\$($nameLower)Form.component.tsx",
    #UI hooks
    "$nameRoot\UI\hooks\index.ts",
    "$nameRoot\UI\hooks\use$($nameLower).hook.ts",
    #UI context
    "$nameRoot\UI\context\authContext.tsx",
    #tests unit
    "$nameRoot\tests\unit\$($nameLower)Service.test.ts",
    #tests integration
    "$nameRoot\tests\integration\$($nameLower)Flow.integration.test.ts",
    #page
    "$nameRoot\page.tsx"
)

# Crear los archivos con contenido inicial
foreach ($file in $files) {
    # Crear archivo
    New-Item -ItemType File -Path $file -Force | Out-Null
}

# Estructura del Proyecto con formato mejorado
Write-Host "`nEstructura del Proyecto: $($name)" -ForegroundColor Cyan
Write-Host "└── $($nameLower)/" -ForegroundColor Yellow
Write-Host "    ├── application/" -ForegroundColor Green
Write-Host "    │   ├── useCases/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower).usecase.ts" -ForegroundColor Green
Write-Host "    │   └── dto/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       └── $($nameLower).dto.ts" -ForegroundColor Green
Write-Host "    ├── domain/" -ForegroundColor Green
Write-Host "    │   ├── models/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower).model.ts" -ForegroundColor Green
Write-Host "    │   └── interfaces/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       └── $($nameLower)Repository.interfaces.ts" -ForegroundColor Green
Write-Host "    ├── infrastructure/" -ForegroundColor Green
Write-Host "    │   ├── api/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)Api.service.ts" -ForegroundColor Green
Write-Host "    │   ├── services/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower).service.ts" -ForegroundColor Green
Write-Host "    │   └── config/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       └── env.config.ts" -ForegroundColor Green
Write-Host "    ├── UI/" -ForegroundColor Green
Write-Host "    │   ├── components/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)Form.component.tsx" -ForegroundColor Green
Write-Host "    │   └── hooks/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       └── use$($nameLower).hook.ts" -ForegroundColor Green
Write-Host "    ├── tests/" -ForegroundColor Green
Write-Host "    │   ├── unit/" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)Service.test.ts" -ForegroundColor Green
Write-Host "    │   └── integration/" -ForegroundColor Green
Write-Host "    │       └── $($nameLower)Flow.integration.test.ts" -ForegroundColor Green
Write-Host "    └── page.tsx" -ForegroundColor Green
