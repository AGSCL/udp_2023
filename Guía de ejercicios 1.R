# Bienvenid@s a R, pueden escribir sus apuntes utilizando el "gato"(shift+3) 
# R es un software gratuito de codigo abierto
# Recomendaciones generales para el desarrollo del script
# No usar caracteres especiales como tildes o eñes.
# R es case sensitive, eso significa que es importante respetar las mayusculas y minusculas de las funciones
# R se puede usar como calculadora, probemos.

# Suma
5 + 5 

# Resta
5 - 5 

# Multiplicación
3 * 5

# División
(5 + 5) / 2 

# Potencia
2^5 
# Exponencial
exp(10)

# Logaritmo natural
log(10)

# Logaritmo base 10
log10(10)

########################
##### EJERCICIO 1 ######
########################

# Ahora ustedes deben calcular lo siguiente:
# 1) La diferencia entre 20 y 10, divido por 5.
# 2) La diferencia entre 5 y 2 elevado a 4.
# 3) El producto entre 9 y la diferencia entre 10 y 4.

# Los resultados se pueden almacenar en el Environment (Esquina superior derecha), tienen que usar una flecha "<-",
# De esta forma podemos crear objetos.

x <- 24

# El objeto x tiene solamente una observación, que es 24. Cuando la guardamos, 
# no nos da el resultado inmediatamente, tenemos que "llamar" al objeto.
x
# Es equivalente usar
print(x)

# Se pueden hacer operaciones matemáticas con los objetos guardados
manzanas <- 5

peras <- 6

frutas <- manzanas + peras

print(frutas)

#####################
#### EJERCICIO 2 ####
#####################

# 1.a) Crear un objeto llamado a, que sea igual a 100
# 1.b) Calcular el logartimo natural de a, guardarlo como log_a
# 2) Calcular la exponencial de log_a, no guardar el resultado
# En R existen diferentes tipos de variables: Numeric o numéricas, Character o 
# categóricas y Logical o lógicas
numerica <- 42

categorica <- "perro"

logica <- TRUE

# Podemos ver el tipo de variable utilizando el comando class
class(numerica)

###############
# EJERCICIO 3 #
###############
# Revisar la clase del objeto categorica y logica usando la funcion class()


# Hasta ahora, solo hemos trabajado con una sola "observacion". Para crear un vector, 
# debemos utilizar el comando c() que significa concatenar.
vector_numerico <- c(20,21,15,26)
vector_numerico
class(vector_numerico)

###############
# EJERCICIO 4 #
###############
# 1.a) Crear un vector llamado vector_categorico que sea de clase character
# este vector debe contener los elementos: perro,gato,canario,caballo
# 1.b) Inspeccionar la clase del vector_categorico

# 2.a) Crear un vector llamado vector_logico que sea de clase logical
# este vector debe contener los elementos: verdadero,falso,falso,verdadero
# 2.b) Inspeccionar la clase del vector_logico

# OPERACIONES CON VECTORES
vector_a <- c(1,2,3)
vector_b <- c(4,5,6)
vector_total <- vector_a + vector_b
vector_total

# Notemos que R suma el elemento 1 del vector 1 con el elemento 1 del vector 2
# y asi sucesivamente.

###################
### EJERCICIO 5 ###
###################
# Fueron al casino durante una semana (de lunes a viernes). Jugaron poker y ruleta. 
# A continuación se encuentra el balance por día del poker:
# Lunes: Ganaron 100
# Martes: Perdieron 200
# Miércoles: Ganaron 20
# Jueves: Perdieron 150
# Viernes: Ganaron 200

# Ahora el balance de la ruleta
# Lunes: Ganaron 40
# Martes: Perdieron 30
# Miércoles: Ganaron 100
# Jueves: Perdieron 140
# Viernes: Ganaron 60

# Construir dos vectores que reflejen el balance de cada juego, durante los 5 días.
# El primer vector debe llamarse poker, el segundo debe llamarse ruleta.




##################
# Librerias en R #
##################

install.packages(epiDisplay) # esto nos da error porque no esta con comillas
install.packages("epiDisplay") # esto si funciona
# R nos ayuda con las funciones y paquetes para entender como funcionan
??epiDisplay
# Esta librería nos permite usar la funcion tab1()
tab1(Marryage$sex) 
# Esto da error.
# ES IMPORTANTE ACTIVAR LA LIBRERIA DESPUES DE INSTALARLA USANDO library()
library(epiDisplay)
data(Marryage) # CARGAMOS UNA BASE DE DATOS DE PRUEBA QUE ESTA INCLUIDO EN EL PAQUETE epiDisplay
View(Marryage) # NOS DA UN VISTAZO DE LA BASE DE DATOS

tab1(Marryage$sex) # TABLA DE FRECUENCIAS DE LA VARIABLE SEXO 

###############
# EJERCICIO 6 #
###############

# UTILIZAR LA FUNCION tab1() CON LA VARIABLE educ


###############
# EJERCICIO 7 #
###############

# INSTALAR EL PAQUETE tidyverse

