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

- Vista predeterminada: dos decks grandes.
- Modo alternativo: cuatro decks.
- Información visible: BPM, tonalidad, posición, duración, pitch, estado de reproducción y waveform.
- Ocho Hot Cues por pista.
- Cue temporal y cue permanente.
- Beatgrid editable y guardable.
- Waveform con carga progresiva y caché.
- Los decks C y D deben poder operarse táctilmente o mediante capas/modificadores de controladora. No se asumirá que una controladora de dos canales ofrece cuatro decks físicos independientes.

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
- Cuatro decks con control físico simultáneo en una controladora de dos decks.
- Copiar código de terceros sin auditoría de licencia y arquitectura.

## 11. Criterios de aceptación iniciales

1. Reproducción estable de dos pistas locales.
2. Mezcla independiente de ambos decks.
3. Master y preescucha en salidas separadas, si el hardware de audio lo permite.
4. Persistencia y recuperación de la biblioteca y metadatos.
5. UI que no interrumpa el audio al cambiar de panel.
6. Pruebas documentadas con el modelo exacto de controladora.
