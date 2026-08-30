set -U fish_greeting ""

if status is-interactive
    # Comandos que solo quieres en sesiones interactivas
    fastfetch
end

function actrepo
    bash (curl -sL https://raw.githubusercontent.com/iJoseG/Mscripts/refs/heads/main/actrepo.sh | psub) $argv
end


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/jguerra/.lmstudio/bin
# End of LM Studio CLI section

