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
- BPM y tonalidad estimados automáticamente.
- Beatgrid sugerido y ajustable.
- Waveform y datos de análisis en caché.
- Persistencia local de cues, loops, BPM, tonalidad, beatgrid, playlists e historial.
- El análisis se ejecutará en segundo plano y no bloqueará la reproducción.

La exactitud del análisis automático deberá medirse con una colección de pistas de prueba; las estimaciones no se presentarán como infalibles.

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
