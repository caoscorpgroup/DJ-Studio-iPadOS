# Arquitectura técnica propuesta

## Estado

Base tecnológica aprobada; arquitectura de audio todavía sujeta a prototipos y mediciones en el iPad objetivo. La elección de Swift no significa que todas las capacidades de audio o hardware estén validadas.

## 1. Lenguaje y tecnologías principales

- **Swift 6:** lenguaje principal para la aplicación, lógica de producto, biblioteca, análisis y coordinación de subsistemas.
- **SwiftUI:** interfaz y navegación.
- **AVFAudio / AVAudioEngine:** primera opción para el prototipo de reproducción, mezcla y procesamiento. Se comparará con Core Audio de menor nivel cuando las mediciones o necesidades de ruteo lo justifiquen.
- **Core MIDI:** descubrimiento de controladoras y recepción/envío de mensajes MIDI.
- **Accelerate / vDSP:** operaciones vectoriales, FFT, filtros y análisis de señales cuando aporten rendimiento.
- **C++ / Objective-C++:** opcionales y limitados a módulos DSP o bibliotecas concretas si un benchmark demuestra una ventaja suficiente y la licencia es compatible.

Swift es la base elegida; el motor de audio definitivo, la versión mínima de iPadOS y las dependencias de análisis siguen pendientes de validación.

## 2. Principio central

El motor de audio debe funcionar independientemente de SwiftUI. La interfaz puede actualizarse, reconstruirse o cambiar de panel sin detener ni bloquear el procesamiento de audio.

## 3. Capas

### Aplicación y presentación
- SwiftUI para vistas y paneles.
- Estado de interfaz separado del estado de audio en tiempo real.
- Comunicación con el motor mediante comandos/eventos ligeros.

### Audio Engine
Responsabilidades:
- Inicialización y configuración de dispositivos/salidas.
- Reloj de audio y transporte.
- Mezcla y ruteo master/cue.
- Gestión de buffers y formatos.
- Recuperación ante cambios de ruta o interrupciones del sistema.

El prototipo comenzará evaluando AVFAudio/AVAudioEngine. La decisión de usar Core Audio de menor nivel o una arquitectura híbrida dependerá de latencia, flexibilidad de ruteo, sincronización y acceso al procesamiento requerido.

### Deck Engine
- Transporte por deck.
- Pitch y reproducción a velocidad variable.
- Beat phase y sincronización.
- Cue points, loops y estado de reproducción.
- Waveform position y metadatos.

### Mixer Engine
- Ganancia por canal.
- EQ de tres bandas.
- Filtros.
- Crossfader y curvas.
- Medición de nivel y clipping.
- Envíos a efectos.

### Effects Engine
- Grafo de procesamiento modular.
- Parámetros suavizados para evitar clicks.
- Presets y cadenas.
- Límites de CPU y degradación controlada.
- Posible soporte AUv3 como extensión posterior.

### Analysis Engine
- BPM, tonalidad y estimación rítmica.
- Beatgrid sugerido.
- Waveform y datos espectrales.
- Procesamiento en segundo plano, con cancelación y reanudación.
- Estimación de actividad/energía rítmica por secciones, ajustable y presentada como análisis orientativo.

### MIDI Manager
- Descubrimiento de dispositivos Core MIDI.
- Lectura de mensajes y normalización.
- Perfiles/mappings declarativos.
- Capas, modificadores, feedback MIDI cuando sea compatible.
- Registro de mensajes para depuración.

### Library Manager
- Acceso a archivos autorizados por el usuario.
- Metadatos y análisis persistidos.
- Playlists, historial y búsqueda.
- Base de datos local y caché.

## 4. Reglas de tiempo real

El callback de audio no debe:
- Hacer operaciones de red o disco.
- Esperar locks que puedan bloquearse.
- Ejecutar análisis musical.
- Realizar asignaciones de memoria impredecibles.
- Actualizar vistas o llamar directamente a SwiftUI.

Los buffers de audio deben estar disponibles antes de necesitarlos. Lectura, decodificación, análisis y generación de waveforms deben ejecutarse fuera del hilo de audio. Se usarán colas/buffers adecuados y cambios de parámetros seguros para tiempo real.

## 5. Alcance de decks

La arquitectura de producto y la primera implementación se limitan a dos decks (A y B) y dos canales de mezcla. El motor, la interfaz, la gestión de recursos y las pruebas de rendimiento se diseñarán para este alcance aprobado, sin reservar espacio ni complejidad para decks adicionales.

No se prometerá rendimiento hasta medir CPU, memoria, latencia, temperatura y comportamiento prolongado de los dos decks en el iPad objetivo.

## 6. Ruteo de audio

Se requiere separar master y cue/headphones. La disponibilidad de canales depende de la interfaz de audio conectada y de cómo iPadOS exponga sus endpoints. La asignación física de canales deberá verificarse con la DJControl AIR y el adaptador/hub concretos.

## 7. Persistencia y seguridad

Los datos de usuario se almacenarán localmente. La aplicación deberá respetar permisos de acceso a archivos y evitar modificar los archivos originales. Los metadatos y análisis se podrán reconstruir si la caché se pierde.

### Biblioteca musical local
- La vista `MusicLibraryView` permite seleccionar carpetas mediante el selector de documentos de iPadOS.
- `MusicFolderBookmarkStore` persiste y resuelve bookmarks en Application Support; el escaneo inicia y detiene el acceso security-scoped alrededor de cada carpeta.
- `SystemAudioMetadataReader` usa AVFoundation para metadatos comunes en formatos reconocidos por el sistema y usa el lector ID3 dedicado como fallback para MP3.
- El núcleo enumera recursivamente formatos de audio admitidos y lee etiquetas ID3 sin reescribir archivos.
- El lector ID3 inicial contempla ID3v2.2, v2.3, v2.4 y fallback ID3v1 para MP3.
- La biblioteca persiste referencias, metadatos y análisis en un catálogo JSON local con escritura atómica; no copia los archivos de audio.
- La capa de aplicación deberá ubicar el catálogo en Application Support y excluirlo de iCloud/backup si el producto lo requiere.
- El análisis de audio y cualquier futura identificación externa son módulos separados; la biblioteca y sus funciones esenciales no dependen de red, streaming ni cuentas de terceros.

## 8. Flujo de desarrollo sin Mac local

El desarrollo se realizará desde el iPad en la medida que las herramientas lo permitan. Se evaluarán Swift Playgrounds y un runner macOS remoto de GitHub Actions para compilar y ejecutar pruebas automatizadas. Antes de considerar viable la distribución en un dispositivo físico habrá que verificar:
- generación del proyecto y compilación con el SDK de iOS/iPadOS requerido;
- firma, provisioning y método permitido de instalación;
- gestión segura de certificados y perfiles, sin exponer secretos en logs;
- posibilidad de depurar y recoger logs desde el iPad;
- límites de disponibilidad del runner y cualquier requisito de cuenta o coste.

No se considerará resuelto el flujo solo porque una compilación remota termine correctamente. La instalación y prueba física en el iPad son obligatorias. No se contratarán servicios ni se incurrirá en gastos sin autorización explícita.

## 9. Pruebas

- Unitarias para BPM, beatgrid, loops, cues y mappings.
- Pruebas de audio con señales conocidas.
- Medición de latencia y jitter.
- Pruebas de interrupciones, llamadas, cambios de salida y desconexión USB.
- Pruebas prolongadas de estabilidad y memoria.
- Pruebas de regresión para evitar clicks, dropouts y cambios bruscos de ganancia.
- Benchmark en el iPad A16 para los dos decks A/B del alcance aprobado.
