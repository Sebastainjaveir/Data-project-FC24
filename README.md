# Data-project-FC24
Análisis de Correlación entre Atributos y Valor de Mercado en FC 24

EA Sports FC 24 es la última versión de la icónica serie de videojuegos de simulación de fútbol, anteriormente conocida como FIFA. Este juego permite a los jugadores gestionar equipos de fútbol profesional, participando en torneos y competiciones con jugadores y equipos reales ofreciendo una simulación detallada del rendimiento de jugadores y equipos, con estadísticas que imitan la realidad del mundo futbolístico.
El dataset utilizado para este proyecto contiene información detallada sobre jugadores, entrenadores y equipos desde FIFA 15 hasta EA Sports FC 24. Con más de 109 atributos por jugador, este conjunto de datos permite un análisis profundo de las características de los jugadores, como su velocidad, habilidades de ataque y defensa, y otras estadísticas personales y profesionales. El propósito de este proyecto es aprovechar estos datos para investigar cómo los diferentes atributos influyen en el valor de mercado de los jugadores dentro del juego, ofreciendo insights sobre la relación entre el rendimiento de los jugadores y su valoración.
El objetivo de este proyecto es analizar la relación entre los atributos de los jugadores y su valor de mercado en EA Sports FC 24. Se realizará un análisis de regresión múltiple para identificar cómo variables como la velocidad, el ataque, la defensa, la edad, el pie preferido y el tiempo restante en el contrato influyen en la determinación del valor de mercado de los jugadores.
El dataset utilizado para este análisis fue obtenido de Kaggle, una plataforma reconocida por ofrecer una amplia variedad de datasets de dominio público. Este conjunto de datos incluye información detallada sobre jugadores, entrenadores y equipos desde FIFA 15 hasta EA Sports FC 24, siendo de acceso público para cualquier interesado en realizar análisis sobre esta información.

Proceso ETL

Para la extracción de los datos, se utilizó SQLite, una base de datos ligera y eficiente para la manipulación y consulta de grandes volúmenes de información. En esta etapa, se seleccionaron los atributos más relevantes para el análisis, como velocidad, habilidades de ataque, defensa, edad, valor de mercado, y tiempo restante en el contrato. En el mismo proceso de extracción con SQL, se calculó el tiempo restante en el contrato, restando la fecha de finalización del contrato de cada jugador de la fecha en que se obtuvieron los datos, transformando la información en días restantes para facilitar su uso en el análisis. La extracción se limitó exclusivamente a la última versión del juego, EA Sports FC 24, para asegurar que los datos analizados correspondieran a la versión más reciente y reflejaran las condiciones actuales.
 
Una vez extraídos, los datos fueron exportados en formato CSV desde SQLite y cargados en Excel para su transformación final utilizando Power Query. Durante esta etapa, se realizaron varias acciones clave. Se ajustaron los tipos de datos de cada columna para garantizar la correcta interpretación durante el análisis. Se eliminaron las celdas vacías para mantener la integridad de los datos y evitar posibles errores en el análisis. También se identificaron y eliminaron registros duplicados para asegurar que cada jugador estuviera representado una sola vez en el dataset. Se revisaron y corrigieron errores de entrada, como valores inconsistentes o mal formateados. Además, los valores del atributo pie preferido, que originalmente se presentaban como "izquierdo" o "derecho", se transformaron en valores numéricos (1 para izquierdo y 0 para derecho). Esta codificación permitió que el atributo pudiera ser utilizado de manera efectiva como una variable en el modelo de regresión.
 

Una vez completadas estas transformaciones, el dataset quedó preparado para el análisis estadístico en R, donde se aplicaron técnicas avanzadas de regresión para examinar la influencia de los diferentes atributos en el valor de mercado de los jugadores.
Se trabajó inicialmente con las variables: edad (X1), valoración general (X2), potencial (X3), altura en cm (X4), peso en kg (X5), tiempo restante del contrato (X6), pie preferido (X7), velocidad (X8), tiro (X9), pase (X10), regate (X11), defensa (X12), y físico (X13). La variable dependiente fue el valor de mercado (Y) en euros.
Se realizaron varios modelos de regresión múltiple con el objetivo de optimizar la selección de variables y ajustar el modelo que mejor explicara la relación entre los atributos de los jugadores y su valor de mercado. En cada iteración, se eliminaron variables que no resultaron significativas, buscando simplificar y optimizar los modelos.
En el primer modelo, se incluyeron todas las variables mencionadas anteriormente. Sin embargo, tras el análisis de los resultados, algunas variables no mostraron una relación significativa con el valor de mercado, por lo que fueron eliminadas en modelos posteriores. Por ejemplo, el potencial y la altura no mostraron un impacto relevante en el valor de mercado en los primeros análisis, lo que llevó a descartarlas para los siguientes modelos.

