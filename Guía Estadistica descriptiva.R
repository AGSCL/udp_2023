###########################
# ESTADISTICA DESCRIPTIVA #
###########################

# EJERCICIO 1
# INSTALAR(SI CORRESPONDE) Y ACTIVAR LAS SIGUIENTES LIBRERIAS
# readxl
# skimr
# epiDisplay

# EJERCICIO 2
# CARGAR LA BASE DE DATOS casen_red, guardela como data
# INCLUYA EL CODIGO EN EL SCRIPT


# ANALISIS DESCRIPTIVO DE VARIABLES CUANTITATIVAS
skim(data)
# EL PAQUETE skimr NOS PERMITE USAR LA FUNCION skim() 
# QUE NOS DA UN RESUMEN DE TODAS LAS VARIABLES EN NUESTRA BASE DE DATOS
# AQUI NOS PODEMOS DAR CUENTA DE VARIAS COSAS
# EN PRIMER LUGAR, ALGUNAS VARIABLES QUE DEBERIAN SER CUANTITATIVAS SON TOMADAS COMO CHARACTER
# EJEMPLO
class(nse) # NOTEMOS QUE ESTO DA UN ERROR
# DICE QUE NO ENCUENTRA ESA VARIABLE
# ESO OCURRE PORQUE CUANDO TRABAJAMOS CON DATA FRAME, Y QUEREMOS
# "LLAMAR" A UNA VARIABLE ESPECÍFICA DEL DATA FRAME
# DEBEMOS UTILIZAR UN SIGNO PESO $
class(data$nse)

# EJERCICIO 3 
# USAR EL COMANDO class() PARA OBSERVAR
# LA CLASE DE LAS VARIABLES QUE DEBERIAN SER CUANTITATIVAS


####################################################
# ESTADISTICA DESCRIPTIVA PARA VARIABLES NUMERICAS #
####################################################

# UNA FUNCION UTIL QUE VIENE DE BASE EN R ES summary()
# NOS SIRVE PARA SACAR ESTADISTICA DESCRIPTIVA DE VARIABLES CUANTITATIVAS
summary(data$v17)
# ESTO NOS DA LA SIGUIENTE INFORMACION
# EL MINIMO
# CUARTIL 1, 2 Y 3
# MEDIA
# MAXIMO
# NUMERO DE VALORES PERDIDOS


aggregate(v17 ~ 1, data = data, FUN = function(x) {
	c(media = round(mean(x, na.rm = TRUE), 2), 
	sd = round(sd(x, na.rm = TRUE), 2), 
	min = min(x, na.rm = TRUE), 
	max = max(x, na.rm = TRUE)) })

# El valor del dividendo tiene alta o baja dispersión?
# NOTEMOS QUE HAY UN -88, ESO NO TIENE SENTIDO
# ES IMPORTANTE LIMPIAR LAS VARIABLES DE VALORES RAROS

data$v17[data$v17 == -88] <- NA

# AHORA SI
aggregate(edad ~ 1, data = data, FUN = function(x) {
	c(media = round(mean(x, na.rm = TRUE), 2), 
	sd = round(sd(x, na.rm = TRUE), 2), 
	min = min(x, na.rm = TRUE), 
	max = max(x, na.rm = TRUE)) })
####################################################
# ESTADISTICA DESCRIPTIVA PARA VARIABLES NOMINALES #
####################################################

# UN COMANDO MUY UTIL PARA SACAR TABLAS DE FRECUENCIA ES tab1()
tab1(data$nse)
# INTERPRETAR LA TABLA
# 1: BAJO, 2: MEDIO, 3: ALTO, 4: BAJO-MEDIO, 5: BAJO-ALTO, 6: BAJO-MEDIO-ALTO, 7:MEDIO-ALTO


# EJERCICIO 
# HACER TABLAS DE FRECUENCIA PARA TODAS LAS VARIABLES NOMINALES
# INTERPRETAR LOS RESULTADOS

##################################
# ANALISIS DESCRIPTIVO BIVARIADO #
##################################


# MUCHAS VECES NOS INTERESARA DESCRIBIR LA RELACION ENTRE DOS VARIABLES
# DPLYR NOS AYUDA MUCHO CON ESO
# PODEMOS VINCULAR UNA VARIABLE NOMINAL CON UNA CUANTITATIVA


aggregate(v18 ~ sexo, 
	data = data[!is.na(data$v18) & data$v18 > -88, ], # ESTABLECEMOS FILTROS PARA ELIMINAR NA, 
	FUN = function(x) {
	c(media = round(mean(x, na.rm = TRUE), 2), 
	sd = round(sd(x, na.rm = TRUE), 2), 
	min = min(x, na.rm = TRUE), 
	max = max(x, na.rm = TRUE)) })


# EJERCICIO 
# RESPONDER ESTAS PREGUNTAS UTILIZANDO ANALISIS BIVARIADO CON DPLYR
# ¿En qué región las personas pagan más en arriendo?
# ¿En qué región las personas pagan más dividendo?

