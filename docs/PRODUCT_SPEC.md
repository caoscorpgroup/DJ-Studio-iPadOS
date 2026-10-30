# Especificación del producto

## 1. Visión

DJ Studio será una aplicación DJ nativa para iPad centrada en mezcla de archivos locales, control táctil y operación mediante controladoras compatibles. La experiencia principal tendrá la claridad de una cabina profesional, con controles esenciales visibles y herramientas avanzadas disponibles en paneles secundarios.

No se pretende reproducir exactamente la interfaz ni el producto de otra marca. Las aplicaciones existentes se estudiarán como referencia funcional y técnica.

## 2. Plataforma y alcance inicial

- Dispositivo objetivo de pruebas iniciales: iPad con chip A16.
- Sistema: iPadOS; versión mínima por definir tras comprobar APIs y dispositivos objetivo.
- Fuente musical inicial: archivos locales accesibles desde el iPad.
- Operación principal sin conexión después de importar la música.
- Sin cuenta obligatoria, suscripción, publicidad invasiva ni servicios externos indispensables.

## 3. Diseño de decks

- Alcance inicial: exclusivamente dos decks (A y B), para reproducir y mezclar dos pistas simultáneamente.
- No habrá modo de cuatro decks en la primera versión; se pospone para una posible ampliación futura.
- Información visible: BPM, tonalidad, posición, duración, pitch, estado de reproducción y waveform.
- Ocho Hot Cues por pista.
- Cue temporal y cue permanente.
- Beatgrid editable y guardable.
- Waveform con carga progresiva y caché.

## 4. Mezcla y reproducción

Funciones objetivo:
- Play/Pause, Cue, Sync y Master Tempo.
- Pitch fader y pitch bend.
- Reverse.
- EQ de tres bandas, filtro, gain y medidores.
- Crossfader y mezcla por canal.
- Preescucha (cue) independiente de la salida master.
- Loops manuales y automáticos.
- Quantize, Slip, Beat Jump y Roll.
- Scratch mediante jog wheels cuando el hardware y su protocolo lo permitan.

## 5. Efectos y rendimiento

Familias de efectos deseadas:
- Echo, Delay, Reverb, Flanger, Phaser, Noise, Gate, Roll, Trans, Beatmasher, Bitcrusher, Tape Stop y Looper.
- Parámetros automatizables y presets guardables.
- Perfiles iniciales de efectos para Techno, Minimal, House y Experimental.
- Panel FX Studio separado de la vista principal.
- Arquitectura que permita añadir efectos propios y evaluar AUv3 como extensión, sin depender de plugins externos para las funciones esenciales.

Los efectos se incorporarán gradualmente. Cada efecto deberá tener límites de CPU, pruebas de audio y comportamiento seguro al cambiar presets.

## 6. Biblioteca y análisis

- Importación y organización de archivos locales.
- BPM y tonalidad estimados automáticamente, incluyendo modo mayor/menor y notación Camelot cuando la confianza lo permita.
- Beatgrid sugerido y ajustable, con downbeats, compases y posibles cambios de tempo.
- Waveform y datos de análisis en caché.
- Análisis musical avanzado progresivo: actividad de bombo y bajo, distribución de energía por bandas de frecuencia, estructura de secciones y cambios de energía.
- Persistencia local de cues, loops, BPM, tonalidad, beatgrid, playlists e historial.
- El análisis se ejecutará en segundo plano y no bloqueará la reproducción.

La exactitud del análisis automático deberá medirse con una colección de pistas de prueba; las estimaciones no se presentarán como infalibles. Las detecciones de instrumentos, secciones y compatibilidad serán probabilísticas y deberán mostrar su nivel de confianza o permitir corrección manual.

## 7. Controladoras y mapping

- Prioridad de validación: Hercules DJControl AIR original.
- Core MIDI como vía inicial para estudiar mensajes de control.
- Mapping por perfiles, con capas y modificadores.
- Panel para asignar controles y guardar configuraciones.
- Evaluar sensor AIR infrarrojo/proximidad como fuente de control continuo, solo después de identificar su exposición real al sistema.
- Diseñar el sistema para incorporar otras controladoras sin acoplar la lógica de mezcla a un único modelo.

