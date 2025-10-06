# Documentación Proyecto BICI-GO
---
# Primera iteración - 13 Octubre


## 1. Propósito

Aquí se encuentra documentado cada parte del proyecto final BICIGO para el curso de Bases de Datos de la Universidad del Magdalena (2025-2).

El objetivo principal es diseñar y construir una solución de almacenamiento de datos basada en una base de datos relacional transaccional, la idea es ofrecer un sistema que permita gestionar el alquiler de bicicletas, junto con información adicional como rutas turísticas, preferencias de los usuarios y condiciones de uso.

Todo lo aquí mencionado está albergado en la Branch 0.1 del repositorio de Github del proyecto;
`https://github.com/DFBR2506/Proyecto-SQL---biciGo-db-system`


### 1.2 Objetivos y alcance
- **Diseñar y desarrollar una base de datos** relacional que permita almacenar y gestionar información relacionada con el alquiler de bicicletas, usuarios, rutas turísticas y demás elementos necesarios para un sistema integral de gestión.
- **Diagrama conceptual** con atributos, relaciones y cardinalidad.
- **Diseño lógico** con la visualización de cada tabla con sus respectivos datos de entrada, conexiones y llaves.
- **Diseño físico**  en Scripts de creación para SQL.
### 1.3 Definiciones y Convenciones
- Notación Chen para la creación de los diagramas conceptuales.
- Tablas diagramadas con DBDesigner para el diagrama lógico.
- Microsoft SQL para los scripts de creación de la base de datos en físico.

---

## 2. Diseño Conceptual
El diseño conceptual fue realizado en **ERDPlus** utilizando la notación de **Chen** e incluye varias de las principales entidades fundamentales para la base de datos.

### 2.1 Objetivo
Representar las entidades y sus relaciones sin considerar la implementación técnica.
El modelo conceptual busca capturar la esencia del dominio de BICIGO: usuarios, bicicletas, rutas y alquileres.

**Elementos incluidos**:
- Entidades principales
- Atributos de cada entidad
- Relaciones entre entidades
- Cardinalidades (1:1, 1:N, M:N)


### 2.2 Análisis de Entidades

A continuación, se listan las entidades principales del sistema con sus descripciones y atributos clave:

| **Entidad**       | **Descripción**                                               | **Atributos Clave**                          | **Observaciones**                         |
|--------------------|---------------------------------------------------------------|-----------------------------------------------|-------------------------------------------|
| **Usuario**        | Registra la información de los usuarios del sistema           | Documento, Email, Telefono                  | Entidad fuerte                            |
| **Bicicleta**      | Contiene datos de cada bicicleta disponible para alquiler     | Número de cuadro, Marca, Tarifa Base         | Asociada a condiciones y tipo de uso      |
| **Alquiler**       | Registra la información de los alquileres realizados          | Fecha de inicio, Fin de vigencia, Estado             | Depende de Usuario, Plan y Bicicleta      |
| **Plan**           | Define los planes de alquiler con tarifas y beneficios        | Tipo de plan, Tarifa, Condiciones especiales                 | ...                            |
| **Método de Pago** | Identifica la forma de pago utilizada en cada alquiler        | Es Transferencia, Nombre                        | ...                            |
| **Ruta Turística** | Representa rutas que los usuarios pueden recorrer             | Nombre, Distancia, Descripcion              | Se asocia con puntos de interés           |
| **Punto de Interés** | Define lugares turísticos dentro de las rutas               | Nombre, Coordenadas         | Puede estar asociado a varias rutas       |
| **Nivel de Dificultad** | Clasifica las rutas según su complejidad                 | Nombre, Descripción                 | Categoriza rutas |
| **Comentario**     | Permite que los usuarios califiquen y opinen sobre el servicio| Calificación, Descripción,Fecha Realizacion      | Puede relacionarse con etiquetas y archivos |
| **Archivo Multimedia** | Registra imágenes o archivos relacionados                 | Tamaño, Formato           | ...              |
| **Etiqueta**       | Etiqueta comentarios                    |  Título                           | Categoriza comentarios      |
| **Ciudad**         | Registra las ciudades donde operan los puntos de alquiler     | Nombre           | Depende de Departamento                   |
| **Departamento**   | Agrupa las ciudades en las que existe operación               | Nombre                       | Entidad fuerte                            |
| **Punto de Alquiler** | Lugares físicos donde se alquilan bicicletas               |  Nombre, Coordenadas, Horario de atencion | Depende de Ciudad                         |


### 2.3 Relaciones Principales

    Uno a Uno: (1:1) Un registro de una entidad A se relaciona con solo un registro en una entidad B. (ejemplo dos entidades, profesor y departamento, con llaves primarias, código_profesor y jefe_depto respectivamente, un profesor solo puede ser jefe de un departamento y un departamento solo puede tener un jefe).

    Uno a Varios: (1:N) Un registro en una entidad en A se relaciona con un B. Pero los registros de B se relacionan con uno o muchos registros en una entidad A. (ejemplo: dos entidades, vendedor y ventas, con llaves primarias, código_vendedor y venta, respectivamente, un vendedor puede tener muchas ventas pero una venta solo puede tener un vendedor).

    Varios a Uno: (N:1) Una entidad en A se relaciona con varios registros con una entidad en B. Pero una entidad en B se puede relacionar con un solo registro de la entidad A. (ejemplo empleado-centro de trabajo).

    Varios a Varios: (N:M) Una entidad en A se puede relacionar con 1 o con muchas entidades en B y viceversa (ejemplo asociaciones-ciudadanos, donde muchos ciudadanos pueden pertenecer a una misma asociación, y cada ciudadano puede pertenecer a muchas asociaciones distintas).

