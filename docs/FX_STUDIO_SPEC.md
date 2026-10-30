# Especificación de FX Studio

## Objetivo

Crear un entorno de efectos modular y configurable que permita ir más allá de activar un efecto predefinido. El usuario debe poder comprender el recorrido de la señal, modificar parámetros, combinar módulos y guardar cadenas propias.

## Principios de diseño

- FX Studio es un espacio de trabajo dedicado; no debe sobrecargar la cabina principal.
- Los controles esenciales para actuación rápida pueden exponerse también desde la cabina.
- El procesamiento de audio permanece desacoplado de SwiftUI.
- Los parámetros se aplican mediante cambios seguros para tiempo real y suavizado cuando sea necesario.
- No se promete un número fijo de efectos simultáneos hasta medir el rendimiento en el iPad A16.

## Modelo funcional propuesto

### Destinos de procesamiento

Evaluar y validar progresivamente:
1. Insert por deck/canal: procesa la señal de un deck o canal.
2. Send/return: permite enviar una cantidad ajustable de señal a un bus de efectos y mezclar el retorno.
3. Master: procesa la mezcla principal.

La disponibilidad final de cada destino dependerá del diseño del mixer, el ruteo de audio y el presupuesto de CPU.

### Cadenas modulares

- Una cadena contiene módulos ordenados.
- El usuario podrá añadir, quitar, reordenar y activar/desactivar módulos.
- Cada módulo expone parámetros individuales adecuados al efecto.
- Se podrá guardar, duplicar, renombrar y recuperar una cadena como preset.
- La interfaz indicará el destino de señal y el orden de procesamiento.
- Se definirán límites seguros de nivel y comportamiento ante clipping.

### Parámetros y control

- Controles manuales con rangos y unidades comprensibles.
- Sincronización al BPM y divisiones rítmicas cuando tengan sentido para el efecto.
- Controles de mezcla dry/wet y ganancia donde corresponda.
- Macros asignables para modificar varios parámetros relacionados.
- Suavizado de parámetros para reducir clicks y cambios abruptos.
- Automatización o modulación avanzada se considerará una ampliación posterior, después de validar el modelo básico de parámetros.

## Familias de efectos candidatas

- Tiempo: Delay, Echo, Reverb.
- Modulación: Flanger, Phaser, Chorus.
- Dinámica: Gate, Trans.
- Textura: Noise, Bitcrusher, filtros y Tape Stop.
- Repetición: Looper.

La lista es una selección objetivo, no una promesa de disponibilidad simultánea en la primera versión.

## Presets iniciales

Preparar familias de presets orientadas a:
- Techno
- Minimal
- House
- Experimental

Los presets serán puntos de partida editables, no configuraciones cerradas.

## Arquitectura técnica por validar

- Effects Engine independiente de SwiftUI.
- Grafo o cadena de procesamiento con orden explícito.
- Parámetros publicados mediante mensajes/comandos seguros para el hilo de audio.
- Sin asignaciones impredecibles, operaciones de disco ni locks bloqueantes en el callback de audio.
- Medición de CPU, memoria, latencia, estabilidad y artefactos audibles.
- Comparar el coste de insert, send/return y master antes de habilitar todas las rutas.

## Fases de implementación

1. Definir interfaz y modelo de parámetros.
2. Implementar un efecto de prueba con bypass y dry/wet.
3. Probar una cadena corta y cambio de presets sin interrupciones.
4. Añadir sincronización rítmica donde aplique.
5. Incorporar macros.
6. Evaluar ruteo por canal, send/return y master.
7. Ampliar catálogo después de pruebas de rendimiento.

## Criterios de aceptación

- Activar/bypassear un módulo sin clicks ni interrupciones recurrentes.
- Cambiar parámetros de forma continua y estable.
- Reordenar una cadena y recuperar un preset.
- Mantener reproducción estable mientras FX Studio está abierto y se manipulan controles.
- Documentar CPU, memoria y observaciones auditivas en el iPad A16.
