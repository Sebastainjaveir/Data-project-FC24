attach(male_players_datset_finished)

# Se renombran las variables para mejor manejo
X1=age
X2=overall
X3=potential
X4=height_cm
X5=weight_kg
X6=remaininng_years_of_contract
X7=`preferred_foot 1 for left`
X8=pace
X9=shooting
X10=passing
X11=dribbling
X12=defending
X13=physic
Y=value_eur

# Creacion y busqueda de el mejor modelo de regresion multiple

modelo_fifa <- lm(Y ~ X1 + X2 + X6 + X9 + X11 + X13, data = male_players_datset_finished)
summary(modelo_fifa)

modelo_fifa_lin_log <- lm(Y ~ log(X1) + log(X2) + log(X9) + log(X11) + log(X13), data = male_players_datset_finished)
summary(modelo_fifa_lin_log)

modelo_fifa_log_lin <- lm(log(Y) ~ X1 + X2 + X3 + X6
                         + X7 + X8 + X9, data = male_players_datset_finished)
summary(modelo_fifa_log_lin)

modelo_fifa_log_log <-lm(Y ~ log(X1) + log(X2) + log(X9) + log(X11) + log(X13), data = male_players_datset_finished)
summary(modelo_fifa_log_log)

# Comprobacion de supuestos del modelo que mejor explica el valor de un jugador

#supuesto de linealidad #supuesto homocedasticidad

# Gráfico de residuos vs ajustados - 
plot(modelo_fifa_log_lin$fitted.values, modelo_fifa_log_lin$residuals,
     xlab = "Fitted Values", ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")

#supuesto de normalidad

# Gráfico Q-Q para verificar 
qqnorm(modelo_fifa_log_lin$residuals)
qqline(modelo_fifa_log_lin$residuals, col = "red")


#supuesto multicolinealidad

# Calcular VIF para el modelo
library(car)
vif(modelo_fifa_log_lin)


#supuesto de valores extremos


# Calcular residuos estudentizados 
studentized_residuals <- rstudent(modelo_fifa_log_lin)

# Graficar residuos estudentizados
plot(studentized_residuals, ylab = "Residuos Estudentizados", main = "Residuos Estudentizados")
abline(h = c(-3, 3), col = "red") # Línea en ±3 para identificar outliers

# Identificar los puntos con residuos estudentizados fuera de ±3
outliers <- abs(studentized_residuals) > 3

# Mostrar los índices de las observaciones que son outliers
outlier_indices <- which(outliers)
length(outlier_indices) # Número de outliers

# Ajustar el modelo sin los outliers
modelo_sin_outliers <- lm(log(Y) ~ X1 + X2 + X3 + X6 + X7 + X8 + X9, 
                          data = male_players_datset_finished[!outliers, ])
# Comparar los resultados
summary(modelo_sin_outliers)
summary(modelo_fifa_log_lin)




