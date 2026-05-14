-- filters/inline-images.lua
-- Convierte imágenes dentro de celdas de tabla a \includegraphics inline.
--
-- Problema A (resuelto): Pandoc envuelve ![](img.jpg) en \begin{figure}
-- (float), que dentro de una celda de longtable escapa hacia la parte
-- superior de la columna. Usar \includegraphics directo lo evita.
--
-- Problema B (resuelto aquí): \includegraphics en una celda p{} coloca
-- la imagen con la baseline en el FONDO de la imagen, por lo que la imagen
-- sube varios centímetros por encima de la baseline de la fila, mientras
-- que el texto de las otras celdas arranca solo ~0.5 cm encima de esa
-- misma baseline. Resultado: imagen visualmente por encima del texto.
-- Solución: \adjustbox{valign=t} alinea el TOPE de la imagen con el tope
-- de la línea de texto, haciendo que imagen y texto comiencen al mismo nivel.

local function make_includegraphics(src, width)
  width = width or "3cm"

  -- Convertir porcentaje a fracción de \linewidth (e.g. "50%" → "0.50\linewidth")
  width = width:gsub("(%d+)%%", function(n)
    return string.format("%.2f\\linewidth", tonumber(n) / 100)
  end)

  -- Normalizar ruta: quitar prefijos "../" para obtener ruta relativa
  -- a la raíz del proyecto (donde pandoc copia las imágenes al dir temporal).
  while src:match("^%.%./") do
    src = src:sub(4)
  end

  -- adjustbox{valign=t} alinea el tope de la imagen con el tope del texto
  return string.format(
    "\\adjustbox{valign=t}{\\includegraphics[width=%s,keepaspectratio]{%s}}",
    width, src
  )
end

-- Problema C (resuelto aquí): pandoc descarta <br> de HTML al convertir a
-- LaTeX (los trata como raw HTML inline y los ignora). Este handler los
-- convierte a \newline, que funciona tanto en texto corrido como en celdas p{}.
function RawInline(el)
  if FORMAT ~= "latex" then return el end
  if el.format == "html" then
    -- Normalizar: quitar espacios y convertir a minúsculas para comparar
    local tag = el.text:lower():gsub("%s+", "")
    if tag == "<br>" or tag == "<br/>" then
      return pandoc.RawInline("latex", "\\leavevmode\\newline ")
    end
  end
  return el
end

function Table(el)
  if FORMAT ~= "latex" then return el end

  return el:walk({
    -- pandoc 3.x: imágenes standalone en celdas se convierten en Figure (bloque)
    Figure = function(fig)
      local src, width = nil, "3cm"
      if fig.content then
        for _, block in ipairs(fig.content) do
          if block.content then
            for _, inline in ipairs(block.content) do
              if inline.t == "Image" then
                src = inline.src
                width = inline.attributes["width"] or "3cm"
                break
              end
            end
          end
          if src then break end
        end
      end
      if not src then return fig end
      return pandoc.RawBlock("latex", make_includegraphics(src, width))
    end,

    -- pandoc 2.x: Image como elemento inline
    Image = function(img)
      return pandoc.RawInline("latex",
        make_includegraphics(img.src, img.attributes["width"]))
    end
  })
end