Basándome en la estructura y ejemplos del texto, aquí están las descripciones añadidas para cada relación:

1.  **USUARIO - compra - ALQUILER**
    -   **Tipo:** N:1
    -   **Descripción:** Un usuario puede realizar muchos alquileres, pero cada alquiler es realizado por un único usuario.

2.  **BICICLETA - tiene - ALQUILER**
    -   **Tipo:** 1:N
    -   **Descripción:** Una bicicleta puede ser alquilada muchas veces en diferentes alquileres, pero un registro de alquiler individual corresponde a una única bicicleta.

3.  **ALQUILER - Se clasifica en - PLAN**
    -   **Tipo:** N:1
    -   **Descripción:** Muchos alquileres pueden estar asociados a un mismo plan (por ejemplo, plan básico, plan premium), pero cada alquiler se clasifica en un único plan.

4.  **ALQUILER - acepta - MÉTODO DE PAGO**
    -   **Tipo:** N:M
    -   **Descripción:** Un alquiler puede ser pagado usando uno o varios métodos de pago (ej. tarjeta y efectivo), y un mismo método de pago (ej. tarjeta de crédito) puede ser utilizado en muchos alquileres distintos.

5.  **RUTA TURÍSTICA - Tiene - PUNTO DE INTERÉS**
    -   **Tipo:** N:M
    -   **Descripción:** Una ruta turística puede incluir múltiples puntos de interés, y un mismo punto de interés (ej. un mirador) puede formar parte de varias rutas turísticas diferentes.

6.  **RUTA TURÍSTICA - Tiene - NIVEL DE DIFICULTAD**
    -   **Tipo:** N:1
    -   **Descripción:** Muchas rutas turísticas pueden compartir el mismo nivel de dificultad (ej. "fácil"), pero cada ruta tiene un único nivel de dificultad asignado.

7.  **USUARIO - publica - COMENTARIO**
    -   **Tipo:** 1:N
    -   **Descripción:** Un usuario puede realizar múltiples comentarios.

8.  **COMENTARIO - Tiene - ETIQUETA**
    -   **Tipo:** M:N
    -   **Descripción:** Un comentario puede estar asociado a múltiples etiquetas, y una etiqueta puede aplicarse a distintos comentarios.

9.  **COMENTARIO - Contiene - ARCHIVO MULTIMEDIA**
    -   **Tipo:** N:M
    -   **Descripción:** Un comentario puede contener varios archivos multimedia (imágenes, videos), y un mismo archivo multimedia (ej. una foto de una bicicleta) puede ser incluido en diferentes comentarios.

10. **CIUDAD - pertenece a - DEPARTAMENTO**
    -   **Tipo:** N:1
    -   **Descripción:** Varias ciudades pueden estar en un mismo departamento.

11. **PUNTO DE ALQUILER - está en - CIUDAD**
    -   **Tipo:** N:1
    -   **Descripción:** Cada punto de alquiler pertenece a una ciudad específica.


---

## Diseño Lógico
El modelo lógico se construyó en **DBDesigner.net**. 

**Objetivo:** 
Convertir el modelo conceptual  en un esquema relacional lógico. Aquí se documentan las tablas, campos, nulabilidad, descripciones y relaciones/claves foráneas según el diagrama lógico. Se buscó cumplir la **3FN**, eliminando redundancias y asegurando integridad referencial. 

## Cambios realizados
- Conversión de entidades del modelo conceptual a tablas relacionales visibles en el diagrama lógico.
- Resolución de relaciones M:N cuando fue necesario según el diagrama (en la versión actual la mayoría de asociaciones han quedado como 1:N representadas mediante FKs).
- Definición de **claves primarias** (`id_*`) y **claves foráneas** (FK) tal como aparece en el diagrama lógico.
- Aplicación de normalización (separación de elementos que evitan redundancia y permiten trazabilidad con el conceptual).

**Nota:** Cuando el diagrama no explicita la nulabilidad, la nulabilidad incluida abajo se ha inferido con criterio práctico (PK → NO nulo; campos auxiliares o complementarios → pueden ser nulos).

---

## Tablas (detalladas)

> Cada bloque incluye: lista de campos (Campo / Tipo / Nulo / Descripción / Restricciones) y las **Relaciones / Claves Foráneas** relacionadas.

---

### Tabla: `Departamentos`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_departamento` | Integer | NO | Identificador único |
| `nombre` | VARCHAR | NO | Nombre del departamento |

**Relaciones / Claves Foráneas:**

- (No tiene FKs).

**Relaciones donde es referenciada:**

- `Ciudades.id_departamento` referencia a `Departamentos.id_departamento`

---

### Tabla: `Ciudades`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_ciudad` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre de la ciudad | 
| `id_departamento` | Integer | NO | FK hacia el departamento | 

**Relaciones / Claves Foráneas:**

- `id_departamento` -> `Departamentos.id_departamento` 

**Relaciones donde es referenciada:**

