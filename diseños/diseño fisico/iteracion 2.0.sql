/* ============================================================
   SCRIPT COMPLETO CORREGIDO (SQL Server 2019+)
   Política de borrado: ON DELETE NO ACTION (bloqueo si hay referencias)
   ============================================================ */

-- ========================
-- SECCIÓN: UBICACIONES
-- ========================
CREATE TABLE departamentos (
    id_departamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT CHK_departamentos_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE ciudades (
    id_ciudad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT FK_ciudades_departamento FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_ciudades_nombre CHECK (TRIM(nombre) <> '')
);

-- ========================
-- SECCIÓN: CATÁLOGOS BÁSICOS (tipos, accesorios, estados)
-- ========================
CREATE TABLE tipos_de_uso (
    id_tipo_de_uso INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    CONSTRAINT CHK_tipos_de_uso_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_tipos_de_uso_descripcion CHECK (TRIM(descripcion) <> '')
);

CREATE TABLE accesorios (
    id_accesorio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    funcion VARCHAR(300) NULL,
    CONSTRAINT CHK_accesorios_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_accesorios_funcion CHECK (funcion IS NULL OR TRIM(funcion) <> '')
);

CREATE TABLE estados_mantenimiento (
    id_estado_mantenimiento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300) NULL,
    CONSTRAINT CHK_estados_mantenimiento_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_estados_mantenimiento_descripcion CHECK (descripcion IS NULL OR TRIM(descripcion) <> '')
);

-- ========================
-- SECCIÓN: FORMATOS Y ARCHIVOS MULTIMEDIA
-- ========================
CREATE TABLE formatos_de_archivo (
    id_formato_archivo INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    acronimo VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_formatos_de_archivo_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_formatos_de_archivo_siglas CHECK (TRIM(acronimo) <> '')
);

CREATE TABLE archivos_multimedia (
    id_archivo_multimedia INT IDENTITY(1,1) PRIMARY KEY,
    URL VARCHAR(300) NOT NULL,
    tamano_en_mb DECIMAL(10,2) NOT NULL,
    id_formato_de_archivo INT NOT NULL,
    fecha_de_subida DATE NULL,
    CONSTRAINT FK_archivos_multimedia_formato FOREIGN KEY (id_formato_de_archivo)
        REFERENCES formatos_de_archivo(id_formato_archivo)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_archivos_multimedia_url CHECK (TRIM(URL) <> ''),
    CONSTRAINT CHK_archivos_multimedia_tamano CHECK (tamano_en_mb > 0)
);

-- ========================
-- SECCIÓN: REPORTES Y ESTADOS
-- ========================
CREATE TABLE estados_del_reporte (
    id_estado_del_reporte INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300) NULL,
    CONSTRAINT CHK_estados_del_reporte_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE reportes (
    id_reporte INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion VARCHAR(1000) NULL,
    id_estado_del_reporte INT NOT NULL,
    CONSTRAINT FK_reportes_estado FOREIGN KEY (id_estado_del_reporte)
        REFERENCES estados_del_reporte(id_estado_del_reporte)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_reportes_titulo CHECK (TRIM(titulo) <> '')
);

-- ========================
-- SECCIÓN: MANTENIMIENTO, MARCAS, SEGUROS
-- ========================
CREATE TABLE tipos_de_mantenimiento (
    id_tipo_de_mantenimiento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300) NULL,
    CONSTRAINT CHK_tipos_mantenimiento_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_tipos_mantenimiento_desc CHECK (descripcion IS NULL OR TRIM(descripcion) <> '')
);

CREATE TABLE marcas (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    eslogan VARCHAR(300) NULL,
    CONSTRAINT CHK_marcas_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_marcas_eslogan CHECK (eslogan IS NULL OR TRIM(eslogan) <> '')
);

CREATE TABLE empresa_de_seguros (
    id_empresa_de_seguros INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    eslogan VARCHAR(300) NULL,
    CONSTRAINT CHK_empresa_seguros_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_empresa_seguros_eslogan CHECK (eslogan IS NULL OR TRIM(eslogan) <> '')
);

