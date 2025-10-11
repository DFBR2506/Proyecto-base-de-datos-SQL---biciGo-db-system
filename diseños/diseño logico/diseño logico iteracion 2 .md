
Bicicletas {
	id_bicicleta integer pk
	modelo varchar
	número_de_cuadro varchar unique
	horas_de_uso integer
	año_de_fabricación date
	tarifa_base_de_alquiler decimal
	etiquetas_adicionales varchar null
	tamaño_del_marco_(cm) decimal
	tamaño_del_marco_(in) decimal
	es_eléctrica boolean
	id_tipo_de_uso integer *> Tipos_de_uso.id_tipo_de_uso
	id_punto_de_alquiler integer unique *> Puntos_de_alquiler.id_punto_de_alquiler
	kilometraje_(km) integer
	kilometraje_(mi) integer
	id_archivo_multimedia integer >* Archivos_multimedia.id_archivo_multimedia
	id_estado_mantenimiento integer *> Estados_mantenimiento.id_estado_mantenimiento
	id_seguro integer *> Seguros.id_seguro
	id_mantenimiento integer >* Mantenimientos.id_mantenimiento
	id_reporte integer >* Reportes.id_reporte
	id_marca integer *> Marcas.id_marca
	id_estado_de_disponibilidad integer *> Estados_de_disponibilidad.id_estado_de_disponibilidad
}

Tipos_de_uso {
	id_tipo_de_uso integer pk
	nombre varchar unique
	descripción varchar
}

Puntos_de_alquiler {
	id_punto_de_alquiler integer pk
	nombre varchar unique
	longitud decimal
	latitud decimal
	id_ciudad integer *> Ciudades.id_ciudad
	id_horario integer > Horarios.id_horario
}

Ciudades {
	id_ciudad integer pk
	nombre varchar
	id_departamento integer *> Departamentos.id_departamento
}

Departamentos {
	id_departamento integer pk *> Ciudades.id
	nombre varchar
}

Accesorios {
	id_accesorio integer pk
	función varchar
	nombre varchar unique
}

Alquileres {
	id_alquiler integer pk
	estado varchar
	fecha_de_inicio date
	fin_de_vigencia date
	id_plan integer *> Planes.id_plan
	id_usuario integer >* Usuarios.id_usuario
	id_bicicleta integer *> Bicicletas.id_bicicleta
	id_método_de_pago integer > Métodos_de_pago.id_método_de_pago
}

Métodos_de_pago {
	id_método_de_pago integer pk
	nombre varchar unique
	es_transferencia boolean
}

Planes {
	id_plan integer pk
	tipo_de_plan varchar unique
	descripción varchar
	beneficios_específicos varchar
	condiciones_especiales varchar
	tarifa_asociada decimal
}

Usuarios {
	id_usuario integer pk
	email varchar unique
	contraseña varchar
	número_de_teléfono varchar unique
	id_documento_de_identificación integer unique *> Documentos_de_identificación.id_documento_de_identificación
	fecha_de_registro date
	fecha_de_nacimiento date
	id_preferencia integer *> Preferencias.id_preferencia
	id_política integer *> Políticas.id_política
	id_reporte integer >* Reportes.id_reporte
	primer_nombre varchar
	primer_apellido varchar
}

Comentarios {
	id_comentario integer pk
	id_usuario integer *> Usuarios.id_usuario
	calificación integer
	descripción varchar
	fecha_de_realización date
	id_ruta_turistica integer >* Rutas_turísticas.id_ruta_turística
}

Idiomas {
	id_idioma integer pk
	nombre varchar unique
	código_ISO_639_2 varchar unique
	código_ISO_639_1 varchar unique
}

Niveles_de_dificultad {
	id_nivel_dificultad integer pk
	nombre varchar unique
	descripción varchar
}

Rutas_turísticas {
	id_ruta_turística integer pk
	nombre varchar unique
	distancia_total_(mi) decimal
	distancia_total_(km) integer
	id_nivel_dificultad integer *> Niveles_de_dificultad.id_nivel_dificultad
}

Puntos_de_interés {
	id_punto_de_interés integer pk
	nombre varchar
	longitud decimal
	latitud decimal
}

Formatos_de_archivo {
	id_formato_de_archivo integer pk
	nombre varchar unique
	acrónimo varchar
}

Archivos_multimedia {
	id_archivo_multimedia integer pk
	URL varchar unique
	tamaño_(mb) decimal
	id_formato_de_archivo integer *> Formatos_de_archivo.id_formato_de_archivo
	fecha_de_subida date
}

