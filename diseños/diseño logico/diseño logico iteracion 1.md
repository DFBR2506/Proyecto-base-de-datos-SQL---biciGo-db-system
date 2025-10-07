
bicicletas {
	id_bicicleta integer pk
	modelo varchar
	número_de_cuadro varchar unique
	horas_de_uso integer
	marca varchar
	año_de_fabricación date
	tarifa_base_de_alquiler decimal
	etiquetas_adicionales varchar null
	tamaño_del_marco_(cm) decimal
	tamaño_del_marco_(in) decimal
	es_electrica boolean
	id_tipo_de_uso integer *> tipos_de_uso.id_tipo_de_uso
	id_punto_de_alquiler integer unique *> puntos_de_alquiler.id_punto_de_alquiler
}

tipos_de_uso {
	nombre varchar
	descripcion varchar
	id_tipo_de_uso integer pk
}

puntos_de_alquiler {
	nombre varchar unique
	longitud decimal
	latitud decimal
	horario_de_atención time
	id_ciudad integer *> ciudades.id_ciudad
	id_punto_de_alquiler integer pk
}

ciudades {
	id_ciudad integer pk
	nombre varchar
	id_departamento integer *> departamentos.id_departamento
}

departamentos {
	id_departamento integer pk *> ciudades.id
	nombre varchar
}

accesorios {
	id_accesorio integer pk
	función varchar
	nombre varchar
}

alquileres {
	id_alquiler integer pk
	estado varchar
	fecha_de_inicio date
	fin_de_vigencia date
	id_plan integer *> planes.id_plan
	id_usuario integer >* usuarios.id_usuario
	id_bicicleta integer *> bicicletas.id_bicicleta
}

métodos_de_pago {
	id_método_de_pago integer pk
	nombre varchar
	es_transferencia boolean
}

planes {
	id_plan integer pk
	tipo_de_plan varchar
	descripcion varchar
	beneficios_especificos varchar
	condiciones_especiales varchar
	tarifa_asociada decimal
}

usuarios {
	id_usuario integer pk
	nombre_completo varchar
	email varchar unique
	contraseña varchar
	numero_de_teléfono varchar unique
	documento_de_identificación varchar unique
	fehca_de_registro date
	fecha_de_nacimiento date
	id_preferencia integer *> preferencias.id_preferencia
	id_politica integer *> politicas.id_politica
}

comentarios {
	id_usuario integer *> usuarios.id_usuario
	calificación integer
	descripcion varchar
	fecha_de_realización date
	id_comentario integer pk
}

idiomas {
	id_idioma integer pk
	nombre varchar
	codigo_ISO_639-2 varchar
	codigo_ISO_639-1 varchar
}

niveles_de_dificultad {
	nombre varchar
	descripcion varchar
	id_nivel_dificultad integer pk
}

rutas_turisticas {
	distancia_total decimal
	nombre varchar
	id_ruta_turistica integer pk
	id_nivel_dificultad integer *> niveles_de_dificultad.id_nivel_dificultad
}

puntos_de_interes {
	id_punto_de_interes integer pk
	nombre varchar
	longitud decimal
	latitud decimal
}

formatos_de_archivo {
	id_formato_de_archivo integer pk
	nombre varchar
	siglas varchar
}

archivos_multimedia {
	id_archivo_multimedia integer pk
	nombre varchar
	tamaño_(mb) decimal
	id_formato_de_archivo integer *> formatos_de_archivo.id_formato_de_archivo
}

sistemas_de_medicion {
	id_sistema_de_medición integer pk
	nombre varchar
}

preferencias {
	id_preferencia integer pk
	id_idioma integer *> idiomas.id_idioma
	id_sistema_de_medición integer *> sistemas_de_medicion.id_sistema_de_medición
}

politicas {
	id_politica integer pk
	es_aceptado boolean
	version_de_los_terminos integer increments unique
}

etiquetas {
	id_etiqueta integer pk
	titulo varchar
}

condiciones_especiales {
	id_condicion_especial integer pk
	nombre varchar
	descripcion integer
}

puntos_de_interes_de_las_rutas {
	id_punto_de_interes integer pk increments unique *> puntos_de_interes.id_punto_de_interes
	id_ruta_turistica integer pk *> rutas_turisticas.id_ruta_turistica
}

rutas_del_usuario {
	id_usuario integer pk unique *> usuarios.id_usuario
	id_ruta_turistica integer pk *> rutas_turisticas.id_ruta_turistica
}

archivos_multimedia_del_comentario {
	id_comentario integer pk *> comentarios.id_comentario
	id_archivo_multimedia integer pk *> archivos_multimedia.id_archivo_multimedia
}

etiquetas_del_comentario {
	id_comentario integer pk increments *> comentarios.id_comentario
	id_etiqueta integer pk *> etiquetas.id_etiqueta
}

metodos_de_pago_aceptados_en_el_alquiler {
	id_alquiler integer pk *> alquileres.id_alquiler
	id_metodo_de_pago integer pk *> métodos_de_pago.id_método_de_pago
}

condiciones_de_la_bicicleta {
	id_bicicleta integer pk *> bicicletas.id_bicicleta
	id_condicion_especial integer pk *> condiciones_especiales.id_condicion_especial
}

accesorios_de_la_bicleta {
	id_bicleta integer pk unique *> bicicletas.id_bicicleta
	id_accesorio integer pk *> accesorios.id_accesorio
}