- `Puntos_Alquiler.id_ciudad` referencia a `Ciudades.id_ciudad`.

---

### Tabla: `Tipos_de_uso`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_tipo_de_uso` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del tipo de uso | 
| `descripcion` | VARCHAR | NO | Descripción del tipo de uso |

**Relaciones / Claves Foráneas:**

- (No tiene FKs).

**Relaciones donde es referenciada:**

- `Bicicletas.id_tipo_de_uso` -> `Tipos_de_uso.id_tipo_de_uso`
---

### Tabla: `Accesorios`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_accesorio` | Integer | NO | Identificador único |
| `nombre` | VARCHAR(100) | NO | Nombre del accesorio | 
| `funcion` | VARCHAR(300) | SI | Función / uso del accesorio | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs).

**Relaciones donde es referenciada:**

- `Bicicletas.id_accesorio` -> `Accesorios.id_accesorio`

---

### Tabla: `condiciones_especiales`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_condicion_especial` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre de la condición especial | 
| `descripcion` | VARCHAR | NO | Descripción de la condición |

**Relaciones / Claves Foráneas:**

- (No tiene FKs).

**Relaciones donde es referenciada:**

- `Bicicletas.id_condiciones_especiales` -> `condiciones_especiales.id_condicion_especial`.

---

### Tabla: `Bicicletas`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_bicicleta` | Integer | NO | Identificador único |
| `numero_de_cuadro` | VARCHAR | NO | Número de cuadro / serial | 
| `marca` | VARCHAR| NO | Marca de la bicicleta | 
| `modelo` | VARCHAR | NO | Modelo | 
| `año_fabricacion` | DATE | NO | Año de fabricación | 
| `tarifa_base_de_alquiler` | DECIMAL | NO | Tarifa base | 
| `tamaño_marco_cm` | DECIMAL | NO | Tamaño del marco (cm) | 
| `tamaño_marco_in` | DECIMAL | NO | Tamaño en pulgadas  | 
| `es_electrica` | BOOLEAN | NO | Flag: es eléctrica | 
| `horas_de_uso` | Integer | NO | Horas de uso acumuladas  |
| `kilometraje` | DECIMAL | NO | Kilometraje acumulado  | 
| `etiquetas_adicionales` | VARCHAR | SI | Etiquetas o tags |
| `id_condiciones_especiales` | Integer | NO | FK a condiciones especiales |
| `id_tipo_de_uso` | Integer | NO | FK a tipo de uso | 
| `id_accesorio` | Integer | NO | FK a accesorio | 

**Relaciones / Claves Foráneas:**

- `id_tipo_de_uso` -> `Tipos_de_uso.id_tipo_de_uso` 
- `id_condiciones_especiales` -> `condiciones_especiales.id_condicion_especial`
- `id_accesorio` -> `Accesorios.id_accesorio`

**Relaciones donde es referenciada:**

- `Alquiler.id_bicicleta` referencia a `Bicicletas.id_bicicleta` (un bicicleta puede aparecer en muchos alquileres a lo largo del tiempo).

---

### Tabla: `Puntos_Alquiler`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_punto_alquiler` | Integer | NO | Identificador único |
| `nombre` | VARCHAR | NO | Nombre del punto de alquiler | 
| `id_ciudad` | Integer | NO | FK a la ciudad donde está | 
| `longitud` | DECIMAL | NO | Longitud geográfica | 
| `latitud` | DECIMAL | NO | Latitud geográfica | 
| `Horario_atencion` | TIME | NO | Horarario de atencion al cliente | 

**Relaciones / Claves Foráneas:**

- `id_ciudad` -> `Ciudades.id_ciudad` 

---

### Tabla: `Metodos_de_pago`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_metodo_pago` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del método de pago | 
| `es_transferencia` | BOOLEAN | NO | Flag si es transferencia | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Alquiler.id_metodo_de_pago` referencia a `Metodos_de_pago.id_metodo_pago`.

---

### Tabla: `Planes`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_plan` | Integer | NO | Identificador único | 
| `tipo_de_plan` | VARCHAR | NO | Nombre / tipo del plan | 
| `descripcion` | VARCHAR | NO | Descripción | 
| `beneficios_especificos` | VARCHAR | NO | Beneficios | 
| `condiciones_especiales` | VARCHAR| NO | Notas sobre condiciones | 
| `tarifa_asociada` | DECIMAL | NO | Tarifa asociada al plan | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs locales)

**Relaciones donde es referenciada:**

- `Alquiler.id_plan` referencia a `Planes.id_plan`.

---

### Tabla: `Usuarios`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_usuario` | Integer | NO | Identificador único | 
| `nombre_completo` | VARCHAR | NO | Nombre completo del usuario | 
| `email` | VARCHAR| NO | Correo electrónico | 
| `contraseña` | VARBINAR | NO | Contraseña / hash |
| `numero_de_telefono` | VARCHAR | NO | Teléfono (opcional) | 
| `documento_de_identificacion` | VARCHAR | NO | Documento (CC, etc.) | 
| `fecha_de_registro` | DATE | NO | Fecha de registro | 
| `fecha_de_nacimiento` | DATE | NO | Fecha de nacimiento | 
| `id_preferencia` | Integer | NO | FK a preferencias (opcional) | 
| `id_ruta_turistica` | Integer | NO | FK a ruta turística favorita (opcional) |
| `id_terminos_condiciones` | Integer | NO | FK a términos y condiciones (registro de aceptación) |

