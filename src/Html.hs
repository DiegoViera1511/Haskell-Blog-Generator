module Html
  ( Html
  , Title
  , Structure
  , Content
  , concatStructure
  , txt_
  , html_
  , h1_
  , p_
  , ul_
  --TODO add ol_ and code_
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

html_ :: Title -> Structure -> Html
html_ title content =
  Html
    ( el "html"
      ( el "head" (el "title" (escape title))
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

ul_ :: [Structure] -> Structure
ul_ =
  Structure . el "ul" . concat . map (el "li" . getStructureString)

--TODO Other of tags 

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