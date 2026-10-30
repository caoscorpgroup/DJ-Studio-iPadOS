# Auditoría inicial de proyectos de código abierto

## Objetivo

Reutilizar algoritmos, documentación y diseños técnicos cuando sea legal y técnicamente razonable. No copiar un proyecto completo sin evaluar arquitectura, licencia, dependencias y portabilidad a iPadOS.

## Candidatos

### Mixxx
Repositorio: https://github.com/mixxxdj/mixxx

Uso previsto en la investigación:
- Referencia de arquitectura DJ.
- Modelo de decks, mixer, efectos y controladoras.
- Referencia para mappings MIDI y comportamiento de la Hercules DJControl AIR.

Licencia identificada en la investigación inicial: GPL-2.0-or-later. Debe revisarse el texto actual del repositorio y la licencia de cada componente antes de reutilizar código. Incorporar o adaptar código GPL puede imponer obligaciones de distribución de la obra derivada. Por ahora, tratar Mixxx como referencia técnica y no copiar código.

Manual de Hercules DJControl AIR:
https://github.com/mixxxdj/manual/blob/master/source/hardware/controllers/hercules_djcontrol_air.rst

El manual es una pista para la investigación del mapping; no sustituye pruebas con el hardware real.

### Essentia
Repositorio: https://github.com/MTG/essentia

Candidato para análisis musical: características espectrales, ritmo y estimaciones de tempo/tonalidad. La licencia y las condiciones de uso/distribución para el caso concreto deben verificarse en los archivos actuales del repositorio antes de integrarlo. La portabilidad, tamaño, dependencias y rendimiento en iPadOS también requieren una prueba.

### KeyFinder
Repositorio: https://github.com/ibsh/is_KeyFinder

Candidato para estudiar detección de tonalidad. Pendiente: revisar licencia, estado de mantenimiento, dependencias, API, precisión y facilidad de compilar para iOS.

### Mappings de Hercules encontrados
- https://github.com/leonardogrimaldi/Hercules-DJControl-AIR-Mixxx-Mapping
- https://github.com/DJPhatso/Hercules-DJControl-AIR-Mixxx-Mapping
- https://github.com/erwanosouf/hercules-djcontrol-airs-controller-mapping

Los enlaces aparecieron en búsquedas previas, pero no se ha confirmado que todos los repositorios estén accesibles ni que correspondan exactamente al modelo AIR original. Revisar cada uno antes de depender de ellos.

## Criterios de auditoría

Para cada candidato registrar:
1. URL y commit/tag examinado.
2. Licencia del repositorio y licencias de dependencias.
3. Estado de mantenimiento y actividad.
4. Lenguaje, sistema de build y dependencias.
5. Compatibilidad iOS/iPadOS y arquitectura CPU.
6. Tamaño, consumo de memoria y rendimiento.
7. Calidad de pruebas y documentación.
8. Posibilidad de aislar el algoritmo sin importar toda la aplicación.
9. Obligaciones de atribución, distribución de fuentes y avisos.
10. Decisión: usar, adaptar, estudiar como referencia o descartar.

## Regla

No se integrará ninguna dependencia hasta completar una revisión de licencia y una prueba mínima de compilación/ejecución para iPadOS.
