#!/bin/bash

# ------------------------------------------------------------------------------
# 1. Función para verificar si el archivo tsconfig.json ya existe
check_tsconfig_exists() {
    if [ -f "tsconfig.json" ]; then
        read -p "tsconfig.json ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará tsconfig.json."
            return 1  # Retorna 1 si no se reemplaza
        fi
    fi
    return 0  # Retorna 0 si se reemplazará
}

# ------------------------------------------------------------------------------
# 2. Función para pedir al usuario el tipo de proyecto
ask_project_type() {
    read -p "¿Es un proyecto de Next.js o Nest.js? (next/nest): " project_type
    echo "$project_type"
}

# ------------------------------------------------------------------------------
# 3. Función para generar la configuración de tsconfig para Next.js
generate_next_tsconfig() {
    echo '{
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
}'
}

# ------------------------------------------------------------------------------
# 4. Función para generar la configuración de tsconfig para Nest.js
generate_nest_tsconfig() {
    echo '{
  "compilerOptions": {
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "alwaysStrict": true,
    "exactOptionalPropertyTypes": true,
    "noFallthroughCasesInSwitch": true,
    "noImplicitAny": true,
    "noImplicitOverride": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noPropertyAccessFromIndexSignature": true,
    "noUncheckedIndexedAccess": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "strict": true,
    "strictBindCallApply": true,
    "strictBuiltinIteratorReturn": true,
    "strictFunctionTypes": true,
    "strictNullChecks": true,
    "strictPropertyInitialization": true,
    "useUnknownInCatchVariables": true,
    "baseUrl": "./",
    "module": "commonjs",
    "target": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "declaration": true,
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "typeRoots": ["./node_modules/@types", "./src/@types"],
    "lib": ["ES2021", "DOM"],
    "incremental": true,
    "noEmitOnError": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "allowJs": false,
    "useDefineForClassFields": true,
    "suppressImplicitAnyIndexErrors": false,
    "disableSizeLimit": true,
    "removeComments": true
  },
  "include": ["src/**/*.ts", "src/@types/**/*.d.ts", "prettier.config.js", "package.json"],
  "exclude": ["node_modules", "dist", "package.json"]
}'
}

# ------------------------------------------------------------------------------
# 5. Función para manejar el gestor de paquetes (npm, yarn, pnpm)
ask_for_package_manager() {
    read -p "¿Qué gestor de paquetes estás utilizando? (npm/yarn/pnpm): " package_manager
    if [[ "$package_manager" == "npm" || "$package_manager" == "yarn" || "$package_manager" == "pnpm" ]]; then
        echo "$package_manager"
    else
        echo "Respuesta no válida. Debes ingresar 'npm', 'yarn' o 'pnpm'."
        ask_for_package_manager  # Llamada recursiva
    fi
}

# ------------------------------------------------------------------------------
# 6. Función para instalar TypeScript
install_required_packages() {
    package_manager=$(ask_for_package_manager)

    if [ -f "package.json" ]; then
        echo "package.json encontrado. Instalando dependencias..."

        case "$package_manager" in
            npm)
                npm install --save-dev typescript
                echo "Paquete TypeScript instalado correctamente con npm."
                ;;
            yarn)
                yarn add --dev typescript
                echo "Paquete TypeScript instalado correctamente con yarn."
                ;;
            pnpm)
                pnpm i -D typescript
                echo "Paquete TypeScript instalado correctamente con pnpm."
                ;;
        esac
    else
        echo "package.json no encontrado. Asegúrate de estar en un proyecto Node.js."
    fi
}

# ------------------------------------------------------------------------------
# 7. Función principal que organiza el flujo del script
main() {
    # Verificar si tsconfig.json existe y preguntar si se desea reemplazar
    check_tsconfig_exists || return  # Si no se desea reemplazar, detener la ejecución

    # Pedir el tipo de proyecto
    project_type=$(ask_project_type)

    # Generar la configuración de tsconfig según el tipo de proyecto
    case "$project_type" in
        next)
            ts_config=$(generate_next_tsconfig)
            ;;
        nest)
            ts_config=$(generate_nest_tsconfig)
            ;;
        *)
            echo "Tipo de proyecto no válido. Debes ingresar 'next' o 'nest'."
            return
            ;;
    esac

    # Crear el archivo tsconfig.json
    echo "$ts_config" > tsconfig.json
    echo "tsconfig.json creado/reemplazado exitosamente."

    # Instalar paquetes requeridos
    install_required_packages
}

# Llamada a la función principal para ejecutar el script
main
