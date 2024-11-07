#!/bin/bash

#* 1. Función para pedir al usuario el tipo de proyecto
ask_project_type() {
    read -p "¿Estás trabajando con NestJS o Next.js? (nest/next): " framework
    echo "$framework"
}

#* 2. Función para pedir al usuario el nombre del módulo
ask_module_name() {
    read -p "Por favor, proporciona un nombre para el módulo (ejemplo: user): " name
    nameLower="$(echo ${name} | tr '[:upper:]' '[:lower:]')" # Convertir el nombre a minúsculas
    echo "$nameLower"
}

#* 3. Función para obtener la ruta del directorio actual y crear el nombre del módulo
get_module_path() {
    rootPath=$(pwd)
    nameRoot="$rootPath/$1"
    echo "$nameRoot"
}

#* 4. Función para generar la estructura de archivos y carpetas con contenido inicial
generate_files_and_folders_nest() {
    local rootPath="$1"
    local moduleName="$2"

    # Define las rutas de los archivos y su contenido inicial
    declare -A files=(
        # APPLICATION
        # DTO
        ["$rootPath/application/dtos/${moduleName}-create.dto.ts"]="export class ${moduleName^}CreateDto {}"
        ["$rootPath/application/dtos/${moduleName}-by-id.dto.ts"]="export class ${moduleName^}ByIdDto {}"
        ["$rootPath/application/dtos/${moduleName}-update.dto.ts"]="export class ${moduleName^}UpdateDto {}"
        ["$rootPath/application/dtos/${moduleName}-delete.dto.ts"]="export class ${moduleName^}DeleteDto {}"
        ["$rootPath/application/dtos/${moduleName}-get-all.dto.ts"]="export class ${moduleName^}GetAllDto {}"
        ["$rootPath/application/dtos/${moduleName}-errors.dto.ts"]="export class ${moduleName^}ErrorsDto {}"

        # USE CASE
        ["$rootPath/application/use-case/${moduleName}-create.use-case.ts"]="export class ${moduleName^}CreateUseCase {}"
        ["$rootPath/application/use-case/${moduleName}-by-id.use-case.ts"]="export class ${moduleName^}ByIdUseCase {}"
        ["$rootPath/application/use-case/${moduleName}-update.use-case.ts"]="export class ${moduleName^}UpdateUseCase {}"
        ["$rootPath/application/use-case/${moduleName}-delete.use-case.ts"]="export class ${moduleName^}DeleteUseCase {}"
        ["$rootPath/application/use-case/${moduleName}-get-all.use-case.ts"]="export class ${moduleName^}GetAllUseCase {}"

        # DOMAIN
        # ENTITY
        ["$rootPath/domain/entities/${moduleName}.entity.ts"]="export class ${moduleName^}Entity {}"

        # INTERFACE
        ["$rootPath/domain/interfaces/${moduleName}-input.interface.ts"]="export interface ${moduleName^}Input {}"
        ["$rootPath/domain/interfaces/${moduleName}-output.interface.ts"]="export interface ${moduleName^}Output {}"

        # SERVICE
        ["$rootPath/domain/services/${moduleName}-create.service.ts"]="export class ${moduleName^}CreateService {}"
        ["$rootPath/domain/services/${moduleName}-by-id.service.ts"]="export class ${moduleName^}ByIdService {}"
        ["$rootPath/domain/services/${moduleName}-update.service.ts"]="export class ${moduleName^}UpdateService {}"
        ["$rootPath/domain/services/${moduleName}-delete.service.ts"]="export class ${moduleName^}DeleteService {}"
        ["$rootPath/domain/services/${moduleName}-get-all.service.ts"]="export class ${moduleName^}GetAllService {}"

        # INFRASTRUCTURE
        # CONTROLLERS
        ["$rootPath/infrastructure/controllers/${moduleName}-create.controller.ts"]="export class ${moduleName^}CreateController {}"
        ["$rootPath/infrastructure/controllers/${moduleName}-by-id.controller.ts"]="export class ${moduleName^}ByIdController {}"
        ["$rootPath/infrastructure/controllers/${moduleName}-update.controller.ts"]="export class ${moduleName^}UpdateController {}"
        ["$rootPath/infrastructure/controllers/${moduleName}-delete.controller.ts"]="export class ${moduleName^}DeleteController {}"
        ["$rootPath/infrastructure/controllers/${moduleName}-get-all.controller.ts"]="export class ${moduleName^}GetAllController {}"

        # REPOSITORIES
        ["$rootPath/infrastructure/repositories/index.ts"]="// Repositories index file for $moduleName"
        ["$rootPath/infrastructure/repositories/${moduleName}-prisma-create.repository.ts"]="export class ${moduleName^}PrismaCreateRepository {}"
        ["$rootPath/infrastructure/repositories/${moduleName}-prisma-by-id.repository.ts"]="export class ${moduleName^}PrismaByIdRepository {}"
        ["$rootPath/infrastructure/repositories/${moduleName}-prisma-update.repository.ts"]="export class ${moduleName^}PrismaUpdateRepository {}"
        ["$rootPath/infrastructure/repositories/${moduleName}-prisma-delete.repository.ts"]="export class ${moduleName^}PrismaDeleteRepository {}"
        ["$rootPath/infrastructure/repositories/${moduleName}-prisma-get-all.repository.ts"]="export class ${moduleName^}PrismaGetAllRepository {}"

        # TESTS
        # UNIT
        ["$rootPath/tests/unit/${moduleName}-create.service.spec.ts"]="describe('${moduleName^}CreateService Tests', () => {});"
        ["$rootPath/tests/unit/${moduleName}-by-id.service.spec.ts"]="describe('${moduleName^}ByIdService Tests', () => {});"
        ["$rootPath/tests/unit/${moduleName}-update.service.spec.ts"]="describe('${moduleName^}UpdateService Tests', () => {});"
        ["$rootPath/tests/unit/${moduleName}-delete.service.spec.ts"]="describe('${moduleName^}DeleteService Tests', () => {});"
        ["$rootPath/tests/unit/${moduleName}-get-all.service.spec.ts"]="describe('${moduleName^}GetAllService Tests', () => {});"

        # INTEGRATION
        ["$rootPath/tests/integration/${moduleName}.controller.spec.ts"]="describe('${moduleName^}Controller Tests', () => {});"
        ["$rootPath/tests/integration/${moduleName}-prisma.repository.spec.ts"]="describe('${moduleName^}PrismaRepository Tests', () => {});"

        # README
        ["$rootPath/README.md"]="# $moduleName Module\nEste módulo contiene la lógica de negocio para $moduleName."

        # Para controllers
        ["$rootPath/${moduleName}.module.ts"]="import { Module } from '@nestjs/common';\n\n@Module({})\nexport class ${moduleName^}Module {}"
    )

    # Crea cada carpeta y archivo según lo especificado en el array files
    for filePath in "${!files[@]}"; do
        mkdir -p "$(dirname "$filePath")" # Crea la carpeta
        echo -e "${files[$filePath]}" > "$filePath" # Crea el archivo con contenido
    done

    #APPLICATION
    # Para dtos
    dtosIndex="$rootPath/application/dtos/index.ts"
    echo "export * from \"./${moduleName}-errors.dto\";" > "$dtosIndex"
    echo "export * from \"./${moduleName}-by-id.dto\";" >> "$dtosIndex"
    echo "export * from \"./${moduleName}-create.dto\";" >> "$dtosIndex"
    echo "export * from \"./${moduleName}-delete.dto\";" >> "$dtosIndex"
    echo "export * from \"./${moduleName}-get-all.dto\";" >> "$dtosIndex"
    echo "export * from \"./${moduleName}-update.dto\";" >> "$dtosIndex"

    # Para use-case
    useCaseIndex="$rootPath/application/use-case/index.ts"
    echo "export * from \"./${moduleName}-create.use-case\";" > "$useCaseIndex"
    echo "export * from \"./${moduleName}-by-id.use-case\";" >> "$useCaseIndex"
    echo "export * from \"./${moduleName}-update.use-case\";" >> "$useCaseIndex"
    echo "export * from \"./${moduleName}-delete.use-case\";" >> "$useCaseIndex"
    echo "export * from \"./${moduleName}-get-all.use-case\";" >> "$useCaseIndex"

    #DOMAIN
    # Para entities
    interfacesIndex="$rootPath/domain/entities/index.ts"
    echo "export * from \"./${moduleName}.entity\";" > "$interfacesIndex"

    # Para interfaces
    interfacesIndex="$rootPath/domain/interfaces/index.ts"
    echo "export * from \"./${moduleName}-input.interface\";" > "$interfacesIndex"
    echo "export * from \"./${moduleName}-output.interface\";" >> "$interfacesIndex"

    # Para servicios
    servicesIndex="$rootPath/domain/services/index.ts"
    echo "export * from \"./${moduleName}-create.service\";" > "$servicesIndex"
    echo "export * from \"./${moduleName}-by-id.service\";" >> "$servicesIndex"
    echo "export * from \"./${moduleName}-update.service\";" >> "$servicesIndex"
    echo "export * from \"./${moduleName}-delete.service\";" >> "$servicesIndex"
    echo "export * from \"./${moduleName}-get-all.service\";" >> "$servicesIndex"

    #INFRASTRUCTURE
    # Para repositorios
    repositoriesIndex="$rootPath/infrastructure/repositories/index.ts"
    echo "export * from \"./${moduleName}-prisma-create.repository\";" > "$repositoriesIndex"
    echo "export * from \"./${moduleName}-prisma-by-id.repository\";" >> "$repositoriesIndex"
    echo "export * from \"./${moduleName}-prisma-update.repository\";" >> "$repositoriesIndex"
    echo "export * from \"./${moduleName}-prisma-delete.repository\";" >> "$repositoriesIndex"
    echo "export * from \"./${moduleName}-prisma-get-all.repository\";" >> "$repositoriesIndex"
}

