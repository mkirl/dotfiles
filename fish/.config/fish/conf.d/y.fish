function y --description "Yazi with directory tracking"
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if test -f $tmp
        set -l cwd (cat -- "$tmp")
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd -- "$cwd"
        end
    end
    rm -f -- "$tmp"
end