## 8. Grabación

La grabación de mezclas es una función deseada. Debe evaluarse el formato, la ruta de captura, el uso de almacenamiento, la gestión de interrupciones y las restricciones de iPadOS antes de comprometer una implementación.

## 9. Personalización

- Tema oscuro profesional predeterminado.
- Colores configurables para decks, cues y waveforms.
- Paneles y densidad de información ajustables.
- Presets de configuración y de FX.

## 10. No objetivos de la primera versión

- Streaming musical integrado.
- Servicios en la nube obligatorios.
- Red social o publicación automática de mezclas.
- Compatibilidad universal garantizada con cualquier controladora.
- Cuatro decks o mezcla de más de dos pistas simultáneas en la primera versión.
- Copiar código de terceros sin auditoría de licencia y arquitectura.

## 11. Criterios de aceptación iniciales

1. Reproducción estable de dos pistas locales.
2. Mezcla independiente de ambos decks.
3. Master y preescucha en salidas separadas, si el hardware de audio lo permite.
4. Persistencia y recuperación de la biblioteca y metadatos.
5. UI que no interrumpa el audio al cambiar de panel.
6. Pruebas documentadas con el modelo exacto de controladora.
## 12. Referencia visual y navegación — edjing Mix

edjing Mix queda establecido como referencia de facilidad de uso, organización de pantallas y flujo de mezcla. Se estudiará como inspiración funcional y visual, sin copiar código, identidad, recursos gráficos ni una interfaz propietaria.

Principios acordados:
- La pantalla principal debe ser clara y fácil de entender, con los controles esenciales a mano.
- La cabina inicial tendrá exclusivamente dos decks grandes, A y B, con espacio suficiente para waveforms y controles legibles.
- El modo de cuatro decks queda pospuesto; no se comprimirá la interfaz para intentar incluir más reproductores.
- Biblioteca musical, FX Studio, Performance y Hardware/Mapping tendrán espacios claramente identificados y navegación sencilla.
- Las herramientas avanzadas estarán en paneles secundarios o desplegables para no sobrecargar la pantalla de mezcla.
- La estética será oscura, profesional y propia de DJ Studio.

### Biblioteca y análisis de pistas
La biblioteca debe permitir importar y escanear archivos musicales locales. El análisis buscará identificar BPM, tonalidad y estructura rítmica, además de generar waveforms. Se desea mostrar visualmente las zonas de mayor y menor actividad rítmica/energética de una pista para facilitar la preparación y la mezcla. Esta representación será una estimación derivada del análisis de audio, no una afirmación de que cada sección tiene un nivel de beat objetivo universal. El usuario podrá revisar y corregir los resultados.

### Alcance de decks y espacio de trabajo
- La primera versión tendrá dos decks (A y B) y permitirá reproducir/mezclar dos pistas simultáneamente.
- El espacio de pantalla se dedicará a dos waveforms amplios, transporte y controles esenciales.
- No se incluirán decks C/D ni un mixer de cuatro canales en el alcance inicial.
- Una posible versión futura podrá reevaluar cuatro decks, capas de controladora y mixer ampliado, después de validar espacio, rendimiento y usabilidad.

### Áreas principales de navegación
1. DJ principal: decks, waveforms, mixer y transporte.
2. FX Studio: efectos, cadenas, parámetros y presets.
3. Biblioteca: exploración, importación, análisis y preparación musical.
4. Performance: Hot Cues, loops, Roll, Beat Jump y sampler.
5. Hardware/Mapping: selección de controladora, asignación de botones, knobs, faders y perfiles.

## 13. Alcance inicial: dos decks

Decisión de producto aprobada:
- La primera versión tendrá únicamente dos decks, A y B, para reproducir y mezclar dos pistas de audio simultáneamente.
- El mixer tendrá dos canales, uno asignado a cada deck, dentro de una única sección central de mezcla.
- La interfaz priorizará dos waveforms amplios, controles legibles y acceso directo a las funciones esenciales.
- No se implementará ni mostrará un modo de cuatro decks en la primera versión.
- La posibilidad de cuatro decks queda aplazada para una fase futura y no condicionará el diseño ni la arquitectura visual inicial.