generate_files_and_folders_next() {
    local rootPath="$1"
      local moduleName="$2"


    # Define rutas y contenidos iniciales de archivos
    declare -A files=(
        # Application Layer
        ["$rootPath/application/use-cases/${moduleName}.use-case.ts"]="export class ${moduleNamePascal}UseCase {\n    execute() {\n        // Implementación del caso de uso\n    }\n}"
        ["$rootPath/application/use-cases/index.ts"]="export * from './${moduleName}.use-case';"
        ["$rootPath/application/dtos/${moduleName}.dto.ts"]="export class ${moduleNamePascal}Dto {\n    // Definir las propiedades y validaciones\n}"
        ["$rootPath/application/dtos/index.ts"]="export * from './${moduleName}.dto';"

        # Domain Layer
        ["$rootPath/domain/entities/${moduleName}.entity.ts"]="export class ${moduleNamePascal}Entity {\n    // Definir las propiedades del modelo\n}"
        ["$rootPath/domain/entities/index.ts"]="export * from './${moduleName}.entity';"
        ["$rootPath/domain/interfaces/${moduleName}-api.interface.ts"]="export interface ${moduleNamePascal}Api {\n    // Definir los métodos de la API relacionados\n}"
        ["$rootPath/domain/interfaces/index.ts"]="export * from './${moduleName}-api.interface';"

        # UI Layer
        ["$rootPath/UI/components/${moduleName}-form.component.tsx"]="import React from 'react';\n\nexport const ${moduleNamePascal}Form = () => {\n    return <div>${moduleNamePascal} Form Component</div>;\n};"
        ["$rootPath/UI/components/index.ts"]="export * from './${moduleName}-form.component';"
        ["$rootPath/UI/hooks/use-${moduleName}.hook.ts"]="import { useState, useEffect } from 'react';\n\nexport const use${moduleNamePascal} = () => {\n    // Implementar lógica de hook\n};"
        ["$rootPath/UI/hooks/index.ts"]="export * from './use-${moduleName}.hook';"
        ["$rootPath/UI/context/${moduleName}.context.ts"]="import { createContext } from 'react';\n\nexport const ${moduleNamePascal}Context = createContext(null);"
        ["$rootPath/UI/context/index.ts"]="export * from './${moduleName}.context';"
        ["$rootPath/UI/config/env.config.ts"]="export const config = {\n    // Configuraciones del entorno\n};"
        ["$rootPath/UI/config/index.ts"]="export * from './env.config';"

        # Tests Layer
        ["$rootPath/tests/unit/${moduleName}Service.test.ts"]="import { ${moduleNamePascal}Service } from '../../domain/services/${moduleName}.service';\n\ndescribe('${moduleNamePascal}Service', () => {\n    it('should work correctly', () => {\n        // Prueba de unidad\n    });\n});"
        ["$rootPath/tests/integration/${moduleName}Flow.integration.test.ts"]="describe('${moduleNamePascal} Integration Flow', () => {\n    it('should execute the integration flow successfully', () => {\n        // Prueba de integración\n    });\n});"

        # Root Page
        ["$rootPath/page.tsx"]="import React from 'react';\n\nconst ${moduleNamePascal}Page = () => {\n    return <div>Página principal para ${moduleNamePascal}</div>;\n};\n\nexport default ${moduleNamePascal}Page;"
    )

    # Crear cada carpeta y archivo con contenido inicial
    for filePath in "${!files[@]}"; do
        mkdir -p "$(dirname "$filePath")"
        echo -e "${files[$filePath]}" > "$filePath"
    done

    # Log de finalización
    echo "Estructura de archivos y carpetas creada exitosamente para el módulo '$moduleName' en '$rootPath'."
}

