module Convert where

import qualified Markup
import qualified Html 

convert :: Html.Title -> Markup.Document -> Html.Html
convert title = Html.html_ title . Html.concatStructure . map convertStructure 

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markup.Heading 1 txt ->
      Html.h1_ $ Html.txt_ txt

    Markup.UnorderedList list ->
      Html.ul_ $ map (Html.p_ . Html.txt_) list
      
    Markup.Paragraph p ->
      Html.p_ $ Html.txt_ p
      
    Markup.OrderedList list ->
      Html.ol_ $ map (Html.p_ . Html.txt_) list

    Markup.CodeBlock list ->
      Html.code_ (unlines list)