## 14. FX Studio modular

Decisión de producto aprobada:
- FX Studio será un área dedicada y más profunda que un panel convencional de efectos.
- El usuario podrá ajustar parámetros individuales, combinar módulos en cadenas y guardar sus propias configuraciones.
- Se estudiarán distintas ubicaciones de procesamiento: por deck/canal, envío y master, siempre que la arquitectura y el rendimiento lo permitan.
- Los parámetros podrán sincronizarse al tempo cuando el efecto lo admita, además de ofrecer control manual.
- La interfaz deberá mostrar claramente el orden de la cadena, el destino de señal y los parámetros activos.
- Se contemplan macros para controlar varios parámetros relacionados con un solo gesto, sin eliminar el acceso al ajuste individual.
- Los cambios de parámetros y presets deberán suavizarse para evitar clicks, saltos bruscos de ganancia o interrupciones.
- El conjunto inicial de efectos y las cadenas disponibles se incorporarán gradualmente y se validarán con pruebas de CPU, memoria y audio en el iPad A16.

La modularidad y el nivel de personalización son objetivos de diseño; el número de módulos simultáneos y las posibilidades de ruteo quedarán sujetos a mediciones reales.


## 15. Análisis musical avanzado y compatibilidad de mezcla

Objetivo de evolución:
DJ Studio podrá analizar más que BPM, tonalidad y waveform. Se busca construir una representación musical útil para preparar mezclas y entender visualmente cómo evoluciona cada pista.

### Capas de análisis

1. **Armonía**
   - Estimar tonalidad y modo mayor/menor.
   - Mostrar notación musical y Camelot.
   - Investigar detección de modulaciones o cambios de tonalidad dentro de una pista.
   - Permitir corrección manual y conservar el dato corregido.

2. **Ritmo**
   - Detectar beats, downbeats y compases.
   - Construir beatgrid editable.
   - Detectar cambios de tempo, ritmos sincopados y pasajes donde la detección sea incierta.
   - No asumir que todas las pistas tienen tempo constante o estructura regular.

3. **Actividad por bandas y elementos**
   - Analizar energía de bajas, medias y altas frecuencias.
   - Estimar actividad de bombo/kick y bajo, incluyendo sus entradas, salidas y pausas.
   - Diferenciar energía espectral de una identificación real de instrumento: una banda de graves activa no demuestra por sí sola que exista un bajo o bombo aislado.
   - Mostrar capas visuales sincronizadas con el waveform, activables individualmente.

4. **Estructura y energía**
   - Estimar intro, outro, breakdown/break, build-up, drop y otras secciones relevantes.
   - Representar evolución de energía y densidad rítmica a lo largo de la pista.
   - Permitir editar límites de secciones y etiquetas.
   - Tratar las etiquetas como sugerencias, no como verdades universales del género.

5. **Compatibilidad entre pistas**
   - Comparar BPM y estabilidad de tempo.
   - Comparar tonalidad/modo y proximidad armónica mediante Camelot cuando aplique.
   - Comparar energía, densidad rítmica y estructura.
   - Sugerir posibles zonas de entrada/salida y ventanas de mezcla.
   - Explicar por qué dos pistas podrían funcionar juntas y señalar posibles conflictos.
   - No reducir la compatibilidad a una puntuación única ni garantizar que una mezcla sonará bien; el oído y la decisión del DJ siguen siendo determinantes.

### Presentación en la interfaz

- El waveform podrá mostrar capas opcionales para beats/downbeats, actividad de graves, energía por bandas, secciones y energía general.
- Cada capa tendrá una leyenda clara y podrá ocultarse para mantener una pantalla limpia.
- La vista principal de dos decks conservará legibilidad: el análisis detallado vivirá en Biblioteca/Preparación o en un panel expandible.
- Las zonas detectadas podrán utilizarse para preparar Hot Cues y loops sugeridos, siempre con confirmación del usuario.

### Estrategia técnica y validación