#* 5. Función para imprimir estructura de carpetas y archivos

generate_estructura_files_and_folders_nest() {
    local nameRoot="$1"

    echo -e "    ├── application/"
    echo -e "    │   ├── dtos/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameRoot}-by-id.dto.ts"
    echo -e "    │   │   ├── ${nameRoot}-create.dto.ts"
    echo -e "    │   │   ├── ${nameRoot}-delete.dto.ts"
    echo -e "    │   │   ├── ${nameRoot}-errors.dto.ts"
    echo -e "    │   │   ├── ${nameRoot}-get-all.dto.ts"
    echo -e "    │   │   └── ${nameRoot}-update.dto.ts"
    echo -e "    │   └── use-case/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       ├── ${nameRoot}-by-id.use-case.ts"
    echo -e "    │       ├── ${nameRoot}-create.use-case.ts"
    echo -e "    │       ├── ${nameRoot}-delete.use-case.ts"
    echo -e "    │       ├── ${nameRoot}-get-all.use-case.ts"
    echo -e "    │       └── ${nameRoot}-update.use-case.ts"
    echo -e "    ├── domain/"
    echo -e "    │   ├── entities/"
    echo -e "    │       ├── index.ts"
    echo -e "    │   │   └── ${nameRoot}.entity.ts"
    echo -e "    │   ├── interfaces/"
    echo -e "    │   │    ├── index.ts"
    echo -e "    │   │    ├── ${nameRoot}-input.interface.ts"
    echo -e "    │   │    └── ${nameRoot}-output.interface.ts"
    echo -e "    │   └── services/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       ├── ${nameRoot}-by-id.service.ts"
    echo -e "    │       ├── ${nameRoot}-create.service.ts"
    echo -e "    │       ├── ${nameRoot}-delete.service.ts"
    echo -e "    │       ├── ${nameRoot}-get-all.service.ts"
    echo -e "    │       └── ${nameRoot}-update.service.ts"
    echo -e "    ├── infrastructure/"
    echo -e "    │   ├── controllers/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameRoot}-by-id.controller.ts"
    echo -e "    │   │   ├── ${nameRoot}-create.controller.ts"
    echo -e "    │   │   ├── ${nameRoot}-delete.controller.ts"
    echo -e "    │   │   ├── ${nameRoot}-get-all.controller.ts"
    echo -e "    │   │   └── ${nameRoot}-update.controller.ts"
    echo -e "    │   └── repositories/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       ├── ${nameRoot}-prisma-create.repository.ts"
    echo -e "    │       ├── ${nameRoot}-prisma-by-id.repository.ts"
    echo -e "    │       ├── ${nameRoot}-prisma-update.repository.ts"
    echo -e "    │       ├── ${nameRoot}-prisma-delete.repository.ts"
    echo -e "    │       └── ${nameRoot}-prisma-get-all.repository.ts"
    echo -e "    ├── tests/"
    echo -e "    │   ├── integration/"
    echo -e "    │   │   ├── ${nameRoot}-prisma.repository.spec.ts"
    echo -e "    │   │   └── ${nameRoot}.controller.spec.ts"
    echo -e "    │   └── unit/"
    echo -e "    │       ├── ${nameRoot}-by-id.service.spec.ts"
    echo -e "    │       ├── ${nameRoot}-create.service.spec.ts"
    echo -e "    │       ├── ${nameRoot}-delete.service.spec.ts"
    echo -e "    │       ├── ${nameRoot}-get-all.service.spec.ts"
    echo -e "    │       └── ${nameRoot}-update.service.spec.ts"
    echo -e "    ├── README.md"
    echo -e "    └── ${nameRoot}.module.ts"
}
generate_estructura_files_and_folders_next() {
    local nameRoot="$1"

    echo -e "    ├── application/"
    echo -e "    │   ├── use-cases/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.use-case.ts"
    echo -e "    │   └── dtos/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── ${nameLower}.dto.ts"
    echo -e "    ├── domain/"
    echo -e "    │   ├── entities/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.entity.ts"
    echo -e "    │   └── interfaces/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── ${nameLower}-api.interface.ts"
    echo -e "    ├── UI/"
    echo -e "    │   ├── components/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}-form.component.tsx"
    echo -e "    │   ├── hooks/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── use${nameLower}.hook.ts"
    echo -e "    │   ├── context/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.context.ts"
    echo -e "    │   └── config/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── env.config.ts"
    echo -e "    ├── tests/"
    echo -e "    │   ├── unit/"
    echo -e "    │   │   └── ${nameLower}Service.test.ts"
    echo -e "    │   └── integration/"
    echo -e "    │       └── ${nameLower}Flow.integration.test.ts"
    echo -e "    └── page.tsx"
}
main() {
    framework=$(ask_project_type)
    module_name=$(ask_module_name)
    module_path=$(get_module_path "$module_name")

    # Ejecutar la función según el tipo de proyecto
    if [ "$framework" == "nest" ]; then
        generate_files_and_folders_nest "$module_path" "$module_name"

        # Mostrar la estructura en la terminal
        generate_estructura_files_and_folders_nest "$module_name"
    elif [ "$framework" == "next" ]; then
        generate_files_and_folders_next "$module_path" "$module_name"
    else
        echo "Framework no reconocido. Solo se soportan 'nest' o 'next'."
        exit 1
    fi
}

main

