
main :: IO ()
main = putStrLn (wrapHtml "Hello World!")

wrapHtml content = "<html><body>" <> content <> "</body></html>"

