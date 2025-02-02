# Haskel Blog Generator

Este proyecto es un conversor de un lenguaje de marcado similar a Markdown a HTML, desarrollado en Haskell. Permite transformar documentos estructurados con una sintaxis sencilla en páginas HTML estilizadas, utilizando un archivo CSS personalizable.

---

## 🛠 Funcionamiento

El programa consta de los siguientes componentes:

1. **Módulo `Markup.hs`**:  
   Define la sintaxis del lenguaje de marcado y parsea el texto de entrada en una estructura de datos (`Document`).  
   - **Sintaxis soportada**:
     - Encabezados: `* Título`, `** Subtítulo`, `*** Sub-subtítulo`.
     - Listas no ordenadas: `- Elemento`.
     - Listas ordenadas: `# Elemento`.
     - Imágenes: `% ruta/imagen.png`.
     - Línea horizontal: `---`.
     - Bloques de código: `> línea de código`.
     - Párrafos: texto plano.

2. **Módulo `Html.hs`**:  
   Genera HTML a partir de la estructura parseada. Incluye funciones para crear elementos como encabezados, listas, imágenes, etc.

3. **Módulo `Convert.hs`**:  
   Convierte la estructura `Document` del módulo `Markup` en una estructura `Html` válida, aplicando estilos CSS.

4. **Archivo CSS**:  
   Proporciona estilos predeterminados (`defaultStyles.css`) para el HTML generado, con efectos como gradientes en encabezados y fondo oscuro.

5. **Módulo `Main.hs`**:  
   Maneja la entrada/salida, acepta argumentos de línea de comandos y ejecuta el proceso de conversión.

---

## 📥 Instalación

### Requisitos
- **GHC** (Glasgow Haskell Compiler) y **Cabal** instalados.  
  Puedes instalarlos desde [Haskell.org](https://www.haskell.org/).

### Pasos
1. Clona el repositorio:
```bash
git clone https://github.com/DiegoViera1511/Haskell-Blog-Generator.git
cd Haskell-Blog-Generator
```


### Compila el proyecto
```bash
./run.sh
```
### Aquí vemos un ejemplo al correr el comando

<img src ="https://i.imgur.com/np91aQb.png">

### Notas:
* Al correr el blog con el default.txt que se encuentra en la carpeta input usted deberá proporcionar el path completo hacia la imagen en su PC, en el propio txt se encuentra un ejemplo, pero debe cambiarlo con su path propio, en caso contrario no verá la imagen


