# Hoja de ruta

Las etapas son secuenciales y sus fechas se definirán después de comprobar herramientas, licencias y disponibilidad de hardware.

## Fase 0 — Definición y auditoría
- [x] Crear repositorio privado.
- [x] Registrar visión y requisitos iniciales.
- [x] Aprobar Swift 6 como lenguaje principal.
- [ ] Confirmar versión de iPadOS y adaptador/hub de la controladora.
- [ ] Auditar licencias y portabilidad de proyectos candidatos.
- [ ] Separar funciones imprescindibles de funciones posteriores.
- [ ] Validar un flujo de desarrollo viable desde iPad, incluida compilación remota, firma e instalación.

## Fase 1 — Prueba técnica de audio
- [ ] Crear proyecto mínimo nativo iPadOS en Swift.
- [ ] Configurar un flujo de compilación reproducible con runner macOS remoto, si resulta viable sin coste.
- [ ] Abrir archivo local y reproducirlo.
- [ ] Medir latencia y estabilidad.
- [ ] Probar salida master y salida cue multicanal.
- [ ] Verificar interrupciones y cambios de ruta.
- [ ] Instalar y probar la compilación en el iPad A16.

Puerta de salida: reproducción estable, instalación reproducible y ruteo documentado antes de construir la interfaz completa.

## Fase 1A — Base de biblioteca local (integración inicial; validación pendiente)
- [x] Añadir modelos de pista, metadatos ID3 y análisis.
- [x] Implementar lector ID3v2.2/v2.3/v2.4 e ID3v1 para MP3.
- [x] Añadir enumeración recursiva de carpetas y formatos locales.
- [x] Añadir catálogo local JSON con persistencia atómica.
- [x] Conectar escaneo, lector de metadatos y almacenamiento.
- [ ] Compilar y ejecutar pruebas unitarias cuando exista un entorno autorizado sin coste adicional.
- [x] Añadir persistencia y resolución de bookmarks de carpetas en Application Support.
- [x] Añadir lector AVFoundation de metadatos comunes y fallback ID3 para MP3.
- [x] Añadir prueba de parser contra un archivo binario temporal con etiquetas ID3.
- [ ] Integrar la vista en un target de aplicación iPadOS/Xcode.
- [ ] Compilar y ejecutar pruebas unitarias cuando exista un entorno autorizado sin coste adicional.
- [ ] Validar bookmarks después de cerrar/reabrir la app en iPadOS.
- [ ] Probar con archivos MP3/M4A reales proporcionados y bibliotecas de distintos tamaños.

## Fase 2 — Dos decks y mixer
- [ ] Dos decks con transporte.
- [ ] Ganancia, EQ, filtro y crossfader.
- [ ] BPM manual y sincronización inicial.
- [ ] Cue temporal y Hot Cues.
- [ ] Biblioteca local básica.

## Fase 3 — Hercules DJControl AIR
- [ ] Identificar enumeración USB/MIDI en iPadOS.
- [ ] Capturar mensajes MIDI de todos los controles.
- [ ] Validar jog wheels y scratch.
- [ ] Validar botones, faders, knobs y LEDs/feedback.
- [ ] Investigar sensor AIR.
- [ ] Validar master/cue y canales físicos con el adaptador real.
- [ ] Crear mapping inicial y pruebas de regresión.

## Fase 4 — Análisis y waveforms
- [ ] BPM automático.
- [ ] Tonalidad automática.
- [ ] Beatgrid editable.
- [ ] Waveform overview y detalle.
- [ ] Caché y análisis en segundo plano.
- [ ] Estimar y visualizar actividad/energía rítmica por secciones.
- [ ] Analizar energía por bandas (graves, medios y agudos).
- [ ] Investigar detección de kick/bajo y entradas/salidas con nivel de confianza.
- [ ] Detectar secciones musicales (intro, break, build-up, drop, outro) como sugerencias editables.
- [ ] Investigar cambios de tonalidad y tempo dentro de una pista.
- [ ] Diseñar comparador de compatibilidad entre dos pistas: armonía, BPM, energía y estructura.
- [ ] Escanear carpetas locales y generar biblioteca con análisis y caché.
- [ ] Crear agrupación/orden por tonalidad, modo y Camelot.
- [ ] Crear recomendador de pistas compatibles para una canción seleccionada.
- [ ] Diseñar constructor asistido de sets por duración objetivo.
- [ ] Proponer secuencias con continuidad armónica, BPM, energía y estructura.
- [ ] Permitir bloquear/reemplazar pistas, comparar propuestas y ajustar transiciones.
- [ ] Visualizar timeline, curva de energía y duración estimada del set.
- [ ] Explicar los motivos de cada recomendación y permitir guardar listas de preparación.

## Fase 5 — FX y performance
- [ ] FX básicos y parámetros.
- [ ] Presets y perfiles.
- [ ] Loops, Beat Jump, Roll, Slip y Quantize.
- [ ] Grabación de mezcla.
- [ ] Pruebas de carga y estabilidad.

## Fase futura — Evaluación de cuatro decks (fuera del alcance inicial)
- [ ] Reevaluar si cuatro decks aportan valor sin saturar la pantalla del iPad.
- [ ] Prototipar una distribución con un solo mixer central de cuatro canales.
- [ ] Evaluar capas A/C y B/D para hardware de dos decks.
- [ ] Medir CPU, memoria, latencia y temperatura antes de decidir su viabilidad.
- [ ] Requerirá una decisión de producto explícita antes de entrar en implementación.

## Fase 7 — Extensibilidad y publicación
- [ ] Mapping editor.
- [ ] Evaluación AUv3.
- [ ] Auditoría de seguridad, licencias y privacidad.
- [ ] TestFlight/App Store o distribución alternativa, según viabilidad.
- [ ] Documentación de usuario y soporte.

## Fase de diseño visual y navegación — antes de la implementación completa
- [ ] Usar edjing Mix como referencia de facilidad de uso, sin copiar su identidad ni recursos.
- [ ] Diseñar el layout principal de dos decks.
- [ ] Mantener el diseño inicial enfocado exclusivamente en dos decks y dos waveforms amplios.
- [ ] Definir navegación y jerarquía para DJ principal, FX Studio, Biblioteca, Performance y Hardware/Mapping.
- [ ] Diseñar el flujo de importación y escaneo de música.
- [ ] Diseñar visualización de waveform y análisis de secciones de mayor/menor actividad rítmica.
- [ ] Validar el diseño de dos decks en las dimensiones reales del iPad A16 antes de fijar tamaños.

## Regla de avance

No se marcará una tarea como completada hasta que exista evidencia verificable: código, prueba, medición, captura o documentación técnica reproducible.