CREATE TABLE seguros (
    id_seguro INT IDENTITY(1,1) PRIMARY KEY,
    tarifa_base DECIMAL(10,2) NOT NULL,
    cobertura VARCHAR(300) NOT NULL,
    maximo_valor_asegurable DECIMAL(12,2) NOT NULL,
    id_empresa_de_seguros INT NOT NULL,
    CONSTRAINT FK_seguros_empresa FOREIGN KEY (id_empresa_de_seguros)
        REFERENCES empresa_de_seguros(id_empresa_de_seguros)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_seguros_tarifa CHECK (tarifa_base > 0),
    CONSTRAINT CHK_seguros_cobertura CHECK (TRIM(cobertura) <> ''),
    CONSTRAINT CHK_seguros_valormax CHECK (maximo_valor_asegurable > 0)
);

-- ========================
-- SECCIÓN: CONDICIONES ESPECIALES
-- ========================
CREATE TABLE condiciones_especiales (
    id_condicion_especial INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    CONSTRAINT CHK_condiciones_especiales_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_condiciones_especiales_descripcion CHECK (TRIM(descripcion) <> '')
);

-- ========================
-- SECCIÓN: HORARIOS Y PUNTOS DE ALQUILER
-- ========================
CREATE TABLE dias (
    id_dia INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    CONSTRAINT CHK_dias_nombre CHECK (LOWER(nombre) IN ('lunes','martes','miercoles','jueves','viernes','sabado','domingo'))
);

CREATE TABLE horarios (
    id_horario INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(200) NULL
);

