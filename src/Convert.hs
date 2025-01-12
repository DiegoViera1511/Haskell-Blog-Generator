module Convert where

import qualified Markup
import qualified Html 

convert :: Html.Title -> String -> Markup.Document -> Html.Html
convert title styles = Html.html_ title styles . Html.concatStructure . map convertStructure 

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markup.Heading 1 txt ->
      Html.h1_ $ Html.txt_ txt

    Markup.Heading 2 txt ->
      Html.h2_ $ Html.txt_ txt

    Markup.Heading 3 txt ->
      Html.h3_ $ Html.txt_ txt
    
    Markup.Image src ->
      Html.img_ src
      
    Markup.UnorderedList list ->
      Html.ul_ $ map (Html.p_ . Html.txt_) list
      
    Markup.Paragraph p ->
      Html.p_ $ Html.txt_ p
      
    Markup.OrderedList list ->
      Html.ol_ $ map (Html.p_ . Html.txt_) list

    Markup.CodeBlock list ->
      Html.code_ (unlines list)
      
    Markup.HorizontalLine _ -> 
      Html.hr_
