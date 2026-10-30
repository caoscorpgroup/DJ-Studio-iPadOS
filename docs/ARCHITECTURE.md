# Arquitectura técnica propuesta

## Estado

Propuesta preliminar. No es una arquitectura implementada ni validada mediante mediciones en dispositivo.

## 1. Principio central

El motor de audio debe funcionar independientemente de SwiftUI. La interfaz puede actualizarse, reconstruirse o cambiar de panel sin detener ni bloquear el procesamiento de audio.

## 2. Capas

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

Tecnologías a evaluar: Core Audio y AVAudioEngine. La elección deberá basarse en latencia, flexibilidad de ruteo, sincronización y acceso a procesamiento de bajo nivel.

### Deck Engine
- Transporte por deck.
- Pitch y reproducción a velocidad variable.
- Beat phase y sincronización.
- Cue points, loops, reverse y estado de reproducción.
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

## 3. Reglas de tiempo real

El callback de audio no debe:
- Hacer operaciones de red o disco.
- Esperar locks que puedan bloquearse.
- Ejecutar análisis musical.
- Realizar asignaciones de memoria impredecibles.
- Actualizar vistas o llamar directamente a SwiftUI.

Los buffers de audio deben estar disponibles antes de necesitarlos. Lectura, decodificación, análisis y generación de waveforms deben ejecutarse fuera del hilo de audio. Se usarán colas/buffers adecuados y cambios de parámetros seguros para tiempo real.

## 4. Cuatro decks

El modo de cuatro decks incrementa el coste de decodificación, mezcla, EQ, FX y visualización. Debe medirse cada etapa. Se priorizará:
1. Dos decks estables.
2. Cuatro decks con FX básicos.
3. Cuatro decks con cadenas de FX ampliadas.

No se prometerá rendimiento hasta medir CPU, memoria, latencia, temperatura y comportamiento prolongado en el iPad objetivo.

## 5. Ruteo de audio

Se requiere separar master y cue/headphones. La disponibilidad de canales depende de la interfaz de audio conectada y de cómo iPadOS exponga sus endpoints. La asignación física de canales deberá verificarse con la DJControl AIR y el adaptador/hub concretos.

## 6. Lenguajes

- Swift: aplicación, biblioteca, lógica de producto y UI.
- SwiftUI: presentación.
- C++: DSP o algoritmos compartidos cuando la auditoría justifique su uso.
- Objective-C++: puente solo si se necesita interoperabilidad entre Swift y C++.
- Accelerate: optimizaciones vectoriales cuando sean pertinentes.

No se utilizará Python en el callback ni como motor de audio de producción.

## 7. Persistencia y seguridad

Los datos de usuario se almacenarán localmente. La aplicación deberá respetar permisos de acceso a archivos y evitar modificar los archivos originales. Los metadatos y análisis se podrán reconstruir si la caché se pierde.

## 8. Pruebas

- Unitarias para BPM, beatgrid, loops, cues y mappings.
- Pruebas de audio con señales conocidas.
- Medición de latencia y jitter.
- Pruebas de interrupciones, llamadas, cambios de salida y desconexión USB.
- Pruebas prolongadas de estabilidad y memoria.
- Pruebas de regresión para evitar clicks, dropouts y cambios bruscos de ganancia.