- Empezar con DSP local y análisis de características de audio que pueda ejecutarse sin conexión.
- Evaluar modelos de machine learning únicamente cuando una técnica DSP más simple no alcance la precisión necesaria.
- El análisis pesado se ejecutará fuera del hilo de audio, con caché local y progreso visible.
- No usar servicios remotos obligatorios ni APIs de pago para las funciones esenciales.
- Medir precisión por tipo de pista, género, calidad de grabación y estructura; incluir pruebas con música electrónica, pistas con intros largas, breaks, cambios de tempo y material poco convencional.
- Mostrar incertidumbre cuando el algoritmo no pueda distinguir con fiabilidad un elemento o una sección.
- Las recomendaciones de mezcla serán asistivas y editables, no automatismos que tomen el control de la mezcla.

Este bloque es una dirección futura del producto. No implica que todas las capas de análisis estén incluidas en la primera versión.


## 16. Preparación de biblioteca por carpetas y recomendaciones de mezcla

### Flujo deseado

1. El usuario selecciona una carpeta o conjunto de carpetas de música local.
2. DJ Studio importa/escanea los archivos y analiza sus metadatos musicales.
3. La biblioteca permite agrupar y filtrar pistas por tonalidad, modo y Camelot, además de BPM.
4. El usuario puede solicitar recomendaciones de pistas que combinen con una canción seleccionada.
5. El sistema presenta una lista ordenada de candidatas con razones comprensibles y datos comparativos.
6. El usuario puede guardar listas, colecciones o grupos de mezcla para preparar una sesión.

### Vistas de organización

- Agrupar automáticamente por tonalidad detectada y modo mayor/menor.
- Vista Camelot para facilitar selección armónica.
- Ordenar o filtrar por BPM, energía, duración, género/etiquetas si existen, y confianza del análisis.
- Permitir ordenar por tono sin obligar a que ese sea el único criterio.
- Mantener la posibilidad de corregir manualmente tonalidad, BPM y etiquetas.
- No mover ni modificar los archivos originales al organizar la biblioteca; usar colecciones y listas virtuales locales.

### Recomendador "¿Qué puedo mezclar con esta pista?"

Al seleccionar una canción, el sistema buscará en la biblioteca pistas candidatas y podrá clasificarlas por:
- Compatibilidad armónica (tonalidad/modo/Camelot).
- Diferencia de BPM y estabilidad del tempo.
- Compatibilidad de energía y densidad rítmica.
- Estructura musical y posibles ventanas de transición.
- Actividad de graves y posibles conflictos de kick/bajo durante la superposición.
- Calidad/confianza de los datos analizados.

Cada recomendación debe explicar por qué aparece: por ejemplo, "misma tonalidad", "vecina Camelot", "BPM cercano", "intro disponible para mezclar" o "energía ascendente compatible". Cuando haya señales contradictorias, también debe indicarlo.

### Formato de resultados

- Lista de mejores candidatas para la pista seleccionada.
- Filtros para priorizar armonía, BPM, energía o estructura.
- Comparación de dos pistas y vista previa de puntos de entrada/salida sugeridos.
- Guardar el resultado como playlist o colección de preparación.
- El usuario conserva la decisión final; las recomendaciones no mezclan ni modifican pistas automáticamente.

### Límites

- La compatibilidad es una sugerencia, no una garantía musical.
- La tonalidad detectada puede ser ambigua o cambiar durante la pista.
- Las secciones, instrumentos y transiciones se estiman y deben poder corregirse.
- El análisis y la recomendación funcionarán localmente como objetivo de diseño, sin requerir servicios de pago ni conexión permanente.


## 17. Constructor asistido de sets y planificación de sesiones largas

### Problema de usuario

Preparar un set de varias horas requiere escuchar, comparar y seleccionar manualmente muchas pistas. El objetivo es reducir el tiempo de curaduría sin quitar al DJ el control creativo ni convertir la selección en una secuencia automática y rígida.

### Objetivo

A partir de una biblioteca analizada, permitir que el usuario defina una duración objetivo (por ejemplo, tres horas) y reciba propuestas de secuencias de pistas que puedan formar un show coherente.

### Flujo de trabajo