Sistemas_de_medición {
	id_sistema_de_medición integer pk
	nombre varchar unique
}

Preferencias {
	id_preferencia integer pk
	id_idioma integer *> Idiomas.id_idioma
	id_sistema_de_medición integer *> Sistemas_de_medición.id_sistema_de_medición
}

Políticas {
	id_política integer pk
	es_aceptado boolean
	versión_de_los_términos integer increments unique
}

Etiquetas {
	id_etiqueta integer pk
	título varchar unique
}

Condiciones_especiales {
	id_condición_especial integer pk
	nombre varchar unique
	descripción integer
}

Puntos_de_interés_de_las_rutas {
	id_punto_de_interés integer pk increments unique *> Puntos_de_interés.id_punto_de_interés
	id_ruta_turística integer pk *> Rutas_turísticas.id_ruta_turística
}

Rutas_de_usuarios {
	id_usuario integer pk unique *> Usuarios.id_usuario
	id_ruta_turística integer pk *> Rutas_turísticas.id_ruta_turística
	fecha_realizacion date
}

Archivos_multimedia_de_comentarios {
	id_comentario integer pk *> Comentarios.id_comentario
	id_archivo_multimedia integer pk *> Archivos_multimedia.id_archivo_multimedia
}

Etiquetas_de_comentarios {
	id_comentario integer pk increments *> Comentarios.id_comentario
	id_etiqueta integer pk *> Etiquetas.id_etiqueta
}

Condiciones_de_bicicletas {
	id_bicicleta integer pk *> Bicicletas.id_bicicleta
	id_condición_especial integer pk *> Condiciones_especiales.id_condición_especial
}

Accesorios_de_bicicletas {
	id_bicicleta integer pk unique *> Bicicletas.id_bicicleta
	id_accesorio integer pk *> Accesorios.id_accesorio
}

Estados_de_disponibilidad {
	id_estado_de_disponibilidad integer pk
	nombre varchar unique
	descripción varchar null
}

Estados_mantenimiento {
	id_estado_mantenimiento integer pk
	nombre varchar unique
	descripción varchar null
}

Empresas_de_seguros {
	id_empresa_de_seguros integer pk
	nombre varchar unique
	eslogan varchar null
}

Seguros {
	id_seguro integer pk
	tarifa_base integer
	cobertura varchar
	máximo_valor_asegurable integer
	id_empresa_de_seguros integer *> Empresas_de_seguros.id_empresa_de_seguros
}

Mantenimientos {
	id_mantenimiento integer pk increments unique
	descripción varchar
	fecha_de_inicio date
	fecha_de_fin date
	id_tipo_de_mantenimiento integer *> Tipos_de_mantenimiento.id_tipo_de_mantenimiento
}

Tipos_de_mantenimiento {
	id_tipo_de_mantenimiento integer pk increments unique
	nombre varchar unique
	descripción varchar null
}

Reportes {
	id_reporte integer pk increments unique
	título varchar
	descripción varchar
	id_estado_del_reporte integer *> Estados_del_reporte.id_estado_del_reporte
}

Estados_del_reporte {
	id_estado_del_reporte integer pk increments unique
	nombre varchar unique
	descripción varchar null
}

Marcas {
	id_marca integer pk increments unique
	nombre varchar unique
	eslogan varchar null
}

Horarios {
	id_horario integer pk increments unique
}

Días {
	id_día integer pk increments unique
	nombre varchar unique
}

Documentos_de_identificación {
	id_documento_de_identificación integer pk increments unique
	número integer unique
	id_tipo_de_documento integer *> Tipos_de_documento.id_tipo_de_documento
	lugar_de_expedición varchar
	fecha_de_expedición date
}

Tipos_de_documento {
	id_tipo_de_documento integer pk increments unique
	nombre varchar unique
	acrónimo varchar
}

Días_de_los_horarios {
	id_días_de_los_horarios integer pk
	id_día integer increments unique *> Días.id_día
	id_horario integer *> Horarios.id_horario
	hora_de_apertura time
	hora_de_cierre time
}

Archivos_multimedia_de_reportes {
	id_reporte integer increments unique *> Reportes.id_reporte
	id_archivo_multimedia integer *> Archivos_multimedia.id_archivo_multimedia
}

Métodos_de_pago_aceptados_por_alquileres {
	id_punto_de_alquiler integer increments unique *> Puntos_de_alquiler.id_punto_de_alquiler
	id_método_de_pago integer *> Métodos_de_pago.id_método_de_pago
}

