if functions -q fish_right_prompt
    functions -e __fish_right_prompt
    functions -c fish_right_prompt __fish_right_prompt
    functions -e fish_right_prompt
else
    function __fish_right_prompt_orig
    end
end

function __kubectl_context_add_prompt
    set_color normal
    echo -n '('
    set_color -o green
    echo -n (kubectl config current-context)
    set_color normal
    echo -n ') '
end

function fish_right_prompt
    __kubectl_context_add_prompt
    __fish_right_prompt
end
