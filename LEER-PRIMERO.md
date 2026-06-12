# Cómo ejecutar PDFCraft localmente

Este proyecto **no es un simple `index.html`**. Es una aplicación web hecha con
**Next.js 15 + React 19 + TypeScript** (descargada de
<https://github.com/PDFCraftTool/pdfcraft>). El `index.html` no existe hasta que
el proyecto se *compila*: al compilar, Next.js genera una carpeta `out\` con el
`index.html` y todas las herramientas de PDF listas para abrirse en el navegador.

Todo el procesamiento de PDF ocurre **dentro de tu navegador** (con WebAssembly);
tus archivos nunca se suben a ningún servidor.

## Forma fácil (recomendada)

1. Asegúrate de tener **Node.js** instalado. Si no lo tienes, descárgalo (versión LTS)
   desde <https://nodejs.org/> e instálalo.
2. Haz **doble clic** en **`RUN-LOCAL.bat`** (en esta misma carpeta).
3. La primera vez hará 3 cosas automáticamente:
   - instalar dependencias (`npm install`),
   - compilar el sitio (`npm run build`) — genera 2000+ páginas, tarda varios minutos,
   - iniciar un servidor local y abrir tu navegador en <http://localhost:3000>.
4. **Deja la ventana negra abierta** mientras usas PDFCraft. Ciérrala cuando termines.

La próxima vez que lo abras será casi instantáneo (ya no recompila).

## Por qué no puedes abrir el index.html con doble clic

Aunque exista `out\index.html`, abrirlo como archivo (`file://`) **no funciona**:
el navegador bloquea WebAssembly y la carga de módulos por seguridad. Por eso el
lanzador levanta un pequeño servidor local (`http://localhost:3000`), que es como
debe servirse.

## Forma manual (si prefieres la terminal)

Abre una terminal en esta carpeta y ejecuta:

```bash
npm install        # solo la primera vez
npm run build      # genera la carpeta out\
npx serve out -l 3000
```

Luego abre <http://localhost:3000> en tu navegador.

Para el **modo desarrollo** (con recarga en caliente, sin compilar todo):

```bash
npm install
npm run dev
```

y abre <http://localhost:3000>.

## Notas

- Necesitas conexión a internet **solo durante `npm install` y el primer build**
  (para descargar dependencias y las fuentes de Google). Una vez generada la carpeta
  `out\`, PDFCraft funciona sin internet.
- Si quieres recompilar desde cero, borra la carpeta `out\` y vuelve a ejecutar el lanzador.
