param(
    [string]$modulePath
)

# Verifica si el parámetro está vacío
if (-not $modulePath) {
    Write-Host "Por favor, proporciona la ruta del módulo (ejemplo: module/user)" -ForegroundColor Red
    return
}

# Divide la ruta en partes usando '/' como delimitador
$pathParts = $modulePath -split '/'

# Extrae la última parte como el nombre del módulo
$name = $pathParts[-1]

# Extrae la ruta base (todo antes de la última parte)
$basePath = [string]::Join('\', $pathParts[0..($pathParts.Length - 2)])

# Comprobar si la ruta base existe, si no crearla
$rootPath = Join-Path -Path (Get-Location) -ChildPath $basePath

# Definir la ruta completa donde se creará el módulo
$nameRoot = Join-Path -Path $rootPath -ChildPath $name
$nameLower = $name.ToLower()

# Archivos a crear
$files = @(
    # application dtos
    "$nameRoot\application\dtos\index.ts",
    "$nameRoot\application\dtos\$($nameLower)-create.dto.ts",
    "$nameRoot\application\dtos\$($nameLower)-by-id.dto.ts",
    "$nameRoot\application\dtos\$($nameLower)-update.dto.ts",
    "$nameRoot\application\dtos\$($nameLower)-delete.dto.ts",
    "$nameRoot\application\dtos\$($nameLower)-get-all.dto.ts",
    "$nameRoot\application\dtos\error\$($nameLower)-errors.dto.ts",
    # application usecases
    "$nameRoot\application\usecase\index.ts",
    "$nameRoot\application\usecase\$($nameLower)-create.usecase.ts",
    "$nameRoot\application\usecase\$($nameLower)-by-id.usecase.ts",
    "$nameRoot\application\usecase\$($nameLower)-update.usecase.ts",
    "$nameRoot\application\usecase\$($nameLower)-delete.usecase.ts",
    "$nameRoot\application\usecase\$($nameLower)-get-all.usecase.ts",
    # domain entities
    "$nameRoot\domain\entities\$($nameLower).entity.ts",
    # domain interfaces
    "$nameRoot\domain\interfaces\index.ts",
    "$nameRoot\domain\interfaces\$($nameLower)-create.interface.ts",
    "$nameRoot\domain\interfaces\$($nameLower)-by-id.interface.ts",
    "$nameRoot\domain\interfaces\$($nameLower)-update.interface.ts",
    "$nameRoot\domain\interfaces\$($nameLower)-delete.interface.ts",
    "$nameRoot\domain\interfaces\$($nameLower)-get-all.interface.ts",
    # domain service
    "$nameRoot\domain\services\index.ts",
    "$nameRoot\domain\services\$($nameLower)-create.service.ts",
    "$nameRoot\domain\services\$($nameLower)-by-id.service.ts",
    "$nameRoot\domain\services\$($nameLower)-update.service.ts",
    "$nameRoot\domain\services\$($nameLower)-delete.service.ts",
    "$nameRoot\domain\services\$($nameLower)-get-all.service.ts",
    # infrastructure controllers
    "$nameRoot\infrastructure\controllers\index.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower).controller.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower)-create.controller.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower)-by-id.controller.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower)-update.controller.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower)-delete.controller.ts",
    "$nameRoot\infrastructure\controllers\$($nameLower)-get-all.controller.ts",
    # infrastructure repositories
    "$nameRoot\infrastructure\repositories\index.ts",
    "$nameRoot\infrastructure\repositories\$($nameLower)-prisma-create.repository.ts",
    "$nameRoot\infrastructure\repositories\$($nameLower)-prisma-by-id.repository.ts",
    "$nameRoot\infrastructure\repositories\$($nameLower)-prisma-update.repository.ts",
    "$nameRoot\infrastructure\repositories\$($nameLower)-prisma-delete.repository.ts",
    "$nameRoot\infrastructure\repositories\$($nameLower)-prisma-get-all.repository.ts",
    # infrastructure mappers
    "$nameRoot\infrastructure\mappers\$($nameLower).mapper.ts",
    # tests unit
    "$nameRoot\tests\unit\$($nameLower)-create.service.spec.ts",
    "$nameRoot\tests\unit\$($nameLower)-by-id.service.spec.ts",
    "$nameRoot\tests\unit\$($nameLower)-update.service.spec.ts",
    "$nameRoot\tests\unit\$($nameLower)-delete.service.spec.ts",
    "$nameRoot\tests\unit\$($nameLower)-get-all.service.spec.ts",
    # tests integration
    "$nameRoot\tests\integration\$($nameLower).controller.spec.ts",
    "$nameRoot\tests\integration\$($nameLower)-prisma.repository.spec.ts",
    # README
    "$nameRoot\README.md",
    # module
    "$nameRoot\$($nameLower).module.ts"
)

# Crear las carpetas necesarias
$folders = @(
    "$nameRoot\application\dtos\error",
    "$nameRoot\application\usecase",
    "$nameRoot\domain\entities",
    "$nameRoot\domain\repositories",
    "$nameRoot\infrastructure\controllers",
    "$nameRoot\infrastructure\repositories",
    "$nameRoot\infrastructure\mappers",
    "$nameRoot\tests\unit",
    "$nameRoot\tests\integration"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

# Crear los archivos con contenido inicial
foreach ($file in $files) {
    # Crear archivo
    New-Item -ItemType File -Path $file -Force | Out-Null
}

# Estructura del Proyecto con formato mejorado
Write-Host "`nEstructura del Proyecto: $($name)" -ForegroundColor Cyan
Write-Host "└── $($nameLower)/" -ForegroundColor Yellow
Write-Host "    ├── application/" -ForegroundColor Green
Write-Host "    │   ├── dtos/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-create.dto.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-by-id.dto.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-update.dto.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-delete.dto.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-get-all.dto.ts" -ForegroundColor Green
Write-Host "    │   │   └── error/" -ForegroundColor Green
Write-Host "    │   │       └── $($nameLower)-errors.dto.ts" -ForegroundColor Green
Write-Host "    │   └── usecase/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-create.usecase.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-by-id.usecase.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-update.usecase.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-delete.usecase.ts" -ForegroundColor Green
Write-Host "    │       └── $($nameLower)-get-all.usecase.ts" -ForegroundColor Green
Write-Host "    ├── domain/" -ForegroundColor Green
Write-Host "    │   ├── entities/" -ForegroundColor Green
Write-Host "    │   ├── services/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-create.service.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-by-id.service.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-update.service.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-delete.service.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)-get-all.service.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower).entity.ts" -ForegroundColor Green
Write-Host "    │   └── interfacess/" -ForegroundColor Green
Write-Host "    │       ├── index.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-create.interface.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-by-id.interface.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-update.interface.ts" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower)-delete.interface.ts" -ForegroundColor Green
Write-Host "    │       └── $($nameLower)-get-all.interface.ts" -ForegroundColor Green
Write-Host "    ├── infrastructure/" -ForegroundColor Green
Write-Host "    │   ├── controllers/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower).controller.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-create.controller.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-by-id.controller.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-update.controller.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-delete.controller.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)-get-all.controller.ts" -ForegroundColor Green
Write-Host "    │   ├── repositories/" -ForegroundColor Green
Write-Host "    │   │   ├── index.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-prisma-create.repository.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-prisma-by-id.repository.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-prisma-update.repository.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-prisma-delete.repository.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)-prisma-get-all.repository.ts" -ForegroundColor Green
Write-Host "    │   └── mappers/" -ForegroundColor Green
Write-Host "    │       └── $($nameLower).mapper.ts" -ForegroundColor Green
Write-Host "    ├── tests/" -ForegroundColor Green
Write-Host "    │   ├── unit/" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-create.service.spec.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-by-id.service.spec.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-update.service.spec.ts" -ForegroundColor Green
Write-Host "    │   │   ├── $($nameLower)-delete.service.spec.ts" -ForegroundColor Green
Write-Host "    │   │   └── $($nameLower)-get-all.service.spec.ts" -ForegroundColor Green
Write-Host "    │   └── integration/" -ForegroundColor Green
Write-Host "    │       ├── $($nameLower).controller.spec.ts" -ForegroundColor Green
Write-Host "    │       └── $($nameLower)-prisma.repository.spec.ts" -ForegroundColor Green
Write-Host "    ├── README.md" -ForegroundColor Green
Write-Host "    └── $($nameLower).module.ts" -ForegroundColor Green
