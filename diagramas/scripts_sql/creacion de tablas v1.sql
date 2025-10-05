CREATE TABLE Departamentos (
    id_departamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT chk_Departamentos_nombre CHECK (TRIM(nombre) <> '')
);

CREATE TABLE Ciudades (
    id_ciudad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    CONSTRAINT id_departamento FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
    ON UPDATE CASCADE 
    ON DELETE NO ACTION,
    CONSTRAINT chk_Ciudades_nombre CHECK (TRIM(nombre) <> '')
);


CREATE TABLE Tipos_de_uso (
    id_tipo_de_uso INT IDENTITY(1,1),
    nombre VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    CONSTRAINT PK_Tipos_de_uso PRIMARY KEY (id_tipo_de_uso),
    CONSTRAINT chk_Tipos_de_uso_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_Tipos_de_uso_descripcion CHECK (TRIM(descripcion) <> '')
);


CREATE TABLE Accesorios (
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
    id_accesorio INT NOT NULL
    CONSTRAINT FK_Bicicletas_id_tipo_uso FOREIGN KEY (id_tipo_de_uso) 
    REFERENCES Tipos_de_uso(id_tipo_de_uso)ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Bicicletas_id_condiciones_especiales FOREIGN KEY (id_condiciones_especiales) 
    REFERENCES condiciones_especiales(id_condicion_especial) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Bicicletas_id_accesorio FOREIGN KEY (id_accesorio) 
    REFERENCES Accesorios (id_accesorio)ON UPDATE CASCADE ON DELETE NO ACTION,
     CONSTRAINT chk_numero_de_cuadro CHECK (LTRIM(RTRIM(numero_de_cuadro)) <> ''),
    CONSTRAINT chk_marca CHECK (TRIM(marca) <> ''),
    CONSTRAINT chk_modelo CHECK (TRIM(TRIM(modelo)) <> ''),
    CONSTRAINT chk_año_fabricacion CHECK (año_fabricacion <= GETDATE()),
    CONSTRAINT chk_tarifa_base CHECK (tarifa_base_de_alquiler > 0),
    CONSTRAINT chk_tamaño_marco_cm CHECK (tamaño_marco_cm BETWEEN 30 AND 80), -- rango lógico en cm
    CONSTRAINT chk_tamaño_marco_in CHECK (tamaño_marco_in IS NULL OR tamaño_marco_in BETWEEN 12 AND 32), -- pulgadas
    CONSTRAINT chk_horas_de_uso CHECK (horas_de_uso IS NULL OR horas_de_uso >= 0),
    CONSTRAINT chk_kilometraje CHECK (kilometraje IS NULL OR kilometraje >= 0)
);


CREATE TABLE Puntos_Alquiler (
    id_punto_alquiler INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    id_ciudad INT NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    longitud DECIMAL(12,8) NULL,
    latitud DECIMAL(12,8) NULL,
    hora_apertura TIME NOT NULL,
    hora_cierre TIME NOT NULL,
    dias_abierto VARCHAR NOT NULL
    CONSTRAINT FK_PuntoAlquiler_id_ciudad FOREIGN KEY (id_ciudad) REFERENCES Ciudades (id_ciudad) ON UPDATE CASCADE 
    ON DELETE NO ACTION,
   
    CONSTRAINT chk_nombre CHECK (TRIM(nombre) <> ''),
    CONSTRAINT chk_direccion CHECK (TRIM(direccion) <> ''),

    CONSTRAINT chk_longitud CHECK (longitud IS NULL OR (longitud BETWEEN -180 AND 180)),
    CONSTRAINT chk_latitud CHECK (latitud IS NULL OR (latitud BETWEEN -90 AND 90)),

    CONSTRAINT chk_horario CHECK (hora_apertura < hora_cierre),

    CONSTRAINT chk_dias_abierto CHECK (dias_abierto LIKE ('%-%'))
);


CREATE TABLE Idiomas ( 
    id_idioma INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    codigo_ISO INT NOT NULL, 
    codigo_ISO_639_2 VARCHAR(10) NOT NULL, 
    codigo_ISO_639_1 VARCHAR(10) NOT NULL, 
    CONSTRAINT chk_Idiomas_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Idiomas_codigoISO CHECK (codigo_ISO > 0) 
); 



CREATE TABLE Sistemas_de_medicion ( 
    id_sistema_medicion INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    CONSTRAINT chk_Sistemas_medicion_nombre CHECK (TRIM(nombre) <> '') 
);


CREATE TABLE Preferencias ( 
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY, 
    id_idioma INT NOT NULL, 
    id_sistema_medicion INT NOT NULL,
    CONSTRAINT FK_Preferencias_Idiomas FOREIGN KEY (id_idioma) REFERENCES Idiomas(id_idioma) ON UPDATE CASCADE ON DELETE NO ACTION, 
    CONSTRAINT FK_Preferencias_Sistemas_medicion FOREIGN KEY (id_sistema_medicion) 
    REFERENCES Sistemas_de_medicion(id_sistema_medicion) ON UPDATE CASCADE ON DELETE NO ACTION 
); 

CREATE TABLE Puntos_de_interes (
    id_punto_interes INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(150) NOT NULL, 
    longitud DECIMAL(9,6) NOT NULL, 
    latitud DECIMAL(9,6) NOT NULL, 
    CONSTRAINT chk_Puntos_de_interes_nombre CHECK (TRIM(nombre) <> ''), 
    CONSTRAINT chk_Puntos_de_interes_long CHECK (longitud BETWEEN -180 AND 180), 
    CONSTRAINT chk_Puntos_de_interes_lat CHECK (latitud BETWEEN -90 AND 90) 
); 

CREATE TABLE Niveles_dificultad ( 
    id_nivel_dificultad INT IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(13) NOT NULL, 
    descripcion VARCHAR(200) NULL, 
    CONSTRAINT chk_Niveles_dificultad_nombre CHECK (nombre IN ('facil','moderado','dificil')) 
); 

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

CREATE TABLE Terminos_y_condiciones ( 
    id_terminos_condiciones INT IDENTITY(1,1) PRIMARY KEY, 
    es_aceptado BIT NOT NULL DEFAULT 0 
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


CREATE TABLE Etiquetas (
    id_etiqueta INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    CONSTRAINT chk_Etiquetas_titulo CHECK (TRIM(titulo) <> '')
);

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

CREATE TABLE Metodos_de_pago (
    id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    es_transferencia BIT NOT NULL DEFAULT 0,
    CONSTRAINT chk_Metodos_de_pago_nombre CHECK (TRIM(nombre) <> '')
);

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
    -- Validaciones 
    CONSTRAINT chk_Alquiler_estado CHECK (estado IN ('activo','finalizado','cancelado')), 
    CONSTRAINT chk_Alquiler_fechas CHECK (fecha_de_inicio < fin_de_vigencia) 

);
