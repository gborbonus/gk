#!/bin/bash

# Bash completion for gk command

_gk_completion() {
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    # List of main commands
    local commands="list get mod conn log top events help"
    local resource_types="pods configmaps secrets services namespaces jobs deployments cronjobs nodes"

    # If no command yet, suggest commands
    if [ $cword -eq 1 ]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return
    fi

    # Handle completion based on the command
    local cmd="${words[1]}"
    case "$cmd" in
        "list")
            if [ "$prev" = "-t" ]; then
                COMPREPLY=($(compgen -W "$resource_types" -- "$cur"))
            elif [ "$prev" = "-ns" ]; then
                COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
            else
                COMPREPLY=($(compgen -W "-t -ns" -- "$cur"))
            fi
            ;;

        "get")
            if [ $cword -eq 2 ]; then
                COMPREPLY=($(compgen -W "config file desc" -- "$cur"))
            else
                local subcmd="${words[2]}"
                case "$subcmd" in
                    "config" | "desc")
                        if [ "$prev" = "-t" ]; then
                            COMPREPLY=($(compgen -W "$resource_types" -- "$cur"))
                        elif [ "$prev" = "-n" ]; then
                            local type=$(echo "${words[*]}" | grep -oP '(?<=-t\s)\w+' || echo "pods")
                            COMPREPLY=($(compgen -W "$(kubectl get "$type" -n fgref -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "-ns" ]; then
                            COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        else
                            COMPREPLY=($(compgen -W "-t -n -ns" -- "$cur"))
                        fi
                        ;;
                    "file")
                        if [ "$prev" = "-n" ]; then
                            COMPREPLY=($(compgen -W "$(kubectl get pods -n fgref -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "-ns" ]; then
                            COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "--file" ]; then
                            COMPREPLY=()
                        else
                            COMPREPLY=($(compgen -W "-n --file -ns" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        "mod")
            if [ $cword -eq 2 ]; then
                COMPREPLY=($(compgen -W "delete restart scale edit" -- "$cur"))
            else
                local subcmd="${words[2]}"
                case "$subcmd" in
                    "delete" | "restart" | "edit")
                        if [ "$prev" = "-t" ]; then
                            COMPREPLY=($(compgen -W "$resource_types" -- "$cur"))
                        elif [ "$prev" = "-n" ]; then
                            local type=$(echo "${words[*]}" | grep -oP '(?<=-t\s)\w+' || echo "pods")
                            COMPREPLY=($(compgen -W "$(kubectl get "$type" -n fgref -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "-ns" ]; then
                            COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        else
                            COMPREPLY=($(compgen -W "-t -n -ns" -- "$cur"))
                        fi
                        ;;
                    "scale")
                        if [ "$prev" = "-t" ]; then
                            COMPREPLY=($(compgen -W "$resource_types" -- "$cur"))
                        elif [ "$prev" = "-n" ]; then
                            local type=$(echo "${words[*]}" | grep -oP '(?<=-t\s)\w+' || echo "deployments")
                            COMPREPLY=($(compgen -W "$(kubectl get "$type" -n fgref -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "-ns" ]; then
                            COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
                        elif [ "$prev" = "--replicas" ]; then
                            COMPREPLY=($(compgen -W "1 2 3 4 5" -- "$cur"))
                        else
                            COMPREPLY=($(compgen -W "-t -n --replicas -ns" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        "conn" | "log" | "top")
            if [ "$cmd" = "top" ] && [ $cword -eq 2 ]; then
                COMPREPLY=($(compgen -W "-n prep-top" -- "$cur"))
            elif [ "$prev" = "-n" ]; then
                COMPREPLY=($(compgen -W "$(kubectl get pods -n fgref -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
            elif [ "$prev" = "-ns" ]; then
                COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
            else
                COMPREPLY=($(compgen -W "-n -ns ${cmd == "log" && "-f"}" -- "$cur"))
            fi
            ;;

        "events")
            if [ "$prev" = "-ns" ]; then
                COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{range .items[*]}{.metadata.name}{" "}')" -- "$cur"))
            else
                COMPREPLY=($(compgen -W "-ns" -- "$cur"))
            fi
            ;;

        "help")
            COMPREPLY=()
            ;;
    esac

    compopt -o nospace 2>/dev/null
}

# Register the completion function
complete -F _gk_completion gk