1. El usuario elige una duración objetivo, por ejemplo 180 minutos.
2. Opcionalmente selecciona una pista inicial, energía inicial/final, estilo, rango de BPM, tonalidades preferidas o pistas obligatorias/excluidas.
3. DJ Studio propone una o varias secuencias candidatas a partir de la biblioteca local.
4. Cada secuencia muestra duración estimada, número de pistas, orden, BPM, tonalidad/Camelot, energía y transiciones previstas.
5. El usuario puede bloquear pistas/posiciones, reemplazar una canción, pedir alternativas para un punto específico o reorganizar manualmente.
6. La duración total se recalcula con los tiempos de mezcla estimados y el usuario puede ajustar cuánto se superponen las pistas.
7. El set se guarda como proyecto/lista de preparación, sin modificar los archivos originales.

### Motor de secuenciación

El recomendador debe evaluar la secuencia como conjunto, no solo sumar compatibilidades de pares. Considerar:
- Compatibilidad armónica entre pistas consecutivas, incluyendo cambios de tonalidad y posibles variaciones internas.
- Continuidad y evolución de BPM; detectar saltos que requieran ajuste de pitch o transición especial.
- Curva de energía y densidad rítmica a lo largo del set.
- Estructuras, intros/outros y ventanas de mezcla disponibles.
- Posibles conflictos de graves/kick/bajo y solapamiento de elementos densos.
- Repetición excesiva de tonalidades, artistas, pistas o patrones.
- Calidad y confianza de los análisis, duración real y disponibilidad de segmentos utilizables.

### Curva narrativa y control creativo

- Permitir definir una trayectoria de energía, por ejemplo: apertura, desarrollo, subida, pico, respiro y cierre.
- No imponer una curva fija: el usuario puede elegir una progresión lineal, escalonada, ondulante o personalizada.
- Ofrecer más de una propuesta de set con enfoques distintos.
- Explicar los motivos y compromisos de cada transición.
- Permitir marcar pistas favoritas, obligatorias, prohibidas y reservas.
- Ofrecer alternativas locales para cada posición sin reconstruir todo el set.
- Mantener edición manual total y no iniciar reproducción o mezcla automática como resultado de la planificación.

### Estimación de duración

La duración del set debe estimarse considerando duración de cada pista y solapamiento de las transiciones; no asumir que 50 canciones equivalen siempre a tres horas. Mostrar duración estimada y margen de incertidumbre, ya que el DJ puede alargar o acortar mezclas en vivo.

### Presentación

- Timeline de la sesión con pistas ordenadas y bloques de transición.
- Curva de energía estimada.
- Indicadores de armonía/BPM y alertas de saltos o posibles conflictos.
- Tiempo acumulado y duración estimada restante.
- Vista de alternativas y reservas.

### Principio de diseño

El sistema es un asistente de curaduría y planificación: propone, explica y permite experimentar. El DJ decide el orden final, las transiciones y la interpretación del show. No prometer que una secuencia algorítmica garantiza un buen set.


## 18. Enriquecimiento opcional de metadatos mediante fuentes externas

### Objetivo

Durante el escaneo de la biblioteca, DJ Studio podrá intentar identificar pistas y completar metadatos usando fuentes externas, cuando el usuario lo permita. Esta capa complementa —no sustituye— el análisis acústico local.

### Orden de trabajo

1. Leer primero etiquetas locales y metadatos embebidos (ID3, MP4 y formatos compatibles).
2. Analizar localmente BPM, tonalidad, beatgrid, energía, estructura y características espectrales.
3. Si faltan datos o hay ambigüedad, ofrecer identificación externa opcional.
4. Cuando sea técnicamente y legalmente viable, calcular una huella acústica local y consultar un proveedor de identificación compatible.
5. Recuperar metadatos descriptivos y vincularlos al archivo solo si la coincidencia supera un umbral de confianza; permitir confirmación/corrección manual.
6. Guardar en caché el resultado y la procedencia para evitar consultas repetidas.

### Privacidad y control

