function create_fish_dotenv
    if test -f .env
        echo "# Auto-generated .env.fish file" > .env.fish
        cat .env | while read line
            if not string match -qr '^\s*#' -q $line
                if not string match -qr '^\s*$' -q $line
                    set key (string split -m 1 '=' $line)[1]
                    set value (string split -m 1 '=' $line)[2]
                    echo "set -x $key $value" >> .env.fish
                end
            end
        end
        echo ".env.fish file created successfully."
    else
        echo ".env file not found in current directory."
    end
end
