function fish_title
    echo $argv[1] (prompt_pwd)

    switch "$TERM"
    case 'screen*'

      if set -q SSH_CLIENT
        set maybehost (hostname):
      else
        set maybehost ""
      end

      echo -ne "\\ek"$maybehost(status current-command)"\\e\\" > /dev/tty
    end
end
