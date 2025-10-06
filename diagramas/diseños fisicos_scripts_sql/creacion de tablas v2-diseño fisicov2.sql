CREATE TABLE departamentos (
    id_departamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT chk_Departamentos_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE ciudades (
    id_ciudad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT id_departamento FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
    ON UPDATE CASCADE 
    ON DELETE NO ACTION,
    CONSTRAINT chk_Ciudades_nombre CHECK (TRIM(nombre) <> '')
);


CREATE TABLE tipos_de_uso (
    id_tipo_de_uso INT IDENTITY(1,1),
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    CONSTRAINT PK_Tipos_de_uso PRIMARY KEY (id_tipo_de_uso),
    CONSTRAINT chk_Tipos_de_uso_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_Tipos_de_uso_descripcion CHECK (TRIM(descripcion) <> '')
);


CREATE TABLE accesorios (
    id_accesorio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    funcion VARCHAR(300),
     CONSTRAINT chk_Accesorios_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_Accesorios_funcion CHECK (TRIM(funcion) <> ''),
);

CREATE TABLE condiciones_especiales (
    id_condicion_especial INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    CONSTRAINT chk_condiciones_especiales_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_condiciones_especiales_descripcion CHECK (TRIM(descripcion) <> '')
);

CREATE TABLE puntos_de_alquiler (
    id_punto_alquiler INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    id_ciudad INT NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    longitud DECIMAL(12,8) NULL,
    latitud DECIMAL(12,8) NULL,
    hora_apertura TIME NOT NULL,
    hora_cierre TIME NOT NULL,
    dias_abierto VARCHAR(50) NOT NULL,

    CONSTRAINT FK_PuntoAlquiler_id_ciudad FOREIGN KEY (id_ciudad) 
        REFERENCES Ciudades (id_ciudad) 
        ON UPDATE CASCADE 
        ON DELETE NO ACTION,
   
    CONSTRAINT chk_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_direccion CHECK (TRIM(direccion) <> ''),
    CONSTRAINT chk_longitud CHECK (longitud IS NULL OR (longitud BETWEEN -180 AND 180)),
    CONSTRAINT chk_latitud CHECK (latitud IS NULL OR (latitud BETWEEN -90 AND 90)),
    CONSTRAINT chk_horario CHECK (hora_apertura < hora_cierre),
    CONSTRAINT chk_dias_abierto CHECK (dias_abierto LIKE ('%-%'))
);


CREATE TABLE bicicletas (
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
    id_tipo_de_uso INT NOT NULL,
    id_punto_alquiler INT NOT NULL,  -- ? relación con punto de alquiler
    
    -- FK hacia tipos de uso
    CONSTRAINT FK_Bicicletas_id_tipo_uso FOREIGN KEY (id_tipo_de_uso) 
        REFERENCES Tipos_de_uso(id_tipo_de_uso)
        ON UPDATE CASCADE ON DELETE NO ACTION,

    -- FK hacia punto de alquiler
    CONSTRAINT FK_Bicicletas_id_punto FOREIGN KEY (id_punto_alquiler)
        REFERENCES puntos_de_alquiler(id_punto_alquiler)
        ON UPDATE CASCADE ON DELETE NO ACTION,

    -- Validaciones
    CONSTRAINT chk_numero_de_cuadro CHECK (LTRIM(RTRIM(numero_de_cuadro)) <> ''),
    CONSTRAINT chk_marca CHECK (TRIM(marca) <> ''),
    CONSTRAINT chk_modelo CHECK (TRIM(modelo) <> ''),
    CONSTRAINT chk_año_fabricacion CHECK (año_fabricacion <= GETDATE()),
    CONSTRAINT chk_tarifa_base CHECK (tarifa_base_de_alquiler > 0),
    CONSTRAINT chk_tamaño_marco_cm CHECK (tamaño_marco_cm BETWEEN 30 AND 80),
    CONSTRAINT chk_tamaño_marco_in CHECK (tamaño_marco_in IS NULL OR tamaño_marco_in BETWEEN 12 AND 32),
    CONSTRAINT chk_horas_de_uso CHECK (horas_de_uso IS NULL OR horas_de_uso >= 0),
    CONSTRAINT chk_kilometraje CHECK (kilometraje IS NULL OR kilometraje >= 0)
);



CREATE TABLE idiomas ( 
    id_idioma INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    codigo_ISO INT NOT NULL, 
    codigo_ISO_639_2 VARCHAR(10) NOT NULL, 
    codigo_ISO_639_1 VARCHAR(10) NOT NULL, 
    CONSTRAINT chk_Idiomas_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Idiomas_codigoISO CHECK (codigo_ISO > 0) 
); 



CREATE TABLE sistemas_de_medicion ( 
    id_sistema_medicion INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    CONSTRAINT chk_Sistemas_medicion_nombre CHECK (TRIM(nombre) <> '') 
);


CREATE TABLE preferencias ( 
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY, 
    id_idioma INT NOT NULL, 
    id_sistema_medicion INT NOT NULL,
    CONSTRAINT FK_Preferencias_Idiomas FOREIGN KEY (id_idioma) REFERENCES Idiomas(id_idioma) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Preferencias_Sistemas_medicion FOREIGN KEY (id_sistema_medicion) 
    REFERENCES Sistemas_de_medicion(id_sistema_medicion) ON UPDATE CASCADE ON DELETE NO ACTION 
); 

CREATE TABLE puntos_de_interes (
    id_punto_de_interes INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(150) NOT NULL, 
    longitud DECIMAL(9,6) NOT NULL, 
    latitud DECIMAL(9,6) NOT NULL, 
    CONSTRAINT chk_Puntos_de_interes_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Puntos_de_interes_long CHECK (longitud BETWEEN -180 AND 180), 
    CONSTRAINT chk_Puntos_de_interes_lat CHECK (latitud BETWEEN -90 AND 90) 
);


CREATE TABLE niveles_dificultad ( 
    id_nivel_dificultad INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(13) NOT NULL, 
    descripcion VARCHAR(200) NULL, 
    CONSTRAINT chk_Niveles_dificultad_nombre CHECK (nombre IN ('facil','moderado','dificil')) 
); 

CREATE TABLE rutas_turisticas ( 
    id_ruta_turistica INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(200) NOT NULL UNIQUE, 
    descripcion VARCHAR(800) NULL, 
    distancia_total DECIMAL(8,2) NOT NULL, 
    id_nivel_dificultad INT NOT NULL,   
    CONSTRAINT FK_Rutas_turisticas_Niveles_dificultad FOREIGN KEY (id_nivel_dificultad) 
    REFERENCES Niveles_dificultad(id_nivel_dificultad) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT chk_Rutas_turisticas_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Rutas_turisticas_distancia CHECK (distancia_total > 0) 
); 

CREATE TABLE puntos_de_interes_de_las_rutas(
        id_punto_de_interes INT NOT NULL,
        id_ruta_turistica INT NOT NULL,
        CONSTRAINT PK_puntos_de_interes_de_las_rutas PRIMARY KEY ( id_punto_de_interes ,id_ruta_turistica),
        CONSTRAINT Fk_puntos_de_interes_de_las_rutas_id_punto_de_interes FOREIGN KEY(id_punto_de_interes) 
        REFERENCES puntos_de_interes(id_punto_de_interes) ON UPDATE CASCADE ON DELETE NO ACTION,
        CONSTRAINT Fk_puntos_de_interes_de_las_rutas_id_ruta_turistica FOREIGN KEY(id_ruta_turistica)
        REFERENCES rutas_turisticas (id_ruta_turistica) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE politicas ( 
    id_politica INT IDENTITY(1,1) PRIMARY KEY, 
    es_aceptado BIT NOT NULL DEFAULT 0,
    version_de_los_terminos INT,
    CONSTRAINT CHK_politicas_version_de_los_terminos CHECK(version_de_los_terminos > 0)
);


CREATE TABLE formatos_de_archivo (
    id_formato_archivo INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR (100) NOT NULL,
    siglas VARCHAR (10) NOT NUll,
    CONSTRAINT CHK_formatos_de_archivo_nombre CHECK (TRIM(nombre)<>''),
    CONSTRAINT CHK_formatos_de_archivo_siglas CHECK (TRIM(siglas)<>'')
);


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


CREATE TABLE etiquetas (
    id_etiqueta INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    CONSTRAINT chk_Etiquetas_titulo CHECK (TRIM(titulo) <> '')
);



CREATE TABLE metodos_de_pago (
    id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    es_transferencia BIT NOT NULL DEFAULT 0,
    CONSTRAINT chk_Metodos_de_pago_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE planes (
    id_plan INT IDENTITY(1,1) PRIMARY KEY,
    tipo_de_plan VARCHAR(100) NOT NULL,
    descripcion VARCHAR(500) NULL,
    beneficios_especificos VARCHAR(500) NULL,
    condiciones_especiales VARCHAR(500) NULL,
    tarifa_asociada DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_Planes_tipo CHECK (TRIM(tipo_de_plan) <> ''),
    CONSTRAINT chk_Planes_tarifa CHECK (tarifa_asociada >= 0)
);

CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_completo VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    contraseña VARBINARY(64) NOT NULL,
    numero_de_telefono VARCHAR(10) NULL,
    documento_de_identificacion VARCHAR(20) NOT NULL UNIQUE,
    fecha_de_registro DATE NOT NULL DEFAULT GETDATE(),
    fecha_de_nacimiento DATE NOT NULL,
    id_preferencia INT NULL,
    id_politica INT NOT NULL,
    
    CONSTRAINT chk_Usuarios_nombre CHECK (TRIM(nombre_completo) <> ''),
    CONSTRAINT chk_Usuarios_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_Usuarios_contraseña CHECK (TRIM(contraseña) <> ''),
    CONSTRAINT chk_Usuarios_fecha_nacimiento CHECK (fecha_de_nacimiento <= GETDATE()),


    CONSTRAINT FK_Usuarios_Preferencias FOREIGN KEY (id_preferencia) 
        REFERENCES Preferencias(id_preferencia) ON UPDATE CASCADE ON DELETE SET NULL,


    CONSTRAINT FK_Usuarios_Terminos FOREIGN KEY (id_politica) 
        REFERENCES politicas (id_politica) ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE comentarios (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL, 
    calificacion INT NOT NULL,
    descripcion VARCHAR(1000) NULL,
    fecha_de_realizacion DATE NOT NULL,

    -- Checks
    CONSTRAINT chk_Comentarios_calificacion CHECK (calificacion BETWEEN 1 AND 5),
    CONSTRAINT chk_Comentarios_descripcion CHECK (descripcion IS NULL OR LTRIM(RTRIM(descripcion)) <> ''),

    -- Foránea hacia usuarios
    CONSTRAINT FK_Comentarios_Usuarios FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) 
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE etiquetas_del_comentario (
    id_comentario INT NOT NULL,
    id_etiqueta INT NOT NULL,

    -- Clave primaria compuesta
    CONSTRAINT PK_etiquetas_del_comentario PRIMARY KEY (id_comentario, id_etiqueta),

    -- Foráneas
    CONSTRAINT FK_etiquetas_del_comentario_comentarios 
        FOREIGN KEY (id_comentario) REFERENCES comentarios(id_comentario)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT FK_etiquetas_del_comentario_etiquetas 
        FOREIGN KEY (id_etiqueta) REFERENCES etiquetas(id_etiqueta)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE archivos_multimedia_del_comentario (
    id_comentario INT NOT NULL,
    id_archivo_multimedia INT NOT NULL,

    -- Clave primaria compuesta
    CONSTRAINT PK_archivos_multimedia_del_comentario PRIMARY KEY (id_comentario, id_archivo_multimedia),

    -- Foráneas
    CONSTRAINT FK_archivos_multimedia_del_comentario_comentarios 
        FOREIGN KEY (id_comentario) REFERENCES comentarios(id_comentario)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT FK_archivos_multimedia_del_comentario_multimedia 
        FOREIGN KEY (id_archivo_multimedia) REFERENCES archivos_multimedia(id_archivo_multimedia)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE rutas_del_usuario (
    id_usuario INT NOT NULL,
    id_ruta_turistica INT NOT NULL,
    
    -- Clave primaria compuesta
    CONSTRAINT PK_Rutas_del_usuario PRIMARY KEY (id_usuario, id_ruta_turistica),

    -- Llaves foráneas
    CONSTRAINT FK_Rutas_del_usuario_Usuarios 
        FOREIGN KEY (id_usuario) 
        REFERENCES usuarios (id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Rutas_del_usuario_Rutas 
        FOREIGN KEY (id_ruta_turistica) 
        REFERENCES rutas_turisticas (id_ruta_turistica)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE alquileres (
    id_alquiler INT IDENTITY(1,1) PRIMARY KEY, 
    estado VARCHAR(20) NOT NULL, 
    fecha_de_inicio DATE NOT NULL, 
    fin_de_vigencia DATE NOT NULL, 
    id_plan INT NOT NULL, 
    id_usuario INT NOT NULL, 
    id_bicicleta INT NOT NULL,  

    -- Foráneas
    CONSTRAINT FK_Alquileres_id_plan FOREIGN KEY (id_plan) 
        REFERENCES Planes(id_plan) ON UPDATE CASCADE ON DELETE NO ACTION,

    CONSTRAINT FK_Alquileres_id_usuario FOREIGN KEY (id_usuario) 
        REFERENCES Usuarios(id_usuario) ON UPDATE CASCADE ON DELETE NO ACTION, 

    CONSTRAINT FK_Alquileres_id_bicicleta FOREIGN KEY (id_bicicleta) 
        REFERENCES Bicicletas(id_bicicleta) ON UPDATE CASCADE ON DELETE NO ACTION, 

    -- Validaciones 
    CONSTRAINT chk_Alquiler_estado CHECK (estado IN ('activo','finalizado','cancelado')), 
    CONSTRAINT chk_Alquiler_fechas CHECK (fecha_de_inicio < fin_de_vigencia) 
);

CREATE TABLE metodos_de_pago_aceptados_en_el_alquiler (
    id_alquiler INT NOT NULL,
    id_metodo_de_pago INT NOT NULL,

    CONSTRAINT PK_metodos_de_pago_aceptados PRIMARY KEY (id_alquiler, id_metodo_de_pago),

    CONSTRAINT FK_metodos_pago_alquiler FOREIGN KEY (id_alquiler) 
        REFERENCES alquileres(id_alquiler) ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT FK_metodos_pago_metodos FOREIGN KEY (id_metodo_de_pago) 
        REFERENCES metodos_de_pago(id_metodo_pago) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE accesorios_de_la_bicicleta (
    id_bicicleta INT NOT NULL,
    id_accesorio INT NOT NULL,

    CONSTRAINT PK_accesorios_de_la_bicicleta PRIMARY KEY (id_bicicleta, id_accesorio),

    CONSTRAINT FK_accesorio_bicicleta FOREIGN KEY (id_bicicleta) 
        REFERENCES bicicletas(id_bicicleta) ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT FK_accesorio_accesorios FOREIGN KEY (id_accesorio) 
        REFERENCES accesorios(id_accesorio) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE condiciones_de_la_bicicleta (
    id_bicicleta INT NOT NULL,
    id_condicion_especial INT NOT NULL,

    CONSTRAINT PK_condiciones_de_la_bicicleta PRIMARY KEY (id_bicicleta, id_condicion_especial),

    CONSTRAINT FK_condicion_bicicleta FOREIGN KEY (id_bicicleta) 
        REFERENCES bicicletas(id_bicicleta) ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT FK_condicion_condiciones FOREIGN KEY (id_condicion_especial) 
        REFERENCES condiciones_especiales(id_condicion_especial) ON UPDATE CASCADE ON DELETE CASCADE
);





