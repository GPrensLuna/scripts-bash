#!/bin/bash

# Solicitar el tipo de proyecto (Nest.js o Next.js)
read -p "¿Es un proyecto de Nest.js o Next.js? (nest/next): " project_type

if [[ "$project_type" != "nest" && "$project_type" != "next" ]]; then
    echo -e "\e[31mPor favor, ingresa 'nest' o 'next'.\e[0m"
    exit 1
fi

# Solicitar el nombre del módulo
read -p "Por favor, proporciona un nombre para el módulo (ejemplo: user): " name

# Convertir el nombre del módulo a minúsculas
nameLower="$(echo ${name} | tr '[:upper:]' '[:lower:]')"

# Obtener la ruta del directorio actual y crear el nombre del módulo
rootPath=$(pwd)
nameRoot="$rootPath/$nameLower"

# Crear las carpetas necesarias según el tipo de proyecto
if [[ "$project_type" == "nest" ]]; then
    folders=(
        "$nameRoot/application/dtos"
        "$nameRoot/application/use-case"
        "$nameRoot/domain/entities"
        "$nameRoot/domain/services"
        "$nameRoot/domain/interfaces"
        "$nameRoot/infrastructure/controllers"
        "$nameRoot/infrastructure/repositories"
        "$nameRoot/infrastructure/mappers"
        "$nameRoot/tests/unit"
        "$nameRoot/tests/integration"
    )
elif [[ "$project_type" == "next" ]]; then
    folders=(
        "$nameRoot/application/use-Cases"
        "$nameRoot/application/dtos"
        "$nameRoot/domain/models"
        "$nameRoot/domain/interfaces"
        "$nameRoot/infrastructure/api"
        "$nameRoot/infrastructure/services"
        "$nameRoot/infrastructure/config"
        "$nameRoot/UI/components"
        "$nameRoot/UI/hooks"
        "$nameRoot/UI/context"
        "$nameRoot/tests/unit"
        "$nameRoot/tests/integration"
    )
fi

# Crear las carpetas
for folder in "${folders[@]}"; do
    mkdir -p "$folder"
done

# Crear los archivos dependiendo del tipo de proyecto
declare -a files
if [[ "$project_type" == "nest" ]]; then
    files=(
        "$nameRoot/application/dtos/index.ts"
        "$nameRoot/application/dtos/${nameLower}-create.dto.ts"
        "$nameRoot/application/dtos/${nameLower}-by-id.dto.ts"
        "$nameRoot/application/dtos/${nameLower}-update.dto.ts"
        "$nameRoot/application/dtos/${nameLower}-delete.dto.ts"
        "$nameRoot/application/dtos/${nameLower}-get-all.dto.ts"
        "$nameRoot/application/dtos/error/${nameLower}-errors.dto.ts"
        "$nameRoot/application/use-case/index.ts"
        "$nameRoot/application/use-case/${nameLower}-create.use-case.ts"
        "$nameRoot/application/use-case/${nameLower}-by-id.use-case.ts"
        "$nameRoot/application/use-case/${nameLower}-update.use-case.ts"
        "$nameRoot/application/use-case/${nameLower}-delete.use-case.ts"
        "$nameRoot/application/use-case/${nameLower}-get-all.use-case.ts"
        "$nameRoot/domain/entities/${nameLower}.entity.ts"
        "$nameRoot/domain/interfaces/index.ts"
        "$nameRoot/domain/interfaces/${nameLower}-ip-put.interface.ts"
        "$nameRoot/domain/interfaces/${nameLower}-out-put.interface.ts"
        "$nameRoot/domain/services/index.ts"
        "$nameRoot/domain/services/${nameLower}-create.service.ts"
        "$nameRoot/domain/services/${nameLower}-by-id.service.ts"
        "$nameRoot/domain/services/${nameLower}-update.service.ts"
        "$nameRoot/domain/services/${nameLower}-delete.service.ts"
        "$nameRoot/domain/services/${nameLower}-get-all.service.ts"
        "$nameRoot/infrastructure/controllers/index.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}.controller.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}-create.controller.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}-by-id.controller.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}-update.controller.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}-delete.controller.ts"
        "$nameRoot/infrastructure/controllers/${nameLower}-get-all.controller.ts"
        "$nameRoot/infrastructure/repositories/index.ts"
        "$nameRoot/infrastructure/repositories/${nameLower}-prisma-create.repository.ts"
        "$nameRoot/infrastructure/repositories/${nameLower}-prisma-by-id.repository.ts"
        "$nameRoot/infrastructure/repositories/${nameLower}-prisma-update.repository.ts"
        "$nameRoot/infrastructure/repositories/${nameLower}-prisma-delete.repository.ts"
        "$nameRoot/infrastructure/repositories/${nameLower}-prisma-get-all.repository.ts"
        "$nameRoot/infrastructure/mappers/${nameLower}.mapper.ts"
        "$nameRoot/tests/unit/${nameLower}-create.service.spec.ts"
        "$nameRoot/tests/unit/${nameLower}-by-id.service.spec.ts"
        "$nameRoot/tests/unit/${nameLower}-update.service.spec.ts"
        "$nameRoot/tests/unit/${nameLower}-delete.service.spec.ts"
        "$nameRoot/tests/unit/${nameLower}-get-all.service.spec.ts"
        "$nameRoot/tests/integration/${nameLower}.controller.spec.ts"
        "$nameRoot/tests/integration/${nameLower}-prisma.repository.spec.ts"
        "$nameRoot/README.md"
        "$nameRoot/${nameLower}.module.ts"
    )
