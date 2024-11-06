function CreatePrettierConfig {
    if (Test-Path ".prettierrc") {
        $respuesta = Read-Host ".prettierrc ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando .prettierrc..."
        } else {
            Write-Host "No se reemplazará .prettierrc."
            return
        }
    }
    $prettierConfig = @"
{
  "endOfLine": "auto",
  "semi": false,
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "jsxSingleQuote": false,
  "trailingComma": "all",
  "bracketSpacing": true,
  "bracketSameLine": true,
  "proseWrap": "always",
  "useTabs": false,
  "parser": "typescript",
  "jsxBracketSameLine": false,
  "arrowParens": "always",
  "quoteProps": "as-needed",
  "fileInfoOptions": {
    "withNodeModules": true,
    "module": true,
    "exclude": [
      "node_modules/**",
      "**/__tests__/**",
      "**/__mocks__/**"
    ]
  },
  "htmlWhitespaceSensitivity": "ignore",
  "embeddedLanguageFormatting": "auto",
  "requireConfig": true,
  "singleAttributePerLine": false
}
"@

    Set-Content -Path ".prettierrc" -Value $prettierConfig -Force
    Write-Host ".prettierrc creado exitosamente."
}

function CreatePrettierIgnore {
      if (Test-Path ".prettierignore") {
        $respuesta = Read-Host ".prettierignore ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando .prettierignore..."
        } else {
            Write-Host "No se reemplazará .prettierignore."
            return
        }
    }
    $prettierIgnoreContent = @"
node_modules
generated/i18n.generated.ts
dist
.next
"@

    Set-Content -Path ".prettierignore" -Value $prettierIgnoreContent -Force
    Write-Host ".prettierignore creado exitosamente."
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
            npm install --save-dev prettier eslint-config-prettier
            Write-Host "Paquetes instalados correctamente con npm."
        } elseif ($packageManager -eq 'yarn') {
            yarn add --dev prettier eslint-config-prettier
            Write-Host "Paquetes instalados correctamente con yarn."
        } elseif ($packageManager -eq 'pnpm') {
            pnpm i -D prettier eslint-config-prettier
            Write-Host "Paquetes instalados correctamente con pnpm."
        }
    } else {
        Write-Host "package.json no encontrado. Asegúrate de estar en un proyecto Node.js."
    }
}

CreatePrettierConfig
CreatePrettierIgnore
InstallRequiredPackages