**Relaciones / Claves Foráneas:**

- `id_preferencia` -> `Preferencias.id_preferencia`
- `id_ruta_turistica` -> `Rutas_turisticas.id_ruta_turistica`
- `id_terminos_condiciones` -> `Terminos_y_condiciones.id_terminos_condiciones`

**Relaciones donde es referenciada:**

- `Alquiler.id_usuario` referencia a `Usuarios.id_usuario`.
- `Comentarios.id_usuario` referencia a `Usuarios.id_usuario`.

---

### Tabla: `Comentarios`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_comentario` | Integer | NO | Identificador único | 
| `id_usuario` | Integer | NO | FK al usuario que comenta |
| `calificacion` | Integer | NO | Calificación numérica | 
| `descripcion` | VARCHAR | NO | Texto del comentario (opcional) | 
| `fecha_de_realizacion` | DATE | NO | Fecha del comentario | 

**Relaciones / Claves Foráneas:**

- `id_usuario` -> `Usuarios.id_usuario` 

---

### Tabla: `Etiqueta`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_etiqueta` | Integer | NO | Identificador único | 
| `titulo` | VARCHAR| NO | Texto de la etiqueta | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Comentarios.id_etiqueta` referencia a `Etiqueta.id_etiqueta`.

---

### Tabla: `Formato_De_Archivo`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_formato_de_archivo` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del formato |
| `siglas` | VARCHAR | NO | Siglas / extensión  | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Archivos_Multimedia.id_formato_de_archivo` referencia a `Formato_De_Archivo.id_formato_de_archivo`.

---

### Tabla: `Archivo_Multimedia`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_archivo_multimedia` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR| NO | Nombre del archivo |
| `tamaño_en_mb` | DECIMAL | NO | Tamaño en MB |
| `id_formato_de_archivo` | Integer | NO | FK al formato | 

**Relaciones / Claves Foráneas:**

- `id_formato_de_archivo` -> `Formato_De_Archivo.id_formato_de_archivo`

**Relaciones donde es referenciada:**

- `Comentarios.id_archivo_multimedia` referencia a `Archivo_Multimedia.id_archivo_multimedia`.

---

### Tabla: `Idioma`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_idioma` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR(| NO | Nombre del idioma |
| `codigo_ISO_639_2` | VARCHAR | NO | Código ISO 639-2 | 
| `codigo_ISO_639_1` | VARCHAR | NO | Código ISO 639-1 | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Preferencias.id_idioma` referencia a `Idioma.id_idioma`.

---

### Tabla: `Sistema_De_Medicion`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_sistema_medicion` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del sistema de medición |

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Preferencias.id_sistema_medicion` referencia a `Sistema_De_Medicion.id_sistema_medicion`.

---

### Tabla: `Preferencia`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_preferencia` | Integer | NO | Identificador único | 
| `id_idioma` | Integer | NO | FK al idioma preferido | 
| `id_sistema_de_medicion` | Integer | NO | FK al sistema de medición preferido | 

**Relaciones / Claves Foráneas:**

- `id_idioma` -> `Idioma.id_idioma`
- `id_sistema_de_medicion` -> `Sistema_De_Medicion.id_sistema_medicion`

**Relaciones donde es referenciada:**

- `Usuarios.id_preferencia` referencia a `Preferencia.id_preferencia`.

---

### Tabla: `Punto_De_Interes`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_punto_interes` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del punto de interés |
| `longitud` | DECIMAL | NO | Longitud |
| `latitud` | DECIMAL| NO | Latitud | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs locales)

**Relaciones donde es referenciada:**

- `Rutas_turisticas.id_punto_interes` puede señalar un punto relevante (dependiendo del diseño, puede ser el punto principal de la ruta).

---