elif [[ "$project_type" == "next" ]]; then
    files=(
        "$nameRoot/application/use-Cases/index.ts"
        "$nameRoot/application/use-Cases/${nameLower}.use-case.ts"
        "$nameRoot/application/dtos/index.ts"
        "$nameRoot/application/dtos/${nameLower}.dto.ts"
        "$nameRoot/domain/models/index.ts"
        "$nameRoot/domain/models/${nameLower}.model.ts"
        "$nameRoot/domain/interfaces/index.ts"
        "$nameRoot/domain/interfaces/${nameLower}Repository.interface.ts"
        "$nameRoot/infrastructure/api/index.ts"
        "$nameRoot/infrastructure/api/${nameLower}Api.service.ts"
        "$nameRoot/infrastructure/services/index.ts"
        "$nameRoot/infrastructure/services/${nameLower}.service.ts"
        "$nameRoot/infrastructure/config/index.ts"
        "$nameRoot/infrastructure/config/env.config.ts"
        "$nameRoot/UI/components/index.ts"
        "$nameRoot/UI/components/${nameLower}Form.component.tsx"
        "$nameRoot/UI/hooks/index.ts"
        "$nameRoot/UI/hooks/use${nameLower}.hook.ts"
        "$nameRoot/UI/context/authContext.tsx"
        "$nameRoot/tests/unit/${nameLower}Service.test.ts"
        "$nameRoot/tests/integration/${nameLower}Flow.integration.test.ts"
        "$nameRoot/page.tsx"
    )
fi

# Crear los archivos
for file in "${files[@]}"; do
    touch "$file"
done

