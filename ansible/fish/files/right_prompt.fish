function __kubectl_context_add_prompt
    set_color normal
    echo -n '('
    set_color -o green
    echo -n (kubectl config current-context)
    set_color normal
    echo -n ')'
end

# if functions -q fish_right_prompt
#     functions -e __fish_right_prompt
#     functions -c fish_right_prompt __fish_right_prompt
#     functions -e fish_right_prompt
# else
#     function __fish_right_prompt_orig
#     end
# end

# function fish_right_prompt
#     __kubectl_context_add_prompt
#     __fish_right_prompt
# end

source /Users/siva.kommuri/.local/share/omf/themes/bobthefish/fish_right_prompt.fish

function fish_right_prompt --description 'bobthefish is all about the right prompt'
        set -l __bobthefish_left_arrow_glyph \uE0B3
  if [ "$theme_powerline_fonts" = "no" ]
    set __bobthefish_left_arrow_glyph '<'
  end

  set_color $fish_color_autosuggestion

  __bobthefish_cmd_duration
  __bobthefish_timestamp
  set_color normal
end
