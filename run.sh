#!/bin/bash


stack build
clear

function GenerateBlog {
    echo -n "> Enter the title of the blog: "
    read title
    echo " "
    if [ -z "$title" ]; then
        title="blog"
    fi

    echo -n "> Enter the styles route of the blog: "
    read styles
    echo " "
    if [ -z "$styles" ]; then
        echo "Using default styles route ./hs-blog-gen/Styles/defaultStyles.css"
        echo " "
        styles="./Styles/defaultStyles.css"
    elif [ ! -d "$styles" ]; then
        echo "Error: Invalid styles route"
        exit 1
    fi

    echo -n "> Enter the input route of the blog: "
    read input
    echo " "
    if [ -z "$input" ]; then
        echo "Using default input route ./hs-blog-gen/Input-Output/default.txt"
        echo " "
        input="./Input-Output/default.txt"
    elif [ ! -d "$input" ]; then
        echo "Error: Invalid input route"
        exit 1
    fi

    echo -n "> Enter the output route of the blog: "
    read output
    echo " "
    if [ -z "$output" ]; then
        echo "Using default output route hs-blog-gen/Input-Output/"$title".html"
        echo " "
        output="./Input-Output/"$title".html"
    elif [ ! -d "$output" ]; then
        echo "Error: Invalid output route"
        exit 1
    fi

    echo "Processing..."
    echo " " 
    stack exec hs-blog-gen-exe $title $styles $input $output

    echo "> Open blog ? (y/n)"
    echo -n "> "
    read open
    echo " "
    while true; do
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
        elif [ "$open" == "n" ]; then
            echo " "
            break
        else
            echo " "
            echo "Invalid option please insert y (yes) or n (no)"
            echo " "
        fi
        read open
        echo " "
        break
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
            echo "Invalid option"
            echo " "
            ;;
    esac
done