# Mostrar la estructura del proyecto
echo -e "\nEstructura del Proyecto: $name"
echo -e "└── $nameLower/"
if [[ "$project_type" == "nest" ]]; then
    echo -e "    ├── application/"
    echo -e "    │   ├── dtos/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameLower}-create.dto.ts"
    echo -e "    │   │   ├── ${nameLower}-by-id.dto.ts"
    echo -e "    │   │   ├── ${nameLower}-update.dto.ts"
    echo -e "    │   │   ├── ${nameLower}-delete.dto.ts"
    echo -e "    │   │   ├── ${nameLower}-get-all.dto.ts"
    echo -e "    │   │   └── error/"
    echo -e "    │   │       └── ${nameLower}-errors.dto.ts"
    echo -e "    │   └── use-case/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       ├── ${nameLower}-create.use-case.ts"
    echo -e "    │       ├── ${nameLower}-by-id.use-case.ts"
    echo -e "    │       ├── ${nameLower}-update.use-case.ts"
    echo -e "    │       ├── ${nameLower}-delete.use-case.ts"
    echo -e "    │       └── ${nameLower}-get-all.use-case.ts"
    echo -e "    ├── domain/"
    echo -e "    │   ├── entities/"
    echo -e "    │   ├── services/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameLower}-create.service.ts"
    echo -e "    │   │   ├── ${nameLower}-by-id.service.ts"
    echo -e "    │   │   ├── ${nameLower}-update.service.ts"
    echo -e "    │   │   ├── ${nameLower}-delete.service.ts"
    echo -e "    │   │   └── ${nameLower}-get-all.service.ts"
    echo -e "    │   └── interfaces/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       ├── ${nameLower}-in-pu.interface.ts"
    echo -e "    │       └── ${nameLower}-out-put.interface.ts"
    echo -e "    ├── infrastructure/"
    echo -e "    │   ├── controllers/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameLower}.controller.ts"
    echo -e "    │   │   ├── ${nameLower}-create.controller.ts"
    echo -e "    │   │   ├── ${nameLower}-by-id.controller.ts"
    echo -e "    │   │   ├── ${nameLower}-update.controller.ts"
    echo -e "    │   │   ├── ${nameLower}-delete.controller.ts"
    echo -e "    │   │   └── ${nameLower}-get-all.controller.ts"
    echo -e "    │   ├── repositories/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   ├── ${nameLower}-prisma-create.repository.ts"
    echo -e "    │   │   ├── ${nameLower}-prisma-by-id.repository.ts"
    echo -e "    │   │   ├── ${nameLower}-prisma-update.repository.ts"
    echo -e "    │   │   ├── ${nameLower}-prisma-delete.repository.ts"
    echo -e "    │   │   └── ${nameLower}-prisma-get-all.repository.ts"
    echo -e "    │   └── mappers/"
    echo -e "    │       └── ${nameLower}.mapper.ts"
    echo -e "    ├── tests/"
    echo -e "    │   ├── unit/"
    echo -e "    │   │   ├── ${nameLower}-create.service.spec.ts"
    echo -e "    │   │   ├── ${nameLower}-by-id.service.spec.ts"
    echo -e "    │   │   ├── ${nameLower}-update.service.spec.ts"
    echo -e "    │   │   ├── ${nameLower}-delete.service.spec.ts"
    echo -e "    │   │   └── ${nameLower}-get-all.service.spec.ts"
    echo -e "    │   └── integration/"
    echo -e "    │       ├── ${nameLower}.controller.spec.ts"
    echo -e "    │       └── ${nameLower}-prisma.repository.spec.ts"
    echo -e "    ├── README.md"
    echo -e "    └── ${nameLower}.module.ts"
elif [[ "$project_type" == "next" ]]; then
    echo -e "    ├── application/"
    echo -e "    │   ├── use-Cases/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.use-case.ts"
    echo -e "    │   └── dtos/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── ${nameLower}.dto.ts"
    echo -e "    ├── domain/"
    echo -e "    │   ├── models/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.model.ts"
    echo -e "    │   └── interfaces/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── ${nameLower}Repository.interface.ts"
    echo -e "    ├── infrastructure/"
    echo -e "    │   ├── api/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}Api.service.ts"
    echo -e "    │   ├── services/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}.service.ts"
    echo -e "    │   └── config/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── env.config.ts"
    echo -e "    ├── UI/"
    echo -e "    │   ├── components/"
    echo -e "    │   │   ├── index.ts"
    echo -e "    │   │   └── ${nameLower}Form.component.tsx"
    echo -e "    │   └── hooks/"
    echo -e "    │       ├── index.ts"
    echo -e "    │       └── use${nameLower}.hook.ts"
    echo -e "    ├── tests/"
    echo -e "    │   ├── unit/"
    echo -e "    │   │   └── ${nameLower}Service.test.ts"
    echo -e "    │   └── integration/"
    echo -e "    │       └── ${nameLower}Flow.integration.test.ts"
    echo -e "    └── page.tsx"
fi
