#!/bin/bash


stack build
clear

function GenerateBlog {
    echo -n "> Enter the title of the blog ( Press enter to use default name ): "
    read title
    echo " "
    if [ -z "$title" ]; then
        title="blog"
    fi
    while true; do
        echo " "
        echo -n "> Enter the styles route of the blog ( Press enter to use default styles ): "
        read styles
        echo " "
        if [ -z "$styles" ]; then
            echo "Using default styles route ./hs-blog-gen/Styles/defaultStyles.css"
            styles="./Styles/defaultStyles.css"
            break
        elif [ ! -d "$styles" ]; then
            echo "Error: invalid styles route"
            echo " "
        else
            echo "Using styles "$styles" "
            break
        fi
    done
    
    echo " "

    while true; do
        echo " "
        echo -n "> Enter the input route of the blog ( Press enter to use default input ): "
        read input
        echo " "
        if [ -z "$input" ]; then
            echo "Using default input route ./hs-blog-gen/Input/default.txt"
            input="./Input/default.txt"
            break
        elif [ ! -d "$input" ]; then
            echo "Error: invalid input route"
            echo " "
        else
            echo "Using input "$input" "
            break
        fi
    done

    echo " " 

    while true; do
        echo " "
        echo -n "> Enter the output route of the blog: "
        read output
        echo " "
        if [ -z "$output" ]; then
            echo "Using default output route ./hs-blog-gen/Output/"$title".html"
            output="./Output/"$title".html"
            break
        elif [ ! -d "$output" ]; then
            echo "Error: Invalid output route"
            echo " "
        else
            echo "Using output "$output" "
            break
        fi
    done

    echo " "

    echo "Processing..."

    stack exec hs-blog-gen-exe $title $styles $input $output

    while true; do
        echo " "
        echo "> Open blog ? (y/n)"
        echo " "
        echo -n "> "
        read open
        echo " "
        if [ "$open" == "y" ]; then
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                xdg-open "$output"
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                open "$output"
            elif [[ "$OSTYPE" == "win32" ]]; then
                start "$output"
            else
                echo "No se pudo detectar el sistema operativo para abrir el archivo HTML."
            fi
            break
        elif [ "$open" == "n" ]; then
            break
        else
            echo "Invalid option please insert y (yes) or n (no)"
        fi
    done
}

while true; do
    echo " "
    echo "Welcome to Haskell-Gen-Blog"
    echo " " 
    echo "Menu:"
    echo " "
    echo "1 -> New blog"
    echo "2 -> Exit"
    echo " "
    echo -n "> "
    read option
    echo " "

    case "$option" in
        1)
            GenerateBlog
            ;;
        2)
            echo "Goodbye!"
            echo " "
            break
            ;;
        *)  
            echo "Invalid option please insert 1 ( New Blog ) or 2 ( Exit )"
            ;;
    esac
done