Posteriormente, se experimentó con transformaciones logarítmicas en las variables independientes y dependientes. Uno de los modelos más prometedores fue el modelo log-lin, en el que el valor de mercado fue transformado logarítmicamente mientras las variables independientes (como la edad, valoración general, años restantes de contrato, y velocidad) permanecieron sin transformación. Este modelo mostró un ajuste superior en comparación con las otras alternativas.

 
Evaluación del Modelo 

El modelo de regresión múltiple log-lin se ajustó para predecir el valor de mercado de los jugadores utilizando una combinación de variables numéricas, como la edad (X1), la valoración general (X2), el potencial (X3), los años restantes de contrato (X6), el pie preferido (X7), la velocidad (X8) y el tiro (X9). A continuación, se describe su desempeño y se analizan los resultados obtenidos.

Residuos
Los residuos representan la diferencia entre los valores observados y los predichos por el modelo. La distribución de los residuos es la siguiente:
Mínimo: -1.05799
Primer cuartil (1Q): -0.12123
Mediana: -0.00884
Tercer cuartil (3Q): 0.11386
Máximo: 0.91261

Dado que la mediana de los residuos es cercana a cero, se puede concluir que el modelo no presenta un sesgo sistemático. Los valores de los residuos son moderados, lo que indica que las diferencias entre los valores predichos y los observados no son excesivamente grandes. Esto sugiere que el modelo tiene un buen ajuste en general, aunque se deben revisar los valores extremos.


Medidas de ajuste


Error estándar residual: 0.2072. Este valor representa la desviación estándar de los residuos, indicando que el promedio de las predicciones del modelo difiere en aproximadamente 0.2072 unidades de log del valor de mercado de los valores observados.
R-cuadrado múltiple: 0.9703. Este valor sugiere que el 97.03% de la variabilidad en el valor de mercado puede explicarse por el modelo, lo que indica un excelente ajuste.
R-cuadrado ajustado: 0.9703. El ajuste permanece igual al R-cuadrado simple, lo que confirma que el número de variables utilizadas está optimizado y no sobreajusta el modelo.
Estadístico F: 75,590 (p < 2.2e-16). El valor del F-test es extremadamente alto y significativo, indicando que el modelo en su conjunto tiene una capacidad predictiva fuerte.

Supuestos

Es importante mencionar que, dado que se trata de un modelo paramétrico, este debe cumplir con varios supuestos clave, como: Linealidad, Homocedasticidad, Normalidad, Multicolinealidad, 
Ausencia de valores extremos.

Supuesto de Linealidad:

Para evaluar la linealidad, se generó un gráfico de residuos versus valores ajustados (Residuals vs Fitted). En este gráfico, los puntos no siguen ningún patrón específico ni presentan una tendencia clara. La distribución es aproximadamente horizontal, lo que indica que no existe una relación no lineal entre las variables independientes y el valor de mercado. La ausencia de patrones sugiere que el modelo cumple con este supuesto, validando que la relación entre las variables explicativas y la variable dependiente es lineal.

Supuesto de homocedasticidad

El supuesto de homocedasticidad se refiere a que la varianza de los errores debe ser constante a lo largo de todas las predicciones del modelo. Para verificarlo, también se utiliza el gráfico de residuos vs valores ajustados. Si los residuos se dispersan de manera uniforme sin formar un patrón cónico o disperso, se puede afirmar que el modelo cumple con este supuesto. En este caso, la disposición de los residuos parece ser homogénea.

Normalidad de los Residuos:

La normalidad de los residuos es evaluada mediante un Q-Q plot, que compara los cuantiles teóricos con los cuantiles observados. Como se observa en el gráfico anterior, los puntos se alinean en gran parte a lo largo de la línea diagonal, lo que indica que los residuos siguen una distribución normal, con excepciones menores en los extremos.

