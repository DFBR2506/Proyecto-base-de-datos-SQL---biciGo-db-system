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
	es_electrica boolean
	id_tipo_de_uso integer *> Tipos_de_uso.id_tipo_de_uso
	id_punto_de_alquiler integer unique *> Puntos_de_alquiler.id_punto_de_alquiler
	kilometraje_(km) integer
	id_archivo_multimedia integer >* Archivos_multimedia.id_archivo_multimedia
	id_estado_mantenimiento integer *> Estado_mantenimiento.id_estado_mantenimiento
	id_seguro integer *> Seguro.id_seguro
	id_mantenimiento integer >* Mantenimiento.id_mantenimiento
	id_reporte integer >* Reporte.id_reporte
	id_marca integer *> Marca.id_marca
	id_estado_de_disponibilidad integer *> Estado_de_disponibilidad.id_estado_de_disponibilidad
}

Tipos_de_uso {
	nombre varchar unique
	descripcion varchar
	id_tipo_de_uso integer pk
}

Puntos_de_alquiler {
	nombre varchar unique
	longitud decimal
	latitud decimal
	horario_de_atención time
	id_ciudad integer *> Ciudades.id_ciudad
	id_punto_de_alquiler integer pk
	id_m integer
	id_método_de_pago integer *>* Métodos_de_pago.id_método_de_pago
	id_horario integer *> Horario.id_horario
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
	nombre varchar
}

Alquileres {
	id_alquiler integer pk
	estado varchar
	fecha_de_inicio date
	fin_de_vigencia date
	id_plan integer *> Planes.id_plan
	id_usuario integer >* Usuarios.id_usuario
	id_bicicleta integer *> Bicicletas.id_bicicleta
	id_método_de_pago integer *> Métodos_de_pago.id_método_de_pago
}

Métodos_de_pago {
	id_método_de_pago integer pk
	nombre varchar
	es_transferencia boolean
}

Planes {
	id_plan integer pk
	tipo_de_plan varchar
	descripcion varchar
	beneficios_especificos varchar
	condiciones_especiales varchar
	tarifa_asociada decimal
}

Usuarios {
	id_usuario integer pk
	nombre_completo varchar
	email varchar unique
	contraseña varchar
	numero_de_teléfono varchar unique
	documento_de_identificación varchar unique
	fehca_de_registro date
	fecha_de_nacimiento date
	id_preferencia integer *> Preferencias.id_preferencia
	id_politica integer *> Politicas.id_politica
	id_reporte integer >* Reporte.id_reporte
}

Comentarios {
	id_usuario integer *> Usuarios.id_usuario
	calificación integer
	descripcion varchar
	fecha_de_realización date
	id_comentario integer pk
}

Idiomas {
	id_idioma integer pk
	nombre varchar
	codigo_ISO_639-2 varchar
	codigo_ISO_639-1 varchar
}

Niveles_de_dificultad {
	nombre varchar
	descripcion varchar
	id_nivel_dificultad integer pk
}

Rutas_turisticas {
	distancia_total decimal
	nombre varchar
	id_ruta_turistica integer pk
	id_nivel_dificultad integer *> Niveles_de_dificultad.id_nivel_dificultad
}

Puntos_de_interes {
	id_punto_de_interes integer pk
	nombre varchar
	longitud decimal
	latitud decimal
}

Formatos_de_archivo {
	id_formato_de_archivo integer pk
	nombre varchar
	siglas varchar
}

Archivos_multimedia {
	id_archivo_multimedia integer pk
	nombre varchar
	tamaño_(mb) decimal
	id_formato_de_archivo integer *> Formatos_de_archivo.id_formato_de_archivo
}

Sistemas_de_medicion {
	id_sistema_de_medición integer pk
	nombre varchar
}

Preferencias {
	id_preferencia integer pk
	id_idioma integer *> Idiomas.id_idioma
	id_sistema_de_medición integer *> Sistemas_de_medicion.id_sistema_de_medición
}

Politicas {
	id_politica integer pk
	es_aceptado boolean
	version_de_los_terminos integer increments unique
}

Etiquetas {
	id_etiqueta integer pk
	titulo varchar
}

Condiciones_especiales {
	id_condicion_especial integer pk
	nombre varchar
	descripcion integer
}

Puntos_de_interes_de_las_rutas {
	id_punto_de_interes integer pk increments unique *> Puntos_de_interes.id_punto_de_interes
	id_ruta_turistica integer pk *> Rutas_turisticas.id_ruta_turistica
}

Rutas_del_usuario {
	id_usuario integer pk unique *> Usuarios.id_usuario
	id_ruta_turistica integer pk *> Rutas_turisticas.id_ruta_turistica
}

Archivos_multimedia_del_comentario {
	id_comentario integer pk *> Comentarios.id_comentario
	id_archivo_multimedia integer pk *> Archivos_multimedia.id_archivo_multimedia
}

Etiquetas_del_comentario {
	id_comentario integer pk increments *> Comentarios.id_comentario
	id_etiqueta integer pk *> Etiquetas.id_etiqueta
}

Condiciones_de_la_bicicleta {
	id_bicicleta integer pk *> Bicicletas.id_bicicleta
	id_condicion_especial integer pk *> Condiciones_especiales.id_condicion_especial
}

Accesorios_de_la_bicicleta {
	id_bicleta integer pk unique *> Bicicletas.id_bicicleta
	id_accesorio integer pk *> Accesorios.id_accesorio
}

Estado_de_disponibilidad {
	id_estado_de_disponibilidad integer pk
	nombre varchar
	descripcion varchar null
}

Estado_mantenimiento {
	id_estado integer pk
	id_estado_mantenimiento integer
	nombre varchar unique
	descripcion varchar
}

Empresa_de_seguros {
	id_empresa_de_seguros integer pk
	nombre varchar
	eslogan varchar
}

Seguro {
	id_seguro integer pk
	tarifa_base integer
	que_cubre varchar
	máximo_valor_asegurable integer
	id_empresa_de_seguros integer *> Empresa_de_seguros.id_empresa_de_seguros
}

Mantenimiento {
	id_mantenimiento integer pk increments unique
	descripcion varchar
	fecha_de_inicio date
	fecha_de_fin date
	id_tipo_de_mantenimiento integer *> Tipo_de_mantenimiento.id_tipo_de_mantenimiento
}

Tipo_de_mantenimiento {
	id_tipo_de_mantenimiento integer pk increments unique
	nombre varchar
	descripcion varchar null
}

Reporte {
	titulo varchar
	descripcion varchar
	id_estado_del_reporte integer *> Estado_del_reporte.id_estado_del_reporte
	id_reporte integer pk increments unique
	id_archivo_multimedia integer *>* Archivos_multimedia.id_archivo_multimedia
}

Estado_del_reporte {
	id_estado_del_reporte integer pk increments unique
	nombre varchar unique
	descripcion varchar null
}

Marca {
	id_marca integer pk increments unique
	nombre varchar unique
	eslogan varchar null
}

Horario {
	id_horario integer pk increments unique
	hora_de_apertura integer
	hora_de_cierre integer
	id_dia integer *>* Dia.id_dia
}

Dia {
	id_dia integer pk increments unique
	nombre integer unique
}