### Tabla: `Nivel_Dificultad`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_nivel_dificultad` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre del nivel | 
| `descripcion` | VARCHAR| SI | Descripción del nivel | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Rutas_turisticas.id_nivel_dificultad` referencia a este registro.

---

### Tabla: `Ruta_Turistica`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción |
|---|---:|:---:|---|
| `id_ruta_turistica` | Integer | NO | Identificador único | 
| `nombre` | VARCHAR | NO | Nombre de la ruta | 
| `distancia_total` | DECIMAL | NO | Distancia total (en km o unidad seleccionada) | 
| `id_nivel_dificultad` | INT | NO | FK al nivel de dificultad |

**Relaciones / Claves Foráneas:**

- `id_nivel_dificultad` -> `Nivel_Dificultad.id_nivel_dificultad`

---

### Tabla: `Terminos_y_Condiciones`

**Descripción de Campos:**

| Campo | Tipo | Nulo | Descripción | 
|---|---:|:---:|---|
| `id_terminos_condiciones` | Integer | NO | Identificador único | 
| `es_aceptado` | BOOLEAN | NO | Flag que indica aceptación | 

**Relaciones / Claves Foráneas:**

- (No tiene FKs)

**Relaciones donde es referenciada:**

- `Usuarios.id_terminos_condiciones` referencia a este registro.

---

## Observaciones y supuestos
- La nulabilidad se ha inferido cuando el diagrama no era explícito. Para la implementación física (SQL) se deberá confirmar `NOT NULL` y valores por defecto según reglas de negocio finales.

- Este diseño lógico está en trazabilidad con el modelo conceptual (entidades y relaciones) y está listo para pasar a **diseño físico** (script SQL, índices y pruebas de datos).

---

# Diseño Físico


Aca se describe la estructura completa de la base de datos. 
El lenguaje utilizado es **Microsoft SQL Server**.

---

### Tabla: Departamentos

Define las divisiones administrativas o territoriales (departamentos o provincias).

```
CREATE TABLE Departamentos (
    id_departamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT chk_Departamentos_nombre CHECK (TRIM(nombre) <> '')
);
```

- id_departamento: Identificador único del departamento.

- nombre: Nombre del departamento, no puede estar vacío.

- *chk_Departamentos_nombre:* garantiza que el nombre no esté vacío ni compuesto solo de espacios.

---

### Tabla: Ciudades

Registra las ciudades y las asocia a un departamento específico.
```
CREATE TABLE Ciudades (
    id_ciudad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT id_departamento FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
    ON UPDATE CASCADE 
    ON DELETE NO ACTION,
    CONSTRAINT chk_Ciudades_nombre CHECK (TRIM(nombre) <> '')
);
```
- Cada ciudad pertenece a un departamento.

*chk_Ciudades_nombre:* valida que el nombre contenga texto significativo (sin espacios vacíos).

- Si un departamento cambia su id, la ciudad se actualiza automáticamente.



---

### Tabla: Tipos_de_uso

Define los tipos de uso posibles para las bicicletas (por ejemplo: urbano, recreativo, deportivo).
```
CREATE TABLE Tipos_de_uso (
    id_tipo_de_uso INT IDENTITY(1,1),
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    CONSTRAINT PK_Tipos_de_uso PRIMARY KEY (id_tipo_de_uso),
    CONSTRAINT chk_Tipos_de_uso_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_Tipos_de_uso_descripcion CHECK (TRIM(descripcion) <> '')
);
```
- *chk_Tipos_de_uso_nombre:* evita valores vacíos en el nombre del tipo de uso. 
- *chk_Tipos_de_uso_descripcion:* impide descripciones nulas o formadas solo por espacios.


---

### Tabla: Accesorios

Contiene los accesorios que pueden incluir las bicicletas, como luces, cascos o canastas.
```
CREATE TABLE Accesorios (
    id_accesorio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    funcion VARCHAR(300),
    CONSTRAINT chk_Accesorios_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_Accesorios_funcion CHECK (TRIM(funcion) <> '')
);
```
- Cada accesorio tiene un nombre único y una función opcional.
- *chk_Accesorios_nombre:* asegura que el nombre sea válido y no esté vacío. 
- *chk_Accesorios_funcion:* impide que la descripción de la función esté vacía, garantizando información útil del accesorio.


---

### Tabla: condiciones_especiales

Registra condiciones o características adicionales que pueden tener las bicicletas.
```
CREATE TABLE condiciones_especiales (
    id_condicion_especial INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    CONSTRAINT chk_condiciones_especiales_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_condiciones_especiales_descripcion CHECK (TRIM(descripcion) <> '')
);
```
- *chk_condiciones_especiales_nombre:* evita nombres vacíos. 
- *chk_condiciones_especiales_descripcion:* asegura que la descripción contenga información real, no espacios vacíos.


---

### Tabla: Bicicletas

Registra las bicicletas disponibles en el sistema.
```
CREATE TABLE Bicicletas (
    id_bicicleta INT IDENTITY(1,1) PRIMARY KEY,
    numero_de_cuadro VARCHAR(100) NOT NULL UNIQUE,
    marca VARCHAR(150) NOT NULL,
    modelo VARCHAR(150) NOT NULL,
    año_fabricacion DATE NOT NULL,
    tarifa_base_de_alquiler DECIMAL(12,2) NOT NULL,
    tamaño_marco_cm DECIMAL(6,2) NOT NULL,
    tamaño_marco_in DECIMAL(6,2) NULL,
    es_electrica BIT NOT NULL DEFAULT 0,
    horas_de_uso DECIMAL(10,2) NULL,
    kilometraje DECIMAL(12,2) NULL,
    etiquetas_adicionales VARCHAR(1000) NULL,
    id_condiciones_especiales INT NOT NULL,
    id_tipo_de_uso INT NOT NULL,
    id_accesorio INT NOT NULL,
    CONSTRAINT FK_Bicicletas_id_tipo_uso FOREIGN KEY (id_tipo_de_uso) 
        REFERENCES Tipos_de_uso(id_tipo_de_uso) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Bicicletas_id_condiciones_especiales FOREIGN KEY (id_condiciones_especiales) 
        REFERENCES condiciones_especiales(id_condicion_especial) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Bicicletas_id_accesorio FOREIGN KEY (id_accesorio) 
        REFERENCES Accesorios (id_accesorio) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT chk_numero_de_cuadro CHECK (LTRIM(RTRIM(numero_de_cuadro)) <> ''),
    CONSTRAINT chk_marca CHECK (TRIM(marca) <> ''),
    CONSTRAINT chk_modelo CHECK (TRIM(TRIM(modelo)) <> ''),
    CONSTRAINT chk_año_fabricacion CHECK (año_fabricacion <= GETDATE()),
    CONSTRAINT chk_tarifa_base CHECK (tarifa_base_de_alquiler > 0),
    CONSTRAINT chk_tamaño_marco_cm CHECK (tamaño_marco_cm BETWEEN 30 AND 80),
    CONSTRAINT chk_tamaño_marco_in CHECK (tamaño_marco_in IS NULL OR tamaño_marco_in BETWEEN 12 AND 32),
    CONSTRAINT chk_horas_de_uso CHECK (horas_de_uso IS NULL OR horas_de_uso >= 0),
    CONSTRAINT chk_kilometraje CHECK (kilometraje IS NULL OR kilometraje >= 0)
);
```
- *chk_numero_de_cuadro:* impide que el número de cuadro esté vacío o tenga solo espacios.
- *chk_marca:* garantiza que la marca no esté vacía.
- *chk_modelo:* evita que el modelo sea una cadena vacía.
- *chk_año_fabricacion:* asegura que la fecha de fabricación no sea futura. 
- *chk_tarifa_base:* exige que la tarifa de alquiler sea positiva. 
- *chk_tamaño_marco_cm:* limita el tamaño del marco a un rango lógico (30–80 cm). 
- *chk_tamaño_marco_in:* permite valores nulos, pero si existen deben estar entre 12–32 pulgadas. 
- *chk_horas_de_uso:* impide valores negativos o inconsistentes en las horas de uso.
- *chk_kilometraje:* garantiza que el kilometraje sea nulo o no negativo.


---

### Tabla: Puntos_Alquiler

Define las estaciones o puntos donde se alquilan las bicicletas.
```
CREATE TABLE Puntos_Alquiler (
    id_punto_alquiler INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    id_ciudad INT NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    longitud DECIMAL(12,8) NULL,
    latitud DECIMAL(12,8) NULL,
    hora_apertura TIME NOT NULL,
    hora_cierre TIME NOT NULL,
    dias_abierto VARCHAR NOT NULL,
    CONSTRAINT FK_PuntoAlquiler_id_ciudad FOREIGN KEY (id_ciudad) REFERENCES Ciudades (id_ciudad) 
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT chk_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_direccion CHECK (TRIM(direccion) <> ''),
    CONSTRAINT chk_longitud CHECK (longitud IS NULL OR (longitud BETWEEN -180 AND 180)),
    CONSTRAINT chk_latitud CHECK (latitud IS NULL OR (latitud BETWEEN -90 AND 90)),
    CONSTRAINT chk_horario CHECK (hora_apertura < hora_cierre),
    CONSTRAINT chk_dias_abierto CHECK (dias_abierto LIKE ('%-%'))
);
```
- *chk_nombre:* evita nombres vacíos. 
- *chk_direccion:* garantiza que la dirección no esté vacía. 
- *chk_longitud:* limita el valor a un rango geográfico real (-180 a 180). 
- *chk_latitud:* restringe el valor entre -90 y 90, coherente con coordenadas reales. 
- *chk_horario:* asegura que la hora de apertura sea menor a la hora de cierre. 
- *chk_dias_abierto:* valida que el campo contenga un formato con guion (por ejemplo, “Lunes-Viernes”).



---

### Tabla: Idiomas

Define los idiomas disponibles para la interfaz o las preferencias del usuario.
```
CREATE TABLE Idiomas ( 
    id_idioma INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    codigo_ISO INT NOT NULL, 
    codigo_ISO_639_2 VARCHAR(10) NOT NULL, 
    codigo_ISO_639_1 VARCHAR(10) NOT NULL, 
    CONSTRAINT chk_Idiomas_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Idiomas_codigoISO CHECK (codigo_ISO > 0) 
);
```
- *chk_Idiomas_nombre:* evita nombres vacíos. 
- *chk_Idiomas_codigoISO:* exige que el código ISO sea un valor positivo.
---

### Tabla: Sistemas_de_medicion

Define los sistemas de medición disponibles (métrico, imperial, etc.).
```
CREATE TABLE Sistemas_de_medicion ( 
    id_sistema_medicion INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    CONSTRAINT chk_Sistemas_medicion_nombre CHECK (TRIM(nombre) <> '') 
);
```
- *chk_Sistemas_medicion_nombre:* impide nombres vacíos o formados por espacios.

---

### Tabla: Preferencias

Asocia las preferencias de idioma y sistema de medición de los usuarios.
```
CREATE TABLE Preferencias ( 
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY, 
    id_idioma INT NOT NULL, 
    id_sistema_medicion INT NOT NULL,
    CONSTRAINT FK_Preferencias_Idiomas FOREIGN KEY (id_idioma) REFERENCES Idiomas(id_idioma) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Preferencias_Sistemas_medicion FOREIGN KEY (id_sistema_medicion) 
    REFERENCES Sistemas_de_medicion(id_sistema_medicion) ON UPDATE CASCADE ON DELETE NO ACTION 
);
```

---

### Tabla: Puntos_de_interes

Define lugares turísticos o relevantes en las rutas.
```
CREATE TABLE Puntos_de_interes (
    id_punto_interes INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(150) NOT NULL, 
    longitud DECIMAL(9,6) NOT NULL, 
    latitud DECIMAL(9,6) NOT NULL, 
    CONSTRAINT chk_Puntos_de_interes_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Puntos_de_interes_long CHECK (longitud BETWEEN -180 AND 180), 
    CONSTRAINT chk_Puntos_de_interes_lat CHECK (latitud BETWEEN -90 AND 90) 
);
```
- *chk_Puntos_de_interes_nombre:* evita nombres vacíos. 
- *chk_Puntos_de_interes_long:* restringe la longitud a valores válidos (-180 a 180).
- *chk_Puntos_de_interes_lat:* limita la latitud a valores entre -90 y 90.
---

### Tabla: Niveles_dificultad

Establece los niveles de dificultad de las rutas turísticas.
```
CREATE TABLE Niveles_dificultad ( 
    id_nivel_dificultad INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(13) NOT NULL, 
    descripcion VARCHAR(200) NULL, 
    CONSTRAINT chk_Niveles_dificultad_nombre CHECK (nombre IN ('facil','moderado','dificil')) 
);
```
*chk_Niveles_dificultad_nombre:* solo permite valores dentro del conjunto definido: 'facil', 'moderado', 'dificil'.
---

### Tabla: Rutas_turisticas

Define las rutas disponibles para recorrer en bicicleta.
```
CREATE TABLE Rutas_turisticas ( 
    id_ruta_turistica INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(200) NOT NULL UNIQUE, 
    descripcion VARCHAR(800) NULL, 
    distancia_total DECIMAL(8,2) NOT NULL, 
    id_punto_interes INT NULL, 
    id_nivel_dificultad INT NOT NULL, 
    CONSTRAINT FK_Rutas_turisticas_Puntos_interes FOREIGN KEY (id_punto_interes) 
        REFERENCES Puntos_de_interes(id_punto_interes) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Rutas_turisticas_Niveles_dificultad FOREIGN KEY (id_nivel_dificultad) 
        REFERENCES Niveles_dificultad(id_nivel_dificultad) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT chk_Rutas_turisticas_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Rutas_turisticas_distancia CHECK (distancia_total > 0) 
);
```
- *chk_Rutas_turisticas_nombre:* impide nombres vacíos. 
- *chk_Rutas_turisticas_distancia:* exige que la distancia total sea mayor que cero.
---

### Tabla: Terminos_y_condiciones

Almacena el estado de aceptación de los términos por parte del usuario.
```
CREATE TABLE Terminos_y_condiciones ( 
    id_terminos_condiciones INT IDENTITY(1,1) PRIMARY KEY, 
    es_aceptado BIT NOT NULL DEFAULT 0 
);
```

---

### Tabla: formatos_de_archivo

Define los formatos de archivos admitidos para subir multimedia.
```
CREATE TABLE formatos_de_archivo (
    id_formato_archivo INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR (100) NOT NULL,
    siglas VARCHAR (10) NOT NUll,
    CONSTRAINT CHK_formatos_de_archivo_nombre CHECK (TRIM(nombre)<>''),
    CONSTRAINT CHK_formatos_de_archivo_siglas CHECK (TRIM(siglas)<>'')
);
```
- *CHK_formatos_de_archivo_nombre:* asegura que el nombre no esté vacío. 
- *CHK_formatos_de_archivo_siglas:* impide que las siglas estén vacías o sean solo espacios.
---

### Tabla: archivos_multimedia

Almacena los archivos multimedia subidos al sistema.
```
CREATE TABLE archivos_multimedia (
    id_archivo_multimedia INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR (20) NOT NULL,
    tamaño_en_mb DECIMAL (10,2) NOT NULL,
    id_formato_de_archivo INT NOT NULL,
    CONSTRAINT FK_archivos_multimedia_id_formato_de_archivo FOREIGN KEY (id_formato_de_archivo) 
        REFERENCES formatos_de_archivo(id_formato_archivo) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT CHK_archivos_multimedia_nombre CHECK (TRIM(nombre)<>''),
    CONSTRAINT CHK_archivos_multimedia_tamaño_en_mb CHECK (tamaño_en_mb > 0)    
);
```
- *CHK_archivos_multimedia_nombre:* evita nombres vacíos. 
- *CHK_archivos_multimedia_tamaño_en_mb:* exige un tamaño positivo para el archivo.
---

### Tabla: Etiquetas

Define etiquetas para clasificar comentarios o contenido multimedia.
```
CREATE TABLE Etiquetas (
    id_etiqueta INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    CONSTRAINT chk_Etiquetas_titulo CHECK (TRIM(titulo) <> '')
);
```
- *chk_Etiquetas_titulo:* garantiza que el título contenga texto válido.
---

### Tabla: Comentarios

Registra opiniones, calificaciones y reseñas de los usuarios.
```
CREATE TABLE Comentarios (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL, 
    calificacion INT NOT NULL,
    descripcion VARCHAR(1000) NULL,
    fecha_de_realizacion DATE NOT NULL,
    id_etiqueta INT NULL, 
    id_archivo_multimedia INT NULL, 
    CONSTRAINT chk_Comentarios_calificacion CHECK (calificacion BETWEEN 1 AND 5),
    CONSTRAINT chk_Comentarios_descripcion CHECK (descripcion IS NULL OR LTRIM(RTRIM(descripcion)) <> ''),   
    CONSTRAINT FK_Comentarios_id_etiqueta FOREIGN KEY (id_etiqueta) 
        REFERENCES Etiquetas(id_etiqueta) ON UPDATE CASCADE ON DELETE SET NULL,        
    CONSTRAINT FK_Comentarios_id_archivo_multimedia FOREIGN KEY (id_archivo_multimedia) 
        REFERENCES Archivos_Multimedia(id_archivo_multimedia) ON UPDATE CASCADE ON DELETE SET NULL
);
```
- *chk_Comentarios_calificacion:* restringe la calificación a valores entre 1 y 5. 
- *chk_Comentarios_descripcion:* permite descripciones nulas, pero si existen, deben contener texto real (sin solo espacios).
---

### Tabla: Metodos_de_pago

Define los métodos de pago disponibles.
```
CREATE TABLE Metodos_de_pago (
    id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    es_transferencia BIT NOT NULL DEFAULT 0,
    CONSTRAINT chk_Metodos_de_pago_nombre CHECK (TRIM(nombre) <> '')
);