- No subir canciones completas ni fragmentos de audio como comportamiento predeterminado.
- Preferir huellas acústicas calculadas localmente; explicar que una huella también se envía al proveedor cuando se usa identificación remota.
- La consulta externa debe ser opcional, configurable y desactivable.
- No enviar rutas locales, nombres de carpetas ni datos personales innecesarios.
- La biblioteca y el análisis básico deben seguir funcionando sin internet.
- No enviar huellas para contribuir a bases de datos ni compartir archivos sin consentimiento separado y explícito.

### Fuentes candidatas y restricciones

- MusicBrainz: candidato para metadatos de grabaciones, lanzamientos, artistas y sellos. La documentación indica que el servicio web es gratuito para uso no comercial, exige identificación de la aplicación y limita cada cliente a una solicitud por segundo. Su licencia/plan aplicable debe verificarse antes de cualquier distribución comercial.
- AcoustID/Chromaprint: candidato para identificar grabaciones mediante huella acústica local y enlazar resultados con MusicBrainz. AcoustID indica que el servicio gratuito es para uso no comercial; las aplicaciones comerciales deben registrarse/consultar sus condiciones comerciales. Respetar el límite publicado de solicitudes.
- Otras fuentes solo podrán incorporarse después de revisar términos, atribución, privacidad, límites, estabilidad y costes.

### Arquitectura de integración

- Definir una interfaz de proveedor independiente para no acoplar la biblioteca a un servicio.
- Separar identificación (huella y coincidencia) de enriquecimiento (metadatos descriptivos).
- Mantener campos originales, campos detectados localmente y campos externos como valores con procedencia separada.
- Registrar fuente, fecha de consulta y confianza de coincidencia.
- Resolver resultados contradictorios sin sobrescribir silenciosamente las etiquetas del usuario.
- Aplicar límites de frecuencia, reintentos controlados y caché.
- No depender de un servidor propio ni contratar infraestructura pagada para la primera versión.

### Alcance inicial y aprobación

Primero implementar lectura local de etiquetas y análisis DSP. La integración remota queda como módulo opcional sujeto a evaluación legal/técnica de cada proveedor. No se autoriza por esta especificación ningún gasto, suscripción, servidor ni API de pago.


## 19. Aclaración de alcance: metadatos locales primero, enriquecimiento opcional

La biblioteca y todas las funciones de análisis/recomendación deben funcionar localmente y sin conexión. No se construirá ni requerirá un servidor externo para el funcionamiento normal de DJ Studio.

### Política de lectura y enriquecimiento

- Leer los tags existentes del archivo (ID3 para MP3 y metadatos equivalentes en otros formatos soportados).
- Conservar los metadatos originales y no sobrescribirlos automáticamente.
- Detectar campos ausentes, incompletos o potencialmente inconsistentes.
- Analizar el contenido de audio localmente para calcular características musicales: BPM/tempo, tonalidad, beatgrid/downbeats, energía por bandas, densidad rítmica, estructura estimada y ventanas potenciales de mezcla.
- Solo si el usuario lo habilita y faltan datos descriptivos, permitir una consulta externa puntual para intentar identificar la grabación y recuperar metadatos complementarios.
- La consulta externa no es requisito para analizar, organizar, recomendar o construir sets.
- No descargar música, no hacer streaming y no enviar archivos de audio completos.
- Cualquier metadato externo se almacena como dato enriquecido con su fuente y confianza, separado de los tags originales.
- El usuario puede aceptar, corregir o descartar el enriquecimiento.
- Si no hay internet, el proveedor falla o el usuario desactiva consultas, continuar normalmente con los datos locales y señalar los campos que no pudieron verificarse.

### Datos y decisiones de compatibilidad

El recomendador debe combinar:
1. Metadatos descriptivos: título, artista, álbum, año, género, sello y versión/remix cuando estén disponibles.
2. Análisis acústico: BPM, tonalidad, compás/beatgrid, energía, estructura y actividad de frecuencias.
3. Preferencias y decisiones del DJ: etiquetas propias, pistas favoritas/excluidas y correcciones manuales.

Los metadatos descriptivos ayudan a reconocer y organizar la música; la compatibilidad de mezcla se calcula principalmente a partir de las características musicales analizadas y las preferencias del DJ.
