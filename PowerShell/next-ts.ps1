
# Función para crear el archivo tsconfig.json
function CreateTypeConfig {
    if (Test-Path "tsconfig.json") {
        $respuesta = Read-Host "tsconfig.json ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando tsconfig.json..."
        } else {
            Write-Host "No se reemplazará tsconfig.json."
            return
        }
    }

    $tsConfig = @"
{
  "compilerOptions": {
    "target": "ESNext",
    "lib": ["dom", "dom.iterable", "esnext"],
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "sourceMap": true,
    "baseUrl": "./",
    "strictNullChecks": true,
    "noImplicitAny": true,
    "strictBindCallApply": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "alwaysStrict": true,
    "noImplicitThis": true,
    "noImplicitReturns": true,
    "useUnknownInCatchVariables": true,
    "strictFunctionTypes": true,
    "strictPropertyInitialization": true,
    "noImplicitOverride": true,
    "allowJs": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@public/*": ["./public/*"]
    }
  },
  "include": ["next-env.d.ts", ".next/types/**/*.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
"@

    Set-Content -Path "tsconfig.json" -Value $tsConfig -Force
    Write-Host "tsconfig.json creado/reemplazado exitosamente."
}


function AskForPackageManager {
    $packageManager = Read-Host "¿Qué gestor de paquetes estás utilizando? (npm/yarn/pnpm)"

    if ($packageManager -eq 'npm' -or $packageManager -eq 'yarn' -or $packageManager -eq 'pnpm') {
        return $packageManager
    } else {
        Write-Host "Respuesta no válida. Debes ingresar 'npm', 'yarn' o 'pnpm'."
        return AskForPackageManager
    }
}

function InstallRequiredPackages {
    # Preguntar por el gestor de paquetes
    $packageManager = AskForPackageManager

    # Verifica si package.json existe
    if (Test-Path "package.json") {
        Write-Host "package.json encontrado. Instalando dependencias..."

        if ($packageManager -eq 'npm') {
            npm install --save-dev typescript
            Write-Host "Paquete TypeScript instalado correctamente con npm."
        } elseif ($packageManager -eq 'yarn') {
            yarn add --dev typescript
            Write-Host "Paquete TypeScript instalado correctamente con yarn."
        } elseif ($packageManager -eq 'pnpm') {
            pnpm i -D typescript
            Write-Host "Paquete TypeScript instalado correctamente con pnpm."
        }
    } else {
        Write-Host "package.json no encontrado. Asegúrate de estar en un proyecto Node.js."
    }
}

CreateTypeConfig

InstallRequiredPackages
