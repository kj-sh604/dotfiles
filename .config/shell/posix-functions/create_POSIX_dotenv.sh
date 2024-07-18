create_POSIX_dotenv() {
    if [ -f .env ]; then
        echo "# auto-generated .env.sh file" > .env.sh
        while IFS= read -r line; do
            if [ "${line#\#}" != "$line" ] || [ -z "$line" ]; then
                continue
            fi
            key=$(echo "$line" | cut -d '=' -f 1)
            value=$(echo "$line" | cut -d '=' -f 2-)
            echo "export $key=\"$value\"" >> .env.sh
        done < .env
        echo ".env.sh file created successfully."
    else
        echo ".env file not found in current directory."
    fi
}