```
- *chk_Metodos_de_pago_nombre:* evita nombres vacíos o compuestos solo por espacios.

---

### Tabla: Planes

Registra los planes de alquiler disponibles.
```
CREATE TABLE Planes (
    id_plan INT IDENTITY(1,1) PRIMARY KEY,
    tipo_de_plan VARCHAR(100) NOT NULL,
    descripcion VARCHAR(500) NULL,
    beneficios_especificos VARCHAR(500) NULL,
    condiciones_especiales VARCHAR(500) NULL,
    tarifa_asociada DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_Planes_tipo CHECK (TRIM(tipo_de_plan) <> ''),
    CONSTRAINT chk_Planes_tarifa CHECK (tarifa_asociada >= 0)
);
```
- *chk_Planes_tipo:* garantiza que el tipo de plan contenga texto válido. 
- *chk_Planes_tarifa:* exige que la tarifa asociada sea mayor o igual a cero.
---

### Tabla: Usuarios

Registra los usuarios del sistema con su información personal y preferencias.
```
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_completo VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    contraseña VARBINARY(64) NOT NULL,
    numero_de_telefono VARCHAR(10) NULL,
    documento_de_identificacion VARCHAR(20) NOT NULL UNIQUE,
    fecha_de_registro DATE NOT NULL DEFAULT GETDATE(),
    fecha_de_nacimiento DATE NOT NULL,
    id_preferencia INT NULL,
    id_ruta_turistica INT NULL,
    id_terminos_condiciones INT NOT NULL,
    CONSTRAINT chk_Usuarios_nombre CHECK (TRIM(nombre_completo) <> ''),
    CONSTRAINT chk_Usuarios_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_Usuarios_contraseña CHECK (TRIM(contraseña) <> ''),
    CONSTRAINT chk_Usuarios_fecha_nacimiento CHECK (fecha_de_nacimiento <= GETDATE()),
    CONSTRAINT FK_Usuarios_Preferencias FOREIGN KEY (id_preferencia) 
        REFERENCES Preferencias(id_preferencia) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT FK_Usuarios_Rutas FOREIGN KEY (id_ruta_turistica) 
        REFERENCES Rutas_turisticas(id_ruta_turistica) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT FK_Usuarios_Terminos FOREIGN KEY (id_terminos_condiciones) 
        REFERENCES Terminos_y_condiciones(id_terminos_condiciones) ON UPDATE CASCADE ON DELETE NO ACTION
);
```
- *chk_Usuarios_nombre:* evita que el nombre completo esté vacío.
- *chk_Usuarios_email:* valida un formato mínimo de correo (debe contener “@” y “.”).
- *chk_Usuarios_contraseña:* impide contraseñas vacías o nulas.
- *chk_Usuarios_fecha_nacimiento:* asegura que la fecha de nacimiento no sea futura.
---

### Tabla: Alquiler

Registra las operaciones de alquiler de bicicletas.
```
CREATE TABLE Alquiler ( 
    id_alquiler INT IDENTITY(1,1) PRIMARY KEY, 
    estado VARCHAR(20) NOT NULL, 
    fecha_de_inicio DATE NOT NULL, 
    fin_de_vigencia DATE NOT NULL, 
    id_metodo_de_pago INT NOT NULL, 
    id_plan INT NOT NULL, 
    id_usuario INT NOT NULL, 
    id_bicicleta INT NOT NULL,  
    CONSTRAINT FK_Alquiler_id_método_de_pago FOREIGN KEY (id_metodo_de_pago)
        REFERENCES Metodos_de_Pago(id_metodo_pago) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Alquiler_id_plan FOREIGN KEY (id_plan) 
        REFERENCES Planes(id_plan) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Alquiler_id_usuario FOREIGN KEY (id_usuario) 
        REFERENCES Usuarios(id_usuario) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Alquiler_id_bicicleta FOREIGN KEY (id_bicicleta) 
        REFERENCES Bicicletas(id_bicicleta) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT chk_Alquiler_estado CHECK (estado IN ('activo','finalizado','cancelado')), 
    CONSTRAINT chk_Alquiler_fechas CHECK (fecha_de_inicio < fin_de_vigencia) 
);
```
- *chk_Alquiler_estado:* restringe el estado a tres valores posibles: 'activo', 'finalizado' o 'cancelado'.
- *chk_Alquiler_fechas:* valida que la fecha de inicio sea anterior a la de fin de vigencia.
---