CREATE TABLE dias_de_los_horarios (
    id_dias_de_los_horarios INT IDENTITY(1,1) PRIMARY KEY,
    id_dia INT NOT NULL,
    id_horario INT NOT NULL,
    hora_de_apertura TIME NOT NULL,
    hora_de_cierre TIME NOT NULL,
    CONSTRAINT FK_dias_horarios_horario FOREIGN KEY (id_horario)
        REFERENCES horarios(id_horario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_dias_horarios_dia FOREIGN KEY (id_dia)
        REFERENCES dias(id_dia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_dias_horarios_horas CHECK (hora_de_apertura < hora_de_cierre)
);

CREATE TABLE puntos_de_alquiler (
    id_punto_alquiler INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    id_ciudad INT NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    longitud DECIMAL(12,8) NULL,
    latitud DECIMAL(12,8) NULL,
    id_horario INT NOT NULL,
    CONSTRAINT FK_puntos_alquiler_ciudad FOREIGN KEY (id_ciudad)
        REFERENCES ciudades(id_ciudad)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_puntos_alquiler_horario FOREIGN KEY (id_horario)
        REFERENCES horarios(id_horario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_puntos_alquiler_nombre CHECK (LTRIM(RTRIM(nombre)) <> ''),
    CONSTRAINT CHK_puntos_alquiler_direccion CHECK (LTRIM(RTRIM(direccion)) <> ''),
    CONSTRAINT CHK_puntos_alquiler_longitud CHECK (longitud IS NULL OR (longitud BETWEEN -180 AND 180)),
    CONSTRAINT CHK_puntos_alquiler_latitud CHECK (latitud IS NULL OR (latitud BETWEEN -90 AND 90))
);

-- ========================
-- SECCIÓN: ESTADOS Y BICICLETAS (entidad principal)
-- ========================
CREATE TABLE estados_de_disponibilidad (
    id_estado_de_disponibilidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300) NULL,
    CONSTRAINT CHK_estados_disponibilidad_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE bicicletas (
    id_bicicleta INT IDENTITY(1,1) PRIMARY KEY,
    modelo VARCHAR(150) NOT NULL,
    numero_de_cuadro VARCHAR(100) NOT NULL UNIQUE,
    horas_de_uso INT NULL,
    anio_de_fabricacion INT NOT NULL,
    tarifa_base_de_alquiler DECIMAL(12,2) NOT NULL,
    etiquetas_adicionales VARCHAR(1000) NULL,
    tamano_del_marco_cm DECIMAL(6,2) NOT NULL,
    tamano_del_marco_in DECIMAL(6,2) NULL,
    es_electrica BIT NOT NULL DEFAULT 0,
    id_tipo_de_uso INT NOT NULL,
    id_punto_de_alquiler INT NOT NULL,
    kilometraje_km INT NULL,
    kilometraje_mi INT NULL,
    id_archivo_multimedia INT NULL,
    id_estado_mantenimiento INT NOT NULL,
    id_seguro INT NULL,
    id_mantenimiento INT NULL,
    id_reporte INT NULL,
    id_marca INT NOT NULL,
    id_estado_de_disponibilidad INT NOT NULL,
    CONSTRAINT FK_bicicletas_tipo_de_uso FOREIGN KEY (id_tipo_de_uso)
        REFERENCES tipos_de_uso(id_tipo_de_uso)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_punto_alquiler FOREIGN KEY (id_punto_de_alquiler)
        REFERENCES puntos_de_alquiler(id_punto_alquiler)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_archivo_multimedia FOREIGN KEY (id_archivo_multimedia)
        REFERENCES archivos_multimedia(id_archivo_multimedia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_estado_mantenimiento FOREIGN KEY (id_estado_mantenimiento)
        REFERENCES estados_mantenimiento(id_estado_mantenimiento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_seguro FOREIGN KEY (id_seguro)
        REFERENCES seguros(id_seguro)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_reporte FOREIGN KEY (id_reporte)
        REFERENCES reportes(id_reporte)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_marca FOREIGN KEY (id_marca)
        REFERENCES marcas(id_marca)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_bicicletas_estado_disponibilidad FOREIGN KEY (id_estado_de_disponibilidad)
        REFERENCES estados_de_disponibilidad(id_estado_de_disponibilidad)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_bicicletas_modelo CHECK (LTRIM(RTRIM(modelo)) <> ''),
    CONSTRAINT CHK_bicicletas_numero_de_cuadro CHECK (LTRIM(RTRIM(numero_de_cuadro)) <> ''),
    CONSTRAINT CHK_bicicletas_anio_de_fabricacion CHECK (anio_de_fabricacion BETWEEN 1900 AND DATEPART(year, GETDATE())),
    CONSTRAINT CHK_bicicletas_tarifa CHECK (tarifa_base_de_alquiler > 0),
    CONSTRAINT CHK_bicicletas_tamano_cm CHECK (tamano_del_marco_cm BETWEEN 30 AND 80),
    CONSTRAINT CHK_bicicletas_tamano_in CHECK (tamano_del_marco_in IS NULL OR tamano_del_marco_in BETWEEN 12 AND 32),
    CONSTRAINT CHK_bicicletas_horas_de_uso CHECK (horas_de_uso IS NULL OR horas_de_uso >= 0),
    CONSTRAINT CHK_bicicletas_kilometraje_km CHECK (kilometraje_km IS NULL OR kilometraje_km >= 0),
    CONSTRAINT CHK_bicicletas_kilometraje_mi CHECK (kilometraje_mi IS NULL OR kilometraje_mi >= 0)
);

-- ========================
-- SECCIÓN: IDIOMAS, SISTEMAS, PREFERENCIAS
-- ========================
CREATE TABLE idiomas (
    id_idioma INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_ISO VARCHAR(10) NOT NULL,
    codigo_ISO_639_2 VARCHAR(10) NOT NULL,
    codigo_ISO_639_1 VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_idiomas_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_idiomas_codigoISO CHECK (TRIM(codigo_ISO) <> '')
);

CREATE TABLE sistemas_de_medicion (
    id_sistema_medicion INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT CHK_sistemas_medicion_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE preferencias (
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY,
    id_idioma INT NOT NULL,
    id_sistema_medicion INT NOT NULL,
    CONSTRAINT FK_preferencias_idioma FOREIGN KEY (id_idioma)
        REFERENCES idiomas(id_idioma)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_preferencias_sistema_medicion FOREIGN KEY (id_sistema_medicion)
        REFERENCES sistemas_de_medicion(id_sistema_medicion)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: RUTAS, PUNTOS DE INTERÉS Y NIVELES
-- ========================
CREATE TABLE puntos_de_interes (
    id_punto_de_interes INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    CONSTRAINT CHK_puntos_de_interes_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_puntos_de_interes_longitud CHECK (longitud BETWEEN -180 AND 180),
    CONSTRAINT CHK_puntos_de_interes_latitud CHECK (latitud BETWEEN -90 AND 90)
);

CREATE TABLE niveles_dificultad (
    id_nivel_dificultad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(13) NOT NULL,
    descripcion VARCHAR(200) NULL,
    CONSTRAINT CHK_niveles_dificultad_nombre CHECK (LOWER(nombre) IN ('facil','moderado','dificil'))
);

CREATE TABLE rutas_turisticas (
    id_ruta_turistica INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL UNIQUE,
    descripcion VARCHAR(800) NULL,
    distancia_total DECIMAL(8,2) NOT NULL,
    id_nivel_dificultad INT NOT NULL,
    CONSTRAINT FK_rutas_nivel_dificultad FOREIGN KEY (id_nivel_dificultad)
        REFERENCES niveles_dificultad(id_nivel_dificultad)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_rutas_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_rutas_distancia CHECK (distancia_total > 0)
);

CREATE TABLE puntos_de_interes_de_las_rutas (
    id_punto_de_interes INT NOT NULL,
    id_ruta_turistica INT NOT NULL,
    CONSTRAINT PK_puntos_de_interes_de_las_rutas PRIMARY KEY (id_punto_de_interes, id_ruta_turistica),
    CONSTRAINT FK_pdir_rutas_punto_de_interes FOREIGN KEY (id_punto_de_interes)
        REFERENCES puntos_de_interes(id_punto_de_interes)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_pdir_rutas_ruta_turistica FOREIGN KEY (id_ruta_turistica)
        REFERENCES rutas_turisticas(id_ruta_turistica)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: POLÍTICAS Y RELACIONES DE MULTIMEDIA <-> REPORTES
-- ========================
CREATE TABLE politicas (
    id_politica INT IDENTITY(1,1) PRIMARY KEY,
    es_aceptado BIT NOT NULL DEFAULT 0,
    version_de_los_terminos INT NULL,
    CONSTRAINT CHK_politicas_version CHECK (version_de_los_terminos IS NULL OR version_de_los_terminos > 0)
);

CREATE TABLE archivos_multimedia_de_reportes (
    id_reporte INT NOT NULL,
    id_archivo_multimedia INT NOT NULL,
    CONSTRAINT PK_archivos_multimedia_de_reportes PRIMARY KEY (id_reporte, id_archivo_multimedia),
    CONSTRAINT FK_am_reportes_reporte FOREIGN KEY (id_reporte)
        REFERENCES reportes(id_reporte)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_am_reportes_multimedia FOREIGN KEY (id_archivo_multimedia)
        REFERENCES archivos_multimedia(id_archivo_multimedia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: ETIQUETAS Y METADATOS
-- ========================
CREATE TABLE etiquetas (
    id_etiqueta INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    CONSTRAINT CHK_etiquetas_titulo CHECK (TRIM(titulo) <> '')
);

CREATE TABLE metodos_de_pago (
    id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    es_transferencia BIT NOT NULL DEFAULT 0,
    CONSTRAINT CHK_metodos_de_pago_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE planes (
    id_plan INT IDENTITY(1,1) PRIMARY KEY,
    tipo_de_plan VARCHAR(100) NOT NULL,
    descripcion VARCHAR(500) NULL,
    beneficios_especificos VARCHAR(500) NULL,
    condiciones_especiales VARCHAR(500) NULL,
    tarifa_asociada DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_planes_tipo CHECK (TRIM(tipo_de_plan) <> ''),
    CONSTRAINT CHK_planes_tarifa CHECK (tarifa_asociada >= 0)
);

-- ========================
-- SECCIÓN: TIPOS DE DOCUMENTO Y DOCUMENTOS DE IDENTIFICACIÓN
-- ========================
CREATE TABLE tipos_de_documento (
    id_tipo_de_documento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    acronimo VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT CHK_tipos_documento_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT CHK_tipos_documento_acronimo CHECK (TRIM(acronimo) <> '')
);

CREATE TABLE documentos_de_identificacion (
    id_documento_de_identificacion INT IDENTITY(1,1) PRIMARY KEY,
    numero BIGINT NOT NULL UNIQUE,
    id_tipo_de_documento INT NOT NULL,
    lugar_de_expedicion VARCHAR(100) NOT NULL,
    fecha_de_expedicion DATE NOT NULL,
    CONSTRAINT FK_documentos_tipo_documento FOREIGN KEY (id_tipo_de_documento)
        REFERENCES tipos_de_documento(id_tipo_de_documento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_documentos_lugar CHECK (TRIM(lugar_de_expedicion) <> ''),
    CONSTRAINT CHK_documentos_fecha CHECK (fecha_de_expedicion <= GETDATE())
);

-- ========================
-- SECCIÓN: USUARIOS
-- ========================
CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE,
    contrasena VARCHAR(200) NOT NULL,
    numero_de_telefono VARCHAR(20) NULL,
    id_documento_de_identificacion INT NOT NULL,
    fecha_de_registro DATE NOT NULL DEFAULT GETDATE(),
    fecha_de_nacimiento DATE NOT NULL,
    id_preferencia INT NULL,
    id_politica INT NULL,
    id_reporte INT NULL,
    primer_nombre VARCHAR(100) NOT NULL,
    primer_apellido VARCHAR(100) NOT NULL,
    CONSTRAINT FK_usuarios_documento_identificacion FOREIGN KEY (id_documento_de_identificacion)
        REFERENCES documentos_de_identificacion(id_documento_de_identificacion)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_usuarios_preferencia FOREIGN KEY (id_preferencia)
        REFERENCES preferencias(id_preferencia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_usuarios_politica FOREIGN KEY (id_politica)
        REFERENCES politicas(id_politica)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_usuarios_reporte FOREIGN KEY (id_reporte)
        REFERENCES reportes(id_reporte)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_usuarios_email CHECK (LTRIM(RTRIM(email)) <> '' AND CHARINDEX('@', email) > 1),
    CONSTRAINT CHK_usuarios_contrasena CHECK (LEN(LTRIM(RTRIM(contrasena))) >= 6),
    CONSTRAINT CHK_usuarios_tel CHECK (numero_de_telefono IS NULL OR numero_de_telefono LIKE '[0-9]%'),
    CONSTRAINT CHK_usuarios_primer_nombre CHECK (LTRIM(RTRIM(primer_nombre)) <> ''),
    CONSTRAINT CHK_usuarios_primer_apellido CHECK (LTRIM(RTRIM(primer_apellido)) <> ''),
    CONSTRAINT CHK_usuarios_fecha_nacimiento CHECK (fecha_de_nacimiento < GETDATE()),
    CONSTRAINT CHK_usuarios_fecha_registro CHECK (fecha_de_registro <= GETDATE())
);

-- ========================
-- SECCIÓN: COMENTARIOS, ETIQUETAS Y MULTIMEDIA RELACIONADOS
-- ========================
CREATE TABLE comentarios (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    calificacion INT NOT NULL,
    descripcion VARCHAR(1000) NULL,
    fecha_de_realizacion DATE NOT NULL DEFAULT GETDATE(),
    id_ruta_turistica INT NOT NULL,
    CONSTRAINT CHK_comentarios_calificacion CHECK (calificacion BETWEEN 1 AND 5),
    CONSTRAINT CHK_comentarios_descripcion CHECK (descripcion IS NULL OR LTRIM(RTRIM(descripcion)) <> ''),
    CONSTRAINT FK_comentarios_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_comentarios_ruta FOREIGN KEY (id_ruta_turistica)
        REFERENCES rutas_turisticas(id_ruta_turistica)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE etiquetas_del_comentario (
    id_comentario INT NOT NULL,
    id_etiqueta INT NOT NULL,
    CONSTRAINT PK_etiquetas_del_comentario PRIMARY KEY (id_comentario, id_etiqueta),
    CONSTRAINT FK_etiquetas_del_comentario_comentarios FOREIGN KEY (id_comentario)
        REFERENCES comentarios(id_comentario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_etiquetas_del_comentario_etiquetas FOREIGN KEY (id_etiqueta)
        REFERENCES etiquetas(id_etiqueta)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE archivos_multimedia_de_comentarios (
    id_comentario INT NOT NULL,
    id_archivo_multimedia INT NOT NULL,
    CONSTRAINT PK_archivos_multimedia_de_comentarios PRIMARY KEY (id_comentario, id_archivo_multimedia),
    CONSTRAINT FK_am_comentarios_comentario FOREIGN KEY (id_comentario)
        REFERENCES comentarios(id_comentario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_am_comentarios_archivo FOREIGN KEY (id_archivo_multimedia)
        REFERENCES archivos_multimedia(id_archivo_multimedia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: RUTAS DE USUARIOS
-- ========================
CREATE TABLE rutas_de_los_usuarios (
    id_usuario INT NOT NULL,
    id_ruta_turistica INT NOT NULL,
    fecha_realizacion DATE NOT NULL,
    CONSTRAINT PK_rutas_de_los_usuarios PRIMARY KEY (id_usuario, id_ruta_turistica, fecha_realizacion),
    CONSTRAINT FK_rutas_usuarios_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_rutas_usuarios_ruta FOREIGN KEY (id_ruta_turistica)
        REFERENCES rutas_turisticas(id_ruta_turistica)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: ALQUILERES Y MÉTODOS DE PAGO
-- ========================
CREATE TABLE alquileres (
    id_alquiler INT IDENTITY(1,1) PRIMARY KEY,
    estado VARCHAR(20) NOT NULL,
    fecha_de_inicio DATE NOT NULL,
    fin_de_vigencia DATE NOT NULL,
    id_plan INT NOT NULL,
    id_usuario INT NOT NULL,
    id_bicicleta INT NOT NULL,
    id_metodo_de_pago INT NOT NULL,
    CONSTRAINT FK_alquileres_plan FOREIGN KEY (id_plan)
        REFERENCES planes(id_plan)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_alquileres_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_alquileres_bicicleta FOREIGN KEY (id_bicicleta)
        REFERENCES bicicletas(id_bicicleta)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_alquileres_metodo_pago FOREIGN KEY (id_metodo_de_pago)
        REFERENCES metodos_de_pago(id_metodo_pago)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT CHK_alquileres_estado CHECK (LOWER(TRIM(estado)) IN ('activo','finalizado','cancelado')),
    CONSTRAINT CHK_alquileres_fechas CHECK (fecha_de_inicio < fin_de_vigencia)
);

CREATE TABLE metodos_de_pago_aceptados_por_alquileres (
    id_punto_de_alquiler INT NOT NULL,
    id_metodo_de_pago INT NOT NULL,
    CONSTRAINT PK_metodos_de_pago_aceptados PRIMARY KEY (id_punto_de_alquiler, id_metodo_de_pago),
    CONSTRAINT FK_mpa_punto_alquiler FOREIGN KEY (id_punto_de_alquiler)
        REFERENCES puntos_de_alquiler(id_punto_alquiler)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_mpa_metodo_pago FOREIGN KEY (id_metodo_de_pago)
        REFERENCES metodos_de_pago(id_metodo_pago)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- SECCIÓN: RELACIONES MANY-TO-MANY (accesorios, condiciones)
-- ========================
CREATE TABLE accesorios_de_la_bicicleta (
    id_bicicleta INT NOT NULL,
    id_accesorio INT NOT NULL,
    CONSTRAINT PK_accesorios_de_la_bicicleta PRIMARY KEY (id_bicicleta, id_accesorio),
    CONSTRAINT FK_accesorios_bicicleta_bicicleta FOREIGN KEY (id_bicicleta)
        REFERENCES bicicletas(id_bicicleta)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_accesorios_bicicleta_accesorio FOREIGN KEY (id_accesorio)
        REFERENCES accesorios(id_accesorio)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE condiciones_de_las_bicicletas (
    id_bicicleta INT NOT NULL,
    id_condicion_especial INT NOT NULL,
    CONSTRAINT PK_condiciones_de_las_bicicletas PRIMARY KEY (id_bicicleta, id_condicion_especial),
    CONSTRAINT FK_condiciones_bicicleta_bicicleta FOREIGN KEY (id_bicicleta)
        REFERENCES bicicletas(id_bicicleta)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_condiciones_bicicleta_condicion FOREIGN KEY (id_condicion_especial)
        REFERENCES condiciones_especiales(id_condicion_especial)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ========================
-- FIN DEL SCRIPT
-- ========================
