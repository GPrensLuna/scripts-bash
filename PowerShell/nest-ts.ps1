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
    "target": "ES2021",                            // Establece la versión de ECMAScript a utilizar
    "module": "commonjs",                         // Utiliza el sistema de módulos CommonJS
    "lib": ["ES2021", "DOM"],                     // Incluye la biblioteca de ES2021 y DOM
    "strict": true,                               // Activa todas las verificaciones estrictas
    "strictNullChecks": true,                     // Habilita la comprobación estricta de nulos
    "noImplicitAny": true,                        // Prohíbe el uso de 'any' implícito
    "noImplicitThis": true,                       // Activa la comprobación de tipos para 'this'
    "noUnusedLocals": true,                       // Genera un error si hay variables locales no utilizadas
    "noUnusedParameters": true,                   // Genera un error si hay parámetros no utilizados en funciones
    "noFallthroughCasesInSwitch": true,           // Genera un error si hay casos sin 'break' en un switch
    "noImplicitReturns": true,                     // Garantiza que todas las rutas de función devuelvan un valor
    "strictFunctionTypes": true,                  // Activa verificaciones estrictas para tipos de función
    "strictPropertyInitialization": true,         // Asegura que todas las propiedades de clase sean inicializadas
    "emitDecoratorMetadata": true,                // Emite metadatos para decoradores
    "experimentalDecorators": true,               // Habilita el uso de decoradores
    "allowSyntheticDefaultImports": true,         // Permite importaciones por defecto en módulos que no tienen exportaciones por defecto
    "resolveJsonModule": true,                    // Permite importar archivos JSON como módulos
    "incremental": true,                          // Habilita la compilación incremental
    "skipLibCheck": true,                         // Omitir la comprobación de tipos en los archivos de declaración (.d.ts)
    "sourceMap": true,                            // Genera archivos de mapas de fuente
    "outDir": "./dist",                           // Directorio de salida para archivos compilados
    "baseUrl": "./",                              // La raíz base para las resoluciones de módulos
    "typeRoots": ["./node_modules/@types", "./src/@types"], // Raíces de tipos para la resolución de tipos
    "forceConsistentCasingInFileNames": true,    // Obliga a utilizar una escritura consistente de los nombres de archivo
    "useUnknownInCatchVariables": true,           // Usa 'unknown' en lugar de 'any' para variables en catch
    "allowUnreachableCode": false,                // No permite código inalcanzable
    "allowUnusedLabels": false,                   // No permite etiquetas no utilizadas
    "allowJs": false,                             // Evita la compilación de archivos JS
    "exactOptionalPropertyTypes": true,           // Permite tipos opcionales exactos para propiedades de objetos
    "noImplicitOverride": true,                   // Genera un error si un método está sobreescribiendo sin un tipo definido
    "noPropertyAccessFromIndexSignature": true,   // Prohibe el acceso a propiedades de objetos indexados
    "strictBindCallApply": true,                  // Asegura que los métodos `bind`, `call` y `apply` sean estrictos
    "useDefineForClassFields": true,              // Usar la nueva sintaxis para la inicialización de campos de clase
    "suppressImplicitAnyIndexErrors": false       // No suprimir errores de índices implícitos con tipo any
  },
  "include": ["src/**/*.ts", "src/**/*.tsx"],
  "exclude": ["node_modules", "test", "dist", "**/*spec.ts"]
}
"@

    # Escribir el contenido en el archivo tsconfig.json
    Set-Content -Path "tsconfig.json" -Value $tsConfig -Force
    Write-Host "tsconfig.json creado exitosamente."
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

# Crear el archivo tsconfig.json
CreateTypeConfig

# Instalar el paquete requerido
InstallRequiredPackages
