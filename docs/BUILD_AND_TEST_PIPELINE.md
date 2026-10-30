# Flujo de compilación y pruebas desde iPad

## Objetivo

Encontrar un flujo que permita editar el proyecto desde el iPad y compilar una aplicación iPadOS de forma reproducible, sin requerir un Mac local y sin incurrir en gastos no autorizados.

## Opciones que se deben evaluar

### 1. Swift Playgrounds en iPad

La documentación oficial de Apple confirma que Swift Playgrounds permite crear y ejecutar App Playgrounds con SwiftUI en el iPad, agregar archivos Swift y paquetes Swift, y abrir/transferir proyectos a Xcode. Es una ruta real para prototipar una app nativa desde el iPad, pero no demuestra por sí sola que todo el paquete y los subsistemas de DJ Studio funcionen en ese entorno.

Evaluar con un proyecto mínimo:
- Abrir o importar el código existente de `DJStudioCore` como paquete Swift.
- Compilar y ejecutar la vista de biblioteca existente.
- Confirmar disponibilidad y comportamiento de AVFAudio/AVAudioEngine, Core MIDI y bookmarks de carpetas.
- Verificar acceso a archivos, pruebas unitarias, estructura de carpetas y exportación Git.
- Probar el uso real de la Hercules DJControl AIR original conectada al iPad.

Referencias oficiales: [Manual de Swift Playgrounds para iPadOS](https://support.apple.com/es-mx/guide/playgrounds-ipad/welcome/ipados), [explorar App Playgrounds](https://support.apple.com/es-mx/guide/playgrounds-ipad/itcdd1ad55f1/ipados) y [Swift Playgrounds para desarrolladores](https://developer.apple.com/swift-playground/).

No asumir que Swift Playgrounds sustituye todas las capacidades de Xcode ni declarar compatibilidad con audio/MIDI hasta probarla.

### 2. GitHub Actions con runner macOS
Evaluar:
- Disponibilidad de runner macOS para la cuenta y repositorio.
- Minutos incluidos, límites y política vigente de facturación.
- Versión de Xcode/SDK disponible.
- Build de simulador y build para dispositivo.
- Ejecución de pruebas unitarias.
- Almacenamiento temporal de artefactos.

No iniciar workflows que puedan generar cargos sin verificar primero los límites aplicables. Si aparece un requisito de pago, detenerse.

### 3. Firma e instalación en dispositivo
Investigar por separado:
- Qué tipo de cuenta Apple se requiere para instalar una build en el iPad.
- Qué perfiles y certificados se necesitan.
- Qué puede hacerse con firma gratuita y cuáles son sus limitaciones.
- Cómo instalar el artefacto de forma segura.
- Cómo evitar que secretos de firma aparezcan en logs o artefactos.

No almacenar certificados, contraseñas, tokens ni perfiles privados en el repositorio. No solicitar ni registrar credenciales del usuario en documentos.

## Pipeline objetivo

1. El código se edita en una rama de trabajo.
2. Un commit dispara validaciones automáticas de formato/estructura y build cuando el workflow esté configurado.
3. Las pruebas unitarias se ejecutan en el runner.
4. El artefacto se conserva solo si el flujo y la política de almacenamiento son aceptables.
5. Se instala manualmente en el iPad siguiendo el método aprobado.
6. Se realizan pruebas físicas de audio/MIDI.
7. Los resultados se registran en documentación o issues.
8. La integración a main requiere revisión.

## Seguridad

- Permisos mínimos para tokens y workflows.
- No imprimir secretos en logs.
- No ejecutar scripts de terceros sin revisar su contenido.
- Fijar versiones de acciones cuando sea razonable y revisar su mantenimiento.
- Evitar permisos de escritura del workflow si solo necesita compilar.
- No publicar artefactos que contengan datos personales o música del usuario.
- Mantener el repositorio privado.

## Matriz de validación

| Área | Pregunta | Evidencia requerida |
|---|---|---|
| Edición | ¿Se puede editar y sincronizar desde iPad? | Procedimiento repetible |
| Compilación | ¿El runner dispone de Xcode/SDK compatible? | Log de build exitoso |
| Coste | ¿La ejecución cabe en límites gratuitos? | Revisión de cuota/política |
| Firma | ¿Se puede firmar para dispositivo? | Procedimiento y resultado |
| Instalación | ¿La app se instala en el iPad A16? | Prueba física |
| Diagnóstico | ¿Se pueden recuperar logs? | Ejemplo sin secretos |
| Repetibilidad | ¿Un segundo build produce el mismo resultado funcional? | Registro de commit y build |

## Estado inicial

Todo el flujo está pendiente de validación. La existencia de GitHub Actions o de un runner macOS no demuestra por sí sola que firma, instalación y depuración desde el iPad sean posibles.
