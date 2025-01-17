import Html
import Markup
import Convert
import System.Directory (doesFileExist)
import System.Environment (getArgs)
import System.IO (getContents, readFile, writeFile)

main :: IO ()
main = do
    getArgs >>= \args ->
        case args of
            [title , stylesinput , contentinput , output] -> do
                styles <- readFile stylesinput
                content <- readFile contentinput
                exists <- doesFileExist output
                let 
                    writeResult = writeFile output (process title styles content)
                if exists
                    then writeResult
                    else writeResult

confirm :: IO Bool
confirm = do
  putStrLn "> Are you sure ? (y/n)"
  answer <- getLine
  case answer of
    "y" -> pure True
    "n" -> pure False
    _ -> do
      putStrLn "Invalid response. use y or n"
      confirm

whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action = do
  result <- cond
  if result
    then action
    else pure ()                 

process :: Html.Title -> String -> String -> String
process title style = Html.render . convert title style . Markup.parse