Supuesto de multicolinealidad
El supuesto de multicolinealidad implica que no debe haber correlaciones lineales fuertes entre las variables independientes. Se revisaron los coeficientes de las variables y se aplicaron diagnósticos como el VIF (Variance Inflation Factor) 
El supuesto de no multicolinealidad significativa se cumple en su mayoría, ya que los valores de VIF para la mayoría de las variables son moderados o bajos. Los valores más altos (para X1, X2, y X3) no superan el umbral crítico de 10, lo que sugiere que la multicolinealidad no es severa. Por lo tanto, el modelo parece estar libre de multicolinealidad significativa.

Supuesto de ausencia de valores extremos

Se calcularon los residuos estudentizados del modelo de regresión y se graficaron para identificar posibles outliers. En el gráfico, se observaron varios puntos que parecían ser outliers, con valores absolutos de residuos estudentizados superiores a 3.
 Después de contabilizar estos puntos, se identificaron 163 observaciones como outliers.
 Sin embargo, dado que el dataset cuenta con más de 16,000 observaciones, se evaluó si estos outliers eran significativos.
 Al ajustar el modelo excluyendo estos outliers, se encontró que los resultados del modelo no cambiaron significativamente. Por lo tanto, se confirma que los outliers no afectan el ajuste del modelo y se cumple el supuesto de homocedasticidad.


Conclusiones

Con base en los coeficientes del modelo de regresión logarítmica, podemos extraer conclusiones sobre cómo cada atributo afecta el valor de mercado de los jugadores en EA Sports FC 24. Vamos a desglosar cada variable y su efecto, explicando por qué los cambios se expresan en porcentaje y cómo se relacionan con el valor del jugador:
El coeficiente para la edad del jugador es -0.105, lo que implica que cada año adicional en la edad del jugador se asocia con una disminución del 10.5% en su valor de mercado. Esto refleja la tendencia común en el fútbol, donde el valor de mercado de un jugador suele disminuir con la edad debido a la percepción de una posible disminución en el rendimiento o en la duración de la carrera.
En contraste, la valoración general del jugador tiene un coeficiente de 0.186, sugiriendo que un aumento de un punto en la valoración general se traduce en un incremento del 18.6% en el valor de mercado. Este coeficiente destaca la importancia significativa de la valoración general en la determinación del valor de un jugador, ya que una mejor valoración indica un rendimiento superior y, por lo tanto, un mayor valor en el mercado.
El coeficiente para el potencial es 0.007, lo que significa que cada incremento de un punto en el potencial del jugador está asociado con un aumento del 0.7% en su valor de mercado. Aunque este efecto es menor comparado con la valoración general, sigue siendo relevante, sugiriendo que los jugadores con un mayor potencial futuro son valorados más alto debido a su posible desarrollo y rendimiento futuro.
En cuanto a los años restantes del contrato, el coeficiente es 0.009. Esto indica que cada año adicional en el contrato del jugador está relacionado con un aumento del 0.9% en su valor de mercado. Esto refleja que los jugadores con contratos más largos tienden a tener un valor de mercado mayor debido a la menor percepción de riesgo para el comprador.
El pie preferido del jugador tiene un coeficiente de -0.017, lo que sugiere que un jugador que prefiere el pie izquierdo tiene un valor de mercado un 1.7% menor en comparación con uno que prefiere el pie derecho. Este efecto, aunque pequeño, puede estar relacionado con la menor demanda o la menor versatilidad percibida de los jugadores con pie dominante izquierdo, aunque este efecto puede variar según el contexto del mercado.
La velocidad del jugador tiene un coeficiente de 0.0017, indicando que cada incremento en la velocidad está asociado con un aumento del 0.17% en el valor de mercado. La velocidad es un atributo altamente valorado en el fútbol, lo que explica su impacto positivo en el valor del jugador.
Finalmente, el coeficiente para la habilidad de tiro es 0.0025, lo que significa que un incremento en esta habilidad se traduce en un aumento del 0.25% en el valor de mercado. La capacidad para marcar goles es crucial en el fútbol, y su influencia positiva en el valor de mercado subraya su importancia.
Por Qué el Cambio se Expresa en Porcentaje
Esto se debe a que el modelo utiliza la transformación logarítmica en la variable dependiente (valor de mercado), esto para estabilizar la varianza y hacer que la relación entre las variables independientes y el valor de mercado sea lineal. Esto implica que los coeficientes de la regresión se interpretan en términos de cambios porcentuales en el valor de mercado en lugar de unidades absolutas. Por ejemplo, un coeficiente de 0.186 para la valoración general significa que un aumento de una unidad en la valoración general se traduce en un incremento del 18.6% en el valor de mercado, debido a la transformación logarítmica aplicada al valor de mercado.
