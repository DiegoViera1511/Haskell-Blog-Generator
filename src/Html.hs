module Html
  ( Html
  , Title
  , Style
  , Structure
  , Content
  , concatStructure
  , txt_
  , html_
  , h1_
  , h2_
  , h3_
  , hr_
  , img_
  , p_
  , ul_
  , ol_
  , code_
  , render
  )
  where

newtype Html
  = Html String

newtype Structure
  = Structure String

newtype Content
  = Content String

type Title
  = String

type Style
  = String

html_ :: Title -> Style -> Structure -> Html
html_ title styles content =
  Html
    ( el "html"
      ( el "head" ( el "title" (escape title) <> el "style" styles )
        <> el "body" (getStructureString content)
      )
    )

concatStructure :: [Structure] -> Structure
concatStructure list =
  case list of
    [] -> empty_
    x : xs -> x <> concatStructure xs

empty_ :: Structure
empty_ = Structure ""

txt_ :: String -> Content
txt_ = Content . escape

p_ :: Content -> Structure
p_ = Structure . el "p" . getContentString

h1_ :: Content -> Structure
h1_ = Structure . el "h1" . getContentString

h2_ :: Content -> Structure
h2_ = Structure . el "h2" . getContentString

h3_ :: Content -> Structure
h3_ = Structure . el "h3" . getContentString

ul_ :: [Structure] -> Structure
ul_ =
  Structure . el "ul" . concat . map (el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ =
  Structure . el "ol" . concat . map (el "li" . getStructureString)

code_ :: String -> Structure
code_ = Structure . el "pre" . escape

img_ :: String -> Structure
img_ = Structure . el_img_

hr_ :: Structure
hr_ = Structure "<hr>"

instance Semigroup Structure where
  (<>) c1 c2 =
    Structure (getStructureString c1 <> getStructureString c2)

-- * Render

render :: Html -> String
render html =
  case html of
    Html str -> str

-- * Utilities

el :: String -> String -> String
el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

el_img_ :: String -> String
el_img_ src = el "div" $ "<img src=\"" <> src <> "\"" <> " alt=\"img\" " <> "/>"

getStructureString :: Structure -> String
getStructureString content =
  case content of
    Structure str -> str

getContentString :: Content -> String
getContentString content =
  case content of
    Content str -> str

escape :: String -> String
escape =
  let
    escapeChar c =
      case c of
        '<' -> "&lt;"
        '>' -> "&gt;"
        '&' -> "&amp;"
        '"' -> "&quot;"
        '\'' -> "&#39;"
        _ -> [c]
  in
    concat . map escapeChar
